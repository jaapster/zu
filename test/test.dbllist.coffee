chai = require 'chai'
dbllist = require '../src/dbllist-fn'

assert = chai.assert

describe 'dbllist', ->
	it 'dbllist', ->
		assert dbllist(1,2,3) instanceof Object

	it 'dbllist.head', ->
		console.log dbllist(1,2,3).next().val()
		assert dbllist(1,2,3).val() is 1

	it 'dbllist.tail', ->
		assert dbllist(1,2,3).next().val() is 2

	it 'dbllist.prev', ->
		xs = dbllist(1,2,3)
		assert xs.next().prev() is xs

