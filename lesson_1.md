## Урок 1: Создание организации

> Уровень сложности урока: низкий.

**Создаваемые на данном уроке модули ДАО:**

- `DAO core`
- `Shareholder token`

**Используемые для взаимодействия в данном уроке модули ДАО:**

- `Aira BuilderDAO` ([abi](https://raw.githubusercontent.com/airalab/core/master/abi/builder/BuilderDAO.json))
- `DAO core` ([abi](https://raw.githubusercontent.com/airalab/core/master/abi/modules/Core.json))
- `Shareholder token` ([abi](https://raw.githubusercontent.com/airalab/core/master/abi/modules/TokenEmission.json))

### Описание урока

Для начала работы необходимо создать ядро децентрализованной автономной организации (`DAO Core`). Ядро ДАО позволяет хранить реестр всех используемых организацией автономных контрактов. Для управления данным реестром (внесения/изменения/удаления записей) и других административных функций необходимо создать контракт, который будет хранить реестр акционеров организации `Shareholder token`.

Для того, чтобы создать `DAO core` и `Shareholder token` необходимо обратиться к фабрике ДАО отправив транзакцию со своего аккаунта к сборщику `Aira BuilderDAO` из реестра `DAO factory`.

#### Входные параметры

Параметр | Описание | Пример
---------|----------|-------
`_dao_name` | Название вашей организации | "Martian colony"
`_dao_description` | Краткое описание | "DAO for first human colony on Mars"
`_shares_name` | Название акций | Mars colony shares
`_shares_symbol` | Символ для акций, обычно 1 - 3 символа | MRS
`_shares_count` | Количество акций, эмиссируемых при создании ДАО | 10000

### Проверка умений

> Успешное выполнение урока в официальной сети даст: 50 `air`

**Чтобы успешно выполнить данный урок необходимо:**

Необходимо обратиться к контракту `Lesson 1` для вызова функции `Execute()` указав адрес контракта ядра ДАО `DAO core`. Контракт `Lesson 1` проверит совпадает ли переменная `owner` в контракте `DAO core` с вашим адресом отправителя транзакции.
