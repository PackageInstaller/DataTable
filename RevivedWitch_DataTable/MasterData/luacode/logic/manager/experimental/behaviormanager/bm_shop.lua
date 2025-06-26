-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_shop.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CRechargeReward = (BeanManager.GetTableByName)("recharge.crechargerewards")
local BM_Shop = class("BM_Shop")
BM_Shop.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._shops = (NekoData.Data).shops
end

BM_Shop.GetShopWithShopId = function(self, id)
  -- function num : 0_1 , upvalues : _ENV
  for _,shop in ipairs((self._shops).shop) do
    if shop.id == id then
      return shop
    end
  end
end

BM_Shop.GetRechargeWithTypeId = function(self, id)
  -- function num : 0_2 , upvalues : _ENV
  for _,r in ipairs((self._shops).recharge) do
    if r.typeId == id then
      return r
    end
  end
end

BM_Shop.GetShopGoodInfoByID = function(self, id)
  -- function num : 0_3 , upvalues : _ENV
  for shopid,goods in pairs((self._shops).shop) do
    if shopid == id then
      return goods
    end
  end
end

BM_Shop.GetShopIDList = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local list = {}
  for _,shopinfo in pairs((self._shops).shopinfo) do
    if shopinfo.openType == 0 then
      (table.insert)(list, shopinfo.shopId)
    else
      if shopinfo.openTime == 0 then
        (table.insert)(list, shopinfo.shopId)
      end
    end
  end
  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).GrowGift) and not ((NekoData.BehaviorManager).BM_Welfare):IsBoughtGrowGift() then
    (table.insert)(list, DataCommon.GrowGiftShopId)
  end
  if (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID)):GetCurrentActId() > 0 then
    (table.insert)(list, 23)
  end
  return list
end

BM_Shop.GetHasOpenTimeShopIDList = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local list = {}
  for _,shopinfo in pairs((self._shops).shopinfo) do
    if shopinfo.openType ~= 0 or shopinfo.openTime ~= 0 then
      (table.insert)(list, shopinfo)
    end
  end
  return list
end

BM_Shop.GetHasCloseTimeShopIDList = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local list = {}
  for _,shopinfo in pairs((self._shops).shopinfo) do
    if (shopinfo.openType ~= 0 or shopinfo.closeTime ~= 0) and shopinfo.openType == 2 then
      (table.insert)(list, shopinfo)
    end
  end
  return list
end

BM_Shop.GetHasRefreshTimeShopIDList = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local list = {}
  for _,shopinfo in pairs((self._shops).shopinfo) do
    if (shopinfo.openType ~= 0 or shopinfo.closeTime ~= 0) and shopinfo.openType == 1 then
      (table.insert)(list, shopinfo)
    end
  end
  return list
end

BM_Shop.GetShopInfoByID = function(self, shopid)
  -- function num : 0_8 , upvalues : _ENV
  for _,shopinfo in pairs((self._shops).shopinfo) do
    if shopinfo.shopId == shopid then
      return shopinfo
    end
  end
end

BM_Shop.GetMonthCardRemainTime = function(self, key)
  -- function num : 0_9
  if ((self._shops).monthCardInfo)[key] then
    return (((self._shops).monthCardInfo)[key]).remainTime
  end
  return nil
end

BM_Shop.GetMonthCardEndShowTime = function(self, key)
  -- function num : 0_10
  if ((self._shops).monthCardInfo)[key] then
    return (((self._shops).monthCardInfo)[key]).endTimeStr
  end
  return nil
end

BM_Shop.GetClientOpenShopID = function(self)
  -- function num : 0_11
  return ((self._shops).clientflag).openshopid
end

BM_Shop.GetShopRefreshCointLeftChange = function(self)
  -- function num : 0_12
  return ((self._shops).refreshcoint).leftchance
end

BM_Shop.GetShopRefreshCointCurrencyType = function(self)
  -- function num : 0_13
  return ((self._shops).refreshcoint).currencytype
end

BM_Shop.GetShopRefreshCointNextTimeCost = function(self)
  -- function num : 0_14
  return ((self._shops).refreshcoint).nexttimecost
end

local shop_discount = {11401, 11400, 11399, 11398, 11397, 11396, 11395, 11394, 11393}
BM_Shop.GetDiscountAsset = function(self, discount)
  -- function num : 0_15 , upvalues : shop_discount, CImagePathTable
  if not shop_discount[discount] then
    return nil
  end
  local r = CImagePathTable:GetRecorder(shop_discount[discount])
  if not r then
    return nil
  end
  return r
end

