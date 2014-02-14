'use strict'

list = require './list-fn.coffee'
mlist = require './model-list-fn.coffee'

ot = ->

ot.REMOVE = 'remove'
ot.ADD = 'add'
ot.SET = 'set'

# @param {List} xs
# @param {List} model
# @return {Object}
ot.add = (xs, model) ->
	if model
		[list.cons(model, xs), {
			type: ot.ADD
			id: model.id
			newval: model
		}]
	else
		[xs, null]

# @param {List} xs
# @param {String} id
# @return {Object}
ot.remove = (xs, id) ->
	model = mlist.byId(xs, id)
	if model
		[list.without(xs, model), {
			type: ot.REMOVE
			id: id
			oldval: model
		}]
	else
		[xs, null]

# @param {List} xs
# @param {String} id
# @param {String} key
# @param {*} newval
# @param {*} oldval
# @return {Object}
ot.set = (xs, id, key, newval, oldval) ->
	model = mlist.byId(xs, id)
	if model and not oldval or oldval is model[key]
		[xs, {
			type: ot.SET
			id: id
			key: key
			oldval: oldval
			newval: model[key] = val
		}]
	else
		[xs, null]

# @param {List} xs
# @param {Object} t
# @return {Object}
ot.undo = (xs, t) ->
	if t.type is ot.REMOVE and not mlist.byId(xs, t.id) then ot.add(xs, t.oldval)
	else if t.type is ot.ADD then ot.remove(xs, t.id)
	else if t.type is ot.SET then ot.set(xs, id, key, t.oldval)
	else null

# @param {List} xs
# @param {Object} t
# @return {Object}
ot.do = (xs, t) ->
	if t.type is ot.REMOVE then ot.remove(xs, t.id)
	else if t.type is ot.ADD and not mlist.byId(xs, t.id) then ot.add(xs, t.newval)
	else if t.type is ot.SET then ot.set(xs, id, key, t.newval)
	else null

module.exports = ot