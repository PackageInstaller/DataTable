-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_counter.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_Counter = class("DM_Counter")
DM_Counter.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._counter = (NekoData.Data).counter
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBattleEnd, Common.n_BattleEnd, nil)
end

DM_Counter.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if self._counter then
    for k,v in pairs(self._counter) do
      -- DECOMPILER ERROR at PC8: Confused about usage of register: R6 in 'UnsetPending'

      (self._counter)[k] = nil
    end
  end
end

DM_Counter.ChangeCounter = function(self, tag, num)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._counter)[tag] = ((self._counter)[tag] or 0) + num
end

DM_Counter.FindCounter = function(self, tag)
  -- function num : 0_3
  return (self._counter)[tag]
end

DM_Counter.OnBattleEnd = function(self, notification)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._counter).battle = ((self._counter).battle or 0) + 1
end

return DM_Counter

