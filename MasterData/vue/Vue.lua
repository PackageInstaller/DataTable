local Reactive = require("Vue.reactivity.reactive")
local Computed = require("Vue.reactivity.computed")(Reactive)
local Ref = require("Vue.reactivity.ref")(Reactive)
local Effect = require("Vue.reactivity.effect")
local Binder = require("Vue.reactivity.binder")
local Watcher = require("Vue.reactivity.apiWatch")
local NextTick = require("Vue.reactivity.nextTick")
local Scheduler = require("Vue.reactivity.scheduler")
local Store = require("Vue.vuex.Store")
local VueModel = require("Vue.model.model")
local Vue = {}
Vue.reactive = Reactive.reactive
Vue.raw = Reactive.markRaw
Vue.removeHook = Reactive.removeHook
local _
Vue.ref = Ref.ref
Vue.computed = Computed.computed
Vue.newBinder = Binder.apiNewBinder
Vue.new = Binder.apiNew
Vue.newStore = Store.new
Vue.isRef = Ref.isRef
Vue.flush = NextTick.flushCallbacks
Vue.nextTick = NextTick.nextTick
Vue.queueJob = Scheduler.queueJob
Vue.effect = Effect.effect
Vue.pauseTracking = Effect.forcePauseTracking
Vue.resetTracking = Effect.forceResetTracking
Vue.withoutTracking = Reactive.withoutTracking
Vue.model = VueModel.new

function Vue.isModelClass(cls)
  return getmetatable(cls) == VueModel
end

return Vue
