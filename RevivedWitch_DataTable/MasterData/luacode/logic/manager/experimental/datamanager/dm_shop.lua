-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_shop.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CDormFurnitureGroup = (BeanManager.GetTableByName)("courtyard.cdormfurnituregroup")
local CFurnitureTheme = (BeanManager.GetTableByName)("recharge.cfurnituretheme")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local CRechargeReward = (BeanManager.GetTableByName)("recharge.crechargerewards")
local DM_Shop = class("DM_Shop")
DM_Shop.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._shops = (NekoData.Data).shops
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).shop = {}
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).recharge = {}
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).monthCardInfo = {}
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).shopinfo = {}
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).clientflag = {}
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).refreshcoint = {}
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).cabin = {
furnitureMap = {}
, 
themeMap = {}
}
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).chargeAccumulationData = {}
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).showBoxIcon = false
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).halloweenshopState = -1
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).halloweenRedPoint = 0
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).shopItemCanNotUse = {}
end

DM_Shop.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  while ((self._shops).shop)[#(self._shops).shop] do
    (table.remove)((self._shops).shop, #(self._shops).shop)
  end
  while ((self._shops).recharge)[#(self._shops).recharge] do
    (table.remove)((self._shops).recharge, #(self._shops).recharge)
  end
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).monthCardInfo = {}
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).shopinfo = {}
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).clientflag = {}
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).refreshcoint = {}
  for k,v in pairs(((self._shops).cabin).furnitureMap) do
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R6 in 'UnsetPending'

    (((self._shops).cabin).furnitureMap)[k] = nil
  end
  for k,v in pairs(((self._shops).cabin).themeMap) do
    -- DECOMPILER ERROR at PC67: Confused about usage of register: R6 in 'UnsetPending'

    (((self._shops).cabin).themeMap)[k] = nil
  end
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).chargeAccumulationData = {}
  -- DECOMPILER ERROR at PC74: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).showBoxIcon = false
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).halloweenshopState = -1
  -- DECOMPILER ERROR at PC78: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._shops).halloweenRedPoint = 0
end

DM_Shop.OnSGetShopInfo = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ((self._shops).shop)[protocol.shopId] = {}
  local shopId = protocol.shopId
  warn(">> shopId: ", protocol.shopId)
  if shopId == DataCommon.FurnitureShopId then
    self:RefreshCabinShop(protocol.goods)
  end
  if shopId == 6 or shopId == 14 or shopId == 15 or shopId == 5 or shopId == 19 or shopId == 20 or shopId == 27 or shopId == 46 or shopId == 47 or shopId == 56 or shopId == ((DataCommon.AprilFoolsDayActivity).Shop).ShopID or shopId == DataCommon.ChristmasCallShopID or shopId == DataCommon.DragonBoatFestivalShopID or shopId == ((DataCommon.SpringFestivalActivity).Shop).ShopID or shopId == ((DataCommon.GiftofTime).Shop).ShopID or shopId == (DataCommon.Shop).OverseasReturnWelfare or shopId == ((DataCommon.CommonActivity).Shop).ShopId or shopId == DataCommon.SummerEchoesShopID1 or shopId == DataCommon.SummerEchoesShopID2 or shopId == DataCommon.SummerEchoesShopID3 or shopId == DataCommon.SummerNewShopID or shopId == DataCommon.DoubleElevenShopID or shopId == ((DataCommon.ChildrenActivity).Shop).ShopID then
    for _,v in pairs(protocol.goods) do
      (table.insert)(((self._shops).shop)[protocol.shopId], v)
    end
    for _,v in pairs(protocol.rmtGoods) do
      (table.insert)(((self._shops).shop)[protocol.shopId], v)
    end
  else
    do
      -- DECOMPILER ERROR at PC133: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self._shops).shop)[protocol.shopId] = protocol.goods
      ;
      (table.sort)(((self._shops).shop)[protocol.shopId], function(a, b)
    -- function num : 0_2_0
    do return a.sortId < b.sortId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    end
  end
end

DM_Shop.OnSOpenDiamondShop = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
  while ((self._shops).shop)[protocol.shopId] and (((self._shops).shop)[protocol.shopId])[#((self._shops).shop)[protocol.shopId]] do
    (table.remove)(((self._shops).shop)[protocol.shopId], #((self._shops).shop)[protocol.shopId])
  end
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._shops).shop)[protocol.shopId] = {}
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._shops).shop)[protocol.shopId] = protocol.goods
  for i,v in ipairs(protocol.goods) do
    LogInfoFormat("DM_Shop", "------OnSOpenDiamondShop------------ goodType = %s ------------", v.goodType)
  end
  ;
  (table.sort)(((self._shops).shop)[protocol.shopId], function(a, b)
    -- function num : 0_3_0
    do return a.sortId < b.sortId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

DM_Shop.OnSOpenShop = function(self, protocol)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._shops).shopinfo = protocol.shopInfo
end

