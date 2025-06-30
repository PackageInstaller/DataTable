-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/returnwelfare/returnwelfaregiftbagtabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CReturnGit = (BeanManager.GetTableByName)("welfare.creturngit")
local CMessageTip = (BeanManager.GetTableByName)("message.cmessagetip")
local Item = require("logic.manager.experimental.types.item")
local ReturnWelfareGiftBagTabCell = class("ReturnWelfareGiftBagTabCell", Dialog)
ReturnWelfareGiftBagTabCell.AssetBundleName = "ui/layouts.welfare"
ReturnWelfareGiftBagTabCell.AssetName = "ReturnWelfareRevived"
local GoodStatusType = {CannotBuy = 0, CanBuy = 1, BuyOver = 2}
ReturnWelfareGiftBagTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ReturnWelfareGiftBagTabCell
  ((ReturnWelfareGiftBagTabCell.super).Ctor)(self, ...)
  self._leftTime = nil
  self._itemInfo = {}
  self._sendProtocol = false
end

ReturnWelfareGiftBagTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._awardShow = {}
  for i = 1, 2 do
    do
      -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

      (self._awardShow)[i] = {}
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._awardShow)[i]).itemImg = self:GetChild("BackImage/AwardBack" .. i .. "/Item")
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._awardShow)[i]).diamondBtn = self:GetChild("BackImage/AwardBack" .. i .. "/DiamondBtn")
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._awardShow)[i]).diamondPrice = self:GetChild("BackImage/AwardBack" .. i .. "/DiamondBtn/num")
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._awardShow)[i]).rmbBtn = self:GetChild("BackImage/AwardBack" .. i .. "/RMBBtn")
      -- DECOMPILER ERROR at PC53: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._awardShow)[i]).rmbPrice = self:GetChild("BackImage/AwardBack" .. i .. "/RMBBtn/_Text")
      ;
      (((self._awardShow)[i]).itemImg):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnItemImgClicked(i)
  end
, self)
      ;
      (((self._awardShow)[i]).diamondBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self, i
    self:OnDiamondBtnClicked(i)
  end
, self)
      ;
      (((self._awardShow)[i]).rmbBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_2 , upvalues : self, i
    self:OnRMBBtnClicked(i)
  end
, self)
    end
  end
  self._timeNum = self:GetChild("BackImage/TimeNum")
  -- DECOMPILER ERROR at PC86: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._awardShow)[1]).progressPanel = self:GetChild("ProgressBack")
  -- DECOMPILER ERROR at PC92: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._awardShow)[1]).progress = self:GetChild("ProgressBack/Progress")
  -- DECOMPILER ERROR at PC98: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._awardShow)[1]).progressNum = self:GetChild("ProgressBack/Num/Num")
  -- DECOMPILER ERROR at PC104: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._awardShow)[1]).showTxt = self:GetChild("ProgressBack/Text")
  local str = (TextManager.GetText)(701722)
  ;
  (((self._awardShow)[1]).showTxt):SetText(str)
  -- DECOMPILER ERROR at PC120: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._awardShow)[2]).progressPanel = self:GetChild("ProgressBack (1)")
  -- DECOMPILER ERROR at PC126: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._awardShow)[2]).progress = self:GetChild("ProgressBack (1)/Progress")
  -- DECOMPILER ERROR at PC132: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._awardShow)[2]).progressNum = self:GetChild("ProgressBack (1)/Num/Num")
  -- DECOMPILER ERROR at PC138: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._awardShow)[2]).showTxt = self:GetChild("ProgressBack (1)/Text")
  str = (TextManager.GetText)(701722)
  ;
  (((self._awardShow)[2]).showTxt):SetText(str)
  self._manualTips = self:GetChild("BackImage/Tips")
  ;
  (self._manualTips):Subscribe_PointerClickEvent(self.OnManualTipsClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshData, Common.n_OpenReturnWelfarePack, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBuyResult, Common.n_BuyReturnGiftResult, nil)
end

ReturnWelfareGiftBagTabCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._activityTask then
    (GameTimer.RemoveTask)(self._activityTask)
    self._activityTask = nil
  end
end

ReturnWelfareGiftBagTabCell.RefreshTabCell = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local protocol = ((NekoData.BehaviorManager).BM_ReturnWelfare):GetOpenBackPackProtocolData()
  if protocol then
    self:OnRefreshData(protocol)
  end
