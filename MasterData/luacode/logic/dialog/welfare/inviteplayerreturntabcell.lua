local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CTotalLoginActivity = BeanManager.GetTableByName("welfare.ctotalloginactivity")
local CInvitationGit = BeanManager.GetTableByName("welfare.cinvitationgit")
local Item = require("logic.manager.experimental.types.item")
local InvitePlayerReturnTabCell = class("InvitePlayerReturnTabCell", Dialog)
InvitePlayerReturnTabCell.AssetBundleName = "ui/layouts.welfare"
InvitePlayerReturnTabCell.AssetName = "ReturnWelfareInvite"
local GoodStatusType = {
  CannotBuy = 0,
  CanBuy = 1,
  BuyOver = 2
}

function InvitePlayerReturnTabCell:Ctor(...)
  InvitePlayerReturnTabCell.super.Ctor(self, ...)
  self._leftTime = nil
  self._shareCode = nil
  self._itemInfo = {}
  self._sendProtocol = false
end

function InvitePlayerReturnTabCell:OnCreate()
  self._itemName = {}
  self._itemImg = {}
  self._itemDiamondBtn = {}
  self._itemDiamondPrice = {}
  self._itemRMBBtn = {}
  self._itemRMBPrice = {}
  self._invitePlayerProgress = {}
  for i = 1, 2 do
    self._itemName[i] = self:GetChild("BackImage/AwardBack" .. i .. "/ItemName")
    self._itemImg[i] = self:GetChild("BackImage/AwardBack" .. i .. "/Item")
    self._itemDiamondBtn[i] = self:GetChild("BackImage/AwardBack" .. i .. "/DiamondBtn")
    self._itemDiamondPrice[i] = self:GetChild("BackImage/AwardBack" .. i .. "/DiamondBtn/num")
    self._itemRMBBtn[i] = self:GetChild("BackImage/AwardBack" .. i .. "/RMBBtn")
    self._itemRMBPrice[i] = self:GetChild("BackImage/AwardBack" .. i .. "/RMBBtn/_Text")
    self._itemImg[i]:Subscribe_PointerClickEvent(function()
      self:OnItemImgClicked(i)
    end, self)
    self._itemDiamondBtn[i]:Subscribe_PointerClickEvent(function()
      self:OnItemDiamondClicked(i)
    end, self)
    self._itemRMBBtn[i]:Subscribe_PointerClickEvent(function()
      self:OnItemRMBClicked(i)
    end, self)
    self._invitePlayerProgress[i] = {}
  end
  self._invitePlayerProgress[1].progressPanel = self:GetChild("ProgressBack")
  self._invitePlayerProgress[1].progress = self:GetChild("ProgressBack/Progress")
  self._invitePlayerProgress[1].num = self:GetChild("ProgressBack/Num/Num")
  self._invitePlayerProgress[1].showTxt = self:GetChild("ProgressBack/Text")
  self._invitePlayerProgress[2].progressPanel = self:GetChild("ProgressBack (1)")
  self._invitePlayerProgress[2].progress = self:GetChild("ProgressBack (1)/Progress")
  self._invitePlayerProgress[2].num = self:GetChild("ProgressBack (1)/Num/Num")
  self._invitePlayerProgress[2].showTxt = self:GetChild("ProgressBack (1)/Text")
  self._inviteCodeTxt = self:GetChild("BackImage/InviteNum")
  self._invitePlayerNumTxt = self:GetChild("BackImage/InviteManNum")
  self._shareBtn = self:GetChild("BackImage/TnviteBtn")
  self._lastTimeTxt = self:GetChild("BackImage/Txt")
  self._manualTips = self:GetChild("BackImage/Tips")
  self._shareBtn:Subscribe_PointerClickEvent(self.OnShareBtnClick, self)
  self._manualTips:Subscribe_PointerClickEvent(self.OnManualTipsClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshData, Common.n_OpenInviteReturnPlayer, nil)
  LuaNotificationCenter.AddObserver(self, self.OnBuyResult, Common.n_BuyReturnGiftResult, nil)
end

function InvitePlayerReturnTabCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._activityTask then
    GameTimer.RemoveTask(self._activityTask)
    self._activityTask = nil
  end
end

function InvitePlayerReturnTabCell:RefreshTabCell()
  local protocol = NekoData.BehaviorManager.BM_ReturnWelfare:GetOpenBackInviteProtocolData()
  if protocol then
    self:OnRefreshData(protocol)
  end
end

