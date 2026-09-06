local BlockClickDialog = class("BlockClickDialog", Dialog)
BlockClickDialog.AssetBundleName = "ui/layouts.guide"
BlockClickDialog.AssetName = "GuideBack"

function BlockClickDialog:Ctor(...)
  BlockClickDialog.super.Ctor(self, ...)
  self._groupName = "Guide"
end

function BlockClickDialog:OnCreate()
  self._guideTxt = self:GetChild("GuideBack/GuideTxt")
end

function BlockClickDialog:OnDestroy()
end

return BlockClickDialog
