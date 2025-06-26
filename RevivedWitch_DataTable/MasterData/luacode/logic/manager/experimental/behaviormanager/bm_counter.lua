-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_counter.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_Counter = class("BM_Counter")
BM_Counter.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._counter = (NekoData.Data).counter
end

BM_Counter.GetCounterValue = function(self, tag)
  -- function num : 0_1
  return (self._counter)[tag]
end

BM_Counter.SetCounterValue = function(self, tag, value)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self._counter)[tag] = value
  ;
  (TriggerManager.OnCounterChange)(tag, value)
end

return BM_Counter

