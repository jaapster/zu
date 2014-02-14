'use strict'

# @param {*} head
# @return {List}
dbllist = (vals...) -> if not vals.length then EMPTY else dbllist.cons(null, vals[0]).grow(vals[1...])

# @param {Object} ref
# @param {*} head
# @param {Object} tail
# @return {Object}
dbllist.cons = (p, v , n) ->
	prev: (x) -> if x then p = x else if p then p else @
	val: () -> v
	next: () -> if n then n else @
	empty: -> @ is EMPTY
	push: (x) -> @.prev(dbllist.cons(null, x, @))
	grow: (vals) ->
		if vals.length
		then n = dbllist.cons(@, vals[0]).grow(vals[1...])
		else n = EMPTY
		@

EMPTY = dbllist.cons()

module.exports = dbllist