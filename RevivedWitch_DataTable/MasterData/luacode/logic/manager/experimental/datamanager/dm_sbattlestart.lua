-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_sbattlestart.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_SBattleStart = class("DM_SBattleStart")
DM_SBattleStart.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._sbattlestartinfo = (NekoData.Data).sbattlestartinfo
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._sbattlestartinfo).protocol = {}
end

DM_SBattleStart.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for k,v in pairs((self._sbattlestartinfo).protocol) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ((self._sbattlestartinfo).protocol)[k] = nil
  end
end

DM_SBattleStart.OnSBattleStart = function(self, protocol, type)
  -- function num : 0_2 , upvalues : _ENV
  self:Clear()
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._sbattlestartinfo).protocol = protocol
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_BattleStart)
end

return DM_SBattleStart

