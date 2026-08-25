local lu = require("test.luaunit")
local Effect = require("Vue.reactivity.effect")
local track, trigger, ITERATE_KEY, effect, stop = Effect.track, Effect.trigger, Effect.ITERATE_KEY, Effect.effect, Effect.stop
local TriggerOpTypes = require("Vue.reactivity.operations.TriggerOpTypes")
local Reactive = require("Vue.reactivity.reactive")
local computed = require("Vue.reactivity.computed")(Reactive).computed
local TrackOpTypes = require("Vue.reactivity.operations.TrackOpTypes")
local reactive, markRaw, isReactive = Reactive.reactive, Reactive.markRaw, Reactive.isReactive
local Ref = require("Vue.reactivity.ref")(Reactive)
local ref, isRef = Ref.ref, Ref.isRef
describe("reactivity/reactive", function()
  it("Object", function()
    local original = {foo = 1}
    local observed = reactive(original)
    lu.assertEquals(observed, original)
    lu.assertEquals(isReactive(observed), true)
    lu.assertEquals(isReactive(original), true)
    lu.assertEquals(observed.foo, 1)
    lu.assertEquals(observed.foo ~= nil, true)
    for i, v in pairs(observed) do
      lu.assertEquals(i, "foo")
    end
  end)
  it("proto", function()
    local obj = {}
    local reactiveObj = reactive(obj)
    lu.assertEquals(isReactive(reactiveObj), true)
    local prototype = reactiveObj.__proto__
    local otherObj = {
      data = {"a"}
    }
    lu.assertEquals(true == isReactive(otherObj), false)
    local reactiveOther = reactive(otherObj)
    lu.assertEquals(true == isReactive(reactiveOther), true)
    lu.assertEquals(reactiveOther.data[1], "a")
  end)
  it("nested reactives", function()
    local original = {
      nested = {foo = 1},
      array = {
        {bar = 2}
      }
    }
    local observed = reactive(original)
    lu.assertEquals(isReactive(observed.nested), true)
    lu.assertEquals(isReactive(observed.array), true)
    lu.assertEquals(isReactive(observed.array[1]), true)
  end)
  it("observed value should proxy mutations to original (Object)", function()
    local original = {foo = 1}
    local observed = reactive(original)
    observed.bar = 1
    lu.assertEquals(observed.bar, 1)
    lu.assertEquals(original.bar, 1)
    observed.foo = nil
    lu.assertEquals(observed.foo ~= nil, false)
    lu.assertEquals(original.foo ~= nil, false)
  end)
  it("setting a property with an unobserved value should wrap with reactive", function()
    local observed = reactive({})
    local raw = {}
    observed.foo = raw
    lu.assertEquals(observed.foo, raw)
    lu.assertEquals(isReactive(observed.foo), true)
  end)
  it("observing already observed value should return same Proxy", function()
    local original = {foo = 1}
    local observed = reactive(original)
    local observed2 = reactive(observed)
    lu.assertEquals(observed2, observed)
  end)
  it("observing the same value multiple times should return same Proxy", function()
    local original = {foo = 1}
    local observed = reactive(original)
    local observed2 = reactive(original)
    lu.assertEquals(observed2, observed)
  end)
  it("should not pollute original object with Proxies", function()
    local original = {foo = 1}
    local original2 = {bar = 2}
    local observed = reactive(original)
    local observed2 = reactive(original2)
    observed.bar = observed2
    lu.assertEquals(observed.bar, observed2)
    lu.assertEquals(original.bar, original2)
  end)
  it("toRaw", function()
    local original = {foo = 1}
    local observed = reactive(original)
    lu.assertEquals(observed, original)
    lu.assertEquals(original, original)
  end)
  it("toRaw on object using reactive as prototype", function()
    local original = reactive({})
    local obj = {original}
    local raw = obj
    lu.assertEquals(raw, obj)
    lu.assertNotEquals(raw, original)
  end)
  it("should not unwrap Ref<T>", function()
    local observedNumberRef = reactive(ref(1))
    local observedObjectRef = reactive(ref({foo = 1}))
    lu.assertEquals(isRef(observedNumberRef), true)
    lu.assertEquals(isRef(observedObjectRef), true)
  end)
  it("should unwrap computed refs", function()
    local a = computed(function()
      return 1
    end)
    local b = computed(function()
      return 1
    end, function()
    end)
    local obj = reactive({a = a, b = b})
    local aa = obj.a + 1
    local aa = obj.b + 1
    lu.assertEquals(type(obj.a), "number")
    lu.assertEquals(type(obj.b), "number")
  end)
  it("non-observable values", function()
    local function assertValue(value)
      reactive(value)
      
      lu.toHaveBeenWarned("target cannot be made reactive: ")
    end
    
    assertValue(1)
    assertValue("foo")
    assertValue(false)
    assertValue(nil)
    assertValue(nil)
    local s = 1
    assertValue(s)
    local p = io.output()
    lu.assertEquals(reactive(p), p)
    local r = ""
    lu.assertEquals(reactive(r), r)
    local d = os.clock()
    lu.assertEquals(reactive(d), d)
  end)
  it("markRaw", function()
    local obj = reactive({
      foo = {a = 1},
      bar = markRaw({b = 2})
    })
    lu.assertEquals(isReactive(obj.foo) == true, true)
    lu.assertEquals(isReactive(obj.bar) == true, false)
  end)
  it("should not observe frozen objects", function()
    local obj = reactive({
      foo = setmetatable({a = 1}, {})
    })
    lu.assertEquals(isReactive(obj.foo) == true, false)
  end)
  it("should not observe objects with __v_skip", function()
    local original = markRaw({foo = 1})
    local observed = reactive(original)
    lu.assertEquals(true == isReactive(observed), false)
  end)
end)
