local lu = require("test.luaunit")
local Effect = require("Vue.reactivity.effect")
local track, trigger, ITERATE_KEY, effect, stop = Effect.track, Effect.trigger, Effect.ITERATE_KEY, Effect.effect, Effect.stop
local TriggerOpTypes = require("Vue.reactivity.operations.TriggerOpTypes")
local Reactive = require("Vue.reactivity.reactive")
local computed = require("Vue.reactivity.computed")(Reactive).computed
local TrackOpTypes = require("Vue.reactivity.operations.TrackOpTypes")
local reactive, markRaw, isReactive, readonly, isReadonly, shallowReadonly, isShallow, shallowReactive = Reactive.reactive, Reactive.markRaw, Reactive.isReactive, Reactive.readonly, Reactive.isReadonly, Reactive.shallowReadonly, Reactive.isShallow, Reactive.shallowReactive
local Ref = require("Vue.reactivity.ref")(Reactive)
local ref, isRef, unref, shallowRef, triggerRef, customRef, toRef, toRefs = Ref.ref, Ref.isRef, Ref.unref, Ref.shallowRef, Ref.triggerRef, Ref.customRef, Ref.toRef, Ref.toRefs
describe("shallowReactive", function()
  it("should not make non-reactive properties reactive", function()
    local props = shallowReactive({
      n = {foo = 1}
    })
    lu.assertEquals(isReactive(props.n) == true, false)
  end)
  it("should keep reactive properties reactive", function()
    local props = shallowReactive({
      n = reactive({foo = 1})
    })
    props.n = reactive({foo = 2})
    lu.assertEquals(isReactive(props.n), true)
  end)
  describe("collections", function()
    it("should be reactive", function()
      local shallowSet = shallowReactive({})
      local a = {}
      local size
      effect(function()
        size = #shallowSet
      end)
      lu.assertEquals(size, 0)
      table.insert(shallowSet, a)
      lu.assertEquals(size, 1)
      shallowSet[1] = nil
      lu.assertEquals(size, 0)
    end)
    it("should not observe when iterating", function()
      local shallowSet = shallowReactive({})
      local a = {}
      shallowSet[a] = a
      local spreadA = shallowSet[a]
      lu.assertEquals(true == isReactive(spreadA), false)
    end)
    it("should not get reactive entry", function()
      local shallowMap = shallowReactive({})
      local a = {}
      local key = "a"
      shallowMap[key] = a
      lu.assertEquals(true == isReactive(shallowMap[key]), false)
    end)
    it("should not get reactive on foreach", function()
      local shallowSet = shallowReactive({})
      local a = {}
      shallowSet[a] = true
      for x in pairs(shallowSet) do
        lu.assertEquals(true == isReactive(x), false)
      end
    end)
    it("onTrack on called on objectSpread", function()
      local onTrackFn = lu.createSpy("")
      local shallowSet = shallowReactive({})
      local a
      effect(function()
        a = {}
        for i, v in pairs(shallowSet) do
          a[i] = v
        end
      end, {onTrack = onTrackFn})
      lu.assertEquals(a, {})
      onTrackFn.toHaveBeenCalled()
    end)
  end)
  describe("array", function()
    it("should be reactive", function()
      local shallowArray = shallowReactive({})
      local a = {}
      local size
      effect(function()
        size = #shallowArray
      end)
      lu.assertEquals(size, 0)
      table.insert(shallowArray, a)
      lu.assertEquals(size, 1)
      table.remove(shallowArray)
      lu.assertEquals(size, 0)
    end)
    it("should not observe when iterating", function()
      local shallowArray = shallowReactive({})
      local a = {}
      table.insert(shallowArray, a)
      local spreadA = shallowArray[1]
      lu.assertEquals(true == isReactive(spreadA), false)
    end)
    it("onTrack on called on objectSpread", function()
      local onTrackFn = lu.createSpy("")
      local shallowArray = shallowReactive({})
      local a
      effect(function()
        a = {}
        for i, v in pairs(shallowArray) do
          a[i] = v
        end
      end, {onTrack = onTrackFn})
      lu.assertEquals(a, {})
      onTrackFn.toHaveBeenCalled()
    end)
  end)
end)
