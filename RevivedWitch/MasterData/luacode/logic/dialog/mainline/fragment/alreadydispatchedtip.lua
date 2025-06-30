-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/fragment/alreadydispatchedtip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AlreadyDispatchedTip = class("AlreadyDispatchedTip", Dialog)
AlreadyDispatchedTip.AssetBundleName = "ui/layouts.secondconfirm"
AlreadyDispatchedTip.AssetName = "SingleConfirmLarge"
AlreadyDispatchedTip.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AlreadyDispatchedTip
  ((AlreadyDispatchedTip.super).Ctor)(self, ...)
  self._groupName = "Message"
  self._strList = {}
end

AlreadyDispatchedTip.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Text")
  self._confirmBtn = self:GetChild("ConfirmButton")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

AlreadyDispatchedTip.OnDestroy = function(self)
  -- function num : 0_2
end

AlreadyDispatchedTip.SetText = function(self, str)
  -- function num : 0_3
  (self._text):SetText(str)
end

AlreadyDispatchedTip.OnClickConfirmBtn = function(self)
  -- function num : 0_4
  self:Destroy()
end

return AlreadyDispatchedTip

