## Fork zapret for Mistfall Hunter

Данная сборка основана на [flowseal/zapret-discord-youtube](https://github.com/flowseal/zapret-discord-youtube).

Оригинальный проект: [bol-van/zapret](https://github.com/bol-van/zapret)

Если вы не доверяете бинарным файлам из этого репозитория, вы можете сверить контрольные суммы файлов WinDivert.dll и winws.exe из официального репозитория zapret:

[bol-van/zapret](https://github.com/bol-van/zapret)


### Запуск


1. Запустите скрипт `\utils\calc_ttl.bat`. Он автоматически выполнит трассировку маршрута и сохранит вычисленное значение в `ttl.txt`.


2. Запустите `general (ALT11).bat` в корневой папке. Сценарий сам подтянет значение из файла и применит его для параметра `--dpi-desync-ttl`.

## Контекст
Игровые сервера **Mistfall Hunter** работают на **AWS (AS16509)**.
В России трафик до AWS в некоторых регионах, может попадать под 16 кб блок.

Подробнее о механизме блокировки:
- [net4people/bbs#490](https://github.com/net4people/bbs/issues/490)
- [ntc.party](https://ntc.rkn.quest/t/%D0%B1%D0%BB%D0%BE%D0%BA%D0%B8%D1%80%D0%BE%D0%B2%D0%BA%D0%B0-cloudflare-ovh-hetzner-digitalocean-09062025-xxxxxxxx/17013)





Игра использует нестандартный бинарный протокол поверх TCP.
Первый пакет после TCP handshake - 79 байт, сигнатура `00 00 04 4D`.
На основе этого написан простой WinDivert фильтр.

