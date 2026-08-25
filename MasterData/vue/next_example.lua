print("a")
package.path = package.path .. ";luaexe/?.lua"
require("LuaPanda").start("127.0.0.1", 8818)
local reactive = require("Vue.reactivity.reactive")
local watch = require("Vue.reactivity.apiWatch").watch
local Effect = require("Vue.reactivity.effect")
local effect = Effect.effect
local TrackOpTypes = require("Vue.reactivity.operations.TrackOpTypes")
local data = {
  name = "abc",
  actor = {aname = "aname123", aid = 444},
  id = 123,
  _watchers = {}
}
local obData = reactive.reactive(data)
effect(function(effect, target, type, key, newValue, oldValue)
  print("onEffect", effect, target, type, key, newValue, oldValue)
  if obData.obj then
    return obData.obj.ccc
  end
end)
obData.obj = {ccc = 123}
obData.actor.aname = "a1"
obData.actor.aname = "a2"
obData.actor.obj = {a = 1}
effect(function(effect, target, type, key, newValue, oldValue)
  print("onEffect", effect, target, type, key, newValue, oldValue)
  Effect.track(obData.actor and obData.actor.obj, TrackOpTypes.ITERATE, Effect.ITERATE_KEY)
end)
obData.actor.e = 123
obData.actor.aname = "dsaf"
obData.actor.aname = nil
obData.actor.obj.b = 123
obData.actor.obj.c = 1
obData.actor.obj.d = 2
obData.actor.obj.e = "123"
obData.actor.obj.d = nil
obData.actor.obj.c = 3
obData.actor.obj.c = 123
obData.actor.obj.c = nil
obData.actor = nil
obData.actor = {
  aname = "aname123",
  aid = 444,
  obj = {a = 2}
}
obData.actor.obj.b = 123
obData.actor.obj.c = 1
obData.actor.obj.d = 2
obData.actor.obj.e = "123"
obData.actor.obj.d = nil
obData.actor.obj.c = 3
obData.actor.obj.c = 123
obData.actor.obj.c = nil
local w = watch(function()
  return obData.actor.aname
end, function(vm, value, old)
  print(string.format("onValueChanged : %s -> %s", old, value))
end, {flush = "sync"})
local ff = watch(function()
  return obData.actor.ff
end, function(vm, value, old)
  print(string.format("onValueChanged : %s -> %s", old, value))
end, {flush = "sync"})
local dd = watch(function()
  local new = {}
  for i, v in pairs(obData.actor) do
    new[i] = v
  end
  return new
end, function(vm, value, old)
  print(string.format("onValueChanged : %s -> %s", old, value))
end, {flush = "sync"})
obData.actor.aname = "a3"
obData.actor.aname = nil
obData.actor.aname = "a4"
obData.actor.ff = "fff"
obData.actor = {aname = "ffe"}
