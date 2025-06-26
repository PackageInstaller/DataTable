-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_sbattlestart.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_SBattleStart = class("BM_SBattleStart")
BM_SBattleStart.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._sbattlestartinfo = (NekoData.Data).sbattlestartinfo
end

BM_SBattleStart.GetProtocol = function(self)
  -- function num : 0_1
  return (self._sbattlestartinfo).protocol
end

BM_SBattleStart.GetBattleType = function(self)
  -- function num : 0_2
  return ((self._sbattlestartinfo).protocol).battleType
end

BM_SBattleStart.GetLineId = function(self)
  -- function num : 0_3
  return ((self._sbattlestartinfo).protocol).lineId
end

BM_SBattleStart.GetLeftRoleMap = function(self)
  -- function num : 0_4
  return ((self._sbattlestartinfo).protocol).left
end

return BM_SBattleStart

