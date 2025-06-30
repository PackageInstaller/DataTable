-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_sbattleend.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_SBattleEnd = class("DM_SBattleEnd")
DM_SBattleEnd.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._sbattleendinfo = (NekoData.Data).sbattleendinfo
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._sbattleendinfo).protocol = {}
end

DM_SBattleEnd.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for k,v in pairs((self._sbattleendinfo).protocol) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ((self._sbattleendinfo).protocol)[k] = nil
  end
end

DM_SBattleEnd.OnSBattleEnd = function(self, protocol)
  -- function num : 0_2
  self:Clear()
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._sbattleendinfo).protocol = protocol
end

return DM_SBattleEnd

