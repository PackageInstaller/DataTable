-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guide/baseguide1dialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BaseGuide1Dialog = class("BaseGuide1Dialog", Dialog)
BaseGuide1Dialog.AssetBundleName = "ui/layouts.guide"
BaseGuide1Dialog.AssetName = "ShiXiangGuide1"
BaseGuide1Dialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BaseGuide1Dialog
  ((BaseGuide1Dialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

BaseGuide1Dialog.OnCreate = function(self)
  -- function num : 0_1
  self._okbutton = self:GetChild("Back/ConfirmButton")
  ;
  (self._okbutton):Subscribe_PointerClickEvent(self.OnBtnClick, self)
end

BaseGuide1Dialog.OnDestroy = function(self)
  -- function num : 0_2
end

BaseGuide1Dialog.Init = function(self, key)
  -- function num : 0_3
end

BaseGuide1Dialog.OnBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self:Destroy()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_GuideGetSkill, BaseCharacterInfoSkillChangeDialog, nil)
end

return BaseGuide1Dialog

