local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local SUseBackInviteCode = LuaNetManager.GetProtocolDef("protocol.activity.susebackinvitecode")
local ReturnWelfareEnterCDKeyTabCell = class("ReturnWelfareEnterCDKeyTabCell", Dialog)
ReturnWelfareEnterCDKeyTabCell.AssetBundleName = "ui/layouts.welfare"
ReturnWelfareEnterCDKeyTabCell.AssetName = "ReturnWelfareCDkey"

function ReturnWelfareEnterCDKeyTabCell:Ctor(...)
  ReturnWelfareEnterCDKeyTabCell.super.Ctor(self, ...)
  self._leftTime = nil
  self._sendCGetBackGiftProtocol = false
end

function ReturnWelfareEnterCDKeyTabCell:OnCreate()
  self._backImg = self:GetChild("BackImage")
  self._title = self:GetChild("BackImage/Title")
  self._timeTxt = self:GetChild("BackImage/TimeTxt")
  self._sendBtn = self:GetChild("BackImage/Down/SendBtn")
  self._inputCodeField = self:GetChild("BackImage/Down/InputField")
  self._itemName = self:GetChild("AwardBack2/ItemName")
  self._itemImg = self:GetChild("AwardBack2/Item")
  self._getItemBtn = self:GetChild("AwardBack2/GetBtn")
  self._hasGottenItemBtn = self:GetChild("AwardBack2/DownBtn")
  self._tipsTxt = self:GetChild("BackImage/TimeText")
  self._titleName = self:GetChild("BackImage/TitleName")
  self._sendBtn:Subscribe_PointerClickEvent(self.OnSendBtnClicked, self)
  self._itemImg:Subscribe_PointerClickEvent(self.OnItemImgClicked, self)
  self._getItemBtn:Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshData, Common.n_OpenReturnEnterCDKey, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEnterCodeResult, Common.n_ReturnPlayerEnterInviteCodeResult, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSRefreshBackGift, Common.n_SRefreshBackGift, nil)
end

function ReturnWelfareEnterCDKeyTabCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._activityTask then
    GameTimer.RemoveTask(self._activityTask)
    self._activityTask = nil
  end
end

function ReturnWelfareEnterCDKeyTabCell:RefreshTabCell()
  self._tipsTxt:SetText(TextManager.GetText(701591))
  self._titleName:SetText(TextManager.GetText(701587))
  local protocol = NekoData.BehaviorManager.BM_ReturnWelfare:GetOpenBackGiftProtocolData()
  if protocol then
    self:OnRefreshData(protocol)
  end
end

function ReturnWelfareEnterCDKeyTabCell:OnRefreshData(notification)
  self._leftTime = notification.userInfo.leftTime
  self:RefreshTime()
  if self._activityTask then
    GameTimer.RemoveTask(self._activityTask)
    self._activityTask = nil
  end
  if not self._activityTask then
    self._activityTask = GameTimer.AddTask(0, 60, function()
      self:RefreshTime()
    end)
  end
  self._rewardStatus = notification.userInfo.goodInfo.goodStatus
  self._itemInfo = {
    giftPackId = notification.userInfo.goodInfo.goodId,
    itemId = notification.userInfo.goodInfo.itemId,
    itemNum = notification.userInfo.goodInfo.itemNum
  }
  local giftPackItem = Item.Create(notification.userInfo.goodInfo.goodId)
  self._itemName:SetText(giftPackItem:GetName())
  local imageRecord = giftPackItem:GetIcon()
  self._itemImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local GoodStatusType = {
    CannotBuy = 0,
    CanBuy = 1,
    BuyOver = 2
  }
  self._getItemBtn:SetInteractable(self._rewardStatus ~= GoodStatusType.BuyOver)
  self._getItemBtn:SetActive(self._rewardStatus ~= GoodStatusType.BuyOver)
  self._hasGottenItemBtn:SetInteractable(false)
  self._hasGottenItemBtn:SetActive(self._rewardStatus == GoodStatusType.BuyOver)
end

function ReturnWelfareEnterCDKeyTabCell:OnEnterCodeResult(notification)
  local GoodStatusType = {
    CannotBuy = 0,
    CanBuy = 1,
    BuyOver = 2
  }
  if notification.userInfo.result == SUseBackInviteCode.success then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100445)
    self._rewardStatus = GoodStatusType.CanBuy
    NekoData.BehaviorManager.BM_Activity:SetBackGiftRedPoint(true)
    LuaNotificationCenter.PostNotification(Common.n_RefreshReturnWelfareRedDot, nil, nil)
  end
end

function ReturnWelfareEnterCDKeyTabCell:OnSRefreshBackGift()
  self._getItemBtn:SetActive(false)
  self._hasGottenItemBtn:SetActive(true)
  local GoodStatusType = {
    CannotBuy = 0,
    CanBuy = 1,
    BuyOver = 2
  }
  self._rewardStatus = GoodStatusType.BuyOver
  self._sendCGetBackGiftProtocol = false
  NekoData.BehaviorManager.BM_Activity:SetBackGiftRedPoint(false)
  LuaNotificationCenter.PostNotification(Common.n_RefreshReturnWelfareRedDot, nil, nil)
end

function ReturnWelfareEnterCDKeyTabCell:RefreshTime()
  if self._leftTime then
    local time = self._leftTime / 1000
    local day = math.floor(time / 86400)
    local hour = math.floor((time - day * 24 * 60 * 60) / 3600)
    local min = math.floor((time - day * 24 * 60 * 60 - hour * 60 * 60) / 60)
    local sec = math.floor(time - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60)
    local str = TextManager.GetText(CStringRes:GetRecorder(1042).msgTextID)
    if 0 < day then
      local str1 = TextManager.GetText(CStringRes:GetRecorder(1043).msgTextID)
      self._timeTxt:SetText(str .. day .. str1)
    elseif 0 < hour then
      local str2 = TextManager.GetText(CStringRes:GetRecorder(1044).msgTextID)
      self._timeTxt:SetText(str .. hour .. str2)
    else
      local str3 = TextManager.GetText(CStringRes:GetRecorder(1045).msgTextID)
      self._timeTxt:SetText(str .. min .. str3)
    end
  end
end

function ReturnWelfareEnterCDKeyTabCell:OnSendBtnClicked()
  local code = self._inputCodeField:GetText()
  if code and code ~= "" then
    local protocol = LuaNetManager.CreateProtocol("protocol.activity.cusebackinvitecode")
    if protocol then
      protocol.invitationCode = code
      protocol:Send()
    end
  end
end

function ReturnWelfareEnterCDKeyTabCell:OnItemImgClicked()
  local dialog = DialogManager.CreateSingletonDialog("welfare.returnwelfare.giftpackageitemshowdialog")
  if dialog then
    dialog:SetData(self._itemInfo)
  end
end

function ReturnWelfareEnterCDKeyTabCell:OnGetBtnClicked()
  local GoodStatusType = {
    CannotBuy = 0,
    CanBuy = 1,
    BuyOver = 2
  }
  if self._rewardStatus == GoodStatusType.CanBuy then
    if not self._sendCGetBackGiftProtocol then
      local protocol = LuaNetManager.CreateProtocol("protocol.activity.cgetbackgift")
      if protocol then
        self._sendCGetBackGiftProtocol = true
        protocol.goodId = self._itemInfo.giftPackId
        protocol:Send()
      end
    end
  elseif self._rewardStatus == GoodStatusType.CannotBuy then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100431)
  end
end

return ReturnWelfareEnterCDKeyTabCell
