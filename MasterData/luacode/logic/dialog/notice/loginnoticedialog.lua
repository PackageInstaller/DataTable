local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")
local LoginNoticeDialog = class("NoticeDialog", Dialog)
LoginNoticeDialog.AssetBundleName = "ui/layouts"
LoginNoticeDialog.AssetName = "AnnounceBeforeLogin"
LoginNoticeDialog.Status = {Open = 1, Close = 2}

function LoginNoticeDialog:Ctor(...)
  LoginNoticeDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function LoginNoticeDialog:OnCreate()
  self._title = self:GetChild("Announcement/Title")
  self._frame = self:GetChild("Announcement/Frame")
  self._content = self:GetChild("Announcement/Frame/Text")
  self._scrollBar = self:GetChild("Announcement/Scrollbar")
  self._close = self:GetChild("CloseBtn")
  self._close:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._content:Subscribe_DragEvent(self.OnDrag, self)
  self._anchorY, self._offsetY = self._content:GetHeight()
end

function LoginNoticeDialog:OnDestroy()
end

function LoginNoticeDialog:SetData(data)
  self._title:SetText(data.title)
  self._content:SetText(data.content)
  _, self._total = self._content:GetPreferredSize()
  self._content:SetHeight(0, self._total)
  self._frame:GetUIObject():GetComponent("ScrollRect").verticalNormalizedPosition = 1
end

function LoginNoticeDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("notice.loginnoticedialog")
end

return LoginNoticeDialog
