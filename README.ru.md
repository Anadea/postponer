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
pry(main)> w = Postponer.defer { Story.first }
=> #<Postponer::DelegateAll:0x007fa26c0e5658 @block=#<Proc:0x007fa26c0e5680@(irb):1>>
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
pry(main)> w = Postponer.defer(:estimate) { Story.first }
=> #<Postponer::DelegateSpecific:0x007fa26c0d4038 @block=#<Proc:0x007fa26c0d4060@(irb):2>>
pry(main)> w.estimate
  Story Load (0.8ms)  SELECT  "stories".* FROM "stories"  ORDER BY "stories"."id" ASC LIMIT 1
=> 1320
pry(main)> w.id
NoMethodError: undefined method `id' for #<Postponer::DelegateSpecific:0x007fa26c0d4038>
from (pry):56:in `<main>'
```

## License

[MIT](http://opensource.org/licenses/MIT).
