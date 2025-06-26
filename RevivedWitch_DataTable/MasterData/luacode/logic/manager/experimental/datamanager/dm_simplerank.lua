-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_simplerank.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_SimpleRank = class("DM_SimpleRank")
DM_SimpleRank.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._simpleRank = (NekoData.Data).simpleRank
  self:Clear()
end

DM_SimpleRank.Clear = function(self)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._simpleRank).rankData = {}
end

DM_SimpleRank.OnSSimpleRank = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  if PrintTable then
    PrintTable(protocol, 3, "OnSSimpleRank")
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  if not ((self._simpleRank).rankData)[protocol.rankType] then
    ((self._simpleRank).rankData)[protocol.rankType] = {}
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self._simpleRank).rankData)[protocol.rankType])[protocol.rankId] = {playerRanking = protocol.playerRanking, totalRanking = protocol.ranking}
end

return DM_SimpleRank

