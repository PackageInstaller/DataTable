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
describe("reactivity/computed", function()
  it("should return updated value", function()
    local value = reactive({})
    local cValue = computed(function()
      return value.foo
    end)
    lu.assertEquals(cValue.value, nil)
    value.foo = 1
    lu.assertEquals(cValue.value, 1)
  end)
  it("should compute lazily", function()
    local value = reactive({})
    local getter = lu.createSpy(function()
      return value.foo
    end)
    local cValue = computed(getter)
    getter.toHaventBeenCalled()
    lu.assertEquals(cValue.value, nil)
    getter.toHaveBeenCalledTimes(1)
    getter.toHaveBeenCalledTimes(1)
    value.foo = 1
    getter.toHaveBeenCalledTimes(1)
    lu.assertEquals(cValue.value, 1)
    getter.toHaveBeenCalledTimes(2)
    getter.toHaveBeenCalledTimes(2)
  end)
  it("should trigger effect", function()
    local value = reactive({})
    local cValue = computed(function()
      return value.foo
    end)
    local dummy
    effect(function()
      dummy = cValue.value
    end)
    lu.assertEquals(dummy, nil)
    value.foo = 1
    lu.assertEquals(dummy, 1)
  end)
  it("should work when chained", function()
    local value = reactive({foo = 0})
    local c1 = computed(function()
      return value.foo
    end)
    local c2 = computed(function()
      return c1.value + 1
    end)
    lu.assertEquals(c2.value, 1)
    lu.assertEquals(c1.value, 0)
    value.foo = value.foo + 1
    lu.assertEquals(c2.value, 2)
    lu.assertEquals(c1.value, 1)
  end)
  it("should trigger effect when chained", function()
    local value = reactive({foo = 0})
    local c1
    local getter1 = lu.createSpy(function()
      return value.foo
    end)
    local getter2 = lu.createSpy(function()
      return c1.value + 1
    end)
    c1 = computed(getter1)
    local c2 = computed(getter2)
    local dummy
    effect(function()
      dummy = c2.value
    end)
    lu.assertEquals(dummy, 1)
    getter1.toHaveBeenCalledTimes(1)
    getter2.toHaveBeenCalledTimes(1)
    value.foo = value.foo + 1
    lu.assertEquals(dummy, 2)
    getter1.toHaveBeenCalledTimes(2)
    getter2.toHaveBeenCalledTimes(2)
  end)
  it("should trigger effect when chained (mixed invocations)", function()
    local value = reactive({foo = 0})
    local getter1 = lu.createSpy(function()
      return value.foo
    end)
    local c1
    local getter2 = lu.createSpy(function()
      return c1.value + 1
    end)
    c1 = computed(getter1)
    local c2 = computed(getter2)
    local dummy
    effect(function()
      dummy = c1.value + c2.value
    end)
    lu.assertEquals(dummy, 1)
    getter1.toHaveBeenCalledTimes(1)
    getter2.toHaveBeenCalledTimes(1)
    value.foo = value.foo + 1
    lu.assertEquals(dummy, 3)
    getter1.toHaveBeenCalledTimes(2)
    getter2.toHaveBeenCalledTimes(2)
  end)
  it("should no longer update when stopped", function()
    local value = reactive({})
    local cValue = computed(function()
      return value.foo
    end)
    local dummy
    effect(function()
      dummy = cValue.value
    end)
    lu.assertEquals(dummy, nil)
    value.foo = 1
    lu.assertEquals(dummy, 1)
    stop(cValue)
    value.foo = 2
    lu.assertEquals(dummy, 1)
  end)
  it("should support setter", function()
    local n = ref(1)
    local plusOne = computed(function()
      return n.value + 1
    end, function(self, val)
      n.value = val - 1
    end)
    lu.assertEquals(plusOne.value, 2)
    n.value = n.value + 1
    lu.assertEquals(plusOne.value, 3)
    plusOne.value = 0
    lu.assertEquals(n.value, -1)
  end)
  it("should trigger effect w/ setter", function()
    local n = ref(1)
    local plusOne = computed(function()
      return n.value + 1
    end, function(self, val)
      n.value = val - 1
    end)
    local dummy
    effect(function()
      dummy = n.value
    end)
    lu.assertEquals(dummy, 1)
    plusOne.value = 0
    lu.assertEquals(dummy, -1)
  end)
  it("should warn if trying to set a readonly computed", function()
    local n = ref(1)
    local plusOne = computed(function()
      return n.value + 1
    end)
    plusOne.value = plusOne.value + 1
    lu.toHaveBeenWarned("Write operation failed: computed value is readonly")
  end)
end)
