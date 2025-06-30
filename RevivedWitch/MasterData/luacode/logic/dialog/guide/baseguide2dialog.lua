-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guide/baseguide2dialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BaseGuide2Dialog = class("BaseGuide2Dialog", Dialog)
BaseGuide2Dialog.AssetBundleName = "ui/layouts.guide"
BaseGuide2Dialog.AssetName = "ShiXiangGuide2"
BaseGuide2Dialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BaseGuide2Dialog
  ((BaseGuide2Dialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

BaseGuide2Dialog.OnCreate = function(self)
  -- function num : 0_1
  self._okbutton = self:GetChild("Back/ConfirmButton")
  ;
  (self._okbutton):Subscribe_PointerClickEvent(self.OnBtnClick, self)
end

BaseGuide2Dialog.OnDestroy = function(self)
  -- function num : 0_2
end

BaseGuide2Dialog.Init = function(self, key)
  -- function num : 0_3
end

BaseGuide2Dialog.OnBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV, BaseGuide2Dialog
  self:Destroy()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_GuideGachaTips, BaseGuide2Dialog, nil)
end

return BaseGuide2Dialog

