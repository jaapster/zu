'use strict'

type = require './type-fn.coffee'

# @param {*} head
# @return {List}
list = (args...) ->
	if not args.length then EMPTY else list.cons(args[0], list.apply(null, args[1...]))

# @param {*} head
# @param {List} tail
# @return {List}
list.cons = (head, tail) ->
	head: -> if @ is EMPTY then 'empty' else head
	tail: -> tail

# @param {List} xs
# @return {Number}
list.len = (xs = @xs) ->
	if xs is EMPTY then 0 else 1 + list.len(xs.tail())

# @param {List} xs
# @return {Boolean}
list.empty = (xs) ->
	xs is EMPTY

# @param {List} xs
# @param {*} x
# @return {List}
list.app = (xs, x) ->
	if xs is EMPTY then list.cons(x, EMPTY) else list.cons(xs.head(), list.app(xs.tail(), x))

# @param {List} xs
# @param {List} ys
# @return {List}
list.union = (xs, ys) ->
	if xs is EMPTY then ys else list.cons(xs.head(), list.union(xs.tail(), ys))

# @param {List} xs
# @param {Number} n
# @return {List}
list.take = (xs, n) ->
	if xs is EMPTY or not type.isNum(n) or n is 0 then EMPTY else list.cons(xs.head(), list.take(xs.tail(), n - 1))

# @param {List} xs
# @param {Number} n
# @return {List}
list.drop = (xs, n) ->
	if xs is EMPTY or n is 0 then xs else if not type.isNum(n) then EMPTY else list.drop(xs.tail(), n - 1)

# @param {List} xs
# @param {Number} n
# @return {*}
list.nth = (xs, n) -> if xs is EMPTY then null else if n is 0 then xs.head() else list.nth(xs.tail(), n - 1)

# @param {List} xs
# @param {Function} p
# @return {List}
list.filter = (xs, p) ->
	if xs is EMPTY then xs
	else if p(xs.head()) then list.cons(xs.head(), list.filter(xs.tail(), p))
	else list.filter(xs.tail(), p)

# @param {List} xs
# @param {Function} m
# @return {List}
list.map = (xs, m) ->
	if xs is EMPTY then xs else list.cons(m(xs.head()), list.map(xs.tail(), m))

# @param {List} xs
# @return {List}
list.flat = (xs) ->
	if xs is EMPTY then EMPTY
	else if not type.isList(xs.head()) then list.cons(xs.head(), list.flat(xs.tail()))
	else list.union(list.flat(xs.head()), list.flat(xs.tail()))

# @param {List} xs
# @param {Number} i
# @param {*} x
# @return {List}
list.insertAt = (xs, i, x) ->
	if not type.isNum(i) or not x then xs
	else if xs is EMPTY or i is 0 then list.cons(x, xs)
	else list.cons(xs.head(), list.insertAt(xs.tail(), i - 1, x))

# @param {List} xs
# @param {Number} i
# @return {List}
list.removeAt = (xs, i) ->
	if xs is EMPTY or not type.isNum(i) then xs
	else if i is 0 then xs.tail()
	else list.cons(xs.head(), list.removeAt(xs.tail(), i - 1))

# @param {List} xs
# @return {List}
list.replaceAt = (xs, i, x) ->
	if not type.isNum(i) or not x or xs is EMPTY then xs
	else if i is 0 then list.cons(x, xs.tail())
	else list.cons(xs.head(), list.replaceAt(xs.tail(), i - 1, x))

# @param {List} xs
# @param {List} ys
# @param {Function} m
# @return {List}
list.zip = (xs, ys, m) ->
	if ys is EMPTY then xs else if xs is EMPTY then ys
	else list.cons(m(xs.head(), ys.head()), list.zip(xs.tail(), ys.tail(), m))

# @param {List} xs
# @param {*} x
# @return {Boolean}
list.has = (xs, x) ->
	if xs is EMPTY then no else xs.head() is x or list.has(xs.tail(), x)

# @param {List} xs
# @param {*} x
# @return {List}
list.without = (xs, x) ->
	list.filter(xs, (e) -> e isnt x)

# @param {List} xs
# @param {*} x
# @param {*} y
# @return {List}
list.replace = (xs, x, y) ->
	if not y then xs else list.map(xs, (e) -> if e is x then y else e)

# @param {List} xs
# @param {Function} xs
# @return {List}
list.each = (xs, f) ->
	if not xs is EMPTY
		f(xs.head())
		list.each(xs.tail(), f)
	xs

# @param {List} xs
# @param {Function} p
# @return {Boolean}
list.every = (xs, p) ->
	list.len(xs) is list.len(list.filter(xs, p))

# @param {List} xs
# @param {Function} p
# @return {Boolean}
list.some = (xs, p) ->
	list.len(list.filter(xs, p)) > 0

# @param {List} xs
# @param {Array} a
# @return {Array}
list.array =
		(xs, a = []) -> if xs is EMPTY then a else [xs.head()].concat(list.array(xs.tail()))

# @param {List} xs
# @return {String}
list.string = (xs) ->
	list.array(xs).join(',')

# @param {List} xs
# @return {List}
list.clone = (xs) ->
	list.cons(xs.head(), xs.tail())

EMPTY = list.cons({}, {})

module.exports = list