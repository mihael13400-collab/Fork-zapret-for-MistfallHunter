param(
    [Parameter(Mandatory=$true)]
    [string]$Target,
    [int]$Margin = 1,
    [int]$MaxHops = 30,
    [int]$TimeoutMs = 1000,
    [string]$OutFile = "ttl.txt"
)

$ping = New-Object System.Net.NetworkInformation.Ping
$buffer = [System.Text.Encoding]::ASCII.GetBytes("ttlcheck")
$lastResponding = 0

Write-Host "Tracing route to $Target ..."
Write-Host ""

for ($ttl = 1; $ttl -le $MaxHops; $ttl++) {
    $options = New-Object System.Net.NetworkInformation.PingOptions($ttl, $true)
    try {
        $reply = $ping.Send($Target, $TimeoutMs, $buffer, $options)
    } catch {
        Write-Host ("Hop {0,2}: error" -f $ttl)
        continue
    }

    switch ($reply.Status) {
        'TtlExpired' {
            Write-Host ("Hop {0,2}: {1}" -f $ttl, $reply.Address)
            $lastResponding = $ttl
        }
        'Success' {
            Write-Host ("Hop {0,2}: {1} (reached target)" -f $ttl, $reply.Address)
            $lastResponding = $ttl
        }
        'TimedOut' {
            Write-Host ("Hop {0,2}: * (no response)" -f $ttl)
        }
        default {
            Write-Host ("Hop {0,2}: {1}" -f $ttl, $reply.Status)
        }
    }

    if ($reply.Status -eq 'Success') { break }
}

Write-Host ""

if ($lastResponding -eq 0) {
    Write-Host "Could not determine path to $Target"
    exit 1
}

$computedTTL = $lastResponding - $Margin
Write-Host "Last responding hop: $lastResponding"
Write-Host "Margin: -$Margin"
Write-Host "Computed TTL: $computedTTL"
Write-Host ""

Set-Content -Path $OutFile -Value $computedTTL -NoNewline
Write-Host "Saved to $OutFile"