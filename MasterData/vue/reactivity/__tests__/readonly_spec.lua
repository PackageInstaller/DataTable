local lu = require("test.luaunit")
local Effect = require("Vue.reactivity.effect")
local track, trigger, ITERATE_KEY, effect, stop = Effect.track, Effect.trigger, Effect.ITERATE_KEY, Effect.effect, Effect.stop
local TriggerOpTypes = require("Vue.reactivity.operations.TriggerOpTypes")
local Reactive = require("Vue.reactivity.reactive")
local computed = require("Vue.reactivity.computed")(Reactive).computed
local TrackOpTypes = require("Vue.reactivity.operations.TrackOpTypes")
local reactive, markRaw, isReactive, readonly, isReadonly, shallowReadonly, isShallow = Reactive.reactive, Reactive.markRaw, Reactive.isReactive, Reactive.readonly, Reactive.isReadonly, Reactive.shallowReadonly, Reactive.isShallow
local Ref = require("Vue.reactivity.ref")(Reactive)
local ref, isRef, unref, shallowRef, triggerRef, customRef, toRef, toRefs = Ref.ref, Ref.isRef, Ref.unref, Ref.shallowRef, Ref.triggerRef, Ref.customRef, Ref.toRef, Ref.toRefs
describe("reactivity/readonly", function()
  describe("Object", function()
    it("should make nested values readonly", function()
      local original = {
        foo = 1,
        bar = {baz = 2}
      }
      local wrapped = readonly(original)
      lu.assertEquals(wrapped, original)
      lu.assertEquals(isReactive(wrapped), true)
      lu.assertEquals(isReadonly(wrapped), true)
      lu.assertEquals(isReactive(original), true)
      lu.assertEquals(isReadonly(original), true)
      lu.assertEquals(isReactive(wrapped.bar), true)
      lu.assertEquals(isReadonly(wrapped.bar), true)
      lu.assertEquals(isReactive(original.bar), true)
      lu.assertEquals(isReadonly(original.bar), true)
      lu.assertEquals(wrapped.foo, 1)
      lu.assertEquals(wrapped.foo ~= nil, true)
      lu.assertEquals(wrapped.bar ~= nil, true)
    end)
    it("should not allow mutation", function()
      local qux = setmetatable({"qux"}, {})
      local original = {
        foo = 1,
        bar = {baz = 2},
        [qux] = 3
      }
      local wrapped = readonly(original)
      wrapped.foo = 2
      lu.assertEquals(wrapped.foo, 1)
      lu.toHaveBeenWarned("Set operation on key \"foo\" failed: target is readonly.")
      wrapped.bar.baz = 3
      lu.assertEquals(wrapped.bar.baz, 2)
      lu.toHaveBeenWarned("Set operation on key \"baz\" failed: target is readonly.")
      wrapped[qux] = 4
      lu.assertEquals(wrapped[qux], 3)
      lu.toHaveBeenWarned(" failed: target is readonly.")
      wrapped.foo = nil
      lu.assertEquals(wrapped.foo, 1)
      lu.toHaveBeenWarned("Delete operation on key \"foo\" failed: target is readonly.")
      wrapped.bar.baz = nil
      lu.assertEquals(wrapped.bar.baz, 2)
      lu.toHaveBeenWarned("Delete operation on key \"baz\" failed: target is readonly.")
      wrapped[qux] = nil
      lu.assertEquals(wrapped[qux], 3)
      lu.toHaveBeenWarned("Delete operation on key ")
    end)
    it("should not trigger effects", function()
      local wrapped = readonly({a = 1})
      local dummy
      effect(function()
        dummy = wrapped.a
      end)
      lu.assertEquals(dummy, 1)
      wrapped.a = 2
      lu.assertEquals(wrapped.a, 1)
      lu.assertEquals(dummy, 1)
      lu.toHaveBeenWarned("target is readonly")
    end)
  end)
  describe("Array", function()
    it("should make nested values readonly", function()
      local original = {
        {foo = 1}
      }
      local wrapped = readonly(original)
      lu.assertEquals(wrapped, original)
      lu.assertEquals(isReactive(wrapped), true)
      lu.assertEquals(isReadonly(wrapped), true)
      lu.assertEquals(isReactive(original), true)
      lu.assertEquals(isReadonly(original), true)
      lu.assertEquals(isReactive(wrapped[1]), true)
      lu.assertEquals(isReadonly(wrapped[1]), true)
      lu.assertEquals(isReactive(original[1]), true)
      lu.assertEquals(isReadonly(original[1]), true)
      lu.assertEquals(wrapped[1].foo, 1)
      lu.assertEquals(nil ~= wrapped[1], true)
    end)
    it("should not allow mutation", function()
      lu.clearWarn()
      local wrapped = readonly({
        {foo = 1}
      })
      wrapped[1] = 1
      lu.assertNotEquals(wrapped[1], 1)
      lu.toHaveBeenWarned("Set operation on key \"1\" failed: target is readonly.")
      wrapped[1].foo = 2
      lu.assertEquals(wrapped[1].foo, 1)
      lu.toHaveBeenWarned("Set operation on key \"foo\" failed: target is readonly.")
      wrapped[1] = nil
      lu.assertEquals(#wrapped, 1)
      lu.assertEquals(wrapped[1].foo, 1)
      lu.toHaveBeenWarned("Delete operation on key \"1\" failed: target is readonly.")
      table.insert(wrapped, 2)
      lu.assertEquals(#wrapped, 1)
      lu.toHaveBeenWarnedTimes(4)
    end)
    it("should not trigger effects", function()
      local wrapped = readonly({
        {a = 1}
      })
      lu.clearWarn()
      local dummy
      effect(function()
        dummy = wrapped[1].a
      end)
      lu.assertEquals(dummy, 1)
      wrapped[1].a = 2
      lu.assertEquals(wrapped[1].a, 1)
      lu.assertEquals(dummy, 1)
      lu.toHaveBeenWarnedTimes(1)
      wrapped[1] = {a = 2}
      lu.assertEquals(wrapped[1].a, 1)
      lu.assertEquals(dummy, 1)
      lu.toHaveBeenWarnedTimes(2)
    end)
  end)
  describe("Table", function()
    it("should make nested values readonly", function()
      local key1 = {}
      local key2 = {}
      local original = {
        [key1] = {},
        [key2] = {}
      }
      local wrapped = readonly(original)
      lu.assertEquals(wrapped, original)
      lu.assertEquals(isReactive(wrapped), true)
      lu.assertEquals(isReadonly(wrapped), true)
      lu.assertEquals(isReactive(original), true)
      lu.assertEquals(isReadonly(original), true)
      lu.assertEquals(isReactive(wrapped[key1]), true)
      lu.assertEquals(isReadonly(wrapped[key2]), true)
      lu.assertEquals(isReactive(original[key1]), true)
      lu.assertEquals(isReadonly(original[key2]), true)
    end)
    it("should not allow mutation & not trigger effect", function()
      local map = readonly({})
      local key = {}
      local dummy
      effect(function()
        dummy = map[key]
      end)
      lu.assertIsNil(dummy)
      map[key] = 1
      lu.assertIsNil(dummy)
      lu.assertEquals(nil ~= map[key], false)
      lu.toHaveBeenWarned("Set operation on key \"")
    end)
    it("should retrieve readonly values on iteration", function()
      local key1 = {}
      local key2 = {}
      local original = {
        [key1] = {},
        [key2] = {}
      }
      local wrapped = readonly(original)
      local count = 0
      for key, value in pairs(wrapped) do
        lu.assertEquals(isReadonly(key), true)
        lu.assertEquals(isReadonly(value), true)
        count = count + 1
      end
      lu.assertEquals(count, 2)
      for key, value in pairs(wrapped) do
        lu.assertEquals(isReadonly(value), true)
      end
      for key, value in pairs(wrapped) do
        lu.assertEquals(isReadonly(value), true)
      end
    end)
  end)
  it("calling reactive on an readonly should return readonly", function()
    local a = readonly({})
    local b = reactive(a)
    lu.assertEquals(isReadonly(b), true)
    lu.assertEquals(a, b)
  end)
  it("calling readonly on a reactive object should return readonly", function()
    local a = reactive({})
    local b = readonly(a)
    lu.toHaveBeenWarned("cannot change readonly or shallow on a reactive object")
    lu.assertEquals(isReadonly(b), false)
    lu.assertEquals(a, b)
  end)
  it("readonly should track and trigger if wrapping reactive original", function()
    local a = reactive({n = 1})
    local b = readonly(a)
    lu.assertEquals(isReactive(b), true)
    local dummy
    effect(function()
      dummy = b.n
    end)
    lu.assertEquals(dummy, 1)
    a.n = a.n + 1
    lu.assertEquals(b.n, 2)
    lu.assertEquals(dummy, 2)
  end)
  it("wrapping already wrapped value should return same Proxy", function()
    local original = {foo = 1}
    local wrapped = readonly(original)
    local wrapped2 = readonly(wrapped)
    lu.assertEquals(wrapped2, wrapped)
  end)
  it("wrapping the same value multiple times should return same Proxy", function()
    local original = {foo = 1}
    local wrapped = readonly(original)
    local wrapped2 = readonly(original)
    lu.assertEquals(wrapped2, wrapped)
  end)
  it("markRaw", function()
    local obj = readonly({
      foo = {a = 1},
      bar = markRaw({b = 2})
    })
    lu.assertEquals(isReadonly(obj.foo), true)
    lu.assertEquals(isReactive(obj.bar) ~= nil, false)
  end)
  it("should make ref readonly", function()
    local n = readonly(ref(1))
    lu.toHaveBeenWarned("cannot change readonly or shallow on a reactive object")
    n.value = 2
    lu.assertEquals(n.value, 2)
  end)
  describe("shallowReadonly", function()
    it("should not make non-reactive properties reactive", function()
      local props = shallowReadonly({
        n = {foo = 1}
      })
      lu.assertEquals(isReactive(props.n) == true, false)
    end)
    it("should make root level properties readonly", function()
      local props = shallowReadonly({n = 1})
      props.n = 2
      lu.assertEquals(props.n, 1)
      lu.toHaventWarned()
    end)
    it("should NOT make nested properties readonly", function()
      local props = shallowReadonly({
        n = {foo = 1}
      })
      props.n.foo = 2
      lu.assertEquals(props.n.foo, 2)
      lu.toHaventWarned()
    end)
  end)
end)
