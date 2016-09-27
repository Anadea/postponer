# Postponer

Такая штука для того, чтоб делать запуск какого-то куска кода только по обращению к одному из его методов/свойств. Предполагается использование вместо ActiveRecord::Relation при отсутствии оного. Фактически это делегатор к результатам блока.

## Установка

```ruby
# Gemfile
gem 'postponer'
```

```
$ bundle
```

## Использование

```ruby
pry(main)> w = Postponer.serve { Story.first }
=> #<Postponer:0x007fa3c3ea1280 @executing_block=#<Proc:0x007fa3c3ea1208@(pry):42>>
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
pry(main)> w = Postponer.serve(:estimate) { Story.first }
=> #<Postponer:0x007fa3c05ecae8 @executing_block=#<Proc:0x007fa3c05eca20@(pry):54>>
pry(main)> w.estimate
  Story Load (0.8ms)  SELECT  "stories".* FROM "stories"  ORDER BY "stories"."id" ASC LIMIT 1
=> 1320
pry(main)> w.id
NoMethodError: undefined method `id' for #<Postponer:0x007fa3c05ecae8>
from (pry):56:in `<main>'
```

## License

[MIT](http://opensource.org/licenses/MIT).