function InvitePlayerReturnTabCell:OnRefreshData(notification)
  self._shareCode = notification.userInfo.invitationCode
  self._inviteCodeTxt:SetText(self._shareCode)
  local invitedPlayerNum = notification.userInfo.inviteeNum
  self._invitePlayerNumTxt:SetText(invitedPlayerNum)
  self._leftTime = NekoData.BehaviorManager.BM_Activity:GetOtherActivityLeftTimeWithActivityId(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.invitePlayerReturn)
  self:RefreshTime()
  if notification.userInfo.returnTime > 0 then
    local str = TextManager.GetText(701723)
    self._invitePlayerProgress[1].showTxt:SetText(str)
    str = TextManager.GetText(701723)
    self._invitePlayerProgress[2].showTxt:SetText(str)
  elseif 0 < notification.userInfo.discountTime then
    local str = TextManager.GetText(701732)
    local time = notification.userInfo.discountTime / 1000
    local day = math.floor(time / 86400)
    str = string.gsub(str, "%$parameter1%$", tostring(day))
    self._invitePlayerProgress[1].showTxt:SetText(str)
    str = TextManager.GetText(701732)
    str = string.gsub(str, "%$parameter1%$", tostring(day))
    self._invitePlayerProgress[2].showTxt:SetText(str)
  else
    local str = TextManager.GetText(701733)
    local time = self._leftTime / 1000
    local day = math.floor(time / 86400)
    str = string.gsub(str, "%$parameter1%$", tostring(day))
    self._invitePlayerProgress[1].showTxt:SetText(str)
    str = TextManager.GetText(701733)
    str = string.gsub(str, "%$parameter1%$", tostring(day))
    self._invitePlayerProgress[2].showTxt:SetText(str)
  end
  if self._activityTask then
    GameTimer.RemoveTask(self._activityTask)
    self._activityTask = nil
  end
  if not self._activityTask then
    self._activityTask = GameTimer.AddTask(0, 60, function()
      self:RefreshTime()
    end)
  end
  self._itemInfo = {}
  self._rmbGitCorrespondingDiamondGit = {}
  local index = 1
  for _, g in ipairs(notification.userInfo.goodInfo) do
    if g.correspondGift ~= 0 then
      self._rmbGitCorrespondingDiamondGit[g.goodId] = {
        diamondGit = g.correspondGift,
        index = index
      }
      index = index + 1
    end
  end
  self._gitStatus = {}
  local price = {}
  for i, g in ipairs(notification.userInfo.goodInfo) do
    self._gitStatus[g.goodId] = g.goodStatus
    price[g.goodId] = g.price
  end
  for _, g in ipairs(notification.userInfo.goodInfo) do
    if self._rmbGitCorrespondingDiamondGit[g.goodId] then
      local i = self._rmbGitCorrespondingDiamondGit[g.goodId].index
      local temp = {
        giftPackId = g.goodId,
        itemId = g.itemId,
        itemNum = g.itemNum,
        chargeId = g.chargeId
      }
      self._itemInfo[i] = temp
      self._itemRMBPrice[i]:SetText(g.price)
      self._itemDiamondPrice[i]:SetText(price[self._rmbGitCorrespondingDiamondGit[g.goodId].diamondGit])
      LogInfoFormat("InvitePlayerReturnTabCell", "packgoodid %s diamond status %s rmb status %s", g.goodId, self._gitStatus[self._rmbGitCorrespondingDiamondGit[g.goodId].diamondGit], g.goodStatus)
      if self._gitStatus[self._rmbGitCorrespondingDiamondGit[g.goodId].diamondGit] == GoodStatusType.BuyOver then
        self._itemDiamondBtn[i]:SetActive(false)
      end
      if g.goodStatus == GoodStatusType.CannotBuy then
        self._itemRMBBtn[i]:SetInteractable(false)
      elseif g.goodStatus == GoodStatusType.CanBuy then
        self._itemRMBBtn[i]:SetInteractable(true)
      elseif g.goodStatus == GoodStatusType.BuyOver then
        self._itemRMBBtn[i]:SetActive(false)
      end
      if self._gitStatus[self._rmbGitCorrespondingDiamondGit[g.goodId].diamondGit] == GoodStatusType.BuyOver or g.goodStatus == GoodStatusType.BuyOver then
        self._invitePlayerProgress[i].progressPanel:SetActive(false)
      else
        self._invitePlayerProgress[i].progressPanel:SetActive(true)
      end
      local giftPackItem = Item.Create(g.goodId)
      self._itemName[i]:SetText(giftPackItem:GetName())
      local imageRecord = giftPackItem:GetIcon()
      self._itemImg[i]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      local inviteeLimit = notification.userInfo.inviteeLimit[i]
      local str = TextManager.GetText(701725)
      str = string.gsub(str, "%$parameter1%$", invitedPlayerNum)
      str = string.gsub(str, "%$parameter2%$", inviteeLimit)
      self._invitePlayerProgress[i].num:SetText(str)
      self._invitePlayerProgress[i].progress:SetFillAmount(invitedPlayerNum / inviteeLimit)
    end
  end
