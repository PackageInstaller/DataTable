local Item = require("logic.manager.experimental.types.item")
local CInviteeRewards = BeanManager.GetTableByName("activity.cinviteerewards")
local InviteUtil = require("logic.dialog.invite.inviteutil")
local InviteAcceptDlg = class("InviteAcceptDlg", Dialog)
InviteAcceptDlg.AssetBundleName = "ui/layouts.invite"
InviteAcceptDlg.AssetName = "BeInvited"

function InviteAcceptDlg:Ctor(...)
  InviteAcceptDlg.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function InviteAcceptDlg:OnCreate()
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._itemGet = self:GetChild("Back/ItemGet")
  self._itemGet:SetActive(false)
  self._itemCell = self:GetChild("Back/ItemCell")
  self._tipBtn = self:GetChild("Back/Ibtn")
  self._inviteCode = self:GetChild("InputField")
  self._useBtn = self:GetChild("UseBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._tipBtn:Subscribe_PointerClickEvent(self.ShowTip, self)
  self._itemCell:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self._useBtn:Subscribe_PointerClickEvent(self.UseCode, self)
  LuaNotificationCenter.AddObserver(self, self.Update, Common.n_RefreshUseInvite, nil)
  self:SetData()
end

function InviteAcceptDlg:SetData()
  local record = CInviteeRewards:GetRecorder(1)
  self._item = Item.Create(record.itemID[1])
  InviteUtil.SetItemInfo(self._itemCell, {
    item = self._item,
    num = record.itemAmount[1]
  })
end

function InviteAcceptDlg:Update(protocol)
  self._useBtn:SetInteractable(false)
  self._itemGet:SetActive(true)
end

function InviteAcceptDlg:OnBackBtnClicked()
  self:Destroy()
end

function InviteAcceptDlg:ShowTip()
  DialogManager.CreateSingletonDialog("invite.invitetipsdlg")
end

function InviteAcceptDlg:OnItemCellClicked()
  local width, height = self._itemCell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    tipsDialog:SetTipsPosition(width, height, self._itemCell:GetLocalPointInUiRootPanel())
  end
end

function InviteAcceptDlg:UseCode()
  local code = self._inviteCode:GetText()
  warn("code: ", code)
  code = string.trim(code)
  if not code or code == "" then
    return
  end
  local cmd = LuaNetManager.CreateProtocol("protocol.activity.cuseinvitationcode")
  cmd.invitationCode = code
  cmd:Send()
end

return InviteAcceptDlg
