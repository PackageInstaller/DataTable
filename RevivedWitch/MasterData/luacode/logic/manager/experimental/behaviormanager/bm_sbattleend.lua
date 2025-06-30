-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_sbattleend.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_SBattleEnd = class("BM_SBattleEnd")
BM_SBattleEnd.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._sbattleendinfo = (NekoData.Data).sbattleendinfo
end

BM_SBattleEnd.GetProtocol = function(self)
  -- function num : 0_1
  return (self._sbattleendinfo).protocol
end

BM_SBattleEnd.GetBattleId = function(self)
  -- function num : 0_2
  if ((self._sbattleendinfo).protocol).battleResult then
    return (((self._sbattleendinfo).protocol).battleResult).battleId
  end
end

BM_SBattleEnd.GetBattleResult = function(self)
  -- function num : 0_3
  if ((self._sbattleendinfo).protocol).battleResult then
    return (((self._sbattleendinfo).protocol).battleResult).result
  end
end

BM_SBattleEnd.GetID = function(self)
  -- function num : 0_4
  return ((self._sbattleendinfo).protocol).id
end

BM_SBattleEnd.GetFailTimes = function(self)
  -- function num : 0_5
  if ((self._sbattleendinfo).protocol).battleResult then
    return (((self._sbattleendinfo).protocol).battleResult).failTime
  end
end

BM_SBattleEnd.GetBattleType = function(self)
  -- function num : 0_6
  return ((self._sbattleendinfo).protocol).battleType
end

return BM_SBattleEnd

