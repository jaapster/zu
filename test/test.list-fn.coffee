chai = require 'chai'
list = require '../src/list-fn'
type = require '../src/type-fn'

assert = chai.assert

describe 'list', ->
	describe 'constructor', ->
		it 'should create an empty List', ->
			assert list.empty(list()) is yes
			assert type.isList(list()) is yes

		it 'create a non empty List', ->
			assert not list.empty list(1)

		it 'create a List with one element', ->
			xs = list(1)
			assert xs.head() is 1
			assert list.empty(xs.tail()) is yes

	describe 'len', ->
		it 'return the list size', ->
			ws = list()
			xs = list(1)
			ys = list.cons(2, xs)
			assert list.len(ws) is 0
			assert list.len(xs) is 1
			assert list.len(ys) is 2

	describe 'cons', ->
		it 'create a new list', ->
			xs = list.cons(9, list(1,2,3,4))
			assert xs.head() is 9
			assert list.len(xs) is 5

		it 'create a new list with empty tail', ->
			xs = list.cons(3, list())
			assert xs.head() is 3

	describe 'app', ->
		it 'append values to a non empty list', ->
			xs = list.app(list(1,2,3), 4)
			assert xs.tail().tail().tail().head() is 4

		it 'append values to an empty list', ->
			xs = list.app(list(), 3)
			assert xs.head() is 3

	describe 'union', ->
		it 'two empty Lists', ->
			xs = list.union(list(), list())
			assert list.empty(xs) is yes

		it 'empty list and non empty list', ->
			xs = list(1)
			assert list.union(list(), xs) is xs

		it 'non empty list and empty list', ->
			xs = list(1)
			ys = list()
			zs = list.union(xs, ys)
			assert zs.tail() is ys
			assert zs.head() is 1

		it 'combine two non empty lists', ->
			xs = list(1,2,3)
			ys = list(4,5,6)
			zs = list.union(xs, ys)
			assert list.string(zs) is '1,2,3,4,5,6'

	describe 'filter', ->
		it 'with predicate and wthout scope', ->
			xs = list.filter(list(1,2,3), (x) -> x > 1)
			assert list.string(xs) is '2,3'

	describe 'map', ->
		it 'with map and wthout scope', ->
			xs = list.map(list(1,2,3), (x) -> x + 1)
			assert list.string(xs) is '2,3,4'

	describe 'nth', ->
		it 'return the value at index', ->
			assert list.nth(list(1,2,3,4,5), 3) is 4

		it 'return null on an empty list', ->
			assert list.nth(list(), 3) is null

		it 'should return null if index exceeds List size', ->
			assert list.nth(list(1,2,3,4,5), 10) is null

		it 'should return null if no index', ->
			assert list.nth(list(1,2,3,4,5)) is null

		it 'should return null if no valid index', ->
			assert list.nth(list(1,2,3,4,5), 'd') is null

	describe 'take', ->
		it 'return correct number of elements', ->
			assert list.len(list.take(list(1,2,3,4,5), 3)) is 3

		it 'return elements from start', ->
			assert list.string(list.take(list(1,2,3,4,5), 3)) is '1,2,3'

		it 'return EMPTY when n is 0', ->
			assert list.empty(list.take(list(1,2,3,4,5), 0)) is yes

		it 'return entire list if n exceeds List size', ->
			assert list.string(list.take(list(1,2,3,4,5), 3)) is '1,2,3'

		it 'return EMPTY if no n', ->
			assert list.empty(list.take(list(1,2,3,4,5))) is yes

		it 'return EMPTY if no valid n', ->
			assert list.empty(list.take(list(1,2,3,4,5), 'a')) is yes

	describe 'drop', ->
		it 'should return correct number of elements', ->
			assert list.len(list.drop(list(1,2,3,4,5), 3)) is 2

		it 'should return elements from end', ->
			assert list.string(list.drop(list(1,2,3,4,5), 3)) is '4,5'

		it 'should return complete list when n is 0', ->
			assert list.len(list.drop(list(1,2,3,4,5), 0)) is 5

		it 'should return empty list if n exceeds list size', ->
			assert list.empty(list.drop(list(1,2,3,4,5), 10)) is yes

		it 'should return empty list if no n', ->
			assert list.empty(list.drop(list(1,2,3,4,5))) is yes

		it 'should return empty list if no valid n', ->
			assert list.empty(list.drop(list(1,2,3,4,5), 'a')) is yes

	describe 'flat', ->
		it 'flatten a list containing non empty Lists', ->
			as = list(1,2,3)
			bs = list(4,5,6)
			cs = list(7,8,9)
			ds = list(as, bs, cs)
			fs = list.flat(ds)
			assert list.len(fs) is 9
			assert list.string(fs) is '1,2,3,4,5,6,7,8,9'

		it 'flatten a list containing empty lists', ->
			as = list()
			bs = list()
			cs = list()
			ds = list(as, bs, cs)
			fs = list.flat(ds)
			assert list.len(fs) is 0

		it 'return an empty list', ->
			assert list.empty(list.flat(list())) is yes

		it 'return a list containing no nested Lists', ->
			assert list.len(list.flat(list(1,2,3))) is 3

	describe 'removeAt', ->
		it 'return a list without element at index', ->
			xs = list(1,2,3,4,5)
			ys = list.removeAt(xs, 2)
			assert list.len(ys) is 4
			assert list.string(ys) is '1,2,4,5'

		it 'return an empty list', ->
			xs = list.removeAt(list(), 2)
			assert list.len(xs) is 0

		it 'return list if index exceeds list size', ->
			xs = list(1,2,3,4,5)
			ys = list.removeAt(xs, 10)
			assert list.len(ys) is 5
			assert list.string(ys) is '1,2,3,4,5'

		it 'return list if no valid index', ->
			xs = list(1,2,3,4,5)
			ys = list.removeAt(xs, 'a')
			assert list.len(ys) is 5
			assert list.string(ys) is '1,2,3,4,5'

	describe 'insertAt', ->
		it 'return a list with new element at index', ->
			xs = list(1,2,3,4,5)
			ys = list.insertAt(xs, 2, 9)
			assert list.len(ys) is 6
			assert list.string(ys) is '1,2,9,3,4,5'

		it 'append new element if index exceeds list size', ->
			xs = list(1,2,3,4,5)
			ys = list.insertAt(xs, 10, 9)
			assert list.len(ys) is 6
			assert list.string(ys) is '1,2,3,4,5,9'

		it 'return list if no valid index', ->
			xs = list(1,2,3,4,5)
			ys = list.insertAt(xs, 'a', 9)
			assert list.len(ys) is 5
			assert list.string(ys) is '1,2,3,4,5'

		it 'return list if no valid new element', ->
			xs = list(1,2,3,4,5)
			ys = list.insertAt(xs, 2)
			assert list.len(ys) is 5
			assert list.string(ys) is '1,2,3,4,5'

	describe 'replaceAt', ->
		it 'return a list with replaced element at index', ->
			xs = list(1,2,3,4,5)
			ys = list.replaceAt(xs, 2, 9)
			assert list.len(ys) is 5
			assert list.string(ys) is '1,2,9,4,5'

		it 'return list if index exceeds List size', ->
			xs = list(1,2,3,4,5)
			ys = list.replaceAt(xs, 10, 9)
			assert list.len(ys) is 5
			assert list.string(ys) is '1,2,3,4,5'

		it 'return list if no valid index', ->
			xs = list(1,2,3,4,5)
			ys = list.replaceAt(xs, 'a', 9)
			assert list.len(ys) is 5
			assert list.string(ys) is '1,2,3,4,5'

		it 'return list if no valid new element', ->
			xs = list(1,2,3,4,5)
			ys = list.replaceAt(xs, 2)
			assert list.len(ys) is 5
			assert list.string(ys) is '1,2,3,4,5'

	describe 'zip', ->
		it 'zip lists of equal length', ->
			xs = list(1,2,3,4,5)
			ys = list(2,2,3,4,4)
			zs = list.zip(xs, ys, (x, y) -> x * y)
			assert list.len(zs) is 5
			assert list.string(zs) is '2,4,9,16,20'

		it 'zip short and long list', ->
			xs = list(1,2)
			ys = list(2,2,3,4,4)
			zs = list.zip(xs, ys, (x, y) -> x * y)
			assert list.len(zs) is 5
			assert list.string(zs) is '2,4,3,4,4'

		it 'zip long and short list', ->
			xs = list(1,2)
			ys = list(2,2,3,4,4)
			zs = list.zip(ys, xs, (x, y) -> x * y)
			assert list.len(zs) is 5
			assert list.string(zs) is '2,4,3,4,4'

		it 'zip empty lists', ->
			zs = list.zip(list(), list(), (x, y) -> x * y)
			assert list.empty(zs) is yes

		it 'zip empty and filled lists', ->
			zs = list.zip(list(), list(1,2,3), (x, y) -> x * y)
			assert list.len(zs) is 3
			assert list.string(zs) is '1,2,3'

		it 'zip filled and empty lists', ->
			zs = list.zip(list(1,2,3), list(), (x, y) -> x * y)
			assert list.len(zs) is 3
			assert list.string(zs) is '1,2,3'

	describe 'has', ->
		it 'has the element', ->
			assert list.has(list(1,2,3), 2) is yes

		it 'hasn\'t the element', ->
			assert list.has(list(1,2,3), 4) is no

	describe 'without', ->
		it 'has the element', ->
			xs = list.without(list(1,2,3,2,5), 2)
			assert list.string(xs) is '1,3,5'

		it 'hasn\'t the element', ->
			xs = list.without(list(1,2,3,2,5), 8)
			assert list.string(xs) is '1,2,3,2,5'

	describe 'replace', ->
		it 'replace existing with existing', ->
			xs = list.replace(list(1,2,3,2,5), 2, 8)
			assert list.string(xs) is '1,8,3,8,5'

		it 'replace non-existing with existing', ->
			xs = list.replace(list(1,2,3,2,5), 7, 8)
			assert list.string(xs) is '1,2,3,2,5'

		it 'replace existing with non-existing', ->
			xs = list.replace(list(1,2,3,2,5), 2)
			assert list.string(xs) is '1,2,3,2,5'

	describe 'every', ->
		it 'is true', ->
			xs = list(1,2,3,2,5)
			assert list.every(xs, (x) -> typeof x is 'number') is yes

		it 'is false', ->
			xs = list(1,2,3,2,'a')
			assert list.every(xs, (x) -> typeof x is 'number') is no

	describe 'some', ->
		it 'is true', ->
			xs = list(1,2,3,2,'a')
			assert list.some(xs, (x) -> typeof x is 'number') is yes

		it 'is also true', ->
			xs = list(1,2,3,2,5)
			assert list.some(xs, (x) -> typeof x is 'number') is yes

		it 'is false', ->
			xs = list(1,2,3,2,5)
			assert list.some(xs, (x) -> typeof x is 'string') is no