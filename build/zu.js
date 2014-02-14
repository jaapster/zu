(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
(function() {
  'use strict';
  var chain, list;

  list = require('./list-fn.coffee');

  chain = (function() {

    function chain(xs, C) {
      if (C == null) C = chain;
      this.C = C;
      this.xs = function() {
        return xs;
      };
    }

    chain.prototype.head = function() {
      return this.xs().head();
    };

    chain.prototype.tail = function() {
      return this.xs().tail();
    };

    chain.prototype.list = function() {
      return this.xs();
    };

    chain.prototype.has = function(x) {
      return list.has(this.xs(), x);
    };

    chain.prototype.every = function(p) {
      return list.every(this.xs(), p);
    };

    chain.prototype.some = function(p) {
      return list.some(this.xs(), p);
    };

    chain.prototype.array = function() {
      return list.array(this.xs());
    };

    chain.prototype.string = function() {
      return list.string(this.xs());
    };

    chain.prototype.len = function() {
      return list.len(this.xs());
    };

    chain.prototype.empty = function() {
      return list.empty(this.xs());
    };

    chain.prototype.nth = function(n) {
      return list.nth(this.xs(), n);
    };

    chain.prototype.app = function(x) {
      return new this.C(list.app(this.xs(), x));
    };

    chain.prototype.take = function(n) {
      return new this.C(list.take(this.xs(), n));
    };

    chain.prototype.drop = function(n) {
      return new this.C(list.drop(this.xs(), n));
    };

    chain.prototype.filter = function(p) {
      return new this.C(list.filter(this.xs(), p));
    };

    chain.prototype.map = function(m) {
      return new this.C(list.map(this.xs(), m));
    };

    chain.prototype.flat = function() {
      return new this.C(list.flat(this.xs()));
    };

    chain.prototype.union = function(c) {
      return new this.C(list.union(this.xs(), c.list()));
    };

    chain.prototype.zip = function(yc, m) {
      return new this.C(list.zip(this.xs(), yc.xs(), m));
    };

    chain.prototype.insertAt = function(i, x) {
      return new this.C(list.insertAt(this.xs(), i, x));
    };

    chain.prototype.removeAt = function(i) {
      return new this.C(list.removeAt(this.xs(), i));
    };

    chain.prototype.replaceAt = function(i, x) {
      return new this.C(list.replaceAt(this.xs(), i, x));
    };

    chain.prototype.without = function(x) {
      return new this.C(list.without(this.xs(), x));
    };

    chain.prototype.replace = function(x, y) {
      return new this.C(list.replace(this.xs(), x, y));
    };

    return chain;

  })();

  module.exports = chain;

}).call(this);

},{"./list-fn.coffee":3}],2:[function(require,module,exports){
(function() {
  'use strict';
  var EMPTY, dbllist,
    __slice = Array.prototype.slice;

  dbllist = function() {
    var vals;
    vals = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    if (!vals.length) {
      return EMPTY;
    } else {
      return dbllist.cons(null, vals[0]).grow(vals.slice(1));
    }
  };

  dbllist.cons = function(p, v, n) {
    return {
      prev: function(x) {
        if (x) {
          return p = x;
        } else if (p) {
          return p;
        } else {
          return this;
        }
      },
      val: function() {
        return v;
      },
      next: function() {
        if (n) {
          return n;
        } else {
          return this;
        }
      },
      empty: function() {
        return this === EMPTY;
      },
      push: function(x) {
        return this.prev(dbllist.cons(null, x, this));
      },
      grow: function(vals) {
        if (vals.length) {
          n = dbllist.cons(this, vals[0]).grow(vals.slice(1));
        } else {
          n = EMPTY;
        }
        return this;
      }
    };
  };

  EMPTY = dbllist.cons();

  module.exports = dbllist;

}).call(this);

},{}],3:[function(require,module,exports){
(function() {
  'use strict';
  var EMPTY, list, type,
    __slice = Array.prototype.slice;

  type = require('./type-fn.coffee');

  list = function() {
    var args;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    if (!args.length) {
      return EMPTY;
    } else {
      return list.cons(args[0], list.apply(null, args.slice(1)));
    }
  };

  list.cons = function(head, tail) {
    return {
      head: function() {
        if (this === EMPTY) {
          return 'empty';
        } else {
          return head;
        }
      },
      tail: function() {
        return tail;
      }
    };
  };

  list.len = function(xs) {
    if (xs === EMPTY) {
      return 0;
    } else {
      return 1 + list.len(xs.tail());
    }
  };

  list.empty = function(xs) {
    return xs === EMPTY;
  };

  list.app = function(xs, x) {
    if (xs === EMPTY) {
      return list.cons(x, EMPTY);
    } else {
      return list.cons(xs.head(), list.app(xs.tail(), x));
    }
  };

  list.union = function(xs, ys) {
    if (xs === EMPTY) {
      return ys;
    } else {
      return list.cons(xs.head(), list.union(xs.tail(), ys));
    }
  };

  list.take = function(xs, n) {
    if (xs === EMPTY || !type.isNum(n) || n === 0) {
      return EMPTY;
    } else {
      return list.cons(xs.head(), list.take(xs.tail(), n - 1));
    }
  };

  list.drop = function(xs, n) {
    if (xs === EMPTY || n === 0) {
      return xs;
    } else if (!type.isNum(n)) {
      return EMPTY;
    } else {
      return list.drop(xs.tail(), n - 1);
    }
  };

  list.nth = function(xs, n) {
    if (xs === EMPTY) {
      return null;
    } else if (n === 0) {
      return xs.head();
    } else {
      return list.nth(xs.tail(), n - 1);
    }
  };

  list.filter = function(xs, p) {
    if (xs === EMPTY) {
      return xs;
    } else if (p(xs.head())) {
      return list.cons(xs.head(), list.filter(xs.tail(), p));
    } else {
      return list.filter(xs.tail(), p);
    }
  };

  list.map = function(xs, m) {
    if (xs === EMPTY) {
      return xs;
    } else {
      return list.cons(m(xs.head()), list.map(xs.tail(), m));
    }
  };

  list.flat = function(xs) {
    if (xs === EMPTY) {
      return EMPTY;
    } else if (!type.isList(xs.head())) {
      return list.cons(xs.head(), list.flat(xs.tail()));
    } else {
      return list.union(list.flat(xs.head()), list.flat(xs.tail()));
    }
  };

  list.insertAt = function(xs, i, x) {
    if (!type.isNum(i) || !x) {
      return xs;
    } else if (xs === EMPTY || i === 0) {
      return list.cons(x, xs);
    } else {
      return list.cons(xs.head(), list.insertAt(xs.tail(), i - 1, x));
    }
  };

  list.removeAt = function(xs, i) {
    if (xs === EMPTY || !type.isNum(i)) {
      return xs;
    } else if (i === 0) {
      return xs.tail();
    } else {
      return list.cons(xs.head(), list.removeAt(xs.tail(), i - 1));
    }
  };

  list.replaceAt = function(xs, i, x) {
    if (!type.isNum(i) || !x || xs === EMPTY) {
      return xs;
    } else if (i === 0) {
      return list.cons(x, xs.tail());
    } else {
      return list.cons(xs.head(), list.replaceAt(xs.tail(), i - 1, x));
    }
  };

  list.zip = function(xs, ys, m) {
    if (ys === EMPTY) {
      return xs;
    } else if (xs === EMPTY) {
      return ys;
    } else {
      return list.cons(m(xs.head(), ys.head()), list.zip(xs.tail(), ys.tail(), m));
    }
  };

  list.has = function(xs, x) {
    if (xs === EMPTY) {
      return false;
    } else {
      return xs.head() === x || list.has(xs.tail(), x);
    }
  };

  list.without = function(xs, x) {
    return list.filter(xs, function(e) {
      return e !== x;
    });
  };

  list.replace = function(xs, x, y) {
    if (!y) {
      return xs;
    } else {
      return list.map(xs, function(e) {
        if (e === x) {
          return y;
        } else {
          return e;
        }
      });
    }
  };

  list.each = function(xs, f) {
    if (!xs === EMPTY) {
      f(xs.head());
      list.each(xs.tail(), f);
    }
    return xs;
  };

  list.every = function(xs, p) {
    return list.len(xs) === list.len(list.filter(xs, p));
  };

  list.some = function(xs, p) {
    return list.len(list.filter(xs, p)) > 0;
  };

  list.array = function(xs, a) {
    if (a == null) a = [];
    if (xs === EMPTY) {
      return a;
    } else {
      return [xs.head()].concat(list.array(xs.tail()));
    }
  };

  list.string = function(xs) {
    return list.array(xs).join(',');
  };

  list.clone = function(xs) {
    return list.cons(xs.head(), xs.tail());
  };

  EMPTY = list.cons({}, {});

  module.exports = list;

}).call(this);

},{"./type-fn.coffee":9}],4:[function(require,module,exports){
(function() {
  'use strict';
  var chain, dbllist, list, modelchain, modellist, obj, ot, type, zu;

  list = require('./list-fn.coffee');

  type = require('./type-fn.coffee');

  obj = require('./obj-fn.coffee');

  dbllist = require('./dbllist-fn.coffee');

  ot = require('./ot-fn.coffee');

  modellist = require('./model-list-fn.coffee');

  chain = require('./chain.coffee');

  modelchain = require('./model-chain.coffee');

  zu = {
    list: list,
    modellist: modellist,
    chain: chain,
    modelchain: modelchain,
    type: type,
    obj: obj,
    dbllist: dbllist,
    ot: ot
  };

  window.zu = zu;

}).call(this);

},{"./chain.coffee":1,"./dbllist-fn.coffee":2,"./list-fn.coffee":3,"./model-chain.coffee":5,"./model-list-fn.coffee":6,"./obj-fn.coffee":7,"./ot-fn.coffee":8,"./type-fn.coffee":9}],5:[function(require,module,exports){
(function() {
  'use strict';
  var chain, modelchain, modellist,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  chain = require('./chain.coffee');

  modellist = require('./model-list-fn.coffee');

  modelchain = (function(_super) {

    __extends(modelchain, _super);

    function modelchain(xs, C) {
      if (C == null) C = modelchain;
      modelchain.__super__.constructor.call(this, xs, C);
    }

    modelchain.prototype.selected = function() {
      return new this.C(modellist.selected(this.xs()));
    };

    modelchain.prototype.elements = function() {
      return new this.C(modellist.elements(this.xs()));
    };

    modelchain.prototype.connectors = function() {
      return new this.C(modellist.connectors(this.xs()));
    };

    modelchain.prototype.byId = function(id) {
      return new this.C(modellist.byId(this.xs(), id));
    };

    modelchain.prototype.hits = function(p) {
      return new this.C(modellist.hits(this.xs(), p));
    };

    modelchain.prototype.move = function(x, y) {
      return new this.C(modellist.move(this.xs(), x, y));
    };

    modelchain.prototype.snap = function() {
      return new this.C(modellist.snap(this.xs()));
    };

    return modelchain;

  })(chain);

  module.exports = modelchain;

}).call(this);

},{"./chain.coffee":1,"./model-list-fn.coffee":6}],6:[function(require,module,exports){
(function() {
  'use strict';
  var list, modellist;

  list = require('./list-fn.coffee');

  modellist = function() {
    return list.apply(null, arguments);
  };

  modellist.CONNECTOR = 'connector';

  modellist.ELEMENT = 'element';

  modellist.isElement = function(x) {
    return x["class"] === modellist.ELEMENT;
  };

  modellist.isConnector = function(x) {
    return x["class"] === modellist.CONNECTOR;
  };

  modellist.elements = function(xs) {
    return list.filter(xs, modellist.isElement);
  };

  modellist.connectors = function(xs) {
    return list.filter(xs, modellist.isConnector);
  };

  modellist.selected = function(xs) {
    return list.filter(xs, function(e) {
      return e.selected;
    });
  };

  modellist.byId = function(xs, id) {
    var l;
    l = list.filter(xs, function(e) {
      return e.id === id;
    });
    if (list.empty(l)) {
      return null;
    } else {
      return l.head();
    }
  };

  modellist.hits = function(xs, p) {
    return list.filter(xs, function(e) {
      var h, w, _ref, _ref2;
      if (modellist.isElement(e)) {
        w = e.width / 2;
        h = e.height / 2;
        return (e.x + w > (_ref = p.x) && _ref > e.x - w) && (e.y + h > (_ref2 = p.y) && _ref2 > e.y - h);
      } else {
        return false;
      }
    });
  };

  modellist.move = function(xs, x, y) {
    return list.map(xs, function(e) {
      if (modellist.isElement(e)) {
        e.x += x;
        e.y += y;
      }
      return e;
    });
  };

  modellist.snap = function(xs) {
    return list.map(xs, function(e) {
      if (modellist.isElement(e)) {
        e.x = Math.round(e.x / 150) * 150;
        e.y = Math.round(e.y / 100) * 100;
      }
      return e;
    });
  };

  module.exports = modellist;

}).call(this);

},{"./list-fn.coffee":3}],7:[function(require,module,exports){
(function() {
  'use strict';
  var obj;

  obj = function(values) {
    return Object.create(values);
  };

  obj.set = function(obj, name, value) {
    var key, values, _i, _len;
    values = {};
    for (_i = 0, _len = obj.length; _i < _len; _i++) {
      key = obj[_i];
      if (key === name) {
        values[key] = value;
      } else {
        values[key] = obj.key;
      }
    }
    return obj(values);
  };

  obj.map = function(obj, f) {
    var key, values, _i, _len;
    values = {};
    for (_i = 0, _len = obj.length; _i < _len; _i++) {
      key = obj[_i];
      values[key] = f(obj.key);
    }
    return obj(values);
  };

  module.exports = obj;

}).call(this);

},{}],8:[function(require,module,exports){
(function() {
  'use strict';
  var list, mlist, ot;

  list = require('./list-fn.coffee');

  mlist = require('./model-list-fn.coffee');

  ot = function() {};

  ot.REMOVE = 'remove';

  ot.ADD = 'add';

  ot.SET = 'set';

  ot.add = function(xs, model) {
    if (model) {
      return [
        list.cons(model, xs), {
          type: ot.ADD,
          id: model.id,
          newval: model
        }
      ];
    } else {
      return [xs, null];
    }
  };

  ot.remove = function(xs, id) {
    var model;
    model = mlist.byId(xs, id);
    if (model) {
      return [
        list.without(xs, model), {
          type: ot.REMOVE,
          id: id,
          oldval: model
        }
      ];
    } else {
      return [xs, null];
    }
  };

  ot.set = function(xs, id, key, newval, oldval) {
    var model;
    model = mlist.byId(xs, id);
    if (model && !oldval || oldval === model[key]) {
      return [
        xs, {
          type: ot.SET,
          id: id,
          key: key,
          oldval: oldval,
          newval: model[key] = val
        }
      ];
    } else {
      return [xs, null];
    }
  };

  ot.undo = function(xs, t) {
    if (t.type === ot.REMOVE && !mlist.byId(xs, t.id)) {
      return ot.add(xs, t.oldval);
    } else if (t.type === ot.ADD) {
      return ot.remove(xs, t.id);
    } else if (t.type === ot.SET) {
      return ot.set(xs, id, key, t.oldval);
    } else {
      return null;
    }
  };

  ot["do"] = function(xs, t) {
    if (t.type === ot.REMOVE) {
      return ot.remove(xs, t.id);
    } else if (t.type === ot.ADD && !mlist.byId(xs, t.id)) {
      return ot.add(xs, t.newval);
    } else if (t.type === ot.SET) {
      return ot.set(xs, id, key, t.newval);
    } else {
      return null;
    }
  };

  module.exports = ot;

}).call(this);

},{"./list-fn.coffee":3,"./model-list-fn.coffee":6}],9:[function(require,module,exports){
(function() {
  'use strict';
  var type;

  type = function() {
    return null;
  };

  type.isDefined = function(x) {
    return x !== void 0 && x !== null;
  };

  type.isNum = function(x) {
    return type.isDefined(x) && (typeof x === 'number');
  };

  type.isList = function(x) {
    return type.isDefined(x) && type.isFunction(x.head) && type.isFunction(x.tail);
  };

  type.isObject = function(x) {
    return type.isDefined(x) && x.constructor === Object;
  };

  type.isArray = function(x) {
    return type.isDefined(x) && x.constructor === Array;
  };

  type.isFunction = function(x) {
    return type.isDefined(x) && x.constructor === Function;
  };

  module.exports = type;

}).call(this);

},{}]},{},[4])