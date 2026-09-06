local InviteTipDlg = class("InviteTipDlg", Dialog)
InviteTipDlg.AssetBundleName = "ui/layouts.invite"
InviteTipDlg.AssetName = "InviteTips"

function InviteTipDlg:Ctor(...)
  InviteTipDlg.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function InviteTipDlg:OnCreate()
  self._closeBtn = self:GetChild("CloseBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._text = self:GetChild("Text")
end

function InviteTipDlg:OnBackBtnClicked()
  self:Destroy()
end

function InviteTipDlg:SetTip(data)
  self._text:SetText(data)
end

return InviteTipDlg
