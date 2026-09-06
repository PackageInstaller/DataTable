local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CRechargeReward = BeanManager.GetTableByName("recharge.crechargerewards")
local BM_Shop = class("BM_Shop")

function BM_Shop:Ctor()
  self._shops = NekoData.Data.shops
end

function BM_Shop:GetShopWithShopId(id)
  for _, shop in ipairs(self._shops.shop) do
    if shop.id == id then
      return shop
    end
  end
end

function BM_Shop:GetRechargeWithTypeId(id)
  for _, r in ipairs(self._shops.recharge) do
    if r.typeId == id then
      return r
    end
  end
end

function BM_Shop:GetShopGoodInfoByID(id)
  for shopid, goods in pairs(self._shops.shop) do
    if shopid == id then
      return goods
    end
  end
end

function BM_Shop:GetShopIDList()
  local list = {}
  for _, shopinfo in pairs(self._shops.shopinfo) do
    if shopinfo.openType == 0 then
      table.insert(list, shopinfo.shopId)
    elseif shopinfo.openTime == 0 then
      table.insert(list, shopinfo.shopId)
    end
  end
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.GrowGift) and not NekoData.BehaviorManager.BM_Welfare:IsBoughtGrowGift() then
    table.insert(list, DataCommon.GrowGiftShopId)
  end
  if 0 < NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID):GetCurrentActId() then
    table.insert(list, 23)
  end
  return list
end

function BM_Shop:GetHasOpenTimeShopIDList()
  local list = {}
  for _, shopinfo in pairs(self._shops.shopinfo) do
    if shopinfo.openType == 0 then
    elseif shopinfo.openTime ~= 0 then
      table.insert(list, shopinfo)
    end
  end
  return list
end

function BM_Shop:GetHasCloseTimeShopIDList()
  local list = {}
  for _, shopinfo in pairs(self._shops.shopinfo) do
    if shopinfo.openType == 0 then
    elseif shopinfo.closeTime ~= 0 and shopinfo.openType == 2 then
      table.insert(list, shopinfo)
    end
  end
  return list
end

function BM_Shop:GetHasRefreshTimeShopIDList()
  local list = {}
  for _, shopinfo in pairs(self._shops.shopinfo) do
    if shopinfo.openType == 0 then
    elseif shopinfo.closeTime ~= 0 and shopinfo.openType == 1 then
      table.insert(list, shopinfo)
    end
  end
  return list
end

function BM_Shop:GetShopInfoByID(shopid)
  for _, shopinfo in pairs(self._shops.shopinfo) do
    if shopinfo.shopId == shopid then
      return shopinfo
    end
  end
end

function BM_Shop:GetMonthCardRemainTime(key)
  if self._shops.monthCardInfo[key] then
    return self._shops.monthCardInfo[key].remainTime
  end
  return nil
end

function BM_Shop:GetMonthCardEndShowTime(key)
  if self._shops.monthCardInfo[key] then
    return self._shops.monthCardInfo[key].endTimeStr
  end
  return nil
end

function BM_Shop:GetClientOpenShopID()
  local flag = self._shops.clientflag.openshopid
  if flag and type(flag) == "string" then
    local ids = {}
    for id in string.gmatch(flag, "%d+") do
      local isopen = NekoData.BehaviorManager.BM_Shop:GetShopInfoByID(tonumber(id))
      if isopen then
        return tonumber(id)
      end
    end
    return 0
  end
  return flag
end

function BM_Shop:GetShopRefreshCointLeftChange()
  return self._shops.refreshcoint.leftchance
end

function BM_Shop:GetShopRefreshCointCurrencyType()
  return self._shops.refreshcoint.currencytype
end

function BM_Shop:GetShopRefreshCointNextTimeCost()
  return self._shops.refreshcoint.nexttimecost
end

local shop_discount = {
  11401,
  11400,
  11399,
  11398,
  11397,
  11396,
  11395,
  11394,
  11393
}

function BM_Shop:GetDiscountAsset(discount)
  if not shop_discount[discount] then
    return nil
  end
  local r = CImagePathTable:GetRecorder(shop_discount[discount])
  if not r then
    return nil
  end
  return r
end

