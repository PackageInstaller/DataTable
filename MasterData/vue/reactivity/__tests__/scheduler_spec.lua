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
local Scheduler = require("Vue.reactivity.scheduler")
local NextTick = require("Vue.reactivity.nextTick")
local flushCallbacks, nextTick = NextTick.flushCallbacks, NextTick.nextTick
local queueJob, invalidateJob, queuePostFlushCb = Scheduler.queueJob, Scheduler.invalidateJob, Scheduler.queuePostFlushCb
describe("scheduler", function()
  it("nextTick", function()
    local calls = {}
    
    local function job1()
      table.insert(calls, "job1")
    end
    
    local function job2()
      table.insert(calls, "job2")
    end
    
    nextTick(job1)
    job2()
    lu.assertEquals(#calls, 1)
    waitForUpdate()
    lu.assertEquals(#calls, 2)
    lu.assertEquals(calls, {"job2", "job1"})
  end)
  describe("queueJob", function()
    it("basic usage", function()
      local calls = {}
      
      local function job1()
        table.insert(calls, "job1")
      end
      
      local function job2()
        table.insert(calls, "job2")
      end
      
      queueJob(job1)
      queueJob(job2)
      lu.assertEquals(calls, {})
      waitForUpdate()
      lu.assertEquals(calls, {"job1", "job2"})
    end)
    it("should dedupe queued jobs", function()
      local calls = {}
      
      local function job1()
        table.insert(calls, "job1")
      end
      
      local function job2()
        table.insert(calls, "job2")
      end
      
      queueJob(job1)
      queueJob(job2)
      queueJob(job1)
      queueJob(job2)
      lu.assertEquals(calls, {})
      waitForUpdate()
      lu.assertEquals(calls, {"job1", "job2"})
    end)
    it("queueJob while flushing", function()
      local calls = {}
      
      local function job2()
        table.insert(calls, "job2")
      end
      
      local function job1()
        table.insert(calls, "job1")
        queueJob(job2)
      end
      
      queueJob(job1)
      waitForUpdate()
      lu.assertEquals(calls, {"job1", "job2"})
    end)
  end)
  describe("queuePostFlushCb", function()
    it("basic usage", function()
      local calls = {}
      
      local function cb1()
        table.insert(calls, "cb1")
      end
      
      local function cb2()
        table.insert(calls, "cb2")
      end
      
      local function cb3()
        table.insert(calls, "cb3")
      end
      
      queuePostFlushCb(cb1, cb2)
      queuePostFlushCb(cb3)
      lu.assertEquals(calls, {})
      waitForUpdate()
      lu.assertTableContains(calls, "cb1")
      lu.assertTableContains(calls, "cb2")
      lu.assertTableContains(calls, "cb3")
      lu.assertEquals(#calls, 3)
    end)
    it("should dedupe queued postFlushCb", function()
      local calls = {}
      
      local function cb1()
        table.insert(calls, "cb1")
      end
      
      local function cb2()
        table.insert(calls, "cb2")
      end
      
      local function cb3()
        table.insert(calls, "cb3")
      end
      
      queuePostFlushCb(cb1, cb2)
      queuePostFlushCb(cb3)
      queuePostFlushCb(cb1, cb3)
      queuePostFlushCb(cb2)
      lu.assertEquals(calls, {})
      waitForUpdate()
      lu.assertTableContains(calls, "cb1")
      lu.assertTableContains(calls, "cb2")
      lu.assertTableContains(calls, "cb3")
      lu.assertEquals(#calls, 3)
    end)
    it("queuePostFlushCb while flushing", function()
      local calls = {}
      
      local function cb2()
        table.insert(calls, "cb2")
      end
      
      local function cb1()
        table.insert(calls, "cb1")
        queuePostFlushCb(cb2)
      end
      
      queuePostFlushCb(cb1)
      waitForUpdate()
      lu.assertEquals(calls, {"cb1", "cb2"})
    end)
  end)
  describe("queueJob w/ queuePostFlushCb", function()
    it("queueJob inside postFlushCb", function()
      local calls = {}
      
      local function job1()
        table.insert(calls, "job1")
      end
      
      local function cb1()
        table.insert(calls, "cb1")
        queueJob(job1)
      end
      
      queuePostFlushCb(cb1)
      waitForUpdate()
      lu.assertEquals(calls, {"cb1", "job1"})
    end)
    it("queueJob & postFlushCb inside postFlushCb", function()
      local calls = {}
      
      local function job1()
        table.insert(calls, "job1")
      end
      
      local function cb2()
        table.insert(calls, "cb2")
      end
      
      local function cb1()
        table.insert(calls, "cb1")
        queuePostFlushCb(cb2)
        queueJob(job1)
      end
      
      queuePostFlushCb(cb1)
      waitForUpdate()
      lu.assertEquals(calls, {
        "cb1",
        "job1",
        "cb2"
      })
    end)
    it("postFlushCb inside queueJob", function()
      local calls = {}
      
      local function cb1()
        table.insert(calls, "cb1")
      end
      
      local function job1()
        table.insert(calls, "job1")
        queuePostFlushCb(cb1)
      end
      
      queueJob(job1)
      waitForUpdate()
      lu.assertEquals(calls, {"job1", "cb1"})
    end)
    it("queueJob & postFlushCb inside queueJob", function()
      local calls = {}
      
      local function cb1()
        table.insert(calls, "cb1")
      end
      
      local function job2()
        table.insert(calls, "job2")
      end
      
      local function job1()
        table.insert(calls, "job1")
        queuePostFlushCb(cb1)
        queueJob(job2)
      end
      
      queueJob(job1)
      waitForUpdate()
      lu.assertEquals(calls, {
        "job1",
        "job2",
        "cb1"
      })
    end)
    it("nested queueJob w/ postFlushCb", function()
      local calls = {}
      
      local function cb2()
        table.insert(calls, "cb2")
      end
      
      local function job2()
        table.insert(calls, "job2")
        queuePostFlushCb(cb2)
      end
      
      local function cb1()
        table.insert(calls, "cb1")
      end
      
      local function job1()
        table.insert(calls, "job1")
        queuePostFlushCb(cb1)
        queueJob(job2)
      end
      
      queueJob(job1)
      waitForUpdate()
      lu.assertEquals(calls, {
        "job1",
        "job2",
        "cb1",
        "cb2"
      })
    end)
  end)
  it("invalidateJob", function()
    local calls = {}
    
    local function job2()
      table.insert(calls, "job2")
    end
    
    local function job1()
      table.insert(calls, "job1")
      invalidateJob(job2)
      job2()
    end
    
    local function job3()
      table.insert(calls, "job3")
    end
    
    local function job4()
      table.insert(calls, "job4")
    end
    
    queueJob(job1)
    queueJob(job2)
    queueJob(job3)
    queuePostFlushCb(job4)
    lu.assertEquals(calls, {})
    waitForUpdate()
    lu.assertEquals(calls, {
      "job1",
      "job2",
      "job3",
      "job4"
    })
  end)
  it("sort job based on id", function()
    local calls = {}
    
    local function job1()
      table.insert(calls, "job1")
    end
    
    local function job2()
      table.insert(calls, "job2")
    end
    
    job2 = setmetatable({id = 2}, {__call = job2})
    
    local function job3()
      table.insert(calls, "job3")
    end
    
    job3 = setmetatable({id = 1}, {__call = job3})
    queueJob(job1)
    queueJob(job2)
    queueJob(job3)
    waitForUpdate()
    lu.assertEquals(calls, {
      "job3",
      "job2",
      "job1"
    })
  end)
end)
