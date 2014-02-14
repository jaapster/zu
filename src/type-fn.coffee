'use strict'

# @param {*} x
# @return {String}
type = -> null

# @param {*} x
# @return {Boolean}
type.isNum = (x) -> (x or (x is 0)) and (typeof x is 'number')

# @param {*} x
# @return {Boolean}
type.isList = (x) -> (x and (typeof x.head is 'function' and typeof x.tail is 'function'))

# @param {*} x
# @return {Boolean}
type.isObject = (x) -> (x and (x.constructor is Object))

# @param {*} x
# @return {Boolean}
type.isObject = (x) -> (x and (x.constructor is Array))

module.exports = type