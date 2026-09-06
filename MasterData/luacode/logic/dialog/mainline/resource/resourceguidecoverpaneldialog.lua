local ResourceGuideCoverPanelDialog = class("ResourceGuideCoverPanelDialog", Dialog)
ResourceGuideCoverPanelDialog.AssetBundleName = "ui/layouts"
ResourceGuideCoverPanelDialog.AssetName = "WindowMask"

function ResourceGuideCoverPanelDialog:Ctor(...)
  ResourceGuideCoverPanelDialog.super.Ctor(self, ...)
  self._groupName = "Guide"
end

function ResourceGuideCoverPanelDialog:OnCreate()
end

function ResourceGuideCoverPanelDialog:OnDestroy()
end

return ResourceGuideCoverPanelDialog
