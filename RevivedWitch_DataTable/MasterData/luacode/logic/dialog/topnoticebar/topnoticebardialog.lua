-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/topnoticebar/topnoticebardialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TopNoticeBarDialog = class("TopNoticeBarDialog", Dialog)
TopNoticeBarDialog.AssetBundleName = "ui/layouts.toast"
TopNoticeBarDialog.AssetName = "TopInform"
TopNoticeBarDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TopNoticeBarDialog
  ((TopNoticeBarDialog.super).Ctor)(self, ...)
  self._groupName = "Message"
end

TopNoticeBarDialog.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Back/Text")
  self._text2 = self:GetChild("Back/Text2")
  self._clear = self:GetChild("Clear")
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationEnd, self)
end

TopNoticeBarDialog.OnDestroy = function(self)
  -- function num : 0_2
end

TopNoticeBarDialog.SetData = function(self, msgTitle, msgMain, showClear)
  -- function num : 0_3
  (self._text):SetText(msgTitle)
  ;
  (self._text2):SetText(msgMain)
  ;
  (self._clear):SetActive(showClear)
end

TopNoticeBarDialog.OnAnimationEnd = function(self)
  -- function num : 0_4
  self:Destroy()
end

TopNoticeBarDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return DataCommon.BackPressed_SkipResponse
end

return TopNoticeBarDialog

