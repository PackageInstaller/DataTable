local BaseGuide1Dialog = class("BaseGuide1Dialog", Dialog)
BaseGuide1Dialog.AssetBundleName = "ui/layouts.guide"
BaseGuide1Dialog.AssetName = "ShiXiangGuide1"

function BaseGuide1Dialog:Ctor(...)
  BaseGuide1Dialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function BaseGuide1Dialog:OnCreate()
  self._okbutton = self:GetChild("Back/ConfirmButton")
  self._okbutton:Subscribe_PointerClickEvent(self.OnBtnClick, self)
end

function BaseGuide1Dialog:OnDestroy()
end

function BaseGuide1Dialog:Init(key)
end

function BaseGuide1Dialog:OnBtnClick()
  self:Destroy()
  LuaNotificationCenter.PostNotification(Common.n_GuideGetSkill, BaseCharacterInfoSkillChangeDialog, nil)
end

return BaseGuide1Dialog
