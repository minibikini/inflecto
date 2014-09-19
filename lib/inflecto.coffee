inflection = require 'inflection'
idx = {}

wrap = (method) -> (str) ->
  getCached(method, str) or setCache(method, str, inflection[method] str)

getCached = (method, key) ->
  idx[method] ?= {}
  idx[method][key]

setCache = (method, key, val) ->
  idx[method] ?= {}
  idx[method][key] = val

inflecto =
  camelize: (str) ->
    getCached('camelize', str) or setCache('camelize', str, inflection.camelize(str, true))

  camelizeBig: (str) ->
    getCached('camelizeBig', str) or setCache('camelizeBig', str, inflection.camelize(str, false))

  pluralize: wrap 'pluralize'
  singularize: wrap 'singularize'
  underscore: wrap 'underscore'

  camelizeKeys: (obj) ->
    newObj = {}
    newObj[inflecto.camelize key] = val for key, val of obj
    newObj

# TODO:
# indexOf( arr, item, from_index, compare_func );
# pluralize( str, plural );
# singularize( str, singular );
# inflect( str, count, singular, plural );
# -- camelize( str, low_first_letter );
# underscore( str, all_upper_case );
# humanize( str, low_first_letter );
# foreign_key( str, drop_id_ubar);
# transform( str, arr);


simpleMethods = ['capitalize', 'dasherize', 'titleize', 'demodulize', 'ordinalize', 'tableize', 'classify']

for method in simpleMethods
  inflecto[method] = wrap method

module.exports = inflecto
