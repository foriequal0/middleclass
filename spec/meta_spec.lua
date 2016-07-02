local class = require 'middleclass'

describe('Class meta', function()

  local Mixin1, Mixin2, Class1, Class2

  before_each(function()
    Mixin1, Mixin2 = {},{}

    Mixin1.meta = {}
    Mixin1.meta.foo = "mixin1-meta-foo"
    Mixin1.meta.bar = "mixin1-meta-bar"

    Mixin2.meta = {}
    Mixin2.meta.baz = "mixin2-meta-baz"

    Class1 = class('Class1'):include(Mixin1, Mixin2)
    Class1.meta.foo = "class1-meta-foo"

    Class2 = class('Class2', Class1)
    Class2.meta.bar2 = "class2-meta-bar2"
  end)

  it('has all its properties copied to its target class', function()
    assert.equal(Class1.meta.bar, 'mixin1-meta-bar')
  end)

  it('makes its properties available to subclasses', function()
    assert.equal(Class2.meta.baz, 'mixin2-meta-baz')
  end)

  it('allows overriding of properties in the same class', function()
    assert.equal(Class2.meta.foo, 'class1-meta-foo')
  end)

  it('allows overriding of properties on subclasses', function()
    assert.equal(Class2.meta.bar2, 'class2-meta-bar2')
  end)

  it('allows collect all properties through its hierarchy', function()
    assert.same(class.metadata(Class2), {
      foo = "class1-meta-foo",
      bar = "mixin1-meta-bar",
      bar2 = "class2-meta-bar2",
      baz = "mixin2-meta-baz",
    })
  end)
end)
