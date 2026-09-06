local CActivityExchange = require("protocols.def.protocol.activity.cactivityexchange")
local CActivitySpringOutingCfg = BeanManager.GetTableByName("activity.cactivityspringoutingcfg")
local CActivitySpringOutingManaCfg = BeanManager.GetTableByName("activity.cactivityspringoutingmanacfg")
local CActivityJackpot = BeanManager.GetTableByName("item.cactivityjackpot")
local BM_DragonBoatFestival = class("BM_DragonBoatFestival")

function BM_DragonBoatFestival:Ctor()
  self._dragonboatfestival = NekoData.Data.activities.dragonboatfestival
end

function BM_DragonBoatFestival:GetIsOpen()
  return self._dragonboatfestival.isOpen
end

function BM_DragonBoatFestival:GetTotalRemainTime()
  return self._dragonboatfestival.totalRemainTime - (ServerGameTimer.GetServerTimeForecast() - self._dragonboatfestival.startTime)
end

function BM_DragonBoatFestival:GetWishIsOpen()
  return self._dragonboatfestival.wishIsOpen
end

function BM_DragonBoatFestival:GetShopIsOpen()
  return self._dragonboatfestival.shopIsOpen
end

function BM_DragonBoatFestival:GetCurrentPoolID()
  return self._dragonboatfestival.currPoolId
end

function BM_DragonBoatFestival:GetCurrentPoolItem()
  return self._dragonboatfestival.currPoolItem
end

function BM_DragonBoatFestival:GetMinPoolID()
  return self._dragonboatfestival.minPoolId
end

function BM_DragonBoatFestival:GetMaxPoolID()
  return self._dragonboatfestival.maxPoolId
end

function BM_DragonBoatFestival:GetPoolIDs()
  return self._dragonboatfestival.poolIds
end

function BM_DragonBoatFestival:AddRedDot(type)
  self._dragonboatfestival.redDotList[type] = true
end

function BM_DragonBoatFestival:KillRedDot(type)
  self._dragonboatfestival.redDotList[type] = nil
end

function BM_DragonBoatFestival:GetRedDot(type)
  return self._dragonboatfestival.redDotList[type]
end

function BM_DragonBoatFestival:HaveRedDot()
  return next(self._dragonboatfestival.redDotList) ~= nil
end

function BM_DragonBoatFestival:ShowRedDot()
  if not self:GetIsOpen() then
    return false
  end
  return self:HaveRedDot() or NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.OpenDragonBoatFestivalDialog) ~= nil or NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.LuckyCopperCoin) >= self:GetExchangeLotteryRate()
end

function BM_DragonBoatFestival:SendCDragonBoatFestivalWish()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cdragonboatfestivalwish")
  if protocol then
    protocol:Send()
  end
end

function BM_DragonBoatFestival:SendCGetShopInfo()
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
  if protocol then
    protocol.shopId = DataCommon.DragonBoatFestivalShopID
    protocol:Send()
  end
end

function BM_DragonBoatFestival:SendCActivityExchangeLottery(exchangeNum)
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cactivityexchange")
  if protocol then
    protocol.activityId = DataCommon.Activities.DragonBoatFestival
    protocol.exchangeType = CActivityExchange.EXCHANGE
    protocol.exchangeNum = exchangeNum
    protocol:Send()
  end
end

function BM_DragonBoatFestival:SendCActivityExchangeRecycle()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cactivityexchange")
  if protocol then
    protocol.activityId = DataCommon.Activities.DragonBoatFestival
    protocol.exchangeType = CActivityExchange.RECYCLE
    protocol.exchangeNum = 0
    protocol:Send()
  end
end

function BM_DragonBoatFestival:GetCActivitySpringOutingCfg()
  return CActivitySpringOutingCfg
end

function BM_DragonBoatFestival:GetCActivitySpringOutingManaCfg()
  return CActivitySpringOutingManaCfg
end

function BM_DragonBoatFestival:GetCActivityJackpot()
  return CActivityJackpot
end

function BM_DragonBoatFestival:GetRewardPoolData()
  if self._dragonboatfestival.rewardPoolData == nil then
    self._dragonboatfestival.rewardPoolData = {}
    local allIds = CActivityJackpot:GetAllIds()
    for _, value in ipairs(allIds) do
      local record = CActivityJackpot:GetRecorder(value)
      if record.activityId == DataCommon.Activities.DragonBoatFestival then
        local tmpTable = {}
        tmpTable.nameId = record.nameId
        tmpTable.isFinalPool = record.resetJackpotNum == -1
        self._dragonboatfestival.rewardPoolData[record.id] = tmpTable
      end
    end
  end
  return self._dragonboatfestival.rewardPoolData
end

function BM_DragonBoatFestival:GetExchangeLotteryRate()
  if self._dragonboatfestival.exchangeLotteryRate == nil then
    local allIds = CActivityJackpot:GetAllIds()
    for _, value in ipairs(allIds) do
      local record = CActivityJackpot:GetRecorder(value)
      if record.activityId == DataCommon.Activities.DragonBoatFestival then
        self._dragonboatfestival.exchangeLotteryRate = record.neednum
        break
      end
    end
  end
  return self._dragonboatfestival.exchangeLotteryRate
end

function BM_DragonBoatFestival:GetExchangeRecycleRate()
  if self._dragonboatfestival.exchangeRecycleRate == nil then
    self._dragonboatfestival.exchangeRecycleRate = CActivitySpringOutingManaCfg:GetRecorder(DataCommon.Activities.DragonBoatFestival).targetNum
  end
  return self._dragonboatfestival.exchangeRecycleRate
end

return BM_DragonBoatFestival
