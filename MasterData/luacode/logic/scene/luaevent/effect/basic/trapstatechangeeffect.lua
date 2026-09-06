local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local TrapStateChangeEffect = class("TrapStateChangeEffect", EffectBase)

function TrapStateChangeEffect:Ctor(trapids, switchids)
  self._trapids = trapids
  self._switchids = switchids
  self._futures = {}
end

function TrapStateChangeEffect:Destroy()
  if self._callback then
    self._callback()
    self._callback = nil
  end
  LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
  self._futures = {}
end

local function change_next_state(self, next)
  return function()
    if next > #self._futures then
      if not self._callback then
        self._finished = true
      end
      self:Destroy()
      return
    end
    self._futures[next]:Then(change_next_state(self, next + 1))
    self._futures[next]:Run()
  end
end

function TrapStateChangeEffect:Run()
  self._finished = false
  for _, v in ipairs(self._trapids or {}) do
    table.insert(self._futures, TrapManager.ToNextState(v.instance, v.id))
  end
  for _, v in ipairs(self._switchids or {}) do
    table.insert(self._futures, SwitchManager.ToNextState(v.instance, v.id))
  end
  change_next_state(self, 1)()
end

function TrapStateChangeEffect:Then(callback)
  self._callback = callback
  if self._finished then
    self:Destroy()
    self._finished = false
  end
end

return TrapStateChangeEffect
