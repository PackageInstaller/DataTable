local DM_DoubleEleven = class("DM_DoubleEleven")

function DM_DoubleEleven:Ctor()
  self._doubleeleven = NekoData.Data.activities.doubleeleven
  self:Clear()
end

function DM_DoubleEleven:Clear()
  self._doubleeleven.isOpen = false
  self._doubleeleven.startTime = -1
  self._doubleeleven.endTime = -1
  self._doubleeleven.cardPoolID = -1
  self._doubleeleven.openCards = {}
  self._doubleeleven.freeReddot = false
end

function DM_DoubleEleven:OnSSendDoubleElevenActivity(protocol)
  self._doubleeleven.isOpen = protocol.state ~= 0
  self._doubleeleven.startTime = protocol.startTime
  self._doubleeleven.endTime = protocol.endTime
end

function DM_DoubleEleven:OnSOpenDoubleElevenActivity(protocol)
  self._doubleeleven.cardPoolID = protocol.poolId
  self._doubleeleven.openCards = protocol.openCards
end

function DM_DoubleEleven:OnSOpenDoubleElevenCard(protocol)
  self._doubleeleven.cardPoolID = protocol.poolId
  self._doubleeleven.openCards[protocol.position] = {
    itemId = protocol.itemInfo.id,
    itemNum = protocol.itemInfo.number
  }
end

function DM_DoubleEleven:ClearCardsData()
  for key, _ in pairs(self._doubleeleven.openCards) do
    self._doubleeleven.openCards[key] = nil
  end
end

function DM_DoubleEleven:OnSActivityShopRedDot(protocol)
  self._doubleeleven.freeReddot = true
end

return DM_DoubleEleven