function BM_Shop:GetRemainTimeStr(endTime)
  local str = ""
  if endTime and 0 < endTime then
    local time = endTime // 1000
    local year = time // 31536000
    local day = time // 86400
    local hour = time // 3600
    local min = time // 60
    local sec = time % 60
    if 0 < year then
      str = TextManager.GetText(CStringRes:GetRecorder(1170).msgTextID)
      str = string.gsub(str, "%$parameter1%$", year)
    elseif 0 < day then
      str = TextManager.GetText(CStringRes:GetRecorder(1171).msgTextID)
      str = string.gsub(str, "%$parameter1%$", day)
    elseif 0 < hour then
      str = TextManager.GetText(CStringRes:GetRecorder(1172).msgTextID)
      str = string.gsub(str, "%$parameter1%$", hour)
    elseif 0 < min then
      str = TextManager.GetText(CStringRes:GetRecorder(1173).msgTextID)
      str = string.gsub(str, "%$parameter1%$", min)
    elseif 0 < sec then
      str = TextManager.GetText(CStringRes:GetRecorder(1173).msgTextID)
      str = string.gsub(str, "%$parameter1%$", 0)
    end
  end
  return str
end

function BM_Shop:GetRemainTimeStrForMonthCard(endTime)
  local str = ""
  if endTime and 0 < endTime then
    local time = endTime // 1000
    local day = time // 86400
    local hour = (time - day * 86400) // 3600
    str = TextManager.GetText(CStringRes:GetRecorder(1528).msgTextID)
    str = string.gsub(str, "%$parameter1%$", day)
    str = string.gsub(str, "%$parameter2%$", hour)
  end
  return str
end

function BM_Shop:GetMonthCardRemainTimeStr(endTime)
  local str = ""
  if endTime and 0 < endTime then
    local time = endTime // 1000
    local year = time // 31536000
    local day = time // 86400
    local hour = time // 3600
    local min = time // 60
    local sec = time % 60
    if 0 < year then
      str = TextManager.GetText(CStringRes:GetRecorder(1502).msgTextID)
      str = string.gsub(str, "%$parameter1%$", year)
    elseif 0 < day then
      str = TextManager.GetText(CStringRes:GetRecorder(1503).msgTextID)
      str = string.gsub(str, "%$parameter1%$", day)
    elseif 0 < hour then
      str = TextManager.GetText(CStringRes:GetRecorder(1504).msgTextID)
      str = string.gsub(str, "%$parameter1%$", hour)
    elseif 0 < min then
      str = TextManager.GetText(CStringRes:GetRecorder(1505).msgTextID)
      str = string.gsub(str, "%$parameter1%$", min)
    elseif 0 < sec then
      str = TextManager.GetText(CStringRes:GetRecorder(1505).msgTextID)
      str = string.gsub(str, "%$parameter1%$", 0)
    end
  end
  return str
end

function BM_Shop:GetSpriteEvidenceRemainTimeStr(endTime)
  local str = ""
  if endTime and 0 < endTime then
    local time = endTime // 1000
    local year = time // 31536000
    local day = time // 86400
    local hour = time // 3600
    local min = time // 60
    local sec = time % 60
    if 0 < year then
      str = TextManager.GetText(CStringRes:GetRecorder(2091).msgTextID)
      str = string.gsub(str, "%$parameter1%$", year)
    elseif 0 < day then
      str = TextManager.GetText(CStringRes:GetRecorder(2092).msgTextID)
      str = string.gsub(str, "%$parameter1%$", day)
    elseif 0 < hour then
      str = TextManager.GetText(CStringRes:GetRecorder(2093).msgTextID)
      str = string.gsub(str, "%$parameter1%$", hour)
    elseif 0 < min then
      str = TextManager.GetText(CStringRes:GetRecorder(2094).msgTextID)
      str = string.gsub(str, "%$parameter1%$", min)
    elseif 0 < sec then
      str = TextManager.GetText(CStringRes:GetRecorder(2094).msgTextID)
      str = string.gsub(str, "%$parameter1%$", 0)
    end
  end
  return str
end

function BM_Shop:TryOpenShopWithID(shopID)
  local dialog = DialogManager.GetDialog("shop.shopmaindialog")
  if dialog then
    dialog:OnGroupBtnClicked(shopID)
  else
    dialog = DialogManager.GetDialog("base.basemainui")
    if dialog then
      LuaNotificationCenter.AddObserver(self, self._OpenShopCallBack, Common.n_SOpenShop, nil)
      self._toOpenShopID = shopID
      dialog:OnShopClick()
    else
      NekoData.DataManager.DM_Shop:ClientSetOpenShopID(shopID)
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
      if protocol then
        protocol:Send()
      end
    end
  end
end

