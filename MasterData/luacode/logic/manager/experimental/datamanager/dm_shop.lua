local CDormFurnitureGroup = BeanManager.GetTableByName("courtyard.cdormfurnituregroup")
local CFurnitureTheme = BeanManager.GetTableByName("recharge.cfurnituretheme")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local CRechargeReward = BeanManager.GetTableByName("recharge.crechargerewards")
local DM_Shop = class("DM_Shop")

function DM_Shop:Ctor()
  self._shops = NekoData.Data.shops
  self._shops.shop = {}
  self._shops.recharge = {}
  self._shops.monthCardInfo = {}
  self._shops.shopinfo = {}
  self._shops.clientflag = {}
  self._shops.refreshcoint = {}
  self._shops.cabin = {
    furnitureMap = {},
    themeMap = {}
  }
  self._shops.chargeAccumulationData = {}
  self._shops.showBoxIcon = false
  self._shops.halloweenshopState = -1
  self._shops.halloweenRedPoint = 0
  self._shops.shopItemCanNotUse = {}
end

function DM_Shop:Clear()
  while self._shops.shop[#self._shops.shop] do
    table.remove(self._shops.shop, #self._shops.shop)
  end
  while self._shops.recharge[#self._shops.recharge] do
    table.remove(self._shops.recharge, #self._shops.recharge)
  end
  self._shops.monthCardInfo = {}
  self._shops.shopinfo = {}
  self._shops.clientflag = {}
  self._shops.refreshcoint = {}
  for k, v in pairs(self._shops.cabin.furnitureMap) do
    self._shops.cabin.furnitureMap[k] = nil
  end
  for k, v in pairs(self._shops.cabin.themeMap) do
    self._shops.cabin.themeMap[k] = nil
  end
  self._shops.chargeAccumulationData = {}
  self._shops.showBoxIcon = false
  self._shops.halloweenshopState = -1
  self._shops.halloweenRedPoint = 0
end

function DM_Shop:OnSGetShopInfo(protocol)
  self._shops.shop[protocol.shopId] = {}
  local shopId = protocol.shopId
  warn(">> shopId: ", protocol.shopId)
  if shopId == DataCommon.FurnitureShopId then
    self:RefreshCabinShop(protocol.goods)
  end
  if shopId == 6 or shopId == 14 or shopId == 15 or shopId == 5 or shopId == 19 or shopId == 20 or shopId == 27 or shopId == 46 or shopId == 47 or shopId == 56 or shopId == 65 or shopId == DataCommon.AprilFoolsDayActivity.Shop.ShopID or shopId == DataCommon.ChristmasCallShopID or shopId == DataCommon.DragonBoatFestivalShopID or shopId == DataCommon.SpringFestivalActivity.Shop.ShopID or shopId == DataCommon.GiftofTime.Shop.ShopID or shopId == DataCommon.Shop.OverseasReturnWelfare or shopId == DataCommon.CommonActivity.Shop.ShopId or shopId == DataCommon.SummerEchoesShopID1 or shopId == DataCommon.SummerEchoesShopID2 or shopId == DataCommon.SummerEchoesShopID3 or shopId == DataCommon.SummerNewShopID or shopId == DataCommon.DoubleElevenShopID or shopId == DataCommon.ChildrenActivity.Shop.ShopID then
    for _, v in pairs(protocol.goods) do
      table.insert(self._shops.shop[protocol.shopId], v)
    end
    for _, v in pairs(protocol.rmtGoods) do
      table.insert(self._shops.shop[protocol.shopId], v)
    end
  else
    self._shops.shop[protocol.shopId] = protocol.goods
    table.sort(self._shops.shop[protocol.shopId], function(a, b)
      return a.sortId < b.sortId
    end)
  end
end

function DM_Shop:OnSOpenDiamondShop(protocol)
  if self._shops.shop[protocol.shopId] then
    while self._shops.shop[protocol.shopId][#self._shops.shop[protocol.shopId]] do
      table.remove(self._shops.shop[protocol.shopId], #self._shops.shop[protocol.shopId])
    end
  else
    self._shops.shop[protocol.shopId] = {}
  end
  self._shops.shop[protocol.shopId] = protocol.goods
  for i, v in ipairs(protocol.goods) do
    LogInfoFormat("DM_Shop", "------OnSOpenDiamondShop------------ goodType = %s ------------", v.goodType)
  end
  table.sort(self._shops.shop[protocol.shopId], function(a, b)
    return a.sortId < b.sortId
  end)
end

function DM_Shop:OnSOpenShop(protocol)
  self._shops.shopinfo = protocol.shopInfo
end

function DM_Shop:OnSBuyShopGood(protocol)
  if self._shops.shop[protocol.shopId] then
    local list = self._shops.shop[protocol.shopId]
    for index, shopinfo in pairs(list) do
      for i, v in ipairs(protocol.refresh) do
        if shopinfo.goodId == v.goodId then
          list[index] = v
        end
      end
    end
  end
  if protocol.shopId == DataCommon.FurnitureShopId then
    self:RefreshCabinGood(protocol.refresh)
  end
end

function DM_Shop:OnSBuyDiamondGood(protocol)
  if self._shops.shop[protocol.shopId] then
    for index, shopinfo in pairs(self._shops.shop[protocol.shopId]) do
      if shopinfo.goodId == protocol.refresh.goodId then
        self._shops.shop[protocol.shopId][index] = protocol.refresh
      end
    end
  end
end

function DM_Shop:OnSMonthCardState(protocol)
  for key, value in pairs(protocol.monthcards) do
    self._shops.monthCardInfo[key] = {
      remainTime = value.remainTime,
      endTimeStr = value.endTime
    }
    LogInfoFormat("DM_Shop", "--- key = %s, remainTime = %s, endTimeStr = %s ---", key, value.remainTime, value.endTime)
  end
end

function DM_Shop:ClientSetOpenShopID(id)
  self._shops.clientflag.openshopid = id
end

function DM_Shop:SOpenResetShopPanel(protocol)
  self._shops.refreshcoint.leftchance = protocol.leftChance
  self._shops.refreshcoint.currencytype = protocol.currencyType
  self._shops.refreshcoint.nexttimecost = protocol.nextTimeCost
end

function DM_Shop:RefreshCabinShop(protocolData)
  for k, v in pairs(self._shops.cabin.furnitureMap) do
    self._shops.cabin.furnitureMap[k] = nil
  end
  for k, v in pairs(self._shops.cabin.themeMap) do
    self._shops.cabin.themeMap[k] = nil
  end
  local themeMap = {}
  local furnitureMap = {}
  local themeTag = true
  for i, v in ipairs(protocolData) do
    if themeTag and v.itemId ~= 777 then
      themeTag = false
    end
    local strTag = CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0")
    if themeTag then
      strTag = strTag .. DataCommon.CabinGoodsType.Theme
      themeMap[v.goodId] = true
    else
      strTag = strTag .. DataCommon.CabinGoodsType.Furniture
      furnitureMap[v.itemId] = v
    end
    local status = CS.UnityEngine.PlayerPrefs.GetInt(strTag .. tostring(v.goodId), DataCommon.CabinGoodsStatus.Default)
    if status == DataCommon.CabinGoodsStatus.Default then
      if v.beginTime and v.beginTime ~= 0 then
        CS.UnityEngine.PlayerPrefs.SetInt(strTag .. tostring(v.goodId), DataCommon.CabinGoodsStatus.NewAdd)
      else
        CS.UnityEngine.PlayerPrefs.SetInt(strTag .. tostring(v.goodId), DataCommon.CabinGoodsStatus.Checked)
      end
    elseif status ~= DataCommon.CabinGoodsStatus.Checked and (not (v.beginTime and v.endTime) or v.beginTime == 0 and v.endTime == 0) then
      CS.UnityEngine.PlayerPrefs.SetInt(strTag .. tostring(v.goodId), DataCommon.CabinGoodsStatus.Checked)
    end
    status = CS.UnityEngine.PlayerPrefs.GetInt(strTag .. tostring(v.goodId), DataCommon.CabinGoodsStatus.Default)
    if themeTag then
      self._shops.cabin.themeMap[v.goodId] = {serverData = v, status = status}
    else
      self._shops.cabin.furnitureMap[v.goodId] = {serverData = v, status = status}
    end
  end
  for themeId, v in pairs(themeMap) do
    local record = CDormFurnitureGroup:GetRecorder(themeId)
    local map = {}
    for i, v in ipairs(record.items) do
      if not map[v] then
        map[v] = 0
      end
      map[v] = map[v] + 1
    end
    local rechargeThemeRecord = CFurnitureTheme:GetRecorder(themeId)
    local haveCount = rechargeThemeRecord.Upperlimit
    local themeInfo = self._shops.cabin.themeMap[themeId]
    local buyCount = themeInfo.serverData.maxRemain
    for furnitureId, num in pairs(map) do
      local count = math.floor(NekoData.BehaviorManager.BM_BagInfo:GetFurnitureCountById(furnitureId) / num)
      if haveCount > count then
        haveCount = count
      end
      if furnitureMap[furnitureId] then
        local count1 = math.floor((furnitureMap[furnitureId].maxRemain - furnitureMap[furnitureId].goodRemain) / num)
        if buyCount > count1 then
          buyCount = count1
        end
      end
    end
    themeInfo.upperLimit = rechargeThemeRecord.Upperlimit
    themeInfo.stock = themeInfo.serverData.maxRemain - buyCount
    themeInfo.haveNum = haveCount
    themeInfo.haveFurnitureNum = 0
    themeInfo.totalFurnitureNum = 0
    themeInfo.price = 0
    themeInfo.comfort = 0
    themeInfo.furnitures = map
    for k, v in pairs(map) do
      local haveNum = NekoData.BehaviorManager.BM_BagInfo:GetFurnitureCountById(k)
      themeInfo.haveFurnitureNum = themeInfo.haveFurnitureNum + (haveNum - themeInfo.haveNum * v)
      themeInfo.totalFurnitureNum = themeInfo.totalFurnitureNum + v
      if furnitureMap[k] then
        themeInfo.price = themeInfo.price + v * furnitureMap[k].discountPrice
      end
      local item = FurnitureItem.Create(k)
      themeInfo.comfort = themeInfo.comfort + item:GetComfort() * v
    end
  end
end

function DM_Shop:RefreshCabinGood(goodInfoList)
  for i, info in ipairs(goodInfoList) do
    local goodInfo = self._shops.cabin.furnitureMap[info.goodId]
    if goodInfo then
      CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.CabinGoodsType.Furniture .. tostring(info.goodId), DataCommon.CabinGoodsStatus.Checked)
      self._shops.cabin.furnitureMap[info.goodId].serverData = info
      local refreshThemeMap, refreshThemeId
      for themeId, _ in pairs(self._shops.cabin.themeMap) do
        local record = CDormFurnitureGroup:GetRecorder(themeId)
        local map = {}
        local tag = false
        for i, v in ipairs(record.items) do
          if not tag and v == info.itemId then
            tag = true
          end
          if not map[v] then
            map[v] = 0
          end
          map[v] = map[v] + 1
        end
        if tag then
          refreshThemeMap = map
          refreshThemeId = themeId
          break
        end
      end
      if refreshThemeId then
        local furnitureMap = NekoData.BehaviorManager.BM_Shop:GetFurnitures()
        local themeInfo = self._shops.cabin.themeMap[refreshThemeId]
        local haveCount = themeInfo.upperLimit
        local buyCount = themeInfo.serverData.maxRemain
        for furnitureId, num in pairs(refreshThemeMap) do
          local count = math.floor(NekoData.BehaviorManager.BM_BagInfo:GetFurnitureCountById(furnitureId) / num)
          if haveCount > count then
            haveCount = count
          end
          local count1 = math.floor((furnitureMap[furnitureId].serverData.maxRemain - furnitureMap[furnitureId].serverData.goodRemain) / num)
          if buyCount > count1 then
            buyCount = count1
          end
        end
        themeInfo.stock = themeInfo.serverData.maxRemain - buyCount
        themeInfo.haveNum = haveCount
        themeInfo.haveFurnitureNum = 0
        themeInfo.totalFurnitureNum = 0
        themeInfo.price = 0
        themeInfo.comfort = 0
        themeInfo.furnitures = refreshThemeMap
        for k, v in pairs(refreshThemeMap) do
          local haveNum = NekoData.BehaviorManager.BM_BagInfo:GetFurnitureCountById(k)
          themeInfo.haveFurnitureNum = themeInfo.haveFurnitureNum + (haveNum - themeInfo.haveNum * v)
          themeInfo.totalFurnitureNum = themeInfo.totalFurnitureNum + v
          themeInfo.price = themeInfo.price + v * furnitureMap[k].serverData.discountPrice
          local item = FurnitureItem.Create(k)
          themeInfo.comfort = themeInfo.comfort + item:GetComfort() * v
        end
      end
    end
  end
end

function DM_Shop:SetChecked(strTag, goodId)
  local curUserId = CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0")
  CS.UnityEngine.PlayerPrefs.SetInt(curUserId .. strTag .. tostring(goodId), DataCommon.CabinGoodsStatus.Checked)
  if strTag == DataCommon.CabinGoodsType.Theme then
    self._shops.cabin.themeMap[goodId].status = DataCommon.CabinGoodsStatus.Checked
  else
    self._shops.cabin.furnitureMap[goodId].status = DataCommon.CabinGoodsStatus.Checked
  end
end

function DM_Shop:OnSShopPoints(protocol)
  local temp = {}
  temp.currentLevel = protocol.level
  temp.currentLevelExp = protocol.score
  temp.totalScore = protocol.totalScore
  local gottenIDTable = {}
  for k, v in pairs(protocol.reward) do
    gottenIDTable[v] = true
  end
  temp.gottenIDTable = gottenIDTable
  if temp.currentLevel >= 1 then
    temp.isChargeAccumulationUnlock = true
  else
    temp.isChargeAccumulationUnlock = false
  end
  self._shops.chargeAccumulationData = temp
  self:HandleChargeAccumulationData()
  if temp.currentLevel >= 1 then
    LuaNotificationCenter.PostNotification(Common.n_ChargeAccumulationUnlock, nil, nil)
  end
end

function DM_Shop:OnSReceiveShopPointReward(protocol)
  self._shops.chargeAccumulationData.gottenIDTable[protocol.id] = true
  self._shops.chargeAccumulationData.waitToGetTable[protocol.id] = nil
  local userInfo = {}
  userInfo.receivedID = protocol.id
  LuaNotificationCenter.PostNotification(Common.n_ChargeAccumulationReceiveReward, nil, userInfo)
end

function DM_Shop:OnSAddShopPoints(protocol)
  local data = self._shops.chargeAccumulationData
  local oldLevel = data.currentLevel
  local currentMaxExp = 0
  if data.currentLevel >= 1 then
    if data.currentLevel >= #CRechargeReward:GetAllIds() then
      currentMaxExp = CRechargeReward:GetRecorder(#CRechargeReward:GetAllIds()).totalExperience - CRechargeReward:GetRecorder(#CRechargeReward:GetAllIds() - 1).totalExperience
    else
      currentMaxExp = CRechargeReward:GetRecorder(data.currentLevel + 1).totalExperience - CRechargeReward:GetRecorder(data.currentLevel).totalExperience
    end
  else
    currentMaxExp = CRechargeReward:GetRecorder(1).totalExperience
  end
  local resultExp = data.currentLevelExp + protocol.addScore
  data.totalScore = data.totalScore + protocol.addScore
  if currentMaxExp <= resultExp then
    local nextLevel = data.currentLevel + 1
    local nextLevelRecord = CRechargeReward:GetRecorder(nextLevel)
    if nextLevelRecord == nil then
      data.currentLevelExp = currentMaxExp
      return
    end
    local diff = resultExp - currentMaxExp
    local nextMaxExp = 0
    if nextLevel >= #CRechargeReward:GetAllIds() then
      nextMaxExp = CRechargeReward:GetRecorder(#CRechargeReward:GetAllIds()).totalExperience - CRechargeReward:GetRecorder(#CRechargeReward:GetAllIds() - 1).totalExperience
    else
      nextMaxExp = CRechargeReward:GetRecorder(nextLevel + 1).totalExperience - CRechargeReward:GetRecorder(nextLevel).totalExperience
    end
    while diff >= nextMaxExp do
      nextLevel = nextLevel + 1
      nextLevelRecord = CRechargeReward:GetRecorder(nextLevel)
      if nextLevelRecord == nil then
        data.currentLevel = nextLevel - 1
        data.currentLevelExp = nextMaxExp
        return
      end
      diff = diff - nextMaxExp
      nextMaxExp = CRechargeReward:GetRecorder(nextLevel + 1).totalExperience - CRechargeReward:GetRecorder(nextLevel).totalExperience
    end
    data.currentLevel = nextLevel
    data.currentLevelExp = diff
    for i = oldLevel + 1, data.currentLevel do
      for k, v in ipairs(data.levelRewardMap[i]) do
        data.waitToGetTable[v] = true
      end
    end
  else
    data.currentLevelExp = resultExp
  end
  if data.currentLevel >= 1 then
    self._shops.chargeAccumulationData.isChargeAccumulationUnlock = true
    LuaNotificationCenter.PostNotification(Common.n_ChargeAccumulationUnlock, nil, nil)
  end
  LuaNotificationCenter.PostNotification(Common.n_ChargeAccumulationAddPoints, nil, nil)
end

function DM_Shop:HandleChargeAccumulationData()
  local data = self._shops.chargeAccumulationData
  local gottenIDTable = data.gottenIDTable
  local levelRewardMap = {}
  local waitToGetTable = {}
  data.levelRewardMap = levelRewardMap
  data.waitToGetTable = waitToGetTable
  for k, v in ipairs(CRechargeReward:GetAllIds()) do
    local record = CRechargeReward:GetRecorder(v)
    local rewardLiist = levelRewardMap[record.unlockLevel]
    if rewardLiist == nil then
      rewardLiist = {}
      levelRewardMap[record.unlockLevel] = rewardLiist
    end
    table.insert(rewardLiist, v)
  end
  local currentLevel = data.currentLevel
  for k, v in ipairs(CRechargeReward:GetAllIds()) do
    local record = CRechargeReward:GetRecorder(v)
    if currentLevel >= record.unlockLevel then
      if gottenIDTable[v] == nil then
        waitToGetTable[v] = true
      end
    else
      break
    end
  end
end

function DM_Shop:OnSFreeLevelGiftIcon()
  self._shops.showBoxIcon = true
end

function DM_Shop:DisableShowBoxIcon()
  self._shops.showBoxIcon = false
end

function DM_Shop:HalloweenShopOpenState(protocol)
  self._shops.halloweenshopState = protocol.state
end

function DM_Shop:HalloweenRedPoint(state)
  self._shops.halloweenRedPoint = state
end

function DM_Shop:OnSShopDisplay(protocol)
  self._shops.shopItemCanNotUse[protocol.shopType] = protocol.isMask == 1
end

return DM_Shop
