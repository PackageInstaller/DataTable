local DialogGroup = require("framework.ui.group.dialoggroup")
local CanvasStaticFunctions = CS.PixelNeko.Lua.UI.CanvasStaticFunctions
local TipsGroup = class("TipsGroup", DialogGroup)

function TipsGroup:Ctor(name, sortinginitorder)
  TipsGroup.super.Ctor(self, name, sortinginitorder)
  self._tips = {}
end

function TipsGroup:AddDialog(dialog)
  local windowmask = DialogManager.CreateFrameDialog("group.windowmaskdialog", self._root)
  CanvasStaticFunctions.AddCanvasWithGraphicRaycaster(windowmask:GetRootWindow()._uiObject).overrideSorting = true
  windowmask:GetRootWindow():SetName(dialog._dialogName)
  windowmask:GetRootWindow():Subscribe_PointerDownEvent(nil, self)
  self._tips[dialog._dialogKey] = windowmask
  table.insert(self._dialogs, dialog)
  windowmask:LoadDialog(dialog)
end

function TipsGroup:RemoveDialog(notification)
  local dialog = notification.userInfo
  local index = self:IndexOf(dialog._dialogKey)
  if index then
    table.remove(self._dialogs, index)
    local windowmask = self._tips[dialog._dialogKey]
    self._tips[dialog._dialogKey] = nil
    windowmask:UnLoadDialog()
  end
end

function TipsGroup:IndexOf(dialogKey)
  for i, dialog in ipairs(self._dialogs) do
    if dialog._dialogKey == dialogKey then
      return i
    end
  end
end

return TipsGroup