end

function InvitePlayerReturnTabCell:OnBuyResult(notification)
  local ResultType = {Failed = 0, Success = 1}
  local protocolGiftId = notification.userInfo.giftID
  LogInfoFormat("InvitePlayerReturnTabCell", "OnBuyResult notification.userInfo.result %s notification.userInfo.giftID %s", notification.userInfo.result, protocolGiftId)
  if notification.userInfo.result == ResultType.Success then
    for i, v in ipairs(self._itemInfo) do
      if v.giftPackId == protocolGiftId or self._rmbGitCorrespondingDiamondGit[v.giftPackId].diamondGit == protocolGiftId then
        self._itemDiamondBtn[i]:SetActive(false)
        self._itemRMBBtn[i]:SetActive(false)
        self._invitePlayerProgress[i].progressPanel:SetActive(false)
      end
    end
  end
  self._sendProtocol = false
end

function InvitePlayerReturnTabCell:RefreshTime()
  if self._leftTime then
    local time = self._leftTime / 1000
    local day = math.floor(time / 86400)
    local hour = math.floor((time - day * 24 * 60 * 60) / 3600)
    local min = math.floor((time - day * 24 * 60 * 60 - hour * 60 * 60) / 60)
    local sec = math.floor(time - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60)
    local str = TextManager.GetText(701592)
    str = string.gsub(str, "%$parameter1%$", tostring(day))
    self._lastTimeTxt:SetText(str)
  end
end

function InvitePlayerReturnTabCell:OnItemImgClicked(i)
  local dialog = DialogManager.CreateSingletonDialog("welfare.returnwelfare.giftpackageitemshowdialog")
  if dialog then
    dialog:SetData(self._itemInfo[i])
  end
end

function InvitePlayerReturnTabCell:OnItemDiamondClicked(i)
  local giftPackId = self._rmbGitCorrespondingDiamondGit[self._itemInfo[i].giftPackId].diamondGit
  if self._gitStatus[giftPackId] == GoodStatusType.CannotBuy then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100454)
  elseif self._gitStatus[giftPackId] == GoodStatusType.CanBuy then
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.cbuyreturngift")
    if protocol and not self._sendProtocol then
      self._sendProtocol = true
      protocol.giftID = giftPackId
      protocol.giftType = protocol.INVITATE
      protocol:Send()
    end
  end
end

function InvitePlayerReturnTabCell:OnItemRMBClicked(i)
  local cmd = LuaNetManager.CreateProtocol("protocol.charge.cbuydiamond")
  cmd.goodId = self._itemInfo[i].chargeId
  cmd:Send()
  if SdkManager.IsOverseas then
    local d = {
      goodId = tostring(self._itemInfo[i].goodId),
      cashPrice = SdkManager.GetPrice(self._itemInfo[i].chargeNum),
      diamondPrice = "0"
    }
    SdkManager.Report("purchase_click", d)
    SdkManager.Report("purchase_click_GP_ONCE", d)
    SdkManager.Report(string.format("purchase_click_%s", d.goodId), d)
  end
end

function InvitePlayerReturnTabCell:OnShareBtnClick()
  if not self._shareCode then
    return
  end
  local dlg = DialogManager.CreateSingletonDialog("welfare.inviteshareresultdlg")
  local showShare = true
  local shared = true
  dlg:Init(showShare, self._shareCode, shared)
  local msg = TextManager.GetText(NekoData.BehaviorManager.BM_Gacha:GetShareTextID())
  msg = string.gsub(msg, "%$parameter1%$", self._shareCode)
  self:GetRootWindow():CopyToClipBoard(msg)
  if DialogManager.GetDialog("welfare.welfaremaindialog") then
    DialogManager.DestroySingletonDialog("welfare.welfaremaindialog")
  end
end

function InvitePlayerReturnTabCell:OnManualTipsClicked()
  local dialog = DialogManager.CreateSingletonDialog("welfare.returnwelfare.returnruletipsdialog")
  if dialog then
    dialog:Init(dialog.TipsType.InvitePlayer)
  end
end

return InvitePlayerReturnTabCell
