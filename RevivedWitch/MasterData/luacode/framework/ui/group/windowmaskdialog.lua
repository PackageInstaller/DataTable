-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/group/windowmaskdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local WindowMaskDialog = class("WindowMaskDialog", Dialog)
WindowMaskDialog.AssetBundleName = "ui/layouts"
WindowMaskDialog.AssetName = "WindowMask"
WindowMaskDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : WindowMaskDialog
  ((WindowMaskDialog.super).Ctor)(self, ...)
  self._dialog = nil
end

WindowMaskDialog.OnCreate = function(self, root)
  -- function num : 0_1
end

WindowMaskDialog.OnDestroy = function(self)
  -- function num : 0_2
  if self._dialog then
    (self._dialog):RootWindowDestroy()
    self._dialog = nil
  end
  self:RootWindowDestroy()
end

WindowMaskDialog.LoadDialog = function(self, dialog)
  -- function num : 0_3
  self._dialog = dialog
  ;
  (self:GetRootWindow()):SetName(self.AssetName .. "_" .. dialog.AssetName)
  dialog:Load((self:GetRootWindow())._uiObject)
end

WindowMaskDialog.UnLoadDialog = function(self)
  -- function num : 0_4
  self:Destroy()
end

return WindowMaskDialog

