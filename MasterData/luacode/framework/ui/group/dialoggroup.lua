local CanvasGroupStaticFunction = CS.PixelNeko.Lua.CanvasGroupStaticFunction
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager
local CanvasStaticFunctions = CS.PixelNeko.Lua.UI.CanvasStaticFunctions
local AutoRender = CS.PixelNeko.UI.AutoRender
local Dialog = require("framework.ui.dialog")
local DialogGroup = class("DialogGroup")

function DialogGroup:Ctor(name, sortinginitorder)
  self._name = name
  self._dialogs = {}
  self._hasDialog = false
  self._root = UIManager.CreateGroup(name, name)
  LuaNotificationCenter.AddObserver(self, self.RemoveDialog, Common.n_DialogWillDestroy, nil)
  LuaNotificationCenter.AddObserver(self, self.RemoveIndex, Common.n_RootWindowWillDestroy, nil)
  LuaNotificationCenter.AddObserver(self, self.DialogWillUnLoad, Common.n_DialogWillUnLoad, nil)
end

function DialogGroup:CloseAllDialog()
  while self._dialogs[#self._dialogs] do
    DialogManager.DestroySingletonDialog(self._dialogs[#self._dialogs]._dialogName)
  end
  self._hasDialog = #self._dialogs > 0
end

function DialogGroup:AddDialog(dialog)
  dialog:Load(self._root)
  CanvasStaticFunctions.AddCanvasWithGraphicRaycaster(dialog._rootWindow._uiObject).overrideSorting = true
  table.insert(self._dialogs, dialog)
  self._hasDialog = #self._dialogs > 0
end

function DialogGroup:ReSort()
  if not self._hasDialog then
    return
  end
  AutoRender.ResortImmediate(self._root)
end

function DialogGroup:RemoveDialog(notification)
  local dialog = notification.userInfo
  local index = self:IndexOf(dialog._dialogKey)
  if index then
    table.remove(self._dialogs, index)
    dialog:RootWindowDestroy()
  end
  self._hasDialog = #self._dialogs > 0
end

function DialogGroup:RemoveIndex(notification)
  local dialog = notification.userInfo
  local index = self:IndexOf(dialog._dialogKey)
  if index then
    table.remove(self._dialogs, index)
  end
end

function DialogGroup:DialogWillUnLoad(notification)
  local dialog = notification.userInfo
  local index = self:IndexOf(dialog._dialogKey)
  if index then
    table.remove(self._dialogs, index)
  end
end

function DialogGroup:SetObjectActive(alpha)
  self._root:SetActive(alpha)
end

function DialogGroup:GetObjectActive()
  return TransformStaticFunctions.IsActive(self._root)
end

function DialogGroup:IndexOf(dialogKey)
  for i, dialog in ipairs(self._dialogs) do
    if dialog._dialogKey == dialogKey then
      return i
    end
  end
end

function DialogGroup:GetDialogGroupLen()
  return #self._dialogs
end

return DialogGroup
