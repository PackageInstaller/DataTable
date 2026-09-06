local DM_SimpleRank = class("DM_SimpleRank")

function DM_SimpleRank:Ctor()
  self._simpleRank = NekoData.Data.simpleRank
  self:Clear()
end

function DM_SimpleRank:Clear()
  self._simpleRank.rankData = {}
end

function DM_SimpleRank:OnSSimpleRank(protocol)
  if PrintTable then
    PrintTable(protocol, 3, "OnSSimpleRank")
  end
  if not self._simpleRank.rankData[protocol.rankType] then
    self._simpleRank.rankData[protocol.rankType] = {}
  end
  self._simpleRank.rankData[protocol.rankType][protocol.rankId] = {
    playerRanking = protocol.playerRanking,
    totalRanking = protocol.ranking
  }
end

return DM_SimpleRank