BM_Shop.GetRemainTimeStr = function(self, endTime)
  -- function num : 0_16 , upvalues : _ENV, CStringRes
  local str = ""
  if endTime and endTime > 0 then
    local time = endTime // 1000
    local year = time // 31536000
    local day = time // 86400
    local hour = time // 3600
    local min = time // 60
    local sec = time % 60
    if year > 0 then
      str = (TextManager.GetText)((CStringRes:GetRecorder(1170)).msgTextID)
      str = (string.gsub)(str, "%$parameter1%$", year)
    else
      if day > 0 then
        str = (TextManager.GetText)((CStringRes:GetRecorder(1171)).msgTextID)
        str = (string.gsub)(str, "%$parameter1%$", day)
      else
        if hour > 0 then
          str = (TextManager.GetText)((CStringRes:GetRecorder(1172)).msgTextID)
          str = (string.gsub)(str, "%$parameter1%$", hour)
        else
          if min > 0 then
            str = (TextManager.GetText)((CStringRes:GetRecorder(1173)).msgTextID)
            str = (string.gsub)(str, "%$parameter1%$", min)
          else
            if sec > 0 then
              str = (TextManager.GetText)((CStringRes:GetRecorder(1173)).msgTextID)
              str = (string.gsub)(str, "%$parameter1%$", 0)
            end
          end
        end
      end
    end
  end
  do
    return str
  end
end

BM_Shop.GetRemainTimeStrForMonthCard = function(self, endTime)
  -- function num : 0_17 , upvalues : _ENV, CStringRes
  local str = ""
  if endTime and endTime > 0 then
    local time = endTime // 1000
    local day = time // 86400
    local hour = (time - day * 86400) // 3600
    str = (TextManager.GetText)((CStringRes:GetRecorder(1528)).msgTextID)
    str = (string.gsub)(str, "%$parameter1%$", day)
    str = (string.gsub)(str, "%$parameter2%$", hour)
  end
  do
    return str
  end
end

BM_Shop.GetMonthCardRemainTimeStr = function(self, endTime)
  -- function num : 0_18 , upvalues : _ENV, CStringRes
  local str = ""
  if endTime and endTime > 0 then
    local time = endTime // 1000
    local year = time // 31536000
    local day = time // 86400
    local hour = time // 3600
    local min = time // 60
    local sec = time % 60
    if year > 0 then
      str = (TextManager.GetText)((CStringRes:GetRecorder(1502)).msgTextID)
      str = (string.gsub)(str, "%$parameter1%$", year)
    else
      if day > 0 then
        str = (TextManager.GetText)((CStringRes:GetRecorder(1503)).msgTextID)
        str = (string.gsub)(str, "%$parameter1%$", day)
      else
        if hour > 0 then
          str = (TextManager.GetText)((CStringRes:GetRecorder(1504)).msgTextID)
          str = (string.gsub)(str, "%$parameter1%$", hour)
        else
          if min > 0 then
            str = (TextManager.GetText)((CStringRes:GetRecorder(1505)).msgTextID)
            str = (string.gsub)(str, "%$parameter1%$", min)
          else
            if sec > 0 then
              str = (TextManager.GetText)((CStringRes:GetRecorder(1505)).msgTextID)
              str = (string.gsub)(str, "%$parameter1%$", 0)
            end
          end
        end
      end
    end
  end
  do
    return str
  end
end

BM_Shop.GetSpriteEvidenceRemainTimeStr = function(self, endTime)
  -- function num : 0_19 , upvalues : _ENV, CStringRes
  local str = ""
  if endTime and endTime > 0 then
    local time = endTime // 1000
    local year = time // 31536000
    local day = time // 86400
    local hour = time // 3600
    local min = time // 60
    local sec = time % 60
    if year > 0 then
      str = (TextManager.GetText)((CStringRes:GetRecorder(2091)).msgTextID)
      str = (string.gsub)(str, "%$parameter1%$", year)
    else
      if day > 0 then
        str = (TextManager.GetText)((CStringRes:GetRecorder(2092)).msgTextID)
        str = (string.gsub)(str, "%$parameter1%$", day)
      else
        if hour > 0 then
          str = (TextManager.GetText)((CStringRes:GetRecorder(2093)).msgTextID)
          str = (string.gsub)(str, "%$parameter1%$", hour)
        else
          if min > 0 then
            str = (TextManager.GetText)((CStringRes:GetRecorder(2094)).msgTextID)
            str = (string.gsub)(str, "%$parameter1%$", min)
          else
            if sec > 0 then
              str = (TextManager.GetText)((CStringRes:GetRecorder(2094)).msgTextID)
              str = (string.gsub)(str, "%$parameter1%$", 0)
            end
          end
        end
      end
    end
  end
  do
    return str
  end
end

BM_Shop.TryOpenShopWithID = function(self, shopID)
  -- function num : 0_20 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("shop.shopmaindialog")
  if dialog then
    dialog:OnGroupBtnClicked(shopID)
  else
    dialog = (DialogManager.GetDialog)("base.basemainui")
    if dialog then
      (LuaNotificationCenter.AddObserver)(self, self._OpenShopCallBack, Common.n_SOpenShop, nil)
      self._toOpenShopID = shopID
      dialog:OnShopClick()
    else
      ;
      ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(shopID)
      local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
      if protocol then
        protocol:Send()
      end
    end
  end
end

BM_Shop._OpenShopCallBack = function(self, notification)
  -- function num : 0_21 , upvalues : _ENV
  local dialog = notification.userInfo
  if dialog and self._toOpenShopID then
    dialog:OnGroupBtnClicked(self._toOpenShopID)
    self._toOpenShopID = nil
  else
    LogError("BM_Shop", "Cannot find shopmaindialog.")
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self, Common.n_SOpenShop, nil)
end

