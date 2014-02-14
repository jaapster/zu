chai = require 'chai'
list = require '../src/list-fn'
type = require '../src/type-fn'

assert = chai.assert

describe 'type checks', ->
	xs = new list(1,2,3)
	fn = (question) -> 42

	describe 'isList', ->
		it 'true', ->
			assert type.isList(xs)

		it 'false', ->
			assert not type.isList(7)
			assert not type.isList()
			assert not type.isList('a')
			assert not type.isList(fn)


	describe 'isNum', ->
		it 'true', ->
			assert type.isNum(0)
			assert type.isNum(1)
			assert type.isNum(23.45)

		it 'false', ->
			assert not type.isNum()
			assert not type.isNum('a')
			assert not type.isNum(fn)
			assert not type.isNum(xs)