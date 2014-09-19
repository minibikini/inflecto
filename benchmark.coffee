inflection = require 'inflection'
inflecto = require './lib/inflecto'

Benchmark = require('benchmark')
Suite = Benchmark.Suite
str = "a_bit_long_string"

console.log "================================="
console.log "Benchmarking `camelize`"
(new Suite)
  .add 'inflection.camelize', -> inflection.camelize str, true
  .add 'inflecto.camelize', -> inflecto.camelize str
  .on 'cycle', (event) -> console.log String event.target
  .on 'complete', -> console.log 'Fastest is ' + @filter('fastest').pluck('name')
  .run async: no


for method in ['pluralize', 'classify', 'capitalize', 'dasherize', 'titleize', 'demodulize', 'ordinalize', 'tableize', 'classify']
  console.log "================================="
  console.log "Benchmarking `#{method}`"
  (new Suite)
    .add "inflection.#{method}", -> inflection[method] str
    .add "inflecto.#{method}", -> inflecto[method] str
    .on 'cycle', (event) -> console.log String event.target
    .on 'complete', -> console.log 'Fastest is ' + @filter('fastest').pluck('name')
    .run async: no

