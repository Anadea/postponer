# Postponer

Such a thing in order to make the execution of a piece of code only in reference to one of its methods / properties. It is supposed to use instead of ActiveRecord::Relation in the absence thereof. In fact, this is a delegator to the results of the block.

## Install

```ruby
# Gemfile
gem 'postponer'
```

```
$ bundle
```

## Usage

```ruby
pry(main)> w = Postponer.defer { Story.first }
=> #<Postponer::DelegateAll:0x007fa26c0e5658 @block=#<Proc:0x007fa26c0e5680@(irb):1>>
```
There is not a SQL query execution

Now we try to execute something on the block result
```ruby
pry(main)> w.estimate
  Story Load (0.7ms)  SELECT  "stories".* FROM "stories"  ORDER BY "stories"."id" ASC LIMIT 1
=> 1320
```
and notice the SQL query execution.

Sometimes you need to permit the delegation of methods that can be invoked on the block

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
