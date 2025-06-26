-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/invite/invitetipsdlg.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local InviteTipDlg = class("InviteTipDlg", Dialog)
InviteTipDlg.AssetBundleName = "ui/layouts.invite"
InviteTipDlg.AssetName = "InviteTips"
InviteTipDlg.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : InviteTipDlg
  ((InviteTipDlg.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

InviteTipDlg.OnCreate = function(self)
  -- function num : 0_1
  self._closeBtn = self:GetChild("CloseBtn")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._text = self:GetChild("Text")
end

InviteTipDlg.OnBackBtnClicked = function(self)
  -- function num : 0_2
  self:Destroy()
end

InviteTipDlg.SetTip = function(self, data)
  -- function num : 0_3
  (self._text):SetText(data)
end

return InviteTipDlg

