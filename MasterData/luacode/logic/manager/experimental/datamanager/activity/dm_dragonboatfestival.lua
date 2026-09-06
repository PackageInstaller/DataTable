local DM_DragonBoatFestival = class("DM_DragonBoatFestival")

function DM_DragonBoatFestival:Ctor()
  self._dragonboatfestival = NekoData.Data.activities.dragonboatfestival
  self:Clear()
end

function DM_DragonBoatFestival:Clear()
  self._dragonboatfestival.isOpen = false
  self._dragonboatfestival.totalRemainTime = 0
  self._dragonboatfestival.startTime = 0
  self._dragonboatfestival.wishIsOpen = false
  self._dragonboatfestival.shopIsOpen = false
  self._dragonboatfestival.redDotList = {}
  self._dragonboatfestival.currPoolId = -1
  self._dragonboatfestival.currPoolItem = {}
end

function DM_DragonBoatFestival:OnSDragonBoatFestivalInfo(protocol)
  self._dragonboatfestival.isOpen = protocol.actOpen ~= 0
  self._dragonboatfestival.totalRemainTime = protocol.leftTime
  self._dragonboatfestival.startTime = ServerGameTimer.GetServerTimeForecast()
  self._dragonboatfestival.wishIsOpen = protocol.wishOpen ~= 0
  self._dragonboatfestival.shopIsOpen = protocol.shopOpen ~= 0
  for key, _ in pairs(self._dragonboatfestival.redDotList) do
    self._dragonboatfestival.redDotList[key] = nil
  end
  for _, value in pairs(protocol.redpoint) do
    self._dragonboatfestival.redDotList[value] = true
  end
end

function DM_DragonBoatFestival:OnSDragonBoatFestivalWish(protocol)
  self._dragonboatfestival.minPoolId = math.maxinteger
  self._dragonboatfestival.maxPoolId = math.mininteger
  self._dragonboatfestival.poolIds = {}
  self._dragonboatfestival.currPoolId = protocol.currPoolId
  for key, _ in pairs(self._dragonboatfestival.currPoolItem) do
    self._dragonboatfestival.currPoolItem[key] = nil
  end
  for _, value in ipairs(protocol.dragonBoatItemPool) do
    local tmpPoolTbl = {}
    for index2, value2 in ipairs(value.itemId) do
      local tmpTable = {}
      tmpTable.itemId = value2
      tmpTable.itemNum = value.itemNum[index2]
      tmpTable.isGet = tmpTable.itemNum == 0
      table.insert(tmpPoolTbl, tmpTable)
    end
    self._dragonboatfestival.currPoolItem[value.poolId] = tmpPoolTbl
    if value.poolId > self._dragonboatfestival.maxPoolId then
      self._dragonboatfestival.maxPoolId = value.poolId
    end
    if value.poolId < self._dragonboatfestival.minPoolId then
      self._dragonboatfestival.minPoolId = value.poolId
    end
    table.insert(self._dragonboatfestival.poolIds, value.poolId)
  end
end

return DM_DragonBoatFestival
