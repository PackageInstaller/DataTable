-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/announcementdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local AnnouncementDialog = class("AnnouncementDialog", Dialog)
AnnouncementDialog.AssetBundleName = "ui/layouts"
AnnouncementDialog.AssetName = "Announcement"
AnnouncementDialog.Status = {Open = 1, Close = 2}
AnnouncementDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AnnouncementDialog
  ((AnnouncementDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

AnnouncementDialog.OnCreate = function(self)
  -- function num : 0_1
  self._backImg = self:GetChild("BackImage")
  self._openServer = self:GetChild("Text1")
  self._closeServer = self:GetChild("Text2")
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._addBtn = self:GetChild("AddBtn")
  self._closeBtn = self:GetChild("CloseBtn")
  ;
  (self._backImg):Subscribe_PointerClickEvent(nil, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._addBtn):Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
end

AnnouncementDialog.OnDestroy = function(self)
  -- function num : 0_2
end

AnnouncementDialog.Init = function(self, status)
  -- function num : 0_3
  self._status = status
end

AnnouncementDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4 , upvalues : AnnouncementDialog
  if self._status then
    if self._status == (AnnouncementDialog.Status).Open then
      self:Destroy()
    else
      if self._status == (AnnouncementDialog.Status).Close then
        self:Destroy()
      end
    end
  end
end

AnnouncementDialog.OnAddBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV, CVarConfig
  local plat = (((CS.PixelNeko).LuaManager).GetSystemType)()
  local systemType = require("protocols.bean.protocol.common.systemtype")
  if plat == systemType.IOS then
    ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)((CVarConfig:GetRecorder(20)).Value)
  else
    if plat == systemType.ANDROID then
      ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)((CVarConfig:GetRecorder(19)).Value)
    end
  end
end

return AnnouncementDialog

