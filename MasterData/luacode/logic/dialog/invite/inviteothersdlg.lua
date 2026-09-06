local Item = require("logic.manager.experimental.types.item")
local CShareReward = BeanManager.GetTableByName("sharesystem.csharereward")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local InviteUtil = require("logic.dialog.invite.inviteutil")
local InviteOtherDlg = class("InviteOtherDlg", Dialog)
InviteOtherDlg.AssetBundleName = "ui/layouts.invite"
InviteOtherDlg.AssetName = "InviteOthers"

function InviteOtherDlg:Ctor(...)
  InviteOtherDlg.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function InviteOtherDlg:OnCreate()
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._itemGet = self:GetChild("Back/ItemGet")
  self._itemGet:SetActive(false)
  self._itemCell = self:GetChild("Back/ItemCell")
  self._tipBtn = self:GetChild("Back/Ibtn")
  self._inviteCode = self:GetChild("Back/InputField")
  self._shareBtn = self:GetChild("ShareBtn")
  self._shareDot = self:GetChild("ShareBtn/RedDot")
  self._playerListBtn = self:GetChild("PlayersListBtn")
  self._rewardListBtn = self:GetChild("RewardListBtn")
  self._redDot = self:GetChild("RewardListBtn/RedDot")
  self._redDot:SetActive(false)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._tipBtn:Subscribe_PointerClickEvent(self.ShowTip, self)
  self._itemCell:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self._tipsText = self:GetChild("Back/TipsText")
  self._shareBtn:Subscribe_PointerClickEvent(self.OnShare, self)
  self._playerListBtn:Subscribe_PointerClickEvent(self.OnShowPlayerList, self)
  self._rewardListBtn:Subscribe_PointerClickEvent(self.OnShowRewardList, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_RefreshActivityRewards, nil)
end

function InviteOtherDlg:SetData(protocol)
  self._inviteMax = protocol.limitNum
  self._inviteCur = protocol.inviteeNum
  self._shared = protocol.weekshare
  self._shareCode = protocol.invitationCode
  self._inviteCode:SetText(self._shareCode)
  if self._shared == -1 then
    self._itemCell:SetActive(false)
    self._tipsText:SetActive(false)
    self._itemGet:SetActive(false)
    self._shareDot:SetActive(true)
  else
    local record = CShareReward:GetRecorder(4)
    self._item = Item.Create(record.itemID[1])
    InviteUtil.SetItemInfo(self._itemCell, {
      item = self._item,
      num = record.itemNum[1]
    })
    if self._shared == 1 then
      self._itemGet:SetActive(true)
      self._shareDot:SetActive(false)
    else
      self._shareDot:SetActive(true)
    end
  end
  self:RefreshRedDot()
end

function InviteOtherDlg:RefreshRedDot()
  local s = NekoData.BehaviorManager.BM_Activity:GetInviteRedDot(2)
  self._redDot:SetActive(s)
end

function InviteOtherDlg:Update(protocol)
  self._itemGet:SetActive(true)
  self:RefreshRedDot()
end

function InviteOtherDlg:OnBackBtnClicked()
  self:Destroy()
end

function InviteOtherDlg:ShowTip()
  local dlg = DialogManager.CreateSingletonDialog("invite.invitetipsdlg")
  local msg = TextManager.GetText(CStringRes:GetRecorder(1514).msgTextID)
  dlg:SetTip(msg)
end

function InviteOtherDlg:OnItemCellClicked()
  local width, height = self._itemCell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    tipsDialog:SetTipsPosition(width, height, self._itemCell:GetLocalPointInUiRootPanel())
  end
end

function InviteOtherDlg:OnShare()
  if self._shareCode == "" then
    return
  end
  local dlg = DialogManager.CreateSingletonDialog("invite.inviteshareresultdlg")
  local showShare = self._inviteCur ~= self._inviteMax
  local shared = self._shared == 1
  dlg:Init(showShare, self._shareCode, shared)
  local msg = TextManager.GetText(NekoData.BehaviorManager.BM_Gacha:GetShareTextID())
  msg = string.gsub(msg, "%$parameter1%$", self._shareCode)
  self:GetRootWindow():CopyToClipBoard(msg)
  self:Destroy()
end

function InviteOtherDlg:OnShowPlayerList()
  local cmd = LuaNetManager.CreateProtocol("protocol.activity.copeninviteelist")
  cmd:Send()
end

function InviteOtherDlg:OnShowRewardList()
  local cmd = LuaNetManager.CreateProtocol("protocol.activity.cgetinvitationrewardslist")
  cmd:Send()
end

return InviteOtherDlg
