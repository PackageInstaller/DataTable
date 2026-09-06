local BaseGuide2Dialog = class("BaseGuide2Dialog", Dialog)
BaseGuide2Dialog.AssetBundleName = "ui/layouts.guide"
BaseGuide2Dialog.AssetName = "ShiXiangGuide2"

function BaseGuide2Dialog:Ctor(...)
  BaseGuide2Dialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function BaseGuide2Dialog:OnCreate()
  self._okbutton = self:GetChild("Back/ConfirmButton")
  self._okbutton:Subscribe_PointerClickEvent(self.OnBtnClick, self)
end

function BaseGuide2Dialog:OnDestroy()
end

function BaseGuide2Dialog:Init(key)
end

function BaseGuide2Dialog:OnBtnClick()
  self:Destroy()
  LuaNotificationCenter.PostNotification(Common.n_GuideGachaTips, BaseGuide2Dialog, nil)
end

return BaseGuide2Dialog
