-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/trapcheckeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local TrapCheckEffect = class("TrapCheckEffect", EffectBase)
TrapCheckEffect.Ctor = function(self, trapids, switchids)
  -- function num : 0_0
  self._trapids = trapids
  self._switchids = switchids
  self._futures = {}
end

TrapCheckEffect.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if self._callback then
    (self._callback)()
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
  self._futures = {}
end

local check_next_state = function(self, next)
  -- function num : 0_2 , upvalues : check_next_state
  return function()
    -- function num : 0_2_0 , upvalues : next, self, check_next_state
    if #self._futures < next then
      self._finished = true
      self:Destroy()
      return 
    end
    ;
    ((self._futures)[next]):Then(check_next_state(self, next + 1))
    ;
    ((self._futures)[next]):Run()
  end

end

TrapCheckEffect.Run = function(self)
  -- function num : 0_3 , upvalues : _ENV, check_next_state
  self._finished = false
  if not self._trapids then
    for _,v in ipairs({}) do
      (table.insert)(self._futures, (TrapManager.CheckState)(v.instance, v.id))
    end
    do
      if not self._switchids then
        for _,v in ipairs({}) do
          (table.insert)(self._futures, (SwitchManager.CheckState)(v.instance, v.id))
        end
        ;
        (check_next_state(self, 1))()
      end
    end
  end
end

TrapCheckEffect.Then = function(self, callback)
  -- function num : 0_4
  self._callback = callback
  if self._finished then
    self:Destroy()
  end
end

return TrapCheckEffect