end

ReturnWelfareGiftBagTabCell.OnRefreshData = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV, GoodStatusType, Item
  self._leftTime = (notification.userInfo).leftTime
  self:RefreshTime()
  if self._activityTask then
    (GameTimer.RemoveTask)(self._activityTask)
    self._activityTask = nil
  end
  if not self._activityTask then
    self._activityTask = (GameTimer.AddTask)(0, 60, function()
    -- function num : 0_4_0 , upvalues : self
    self:RefreshTime()
  end
)
  end
  self._itemInfo = {}
  local currentSpirit = (notification.userInfo).allSpirt
  self._rmbGitCorrespondingDiamondGit = {}
  local index = 1
  for _,g in ipairs((notification.userInfo).goodInfo) do
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R9 in 'UnsetPending'

    if g.correspondGift ~= 0 then
      (self._rmbGitCorrespondingDiamondGit)[g.goodId] = {diamondGit = g.correspondGift, index = index, spirtLimit = ((notification.userInfo).spirtLimit)[index]}
      index = index + 1
    end
  end
  self._gitStatus = {}
  local price = {}
  for i,g in ipairs((notification.userInfo).goodInfo) do
    -- DECOMPILER ERROR at PC63: Confused about usage of register: R10 in 'UnsetPending'

    (self._gitStatus)[g.goodId] = g.goodStatus
    price[g.goodId] = g.price
  end
  for _,g in ipairs((notification.userInfo).goodInfo) do
    if (self._rmbGitCorrespondingDiamondGit)[g.goodId] then
      local i = ((self._rmbGitCorrespondingDiamondGit)[g.goodId]).index
      local temp = {giftPackId = g.goodId, itemId = g.itemId, itemNum = g.itemNum, chargeId = g.chargeId}
      -- DECOMPILER ERROR at PC93: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (self._itemInfo)[i] = temp
      ;
      (((self._awardShow)[i]).rmbPrice):SetText(g.price)
      ;
      (((self._awardShow)[i]).diamondPrice):SetText(price[((self._rmbGitCorrespondingDiamondGit)[g.goodId]).diamondGit])
      LogInfoFormat("ReturnWelfareGiftBagTabCell", "diamond status %s rmb status %s", (self._gitStatus)[((self._rmbGitCorrespondingDiamondGit)[g.goodId]).diamondGit], g.goodStatus)
      if (self._gitStatus)[((self._rmbGitCorrespondingDiamondGit)[g.goodId]).diamondGit] == GoodStatusType.BuyOver then
        (((self._awardShow)[i]).diamondBtn):SetActive(false)
      end
      if g.goodStatus == GoodStatusType.CannotBuy then
        (((self._awardShow)[i]).rmbBtn):SetInteractable(false)
      else
        if g.goodStatus == GoodStatusType.CanBuy then
          (((self._awardShow)[i]).rmbBtn):SetInteractable(true)
        else
          if g.goodStatus == GoodStatusType.BuyOver then
            (((self._awardShow)[i]).rmbBtn):SetActive(false)
          end
        end
      end
      if (self._gitStatus)[((self._rmbGitCorrespondingDiamondGit)[g.goodId]).diamondGit] == GoodStatusType.BuyOver or g.goodStatus == GoodStatusType.BuyOver then
        (((self._awardShow)[i]).progressPanel):SetActive(false)
      else
        ;
        (((self._awardShow)[i]).progressPanel):SetActive(true)
      end
      local giftPackItem = (Item.Create)(g.goodId)
      local imageRecord = giftPackItem:GetIcon()
      ;
      (((self._awardShow)[i]).itemImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      local spirtLimit = ((self._rmbGitCorrespondingDiamondGit)[g.goodId]).spirtLimit
      local str = (TextManager.GetText)(701724)
      str = (string.gsub)(str, "%$parameter1%$", currentSpirit)
      str = (string.gsub)(str, "%$parameter2%$", spirtLimit)
      ;
      (((self._awardShow)[i]).progressNum):SetText(str)
      ;
      (((self._awardShow)[i]).progress):SetFillAmount(currentSpirit / spirtLimit)
    end
  end
end

ReturnWelfareGiftBagTabCell.OnBuyResult = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  local ResultType = {Failed = 0, Success = 1}
  local protocolGiftId = (notification.userInfo).giftID
  if (notification.userInfo).result == ResultType.Success then
    for i,v in ipairs(self._itemInfo) do
      if v.giftPackId == protocolGiftId or ((self._rmbGitCorrespondingDiamondGit)[v.giftPackId]).diamondGit == protocolGiftId then
        (((self._awardShow)[i]).diamondBtn):SetActive(false)
        ;
        (((self._awardShow)[i]).rmbBtn):SetActive(false)
        ;
        (((self._awardShow)[i]).progressPanel):SetActive(false)
      end
    end
  end
  do
    self._sendProtocol = false
  end
end

ReturnWelfareGiftBagTabCell.RefreshTime = function(self)
  -- function num : 0_6 , upvalues : _ENV, CStringRes
  if self._leftTime then
    local time = self._leftTime / 1000
    local day = (math.floor)(time / 86400)
    local hour = (math.floor)((time - day * 24 * 60 * 60) / 3600)
    local min = (math.floor)((time - day * 24 * 60 * 60 - hour * 60 * 60) / 60)
    local sec = (math.floor)(time - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60)
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1042)).msgTextID)
    if day > 0 then
      local str1 = (TextManager.GetText)((CStringRes:GetRecorder(1043)).msgTextID)
      ;
      (self._timeNum):SetText(str .. day .. str1)
    else
      do
        if hour > 0 then
          local str2 = (TextManager.GetText)((CStringRes:GetRecorder(1044)).msgTextID)
          ;
          (self._timeNum):SetText(str .. hour .. str2)
        else
          do
            local str3 = (TextManager.GetText)((CStringRes:GetRecorder(1045)).msgTextID)
            ;
            (self._timeNum):SetText(str .. min .. str3)
          end
        end
      end
    end
  end
