# Учебный центр по созданию децентрализованных автономных организаций на платформе Ethereum
В данном документе содержаться основные учебные уроки по созданию собственной децентрализованной автономной организации (далее сокр. ДАО) (1) с использованием автономных контрактов (2) из репозитория [Aira core](https://github.com/airalab/core).

## Урок 0: подготовьтесь к работе с сетью Ethereum через консоль.
Вам необходим клиент сети Ethereum, поддерживающий работу в консольном режиме. Рекомендуется использовать клиент сети [geth](https://github.com/ethereum/go-ethereum#automated-development-builds) или [parity](https://ethcore.io/parity.html).

После установки клиента сети, выполните синхронизацию с **тестовой сетью** и обратитесь к контракту Airalab в тестовой сети, который отправит вам в ответ небольшое количество эфиров для выполнения следующих уроков.

### Ваша первая транзакция в сеть и первая оценка

TO DO: Eugene

## Урок 1: создайте ядро децентрализованной автономной организации.
Ядро ДАО позволяет хранить реестр всех используемых организацией автономных контрактов. Для управления данным реестром (внесения/изменения/удаления записей) совместно с ядром необходимо создать контракт, который будет хранить реестр акционеров организации.

Для того, чтобы создать ядро и токен акций необходимо выполнить компиляцию исходного кода следующих контрактов:

- [Core.sol](https://github.com/airalab/core/blob/master/sol/dao/Core.sol)
- [TokenEmission.sol](https://github.com/airalab/core/blob/master/sol/token/TokenEmission.sol)

> Обратите внимание, что вам требуется собрать все дополнительные контракты, которые используются ядром и реестром акционеров.

или обратиться к фабрике ДАО отправив транзакцию со своего аккаунта к сборщику ядра [BuilderDAO](https://github.com/airalab/core/wiki/API-Reference#builderdao) следующего формата:

```js
var factory = eth.contract(Core).at("0x4b94c11ff4b118cad6d0d1831ecb60586a9241df")
var builder = eth.contract(BuilderDAO).at(factory.getModule("Aira BuilderDAO"))
builder.create(_dao_name, _dao_description, _shares_name, _shares_symbol, _shares_count,
               {from: eth.accounts[0], gas: 1000000, value: builder.buildingCost()})
```

Здесь `_dao_name, _dao_description, _shares_name, _shares_symbol, _shares_count` это параметры нового DAO.

Успешное выполнение урока в официальной сети даст: 100 `air`

## Урок 2: Распределите акции вашей организации
При создании ДАО на баланс адреса создателя было эмисировано заданное количество акций. Теперь время их распределить среди команды. Для того, чтобы это сделать можно использовать также клиент сети Ethereum wallet с GUI. Чтобы успешно выполнить данный урок необходимо разрешить снятие  1 акции адресу `Airalab learning center` и обратиться к контракту `Second lesson` для вызова функции `Execute()`.

Успешное выполнение урока в официальной сети даст: 100 `air`

TO DO: Eugene пример с Ethereum wallet

TO DO: vol4tim пример с geth

## Урок 3: Используйте общий контракт для хранения эфиров.
Первый шаг к объединению средств организации от акционеров можно выделить в использование общего контракта, на который акционеры передадут средства без учета соотношения вложений к общей сумме средств в эфирах на общем контракте хранения эфиров. Это означает, что все средства, которые будут переведены на контракт будут доступны для использования и вывода **только** владельцу аккаунта, с которого средства были отправлены на контракт.

**Чтобы успешно выполнить данный урок необходимо:**
- обратиться к контракту [BuilderTokenEther](https://github.com/airalab/core/wiki/API-Reference#buildertokenether) в DAO factory с названием `Aira BuilderTokenEther` (`0xbb2695e90d82c6e4b87da5db29a6762645c7d6f5`) для создания контракта, который будет хранить эфиры.
- перевести **0,1** эфир на свой счет в контракте [TokenEther](https://github.com/airalab/core/wiki/API-Reference#tokenether), созданном вами ранее.
- обратиться к контракту `Third lesson` для вызова функции `Execute()` указав `адрес контракта для хранения эфиров` и  имея **0,1** эфир на счету своего аккаунта на контракте.

Успешное выполнение урока в официальной сети даст: 100 `air`

TO DO: Eugene пример с Ethereum wallet

TO DO: vol4tim пример с geth

## Урок 4: Эмиссируйте новые акции привлекая финансирование в эфирах.
Для увеличения количества акций за счёт привлечения финансирования необходимо воспользоваться сборщиком [BuilderIPOStart](https://github.com/airalab/core/wiki/API-Reference#builderipostart), который создаст модуль инфраструктуры ДАО [IPO](https://github.com/airalab/core/wiki/API-Reference#ipo) и модуль [Cashflow](https://github.com/airalab/core/wiki/API-Reference#cashflow) для дальнейшего управления (по окончанию IPO) средствами  в совместном финасировании расходов организации с использованием `пропорционального голосования` (3).

>Пропорциональное голосование выбрано, как начальная форма управления общим фондов организации в силу её наибольшей защищенности от влияния расходования средств отдельного акционера в общем бюджете организации.. При создании данного контракта необходимо задать:

**Параметры, которые необходимо задать при обращении к сборщику `IPO start`:**

- Адрес токена кредитов
- Адрес токена акций
- Время старта IPO (UNIX-время)
- Период проведения IPO в секундах
- Начальная стоимость акций
- Шаг увеличения стоимости в процентах
- Период шага увеличения стоимости в секундах
- Минимальную сумму привлекаемых средств
- Максимальную сумму привлекаемых средств

> в данном уроке максимальную сумму привлекаемых средств необходимо указать равной 5 эфиров.

*Внимание*: После создания контракта на его адрес необходимо перевести число акций для продажи.

Для успешного прохождения урока необходимо внести 5 эфиров с любого аккаунта, который в дальнейшем станет владельцем новых акций и будет участвовать в управлении расходами вместе с уже имеющимися акционерами. Чтобы закончить урок необходимо отправить транзакцию после наполнения IPO 5 эфирами на `адрес контракта четвертый урок` вызвав функцию `Execute()`.

TO DO: Eugene пример с Ethereum wallet

TO DO: vol4tim пример с geth

## Урок 5: Превратите акции ДАО в управленческий капитал фонда организации.
Имея общий бюджет и модуль ДАО [CashFlow](https://github.com/airalab/core/wiki/API-Reference#cashflow) можно создавать [proposal](https://github.com/airalab/core/wiki/API-Reference#proposal) указывая:
- `Адрес в сети Ethereum - цель финансирования`.
- Запрашиваемое финансирования, меньшее чем общая сумма средств на счету `Cashflow`.

Чтобы успешно выполнить данный урок необходимо обратиться к контракту `Fifth lesson` для вызова функции `Execute()` указав `адрес контракта получивший успешно финансирование от ДАО` и сумму в эфирах, которую получил контракт.

Успешное выполнение урока в официальной сети даст: 100 `air`

TO DO: Eugene пример с Ethereum wallet

TO DO: vol4tim пример с geth

## Урок 6: Создайте внутренний рынок ДАО
Создайте рынок ДАО и наполните его предложениями. Для начала необходимо обратиться к сборщику DAO factory [BuilderMarket](https://github.com/airalab/core/wiki/API-Reference#buildermarket), адрес в тестовой сети: `0xf2d826e8b8d36b85d6698ff99a8295e715304c48`.

`Aira BuilderMarket` создаст рынок [Market](https://github.com/airalab/core/wiki/API-Reference#market), на котором возможно выставлять на продажу токены.

Для того, чтобы познакомиться с работой на рынке давайте создадим 2 лота:
- лот на продажу **1 000 shares** организации за **500 credits**;
- лот на покупку **500 credits** за **1 эфир**;

TO DO: Eugene примеры запросов на добавление лотов на рынке (полная инструкция с всеми необходимыми шагами)

Чтобы успешно выполнить данный урок необходимо обратиться к контракту `Sixth lesson` для вызова функции `Execute()` указав `адрес рынка`.

> Важно: на вашем рынке должны быть минимум 2 лота.

TO DO: vol4tim проверяй без учета активен или нет лот и того, что именно продаётся, главное наличие 2 лотов на рынке.

Успешное выполнение урока в официальной сети даст: 100 `air`

TO DO: Eugene пример с Ethereum wallet

TO DO: vol4tim пример с geth

## Урок 7: Добавьте регулятора внутреннего рынка ДАО
Контракты типа `MarketRegulator` получают от рынка информацию о всех сделках проходящих на рынке, а также лотах, которые добавляют на рынок агенты. В данном уроке мы создадим регулятора рынка, который будет разрешать добавление лотов только с токенами, находящимися в реестре ядра ДАО.

TO DO: akru создания регулятора, связанного с реестром ядра ДАО.

Для того, чтобы  включить регулятора в работу рынка необходимо:
- обратиться в `DAO factory` к контракту `Market regulator builder` указав `DAO core address`.
- обратиться с аккаунта создателя рынка `owner` к контракту `Market`, для вызова функции `regulator_switch`, передав адрес, созданного регулятора.

После добавления регулятора рынка можно попробовать его в работе. Для этого необходимо:
- обратиться  в `DAO factory` к контракту `Token Ether Builder` для создания нового токена, который будет отражать ценность на вашем рынке.
- попробуйте добавить лот с любым количеством токенов на рынок - вы должны будете получить сообщение следующего формата: "Данный токен не найден в реестре ядра ДАО".
- добавьте токен в реестр ядра ДАО.
- попробуйте снова добавить лот с любым количеством токенов на рынок - лот должен добавиться.

TO DO: akru прочитай логику, думаю, что есть что ещё доработать в контрактах для реализации данных шагов.

> Совет: например в DAO Aira на внутреннем рынке есть предложение токенов кураторства команды Aira для вашей DAO. 1 токен = 1 месяцу поддержки. Придумайте такой токен, который был бы полезен в дальнейшем в работе.

Для прохождения данного урока, необходимо обратиться к контракту `Seventh lesson`, для вызова функции `Execute()` указав `адрес рынка`.
Успешное выполнение урока в официальной сети даст: 100 `air`

TO DO: Eugene пример с Ethereum wallet

TO DO: vol4tim пример с geth

## Урок 8: Добавьте первого агента рынка
Добавленный на предыдущем шаге регулятор выполняет не только функцию фильтрации предлагаемых на рынок ДАО ценностей, но также помагает выполнять свои задачи контрактам агента рынка. Контракты типа `MarketAgent` позволяют строить логику работы автономного агента с рынком без участия человека. В данном примере мы создадим самого простого агента, который будет автоматически выставлять на рынок все токены, которые будут разрешены для снятия контракту агента рынка, а также при покупке данных токенов на рынке за внутреннюю валюту `credits`, выполнять поиск покупателей `credits` для продажи их за эфиры. Тем самым автономный агент, желающий предложить свою ценность на внутреннем рынке ДАО, сможет сразу получать эфиры.

Для того, чтобы  включить агента рынка в работу ДАО необходимо:
- обратиться к `DAO factory` и найти контракт сборщика с названием `Market agent ether out`, при обращении к данному сборщику необходимо указать, адрес токена ценности, которую вы хотите продавать на внутреннем рынке ДАО, а также адрес рынка. Советуем использовать токен, который был создан ранее в уроке 7.
- внести в реестр агентов рынка в контракте `Market regulator`, созданный контракт агента.

TO DO: akru создать билдер и написать пример обращения к билдеру с указанием данных для конструктора.

Для прохождения данного урока, необходимо обратиться к контракту `Eighth lesson`, для вызова функции `Execute()` указав `адрес контракта агента` и `адрес контракта рынка`.

Успешное выполнение урока в официальной сети даст: 100 `air`

TO DO: Eugene пример с Ethereum wallet

TO DO: vol4tim пример с geth
