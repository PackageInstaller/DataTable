-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_dragonboatfestival.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CActivityExchange = require("protocols.def.protocol.activity.cactivityexchange")
local CActivitySpringOutingCfg = (BeanManager.GetTableByName)("activity.cactivityspringoutingcfg")
local CActivitySpringOutingManaCfg = (BeanManager.GetTableByName)("activity.cactivityspringoutingmanacfg")
local CActivityJackpot = (BeanManager.GetTableByName)("item.cactivityjackpot")
local BM_DragonBoatFestival = class("BM_DragonBoatFestival")
BM_DragonBoatFestival.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._dragonboatfestival = ((NekoData.Data).activities).dragonboatfestival
end

BM_DragonBoatFestival.GetIsOpen = function(self)
  -- function num : 0_1
  return (self._dragonboatfestival).isOpen
end

BM_DragonBoatFestival.GetTotalRemainTime = function(self)
  -- function num : 0_2 , upvalues : _ENV
  return (self._dragonboatfestival).totalRemainTime - ((ServerGameTimer.GetServerTimeForecast)() - (self._dragonboatfestival).startTime)
end

BM_DragonBoatFestival.GetWishIsOpen = function(self)
  -- function num : 0_3
  return (self._dragonboatfestival).wishIsOpen
end

BM_DragonBoatFestival.GetShopIsOpen = function(self)
  -- function num : 0_4
  return (self._dragonboatfestival).shopIsOpen
end

BM_DragonBoatFestival.GetCurrentPoolID = function(self)
  -- function num : 0_5
  return (self._dragonboatfestival).currPoolId
end

BM_DragonBoatFestival.GetCurrentPoolItem = function(self)
  -- function num : 0_6
  return (self._dragonboatfestival).currPoolItem
end

BM_DragonBoatFestival.GetMinPoolID = function(self)
  -- function num : 0_7
  return (self._dragonboatfestival).minPoolId
end

BM_DragonBoatFestival.GetMaxPoolID = function(self)
  -- function num : 0_8
  return (self._dragonboatfestival).maxPoolId
end

BM_DragonBoatFestival.GetPoolIDs = function(self)
  -- function num : 0_9
  return (self._dragonboatfestival).poolIds
end

BM_DragonBoatFestival.AddRedDot = function(self, type)
  -- function num : 0_10
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self._dragonboatfestival).redDotList)[type] = true
end

BM_DragonBoatFestival.KillRedDot = function(self, type)
  -- function num : 0_11
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self._dragonboatfestival).redDotList)[type] = nil
end

BM_DragonBoatFestival.GetRedDot = function(self, type)
  -- function num : 0_12
  return ((self._dragonboatfestival).redDotList)[type]
end

BM_DragonBoatFestival.HaveRedDot = function(self)
  -- function num : 0_13 , upvalues : _ENV
  do return next((self._dragonboatfestival).redDotList) ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_DragonBoatFestival.ShowRedDot = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if not self:GetIsOpen() then
    return false
  end
  do return self:HaveRedDot() or ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).OpenDragonBoatFestivalDialog) ~= nil or self:GetExchangeLotteryRate() <= ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.LuckyCopperCoin) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_DragonBoatFestival.SendCDragonBoatFestivalWish = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cdragonboatfestivalwish")
  if protocol then
    protocol:Send()
  end
end

BM_DragonBoatFestival.SendCGetShopInfo = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
  if protocol then
    protocol.shopId = DataCommon.DragonBoatFestivalShopID
    protocol:Send()
  end
end

BM_DragonBoatFestival.SendCActivityExchangeLottery = function(self, exchangeNum)
  -- function num : 0_17 , upvalues : _ENV, CActivityExchange
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cactivityexchange")
  if protocol then
    protocol.activityId = (DataCommon.Activities).DragonBoatFestival
    protocol.exchangeType = CActivityExchange.EXCHANGE
    protocol.exchangeNum = exchangeNum
    protocol:Send()
  end
end

BM_DragonBoatFestival.SendCActivityExchangeRecycle = function(self)
  -- function num : 0_18 , upvalues : _ENV, CActivityExchange
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cactivityexchange")
  if protocol then
    protocol.activityId = (DataCommon.Activities).DragonBoatFestival
    protocol.exchangeType = CActivityExchange.RECYCLE
    protocol.exchangeNum = 0
    protocol:Send()
  end
end

BM_DragonBoatFestival.GetCActivitySpringOutingCfg = function(self)
  -- function num : 0_19 , upvalues : CActivitySpringOutingCfg
  return CActivitySpringOutingCfg
end

BM_DragonBoatFestival.GetCActivitySpringOutingManaCfg = function(self)
  -- function num : 0_20 , upvalues : CActivitySpringOutingManaCfg
  return CActivitySpringOutingManaCfg
end

BM_DragonBoatFestival.GetCActivityJackpot = function(self)
  -- function num : 0_21 , upvalues : CActivityJackpot
  return CActivityJackpot
end

BM_DragonBoatFestival.GetRewardPoolData = function(self)
  -- function num : 0_22 , upvalues : CActivityJackpot, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  if (self._dragonboatfestival).rewardPoolData == nil then
    (self._dragonboatfestival).rewardPoolData = {}
    local allIds = CActivityJackpot:GetAllIds()
    for _,value in ipairs(allIds) do
      local record = CActivityJackpot:GetRecorder(value)
      if record.activityId == (DataCommon.Activities).DragonBoatFestival then
        local tmpTable = {}
        tmpTable.nameId = record.nameId
        tmpTable.isFinalPool = record.resetJackpotNum == -1
        -- DECOMPILER ERROR at PC36: Confused about usage of register: R9 in 'UnsetPending'

        ;
        ((self._dragonboatfestival).rewardPoolData)[record.id] = tmpTable
      end
    end
  end
  do return (self._dragonboatfestival).rewardPoolData end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

BM_DragonBoatFestival.GetExchangeLotteryRate = function(self)
  -- function num : 0_23 , upvalues : CActivityJackpot, _ENV
  if (self._dragonboatfestival).exchangeLotteryRate == nil then
    local allIds = CActivityJackpot:GetAllIds()
    for _,value in ipairs(allIds) do
      local record = CActivityJackpot:GetRecorder(value)
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R8 in 'UnsetPending'

      if record.activityId == (DataCommon.Activities).DragonBoatFestival then
        (self._dragonboatfestival).exchangeLotteryRate = record.neednum
        break
      end
    end
  end
  do
    return (self._dragonboatfestival).exchangeLotteryRate
  end
end

BM_DragonBoatFestival.GetExchangeRecycleRate = function(self)
  -- function num : 0_24 , upvalues : CActivitySpringOutingManaCfg, _ENV
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  if (self._dragonboatfestival).exchangeRecycleRate == nil then
    (self._dragonboatfestival).exchangeRecycleRate = (CActivitySpringOutingManaCfg:GetRecorder((DataCommon.Activities).DragonBoatFestival)).targetNum
  end
  return (self._dragonboatfestival).exchangeRecycleRate
end

return BM_DragonBoatFestival

