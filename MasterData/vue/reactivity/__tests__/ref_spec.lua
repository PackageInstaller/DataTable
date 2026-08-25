local lu = require("test.luaunit")
local Effect = require("Vue.reactivity.effect")
local track, trigger, ITERATE_KEY, effect, stop = Effect.track, Effect.trigger, Effect.ITERATE_KEY, Effect.effect, Effect.stop
local TriggerOpTypes = require("Vue.reactivity.operations.TriggerOpTypes")
local Reactive = require("Vue.reactivity.reactive")
local computed = require("Vue.reactivity.computed")(Reactive).computed
local TrackOpTypes = require("Vue.reactivity.operations.TrackOpTypes")
local reactive, markRaw, isReactive = Reactive.reactive, Reactive.markRaw, Reactive.isReactive
local Ref = require("Vue.reactivity.ref")(Reactive)
local ref, isRef, unref, shallowRef, triggerRef, customRef, toRef, toRefs = Ref.ref, Ref.isRef, Ref.unref, Ref.shallowRef, Ref.triggerRef, Ref.customRef, Ref.toRef, Ref.toRefs
describe("reactivity/ref", function()
  it("should hold a value", function()
    local a = ref(1)
    lu.assertEquals(a.value, 1)
    a.value = 2
    lu.assertEquals(a.value, 2)
  end)
  it("should be reactive", function()
    local a = ref(1)
    local dummy
    local calls = 0
    effect(function()
      calls = calls + 1
      dummy = a.value
    end)
    lu.assertEquals(calls, 1)
    lu.assertEquals(dummy, 1)
    a.value = 2
    lu.assertEquals(calls, 2)
    lu.assertEquals(dummy, 2)
    a.value = 2
    lu.assertEquals(calls, 2)
    lu.assertEquals(dummy, 2)
  end)
  it("should make nested properties reactive", function()
    local a = ref({count = 1})
    local dummy
    effect(function()
      dummy = a.value.count
    end)
    lu.assertEquals(dummy, 1)
    a.value.count = 2
    lu.assertEquals(dummy, 2)
  end)
  it("should work without initial value", function()
    local a = ref()
    local dummy
    effect(function()
      dummy = a.value
    end)
    lu.assertEquals(dummy, undefined)
    a.value = 2
    lu.assertEquals(dummy, 2)
  end)
  it("should work like a normal property when nested in a reactive object", function()
    local a = ref(1)
    local obj = reactive({
      a = a,
      b = {c = a}
    })
    local dummy1, dummy2
    effect(function()
      dummy1 = obj.a
      dummy2 = obj.b.c
    end)
    
    local function assertDummiesEqualTo(val)
      lu.assertEquals(dummy1, val)
      lu.assertEquals(dummy2, val)
    end
    
    assertDummiesEqualTo(1)
    a.value = a.value + 1
    assertDummiesEqualTo(2)
    obj.a = obj.a + 1
    assertDummiesEqualTo(3)
    obj.b.c = obj.b.c + 1
    assertDummiesEqualTo(4)
  end)
  it("should unwrap nested ref in types", function()
    local a = ref(0)
    local b = ref(a)
    lu.assertEquals(type(b.value + 1), "number")
  end)
  it("should unwrap nested values in types", function()
    local a = {
      b = ref(0)
    }
    local c = ref(a)
    lu.assertEquals(type(c.value.b + 1), "number")
  end)
  it("should NOT unwrap ref types nested inside arrays", function()
    local arr = ref({
      1,
      ref(3)
    }).value
    lu.assertEvalToFalse(isRef(arr[1]))
    lu.assertEvalToFalse(isRef(arr[2]))
    lu.assertEquals(arr[2], 3)
  end)
  it("should keep tuple types", function()
    local tuple = {
      0,
      "1",
      {a = 1},
      function()
        return 0
      end,
      ref(0)
    }
    local tupleRef = ref(tuple)
    tupleRef.value[1] = tupleRef.value[1] + 1
    lu.assertEquals(tupleRef.value[1], 1)
    tupleRef.value[2] = tupleRef.value[2] .. "1"
    lu.assertEquals(tupleRef.value[2], "11")
    tupleRef.value[3].a = tupleRef.value[3].a + 1
    lu.assertEquals(tupleRef.value[3].a, 2)
    tupleRef.value[5] = tupleRef.value[5] + 1
    lu.assertEquals(tupleRef.value[5], 1)
  end)
  it("should keep symbols", function()
    local customSymbol = io.output()
    local asyncIterator = setmetatable({
      "asyncIterator"
    }, {})
    local unscopables = setmetatable({
      "unscopables"
    }, {})
    local obj = {
      [asyncIterator] = {a = 1},
      [unscopables] = {b = "1"},
      customSymbol = {
        c = {
          1,
          2,
          3
        }
      }
    }
    local objRef = ref(obj)
    lu.assertEquals(objRef.value[asyncIterator], obj[asyncIterator])
    lu.assertEquals(objRef.value[unscopables], obj[unscopables])
    lu.assertEquals(objRef.value[customSymbol], obj[customSymbol])
  end)
  it("unref", function()
    lu.assertEquals(unref(1), 1)
    lu.assertEquals(unref(ref(1)), 1)
  end)
  it("shallowRef", function()
    local sref = shallowRef({a = 1})
    lu.assertEvalToFalse(isReactive(sref.value))
    local dummy
    effect(function()
      dummy = sref.value.a
    end)
    lu.assertEquals(dummy, 1)
    sref.value = {a = 2}
    lu.assertEvalToFalse(isReactive(sref.value))
    lu.assertEquals(dummy, 2)
  end)
  it("shallowRef force trigger", function()
    local sref = shallowRef({a = 1})
    local dummy
    effect(function()
      dummy = sref.value.a
    end)
    lu.assertEquals(dummy, 1)
    sref.value.a = 2
    lu.assertEquals(dummy, 1)
    triggerRef(sref)
    lu.assertEquals(dummy, 2)
  end)
  it("isRef", function()
    lu.assertEquals(isRef(ref(1)), true)
    lu.assertEquals(isRef(computed(function()
      return 1
    end)), true)
    lu.assertEvalToFalse(isRef(0))
    lu.assertEvalToFalse(isRef(1))
    lu.assertEvalToFalse(isRef({value = 0}))
  end)
end)
