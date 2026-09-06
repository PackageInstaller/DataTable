local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")
local AnnouncementDialog = class("AnnouncementDialog", Dialog)
AnnouncementDialog.AssetBundleName = "ui/layouts"
AnnouncementDialog.AssetName = "Announcement"
AnnouncementDialog.Status = {Open = 1, Close = 2}

function AnnouncementDialog:Ctor(...)
  AnnouncementDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function AnnouncementDialog:OnCreate()
  self._backImg = self:GetChild("BackImage")
  self._openServer = self:GetChild("Text1")
  self._closeServer = self:GetChild("Text2")
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._addBtn = self:GetChild("AddBtn")
  self._closeBtn = self:GetChild("CloseBtn")
  self._backImg:Subscribe_PointerClickEvent(nil, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._addBtn:Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
end

function AnnouncementDialog:OnDestroy()
end

function AnnouncementDialog:Init(status)
  self._status = status
end

function AnnouncementDialog:OnBackBtnClicked()
  if self._status then
    if self._status == AnnouncementDialog.Status.Open then
      self:Destroy()
    elseif self._status == AnnouncementDialog.Status.Close then
      self:Destroy()
    end
  end
end

function AnnouncementDialog:OnAddBtnClicked()
  local plat = CS.PixelNeko.LuaManager.GetSystemType()
  local systemType = require("protocols.bean.protocol.common.systemtype")
  if plat == systemType.IOS then
    CS.PixelNeko.Tools.ShareHelper.OpenURL(CVarConfig:GetRecorder(20).Value)
  elseif plat == systemType.ANDROID then
    CS.PixelNeko.Tools.ShareHelper.OpenURL(CVarConfig:GetRecorder(19).Value)
  end
end

return AnnouncementDialog
