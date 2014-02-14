'use strict'

# @param {Object} values
# @return {Object}
obj = (values) -> Object.create values

# @param {Object} obj
# @param {String} name
# @param {*} value
# @return {Object}
obj.set = (obj, name, value) ->
	values = {}
	for key in obj
	 if key is name then values[key] = value else values[key] = obj.key
	obj(values)

# @param {Object} obj
# @param {Function} f
# @return {Object}
obj.map = (obj, f) ->
	values = {}
	values[key] = f(obj.key) for key in obj
	obj(values)

module.exports = obj