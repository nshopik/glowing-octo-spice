# Windows-host (сертификат Контур-Экстерн - КриптоПРО 3.x)

1. Если у Вас руТокен, то необходимо средствами КриптоПро скопировать ключевой контейнер в реестр с возможностью экспорта - http://www.kontur-extern.ru/support/faq/34/61
2. КриптоПро ссылаясь на требования ФСБ, не поддерживают экспорт в формате PKCS#12 (сертификат + закрытый ключ), но экспорт осуществить можно при помощи утилиты `P12FromGostCSP`
3. Используя `P12FromGostCSP` выгружаем сертификат в формате PCKS#12

# Unix-host

1. Требуется OpenSSL с поддержкой алгоритмов GOST
2. Вносим изменения в openssl.cnf

```
openssl_conf = openssl_def

[openssl_def]
engines = engine_section

[engine_section]
gost = gost_section

[gost_section]
engine_id = gost
dynamic_path = /usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/libgost.so
default_algorithms = ALL
CRYPT_PARAMS = id-Gost28147-89-CryptoPro-A-ParamSet
```

> **Заметка:** Для разных систем путь в dynamic_path будет разным, `locate libgost.so` в помощь

- проверяем наличие в алгоритмах GOST 

        openssl ciphers | grep GOST

- проверяем файл, что содержит сертификат и закрытый ключ, PKCS#12 командами:

        openssl pkcs12 -in name.p12 -nodes

- Конвертируем полученный на Windows PKCS#12 в PEM: 

        openssl pkcs12 -in name.p12 -out name.pem -nodes -clcerts

- создаем XML файл запроса, согласно памятке оператора и конвертируем его при помощи icov в СP1251 и подписываем:

        openssl smime -sign -in reqest.xml -out reqest.xml.p7s -binary -signer name.pem -outform DER

- проверяем при помощи ручного запроса - http://vigruzki.rkn.gov.ru/tooperators_form/
    - в поле "Файл запроса" вставляем неподписанный файл запроса `request.xml`
    - в поле "Файл электронной подписи" вставляем подписанный файл `request.xml.p7s`

## Автоматизация скачивания

- Используем скрипт https://github.com/yegorov-p/python-zapret-info

Пример `getbans.sh`:

    ./zapret_checker.py > /dev/null && ./zi-xml2text.py | sort|uniq > blocklist.txt

