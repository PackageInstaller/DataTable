-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/trapstatechangeeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local TrapStateChangeEffect = class("TrapStateChangeEffect", EffectBase)
TrapStateChangeEffect.Ctor = function(self, trapids, switchids)
  -- function num : 0_0
  self._trapids = trapids
  self._switchids = switchids
  self._futures = {}
end

TrapStateChangeEffect.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if self._callback then
    (self._callback)()
    self._callback = nil
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
  self._futures = {}
end

local change_next_state = function(self, next)
  -- function num : 0_2 , upvalues : change_next_state
  return function()
    -- function num : 0_2_0 , upvalues : next, self, change_next_state
    if #self._futures < next then
      if not self._callback then
        self._finished = true
      end
      self:Destroy()
      return 
    end
    ;
    ((self._futures)[next]):Then(change_next_state(self, next + 1))
    ;
    ((self._futures)[next]):Run()
  end

end

TrapStateChangeEffect.Run = function(self)
  -- function num : 0_3 , upvalues : _ENV, change_next_state
  self._finished = false
  if not self._trapids then
    for _,v in ipairs({}) do
      (table.insert)(self._futures, (TrapManager.ToNextState)(v.instance, v.id))
    end
    do
      if not self._switchids then
        for _,v in ipairs({}) do
          (table.insert)(self._futures, (SwitchManager.ToNextState)(v.instance, v.id))
        end
        ;
        (change_next_state(self, 1))()
      end
    end
  end
end

TrapStateChangeEffect.Then = function(self, callback)
  -- function num : 0_4
  self._callback = callback
  if self._finished then
    self:Destroy()
    self._finished = false
  end
end

return TrapStateChangeEffect

