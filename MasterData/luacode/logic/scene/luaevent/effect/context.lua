-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/context.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Context = class("Context")
Context.Ctor = function(self)
  -- function num : 0_0
  self._timers = {}
end

Context.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for _,v in pairs(self._timers) do
    (GameTimer.RemoveTask)(v)
  end
  self._timers = {}
end

Context.AddTask = function(self, ...)
  -- function num : 0_2 , upvalues : _ENV
  local timer = (GameTimer.AddTask)(...)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._timers)[#self._timers + 1] = timer
end

Context.RemoveTask = function(self, id)
  -- function num : 0_3 , upvalues : _ENV
  for i,v in pairs(self._timers) do
    if v == id then
      (GameTimer.RemoveTask)(id)
      -- DECOMPILER ERROR at PC11: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self._timers)[i] = nil
      return 
    end
  end
end

return Context

