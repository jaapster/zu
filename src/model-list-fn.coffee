'use strict'

list = require './list-fn.coffee'

# @return {List}
modellist = -> list.apply(null, arguments)

modellist.CONNECTOR = 'connector'
modellist.ELEMENT = 'element'

modellist.isElement = (x) -> x.class == modellist.ELEMENT
modellist.isConnector = (x) -> x.class == modellist.CONNECTOR

# @param {List} xs
# @return {List}
modellist.elements = (xs) -> list.filter(xs, modellist.isElement)

# @param {List} xs
# @return {List}
modellist.connectors = (xs) -> list.filter(xs, modellist.isConnector)

# @param {List} xs
# @return {List}
modellist.selected = (xs) -> list.filter(xs, (e) -> e.selected)

# @param {List} xs
# @param {String} id
# @return {Object}
modellist.byId = (xs, id) ->
	l = list.filter(xs, (e) -> e.id is id)
	if list.empty(l) then null else l.head()

# @param {List} xs
# @param {Object} p
# @param {Number} p.x
# @param {Number} p.y
# @return {List}
modellist.hits = (xs, p) ->
	list.filter(xs, (e) ->
		if modellist.isElement(e)
			w = e.width / 2
			h = e.height / 2
			e.x + w > p.x > e.x - w and e.y + h > p.y > e.y - h
		else no
	)

# @param {List} xs
# @param {Number} x
# @param {Number} y
# @return {List}
modellist.move = (xs, x, y) ->
	list.map(xs, (e) ->
		if modellist.isElement(e)
			e.x += x
			e.y += y
		e
	)

# @param {List} xs
# @return {List}
modellist.snap = (xs) ->
	list.map(xs, (e) ->
		if modellist.isElement(e)
			e.x = Math.round(e.x / 150) * 150
			e.y = Math.round(e.y / 100) * 100
		e
	)

module.exports = modellist