function BM_Shop:_OpenShopCallBack(notification)
  local dialog = notification.userInfo
  if dialog and self._toOpenShopID then
    dialog:OnGroupBtnClicked(self._toOpenShopID)
    self._toOpenShopID = nil
  else
    LogError("BM_Shop", "Cannot find shopmaindialog.")
  end
  LuaNotificationCenter.RemoveObserver(self, Common.n_SOpenShop, nil)
end

function BM_Shop:GetThemeList()
  local list = {}
  for k, v in pairs(self._shops.cabin.themeMap) do
    table.insert(list, v)
  end
  return list
end

function BM_Shop:GetFurnitureList()
  local list = {}
  for k, v in pairs(self._shops.cabin.furnitureMap) do
    table.insert(list, v)
  end
  return list
end

function BM_Shop:GetThemeInfoById(themeId)
  return self._shops.cabin.themeMap[themeId]
end

function BM_Shop:GetFurnitures()
  local map = {}
  for k, v in pairs(self._shops.cabin.furnitureMap) do
    map[v.serverData.itemId] = v
  end
  return map
end

function BM_Shop:GetFurnitureInfo(goodId)
  return self._shops.cabin.furnitureMap[goodId]
end

function BM_Shop:JumpToShopBuyDiamonds()
  DialogManager.GetGroup("SecondConfirm"):CloseAllDialog()
  if GlobalGameFSM:GetCurrentState() == "MainCity" then
    local baseSceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
    if baseSceneController then
      DialogManager.GetGroup("Modal"):ReturnModalDialog()
      NekoData.DataManager.DM_Shop:ClientSetOpenShopID(4)
      baseSceneController:SetCameraAnimatorState(0)
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
      if protocol then
        protocol:Send()
      end
    end
  elseif GlobalGameFSM:GetCurrentState() == "CourtYard" then
    NekoData.DataManager.DM_Shop:ClientSetOpenShopID(4)
    NekoData.DataManager.DM_Game:SetFastMenuSignFromCourtyard("Shop")
    local csend = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
    csend:Send()
  end
end

function BM_Shop:SetChecked(strTag, goodId)
  local value = false
  local str = CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0")
  value = CS.UnityEngine.PlayerPrefs.GetInt(str .. strTag .. tostring(goodId), DataCommon.CabinGoodsStatus.Default) ~= DataCommon.CabinGoodsStatus.Checked
  if value then
    NekoData.DataManager.DM_Shop:SetChecked(strTag, goodId)
    LuaNotificationCenter.PostNotification(Common.n_GoodsChecked, self, {strTag = strTag, goodId = goodId})
  end
end

function BM_Shop:IsChargeAccumulationUnlock()
  return self._shops.chargeAccumulationData.isChargeAccumulationUnlock == true
end

function BM_Shop:HandleChargeAccumulationData()
  NekoData.DataManager.DM_Shop:HandleChargeAccumulationData()
end

function BM_Shop:GetChargAccumulationLevel()
  return self._shops.chargeAccumulationData.currentLevel
end

function BM_Shop:GetChargAccumulationCurrentLevelExp()
  return self._shops.chargeAccumulationData.currentLevelExp
end

function BM_Shop:GetChargAccumulationTotalScore()
  return self._shops.chargeAccumulationData.totalScore
end

function BM_Shop:HasGottenAccumulationReward(rewardID)
  if self._shops.chargeAccumulationData.gottenIDTable[rewardID] then
    return true
  end
  return false
end

function BM_Shop:GetAccumulationRewardIDListByLevel(level)
  return self._shops.chargeAccumulationData.levelRewardMap[level]
end

function BM_Shop:HasAccumulationRewardToGet()
  if self:IsChargeAccumulationUnlock() == false then
    return
  end
  for k, v in pairs(self._shops.chargeAccumulationData.waitToGetTable) do
    if v == true then
      return true
    end
  end
  return false
end

function BM_Shop:GetMaxNeededShopPoints()
  return CRechargeReward:GetRecorder(#CRechargeReward:GetAllIds()).totalExperience
end

function BM_Shop:GetShowBoxIcon()
  return self._shops.showBoxIcon
end

function BM_Shop:GetHalloweenShopOpenState()
  return self._shops.halloweenshopState
end

function BM_Shop:GetHalloweenRedPoint()
  return self._shops.halloweenRedPoint
end

function BM_Shop:GetShopItemCanNotUseWithShopType(shopType)
  return self._shops.shopItemCanNotUse[shopType]
end

return BM_Shop
