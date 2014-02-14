'use strict'

# @param {*} x
# @return {String}
type = -> null

# @param {*} x
# @return {Boolean}
type.isDefined = (x) -> x isnt undefined and x isnt null

# @param {*} x
# @return {Boolean}
type.isNum = (x) -> type.isDefined(x) and (typeof x is 'number')

# @param {*} x
# @return {Boolean}
type.isList = (x) -> type.isDefined(x) and type.isFunction(x.head) and type.isFunction(x.tail)

# @param {*} x
# @return {Boolean}
type.isObject = (x) -> type.isDefined(x) and x.constructor is Object

# @param {*} x
# @return {Boolean}
type.isArray = (x) -> type.isDefined(x) and x.constructor is Array

# @param {*} x
# @return {Boolean}
type.isFunction = (x) -> type.isDefined(x) and x.constructor is Function

module.exports = type