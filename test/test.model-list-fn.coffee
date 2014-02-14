chai = require 'chai'
type = require '../src/type-fn'
list = require '../src/list-fn'
modellist = require '../src/model-list-fn'

assert = chai.assert

describe 'modellist', ->
	describe 'constructor', ->
		it 'should create an empty List', ->
			assert list.empty(modellist()) is yes
			assert type.isList(modellist()) is yes

		it 'create a non empty List', ->
			assert not list.empty modellist(1)

		it 'create a List with one element', ->
			xs = modellist(1)
			assert xs.head() is 1
			assert list.empty(xs.tail()) is yes

	xs = modellist(
		id: '1'
		class: modellist.CONNECTOR
		selected: yes
	,
		id: '2'
		class: modellist.CONNECTOR
	,
		id: '3'
		class: modellist.ELEMENT
		x: 150
		y: 150
		width: 100
		height: 100
	,
		id: '4'
		class: modellist.ELEMENT
		selected: yes
		x: 200
		y: 200
		width: 100
		height: 100
	,
		id: '5'
		class: modellist.ELEMENT
		x: 400
		y: 400
		width: 100
		height: 100
	)

	describe 'filters', ->
		describe 'elements', ->
			it 'return all elements', ->
				assert list.len(modellist.elements(xs)) is 3

		describe 'connectors', ->
			it 'return all connectors', ->
				ys = modellist.connectors(xs)
				assert list.len(ys) is 2

		describe 'selected', ->
			it 'return all selected', ->
				ys = modellist.selected(xs)
				assert list.len(ys) is 2

		describe 'byId', ->
			it 'return element by id', ->
				x = modellist.byId(xs, '4')
				assert x.selected is yes
				assert x.id is '4'
				assert x.class is modellist.ELEMENT

			it 'return null when not found', ->
				assert  modellist.byId(xs, '10') is null

	describe 'hits', ->
		it 'return multiple elements', ->
			ys = modellist.hits(xs,
				x: 175
				y: 175
			)

			assert list.len(ys) is 2
			assert ys.head().id is '3'
			assert ys.tail().head().id is '4'

		it 'return one element', ->
			ys = modellist.hits(xs,
				x: 225
				y: 225
			)

			assert list.len(ys) is 1
			assert ys.head().id is '4'

		it 'return no element', ->
			ys = modellist.hits(xs,
				x: 10
				y: 10
			)

			assert list.empty(ys) is yes

	describe 'move', ->

	describe 'snap', ->