BM_Shop.GetThemeList = function(self)
  -- function num : 0_22 , upvalues : _ENV
  local list = {}
  for k,v in pairs(((self._shops).cabin).themeMap) do
    (table.insert)(list, v)
  end
  return list
end

BM_Shop.GetFurnitureList = function(self)
  -- function num : 0_23 , upvalues : _ENV
  local list = {}
  for k,v in pairs(((self._shops).cabin).furnitureMap) do
    (table.insert)(list, v)
  end
  return list
end

BM_Shop.GetThemeInfoById = function(self, themeId)
  -- function num : 0_24
  return (((self._shops).cabin).themeMap)[themeId]
end

BM_Shop.GetFurnitures = function(self)
  -- function num : 0_25 , upvalues : _ENV
  local map = {}
  for k,v in pairs(((self._shops).cabin).furnitureMap) do
    map[(v.serverData).itemId] = v
  end
  return map
end

BM_Shop.GetFurnitureInfo = function(self, goodId)
  -- function num : 0_26
  return (((self._shops).cabin).furnitureMap)[goodId]
end

BM_Shop.JumpToShopBuyDiamonds = function(self)
  -- function num : 0_27 , upvalues : _ENV
  ((DialogManager.GetGroup)("SecondConfirm")):CloseAllDialog()
  if GlobalGameFSM:GetCurrentState() == "MainCity" then
    local baseSceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
    if baseSceneController then
      ((DialogManager.GetGroup)("Modal")):ReturnModalDialog()
      ;
      ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(4)
      baseSceneController:SetCameraAnimatorState(0)
      local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
      if protocol then
        protocol:Send()
      end
    end
  else
    do
      if GlobalGameFSM:GetCurrentState() == "CourtYard" then
        ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(4)
        ;
        ((NekoData.DataManager).DM_Game):SetFastMenuSignFromCourtyard("Shop")
        local csend = (LuaNetManager.CreateProtocol)("protocol.battle.centermaincity")
        csend:Send()
      end
    end
  end
end

BM_Shop.SetChecked = function(self, strTag, goodId)
  -- function num : 0_28 , upvalues : _ENV
  local value = false
  local str = (((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0")
  value = (((CS.UnityEngine).PlayerPrefs).GetInt)(str .. strTag .. tostring(goodId), (DataCommon.CabinGoodsStatus).Default) ~= (DataCommon.CabinGoodsStatus).Checked
  if value then
    ((NekoData.DataManager).DM_Shop):SetChecked(strTag, goodId)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_GoodsChecked, self, {strTag = strTag, goodId = goodId})
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_Shop.IsChargeAccumulationUnlock = function(self)
  -- function num : 0_29
  do return ((self._shops).chargeAccumulationData).isChargeAccumulationUnlock == true end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Shop.HandleChargeAccumulationData = function(self)
  -- function num : 0_30 , upvalues : _ENV
  ((NekoData.DataManager).DM_Shop):HandleChargeAccumulationData()
end

BM_Shop.GetChargAccumulationLevel = function(self)
  -- function num : 0_31
  return ((self._shops).chargeAccumulationData).currentLevel
end

BM_Shop.GetChargAccumulationCurrentLevelExp = function(self)
  -- function num : 0_32
  return ((self._shops).chargeAccumulationData).currentLevelExp
end

BM_Shop.GetChargAccumulationTotalScore = function(self)
  -- function num : 0_33
  return ((self._shops).chargeAccumulationData).totalScore
end

BM_Shop.HasGottenAccumulationReward = function(self, rewardID)
  -- function num : 0_34
  if (((self._shops).chargeAccumulationData).gottenIDTable)[rewardID] then
    return true
  end
  return false
end

BM_Shop.GetAccumulationRewardIDListByLevel = function(self, level)
  -- function num : 0_35
  return (((self._shops).chargeAccumulationData).levelRewardMap)[level]
end

BM_Shop.HasAccumulationRewardToGet = function(self)
  -- function num : 0_36 , upvalues : _ENV
  if self:IsChargeAccumulationUnlock() == false then
    return 
  end
  for k,v in pairs(((self._shops).chargeAccumulationData).waitToGetTable) do
    if v == true then
      return true
    end
  end
  return false
end

BM_Shop.GetMaxNeededShopPoints = function(self)
  -- function num : 0_37 , upvalues : CRechargeReward
  return (CRechargeReward:GetRecorder(#CRechargeReward:GetAllIds())).totalExperience
end

BM_Shop.GetShowBoxIcon = function(self)
  -- function num : 0_38
  return (self._shops).showBoxIcon
end

BM_Shop.GetHalloweenShopOpenState = function(self)
  -- function num : 0_39
  return (self._shops).halloweenshopState
end

BM_Shop.GetHalloweenRedPoint = function(self)
  -- function num : 0_40
  return (self._shops).halloweenRedPoint
end

BM_Shop.GetShopItemCanNotUseWithShopType = function(self, shopType)
  -- function num : 0_41
  return ((self._shops).shopItemCanNotUse)[shopType]
end

return BM_Shop