end

ReturnWelfareGiftBagTabCell.OnItemImgClicked = function(self, i)
  -- function num : 0_7 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("welfare.returnwelfare.giftpackageitemshowdialog")
  if dialog then
    dialog:SetData((self._itemInfo)[i])
  end
end

ReturnWelfareGiftBagTabCell.OnDiamondBtnClicked = function(self, i)
  -- function num : 0_8 , upvalues : GoodStatusType, CMessageTip, _ENV
  local giftPackId = ((self._rmbGitCorrespondingDiamondGit)[((self._itemInfo)[i]).giftPackId]).diamondGit
  if (self._gitStatus)[giftPackId] == GoodStatusType.CannotBuy then
    local msgRecord = CMessageTip:GetRecorder(100430)
    local str = (TextManager.GetText)(msgRecord.msgTextID)
    str = (string.gsub)(str, "%$parameter1%$", ((self._rmbGitCorrespondingDiamondGit)[((self._itemInfo)[i]).giftPackId]).spirtLimit)
    ;
    ((NekoData.BehaviorManager).BM_Message):AddMessageTip(str)
  else
    do
      if (self._gitStatus)[giftPackId] == GoodStatusType.CanBuy then
        local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cbuyreturngift")
        if protocol and not self._sendProtocol then
          self._sendProtocol = true
          protocol.giftID = giftPackId
          protocol.giftType = protocol.RETURN
          protocol:Send()
        end
      end
    end
  end
end

ReturnWelfareGiftBagTabCell.OnRMBBtnClicked = function(self, i)
  -- function num : 0_9 , upvalues : _ENV
  local cmd = (LuaNetManager.CreateProtocol)("protocol.charge.cbuydiamond")
  cmd.goodId = ((self._itemInfo)[i]).chargeId
  cmd:Send()
  if SdkManager.IsOverseas then
    local d = {goodId = tostring(((self._itemInfo)[i]).goodId), cashPrice = (SdkManager.GetPrice)(((self._itemInfo)[i]).chargeNum), diamondPrice = "0"}
    ;
    (SdkManager.Report)("purchase_click", d)
    ;
    (SdkManager.Report)("purchase_click_GP_ONCE", d)
    ;
    (SdkManager.Report)((string.format)("purchase_click_%s", d.goodId), d)
  end
end

ReturnWelfareGiftBagTabCell.OnManualTipsClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("welfare.returnwelfare.returnruletipsdialog")
  if dialog then
    dialog:Init((dialog.TipsType).GiftPack)
  end
end

return ReturnWelfareGiftBagTabCell

