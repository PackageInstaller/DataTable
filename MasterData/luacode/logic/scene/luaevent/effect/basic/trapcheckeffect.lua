local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local TrapCheckEffect = class("TrapCheckEffect", EffectBase)

function TrapCheckEffect:Ctor(trapids, switchids)
  self._trapids = trapids
  self._switchids = switchids
  self._futures = {}
end

function TrapCheckEffect:Destroy()
  if self._callback then
    self._callback()
  end
  LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
  self._futures = {}
end

local function check_next_state(self, next)
  return function()
    if next > #self._futures then
      self._finished = true
      self:Destroy()
      return
    end
    self._futures[next]:Then(check_next_state(self, next + 1))
    self._futures[next]:Run()
  end
end

function TrapCheckEffect:Run()
  self._finished = false
  for _, v in ipairs(self._trapids or {}) do
    table.insert(self._futures, TrapManager.CheckState(v.instance, v.id))
  end
  for _, v in ipairs(self._switchids or {}) do
    table.insert(self._futures, SwitchManager.CheckState(v.instance, v.id))
  end
  check_next_state(self, 1)()
end

function TrapCheckEffect:Then(callback)
  self._callback = callback
  if self._finished then
    self:Destroy()
  end
end

return TrapCheckEffect
