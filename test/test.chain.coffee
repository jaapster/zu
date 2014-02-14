chai = require 'chai'
list = require '../src/list-fn'
chain = require '../src/chain'

assert = chai.assert

describe 'chain list', ->
	describe 'constructor', ->
		it 'create a chain from a list', ->
			assert new chain(list(1,2,3)) instanceof chain

		it 'returns a chain where needed', ->
			xc = new chain(list(1,2,3))
			assert xc.app(4) instanceof chain
			assert xc.take(2) instanceof chain
			assert xc.drop(2) instanceof chain
			assert xc.filter((x) -> x) instanceof chain
			assert xc.map((x) -> x) instanceof chain
			assert xc.flat() instanceof chain
			assert xc.union(xc) instanceof chain
			assert xc.zip(xc, (x, y) -> x + y) instanceof chain
			assert xc.replace(2, 8) instanceof chain
			assert xc.without(2) instanceof chain
			assert xc.replaceAt(2, 8) instanceof chain
			assert xc.removeAt(2) instanceof chain
			assert xc.insertAt(2, 8) instanceof chain