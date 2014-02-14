'use strict'

list = require './list-fn.coffee'

class chain

	constructor: (xs, C = chain) ->
		@C = C
		@xs = -> xs

	head: -> 											@xs().head()
	tail: -> 											@xs().tail()
	list: -> 											@xs()

	has: (x) -> 									list.has(@xs(), x)
	every: (p) -> 								list.every(@xs(), p)
	some: (p) -> 									list.some(@xs(), p)
	array: () -> 									list.array(@xs())
	string: -> 										list.string(@xs())
	len: -> 											list.len(@xs())
	empty: -> 										list.empty(@xs())
	nth: (n) -> 									list.nth(@xs(), n)

	app: (x) -> 									new @C(list.app(@xs(), x))
	take: (n) -> 									new @C(list.take(@xs(), n))
	drop: (n) -> 									new @C(list.drop(@xs(), n))
	filter: (p) -> 								new @C(list.filter(@xs(), p))
	map: (m) -> 									new @C(list.map(@xs(), m))
	flat: () -> 									new @C(list.flat(@xs()))
	union: (c) -> 								new @C(list.union(@xs(), c.list()))
	zip: (yc, m) -> 							new @C(list.zip(@xs(), yc.xs(), m))

	insertAt: (i, x) -> 					new @C(list.insertAt(@xs(), i, x))
	removeAt: (i) -> 							new @C(list.removeAt(@xs(), i))
	replaceAt: (i, x) ->					new @C(list.replaceAt(@xs(), i, x))
	without: (x) -> 							new @C(list.without(@xs(), x))
	replace: (x, y) -> 						new @C(list.replace(@xs(), x, y))

module.exports = chain
