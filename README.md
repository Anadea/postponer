# Waiter

Такая штука для того, чтоб делать запуск какого-то куска кода только по обращению к одному из его методов/свойств. Предполагается использование вместо ActiveRecord::Relation при отсутствии оного. Фактически это делегатор к результатам блока.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'waiter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install waiter

## Usage

Пока не понятно, что с пространством имён и над этим надо подумать. Предполагалось, что будет как-то так

```ruby
pry(main)> w = Waiter.new { Story.first }
=> #<Waiter:0x007fa3c3ea1280 @executing_block=#<Proc:0x007fa3c3ea1208@(pry):42>>
```
Запроса за историей нет

Обращаемся к одному из методов выражения, которое возвращает блок
```ruby
pry(main)> w.estimate
  Story Load (0.7ms)  SELECT  "stories".* FROM "stories"  ORDER BY "stories"."id" ASC LIMIT 1
=> 1320
```
и видим запрос за историей.

Бывают случаи когда хочется ограничить делегирование методов, на которые реагирует официант

```ruby
pry(main)> w = Waiter.new(:estimate) { Story.first }
=> #<Waiter:0x007fa3c05ecae8 @executing_block=#<Proc:0x007fa3c05eca20@(pry):54>>
pry(main)> w.estimate
  Story Load (0.8ms)  SELECT  "stories".* FROM "stories"  ORDER BY "stories"."id" ASC LIMIT 1
=> 1320
pry(main)> w.id
NoMethodError: undefined method `id' for #<Waiter:0x007fa3c05ecae8>
from (pry):56:in `<main>'
```

Или так для инициализации

```ruby
w = waiter { Story.first }
```

Пока работает как Waiter::Waiter.new и нет сил ковырять

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