DM_Shop.OnSBuyShopGood = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV
  if ((self._shops).shop)[protocol.shopId] then
    local list = ((self._shops).shop)[protocol.shopId]
    for index,shopinfo in pairs(list) do
      for i,v in ipairs(protocol.refresh) do
        if shopinfo.goodId == v.goodId then
          list[index] = v
        end
      end
    end
  end
  do
    if protocol.shopId == DataCommon.FurnitureShopId then
      self:RefreshCabinGood(protocol.refresh)
    end
  end
end

DM_Shop.OnSBuyDiamondGood = function(self, protocol)
  -- function num : 0_6 , upvalues : _ENV
  if ((self._shops).shop)[protocol.shopId] then
    for index,shopinfo in pairs(((self._shops).shop)[protocol.shopId]) do
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R7 in 'UnsetPending'

      if shopinfo.goodId == (protocol.refresh).goodId then
        (((self._shops).shop)[protocol.shopId])[index] = protocol.refresh
      end
    end
  end
end

DM_Shop.OnSMonthCardState = function(self, protocol)
  -- function num : 0_7 , upvalues : _ENV
  for key,value in pairs(protocol.monthcards) do
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R7 in 'UnsetPending'

    ((self._shops).monthCardInfo)[key] = {remainTime = value.remainTime, endTimeStr = value.endTime}
    LogInfoFormat("DM_Shop", "--- key = %s, remainTime = %s, endTimeStr = %s ---", key, value.remainTime, value.endTime)
  end
end

DM_Shop.ClientSetOpenShopID = function(self, id)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self._shops).clientflag).openshopid = id
end

DM_Shop.SOpenResetShopPanel = function(self, protocol)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._shops).refreshcoint).leftchance = protocol.leftChance
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._shops).refreshcoint).currencytype = protocol.currencyType
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._shops).refreshcoint).nexttimecost = protocol.nextTimeCost
end

