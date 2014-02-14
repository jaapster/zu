'use strict'

list = require './list-fn.coffee'
type = require './type-fn.coffee'
obj = require './obj-fn.coffee'
dbllist = require './dbllist-fn.coffee'
ot = require './ot-fn.coffee'
modellist = require './model-list-fn.coffee'
chain = require './chain.coffee'
modelchain = require './model-chain.coffee'

zu =
	list : list
	modellist : modellist
	chain : chain
	modelchain : modelchain
	type : type
	obj : obj
	dbllist : dbllist
	ot : ot

window.zu = zu