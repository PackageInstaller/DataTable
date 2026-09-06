local WindowMaskDialog = class("WindowMaskDialog", Dialog)
WindowMaskDialog.AssetBundleName = "ui/layouts"
WindowMaskDialog.AssetName = "WindowMask"

function WindowMaskDialog:Ctor(...)
  WindowMaskDialog.super.Ctor(self, ...)
  self._dialog = nil
end

function WindowMaskDialog:OnCreate(root)
end

function WindowMaskDialog:OnDestroy()
  if self._dialog then
    self._dialog:RootWindowDestroy()
    self._dialog = nil
  end
  self:RootWindowDestroy()
end

function WindowMaskDialog:LoadDialog(dialog)
  self._dialog = dialog
  self:GetRootWindow():SetName(self.AssetName .. "_" .. dialog.AssetName)
  dialog:Load(self:GetRootWindow()._uiObject)
end

function WindowMaskDialog:UnLoadDialog()
  self:Destroy()
end

return WindowMaskDialog
