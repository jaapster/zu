'use strict'

chain = require './chain.coffee'
modellist = require './model-list-fn.coffee'

class modelchain extends chain

	constructor: (xs, C = modelchain) -> super(xs, C)

	selected: -> 					new @C(modellist.selected(@xs()))
	elements: -> 					new @C(modellist.elements(@xs()))
	connectors: -> 				new @C(modellist.connectors(@xs()))
	byId: (id) -> 				new @C(modellist.byId(@xs(), id))
	hits: (p) -> 					new @C(modellist.hits(@xs(), p))
	move: (x, y) -> 			new @C(modellist.move(@xs(), x, y))
	snap: -> 							new @C(modellist.snap(@xs()))

module.exports = modelchain