DM_Shop.RefreshCabinShop = function(self, protocolData)
  -- function num : 0_10 , upvalues : _ENV, CDormFurnitureGroup, CFurnitureTheme, FurnitureItem
  for k,v in pairs(((self._shops).cabin).furnitureMap) do
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R7 in 'UnsetPending'

    (((self._shops).cabin).furnitureMap)[k] = nil
  end
  for k,v in pairs(((self._shops).cabin).themeMap) do
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R7 in 'UnsetPending'

    (((self._shops).cabin).themeMap)[k] = nil
  end
  local themeMap = {}
  local furnitureMap = {}
  local themeTag = true
  for i,v in ipairs(protocolData) do
    if themeTag and v.itemId ~= 777 then
      themeTag = false
    end
    local strTag = (((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0")
    if themeTag then
      strTag = strTag .. (DataCommon.CabinGoodsType).Theme
      themeMap[v.goodId] = true
    else
      strTag = strTag .. (DataCommon.CabinGoodsType).Furniture
      furnitureMap[v.itemId] = v
    end
    local status = (((CS.UnityEngine).PlayerPrefs).GetInt)(strTag .. tostring(v.goodId), (DataCommon.CabinGoodsStatus).Default)
    if status == (DataCommon.CabinGoodsStatus).Default then
      if v.beginTime and v.beginTime ~= 0 then
        (((CS.UnityEngine).PlayerPrefs).SetInt)(strTag .. tostring(v.goodId), (DataCommon.CabinGoodsStatus).NewAdd)
      else
        ;
        (((CS.UnityEngine).PlayerPrefs).SetInt)(strTag .. tostring(v.goodId), (DataCommon.CabinGoodsStatus).Checked)
      end
    else
      if status ~= (DataCommon.CabinGoodsStatus).Checked and (not v.beginTime or not v.endTime or v.beginTime ~= 0 or v.endTime == 0) then
        (((CS.UnityEngine).PlayerPrefs).SetInt)(strTag .. tostring(v.goodId), (DataCommon.CabinGoodsStatus).Checked)
      end
    end
    status = (((CS.UnityEngine).PlayerPrefs).GetInt)(strTag .. tostring(v.goodId), (DataCommon.CabinGoodsStatus).Default)
    -- DECOMPILER ERROR at PC166: Confused about usage of register: R12 in 'UnsetPending'

    if themeTag then
      (((self._shops).cabin).themeMap)[v.goodId] = {serverData = v, status = status}
    else
      -- DECOMPILER ERROR at PC175: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (((self._shops).cabin).furnitureMap)[v.goodId] = {serverData = v, status = status}
    end
  end
  for themeId,v in pairs(themeMap) do
    local record = CDormFurnitureGroup:GetRecorder(themeId)
    local map = {}
    for i,v in ipairs(record.items) do
      if not map[v] then
        map[v] = 0
      end
      map[v] = map[v] + 1
    end
    local rechargeThemeRecord = CFurnitureTheme:GetRecorder(themeId)
    local haveCount = rechargeThemeRecord.Upperlimit
    local themeInfo = (((self._shops).cabin).themeMap)[themeId]
    local buyCount = (themeInfo.serverData).maxRemain
    for furnitureId,num in pairs(map) do
      local count = (math.floor)(((NekoData.BehaviorManager).BM_BagInfo):GetFurnitureCountById(furnitureId) / num)
      if count < haveCount then
        haveCount = count
      end
      local count1 = (math.floor)(((furnitureMap[furnitureId]).maxRemain - (furnitureMap[furnitureId]).goodRemain) / num)
      if count1 < buyCount then
        buyCount = count1
      end
    end
    themeInfo.upperLimit = rechargeThemeRecord.Upperlimit
    themeInfo.stock = (themeInfo.serverData).maxRemain - buyCount
    themeInfo.haveNum = haveCount
    themeInfo.haveFurnitureNum = 0
    themeInfo.totalFurnitureNum = 0
    themeInfo.price = 0
    themeInfo.comfort = 0
    themeInfo.furnitures = map
    for k,v in pairs(map) do
      local haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetFurnitureCountById(k)
      themeInfo.haveFurnitureNum = themeInfo.haveFurnitureNum + (haveNum - themeInfo.haveNum * v)
      themeInfo.totalFurnitureNum = themeInfo.totalFurnitureNum + v
      themeInfo.price = themeInfo.price + v * (furnitureMap[k]).discountPrice
      local item = (FurnitureItem.Create)(k)
      themeInfo.comfort = themeInfo.comfort + item:GetComfort() * v
    end
  end
end

DM_Shop.RefreshCabinGood = function(self, goodInfoList)
  -- function num : 0_11 , upvalues : _ENV, CDormFurnitureGroup, FurnitureItem
  for i,info in ipairs(goodInfoList) do
    local goodInfo = (((self._shops).cabin).furnitureMap)[info.goodId]
    if goodInfo then
      (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. (DataCommon.CabinGoodsType).Furniture .. tostring(info.goodId), (DataCommon.CabinGoodsStatus).Checked)
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((((self._shops).cabin).furnitureMap)[info.goodId]).serverData = info
      local refreshThemeMap, refreshThemeId = nil, nil
      for themeId,_ in pairs(((self._shops).cabin).themeMap) do
        local record = CDormFurnitureGroup:GetRecorder(themeId)
        local map = {}
        local tag = false
        for i,v in ipairs(record.items) do
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
      do
        if refreshThemeId then
          local furnitureMap = ((NekoData.BehaviorManager).BM_Shop):GetFurnitures()
          local themeInfo = (((self._shops).cabin).themeMap)[refreshThemeId]
          local haveCount = themeInfo.upperLimit
          local buyCount = (themeInfo.serverData).maxRemain
          for furnitureId,num in pairs(refreshThemeMap) do
            local count = (math.floor)(((NekoData.BehaviorManager).BM_BagInfo):GetFurnitureCountById(furnitureId) / num)
            if count < haveCount then
              haveCount = count
            end
            local count1 = (math.floor)((((furnitureMap[furnitureId]).serverData).maxRemain - ((furnitureMap[furnitureId]).serverData).goodRemain) / num)
            if count1 < buyCount then
              buyCount = count1
            end
          end
          themeInfo.stock = (themeInfo.serverData).maxRemain - buyCount
          themeInfo.haveNum = haveCount
          themeInfo.haveFurnitureNum = 0
          themeInfo.totalFurnitureNum = 0
          themeInfo.price = 0
          themeInfo.comfort = 0
          themeInfo.furnitures = refreshThemeMap
          for k,v in pairs(refreshThemeMap) do
            local haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetFurnitureCountById(k)
            themeInfo.haveFurnitureNum = themeInfo.haveFurnitureNum + (haveNum - themeInfo.haveNum * v)
            themeInfo.totalFurnitureNum = themeInfo.totalFurnitureNum + v
            themeInfo.price = themeInfo.price + v * ((furnitureMap[k]).serverData).discountPrice
            local item = (FurnitureItem.Create)(k)
            themeInfo.comfort = themeInfo.comfort + item:GetComfort() * v
          end
        end
        do
          -- DECOMPILER ERROR at PC172: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC172: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC172: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

DM_Shop.SetChecked = function(self, strTag, goodId)
  -- function num : 0_12 , upvalues : _ENV
  local curUserId = (((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0")
  ;
  (((CS.UnityEngine).PlayerPrefs).SetInt)(curUserId .. strTag .. tostring(goodId), (DataCommon.CabinGoodsStatus).Checked)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R4 in 'UnsetPending'

  if strTag == (DataCommon.CabinGoodsType).Theme then
    ((((self._shops).cabin).themeMap)[goodId]).status = (DataCommon.CabinGoodsStatus).Checked
  else
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((((self._shops).cabin).furnitureMap)[goodId]).status = (DataCommon.CabinGoodsStatus).Checked
  end
end

DM_Shop.OnSShopPoints = function(self, protocol)
  -- function num : 0_13 , upvalues : _ENV
  local temp = {}
  temp.currentLevel = protocol.level
  temp.currentLevelExp = protocol.score
  temp.totalScore = protocol.totalScore
  local gottenIDTable = {}
  for k,v in pairs(protocol.reward) do
    gottenIDTable[v] = true
  end
  temp.gottenIDTable = gottenIDTable
  if temp.currentLevel >= 1 then
    temp.isChargeAccumulationUnlock = true
  else
    temp.isChargeAccumulationUnlock = false
  end
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._shops).chargeAccumulationData = temp
  self:HandleChargeAccumulationData()
  if temp.currentLevel >= 1 then
    (LuaNotificationCenter.PostNotification)(Common.n_ChargeAccumulationUnlock, nil, nil)
  end
end

DM_Shop.OnSReceiveShopPointReward = function(self, protocol)
  -- function num : 0_14 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  (((self._shops).chargeAccumulationData).gottenIDTable)[protocol.id] = true
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self._shops).chargeAccumulationData).waitToGetTable)[protocol.id] = nil
  local userInfo = {}
  userInfo.receivedID = protocol.id
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_ChargeAccumulationReceiveReward, nil, userInfo)
end

DM_Shop.OnSAddShopPoints = function(self, protocol)
  -- function num : 0_15 , upvalues : CRechargeReward, _ENV
  local data = (self._shops).chargeAccumulationData
  local oldLevel = data.currentLevel
  local currentMaxExp = 0
  if data.currentLevel >= 1 then
    if #CRechargeReward:GetAllIds() <= data.currentLevel then
      currentMaxExp = (CRechargeReward:GetRecorder(#CRechargeReward:GetAllIds())).totalExperience - (CRechargeReward:GetRecorder(#CRechargeReward:GetAllIds() - 1)).totalExperience
    else
      currentMaxExp = (CRechargeReward:GetRecorder(data.currentLevel + 1)).totalExperience - (CRechargeReward:GetRecorder(data.currentLevel)).totalExperience
    end
  else
    currentMaxExp = (CRechargeReward:GetRecorder(1)).totalExperience
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
    if #CRechargeReward:GetAllIds() <= nextLevel then
      nextMaxExp = (CRechargeReward:GetRecorder(#CRechargeReward:GetAllIds())).totalExperience - (CRechargeReward:GetRecorder(#CRechargeReward:GetAllIds() - 1)).totalExperience
    else
      nextMaxExp = (CRechargeReward:GetRecorder(nextLevel + 1)).totalExperience - (CRechargeReward:GetRecorder(nextLevel)).totalExperience
    end
    while nextMaxExp <= diff do
      nextLevel = nextLevel + 1
      nextLevelRecord = CRechargeReward:GetRecorder(nextLevel)
      if nextLevelRecord == nil then
        data.currentLevel = nextLevel - 1
        data.currentLevelExp = nextMaxExp
        return 
      end
      diff = diff - (nextMaxExp)
      nextMaxExp = (CRechargeReward:GetRecorder(nextLevel + 1)).totalExperience - (CRechargeReward:GetRecorder(nextLevel)).totalExperience
    end
    data.currentLevel = nextLevel
    data.currentLevelExp = diff
    for i = oldLevel + 1, data.currentLevel do
      for k,v in ipairs((data.levelRewardMap)[i]) do
        -- DECOMPILER ERROR at PC147: Confused about usage of register: R19 in 'UnsetPending'

        (data.waitToGetTable)[v] = true
      end
    end
  else
    do
      data.currentLevelExp = resultExp
      -- DECOMPILER ERROR at PC158: Confused about usage of register: R6 in 'UnsetPending'

      if data.currentLevel >= 1 then
        ((self._shops).chargeAccumulationData).isChargeAccumulationUnlock = true
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_ChargeAccumulationUnlock, nil, nil)
      end
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_ChargeAccumulationAddPoints, nil, nil)
    end
  end
end

DM_Shop.HandleChargeAccumulationData = function(self)
  -- function num : 0_16 , upvalues : _ENV, CRechargeReward
  local data = (self._shops).chargeAccumulationData
  local gottenIDTable = data.gottenIDTable
  local levelRewardMap = {}
  local waitToGetTable = {}
  data.levelRewardMap = levelRewardMap
  data.waitToGetTable = waitToGetTable
  for k,v in ipairs(CRechargeReward:GetAllIds()) do
    local record = CRechargeReward:GetRecorder(v)
    local rewardLiist = levelRewardMap[record.unlockLevel]
    if rewardLiist == nil then
      rewardLiist = {}
      levelRewardMap[record.unlockLevel] = rewardLiist
    end
    ;
    (table.insert)(rewardLiist, v)
  end
  local currentLevel = data.currentLevel
  for k,v in ipairs(CRechargeReward:GetAllIds()) do
    local record = CRechargeReward:GetRecorder(v)
    if record.unlockLevel <= currentLevel then
      if gottenIDTable[v] == nil then
        waitToGetTable[v] = true
      end
    else
      break
    end
  end
end

DM_Shop.OnSFreeLevelGiftIcon = function(self)
  -- function num : 0_17
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._shops).showBoxIcon = true
end

DM_Shop.DisableShowBoxIcon = function(self)
  -- function num : 0_18
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._shops).showBoxIcon = false
end

DM_Shop.HalloweenShopOpenState = function(self, protocol)
  -- function num : 0_19
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._shops).halloweenshopState = protocol.state
end

DM_Shop.HalloweenRedPoint = function(self, state)
  -- function num : 0_20
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._shops).halloweenRedPoint = state
end

DM_Shop.OnSShopDisplay = function(self, protocol)
  -- function num : 0_21
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ((self._shops).shopItemCanNotUse)[protocol.shopType] = protocol.isMask == 1
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return DM_Shop

