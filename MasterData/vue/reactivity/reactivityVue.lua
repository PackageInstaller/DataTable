local Reactive = require("Vue.reactivity.reactive")
local Computed = require("Vue.reactivity.apiComputed")
local Ref = require("Vue.reactivity.ref")(Reactive)
local Effect = require("Vue.reactivity.effect")
local Binder = require("Vue.reactivity.binder")
local Watcher = require("Vue.reactivity.apiWatch")
local reactivityVue = {
  reactive = Reactive.reactive,
  readonly = Reactive.readonly,
  shallowReadonly = Reactive.shallowReadonly,
  shallowReactive = Reactive.shallowReactive,
  isReadonly = Reactive.isReadonly,
  isReactive = Reactive.isReactive,
  isShallow = Reactive.isShallow,
  markRaw = Reactive.markRaw,
  isRef = Ref.isRef,
  ref = Ref.ref,
  shallowRef = Ref.shallowRef,
  readonlyRef = Ref.readonlyRef,
  readonlyShallowRef = Ref.readonlyShallowRef,
  triggerRef = Ref.triggerRef,
  unref = Ref.unref,
  computed = Computed.computed,
  newBinder = Binder.apiNewBinder,
  newEffect = Effect.effect
}
return reactivityVue
