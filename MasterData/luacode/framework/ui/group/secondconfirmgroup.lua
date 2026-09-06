local CanvasStaticFunctions = CS.PixelNeko.Lua.UI.CanvasStaticFunctions
local DialogGroup = require("framework.ui.group.dialoggroup")
local SecondConfirmGroup = class("SecondConfirmGroup", DialogGroup)

function SecondConfirmGroup:Ctor(name, sortinginitorder)
  SecondConfirmGroup.super.Ctor(self, name, sortinginitorder)
end

function SecondConfirmGroup:AddDialog(dialog)
  dialog:Load(self._root)
  CanvasStaticFunctions.AddCanvasWithGraphicRaycaster(dialog._rootWindow._uiObject).overrideSorting = true
  table.insert(self._dialogs, dialog)
end

function SecondConfirmGroup:RemoveDialog(notification)
  local dialog = notification.userInfo
  local index = self:IndexOf(dialog._dialogKey)
  if index then
    table.remove(self._dialogs, index)
    dialog:RootWindowDestroy()
  end
end

function SecondConfirmGroup:IndexOf(dialogKey)
  for i, dialog in ipairs(self._dialogs) do
    if dialog._dialogKey == dialogKey then
      return i
    end
  end
end

return SecondConfirmGroup
