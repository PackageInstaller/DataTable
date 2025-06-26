-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/activitydeeplinkdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ActivityDeepLinkDialog = class("ActivityDeepLinkDialog", Dialog)
ActivityDeepLinkDialog.AssetBundleName = "ui/layouts.activityhalloween"
ActivityDeepLinkDialog.AssetName = "ActivityHalloweenInto"
ActivityDeepLinkDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ActivityDeepLinkDialog
  ((ActivityDeepLinkDialog.super).Ctor)(self, ...)
  self._groupName = "Message"
end

ActivityDeepLinkDialog.OnCreate = function(self)
  -- function num : 0_1
  self._goBtn = self:GetChild("BackImage/GoBtn")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
end

ActivityDeepLinkDialog.OnDestroy = function(self)
  -- function num : 0_2
end

ActivityDeepLinkDialog.OnGoBtnClicked = function(self)
  -- function num : 0_3
  self:Destroy()
end

return ActivityDeepLinkDialog

