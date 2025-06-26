-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/notice/loginnoticedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local LoginNoticeDialog = class("NoticeDialog", Dialog)
LoginNoticeDialog.AssetBundleName = "ui/layouts"
LoginNoticeDialog.AssetName = "AnnounceBeforeLogin"
LoginNoticeDialog.Status = {Open = 1, Close = 2}
LoginNoticeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LoginNoticeDialog
  ((LoginNoticeDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

LoginNoticeDialog.OnCreate = function(self)
  -- function num : 0_1
  self._title = self:GetChild("Announcement/Title")
  self._frame = self:GetChild("Announcement/Frame")
  self._content = self:GetChild("Announcement/Frame/Text")
  self._scrollBar = self:GetChild("Announcement/Scrollbar")
  self._close = self:GetChild("CloseBtn")
  ;
  (self._close):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._content):Subscribe_DragEvent(self.OnDrag, self)
  self._anchorY = (self._content):GetHeight()
end

LoginNoticeDialog.OnDestroy = function(self)
  -- function num : 0_2
end

LoginNoticeDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._title):SetText(data.title)
  ;
  (self._content):SetText(data.content)
  _ = (self._content):GetPreferredSize()
  ;
  (self._content):SetHeight(0, self._total)
  ;
  (((self._frame):GetUIObject()):GetComponent("ScrollRect")).verticalNormalizedPosition = 1
end

LoginNoticeDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("notice.loginnoticedialog")
end

return LoginNoticeDialog

