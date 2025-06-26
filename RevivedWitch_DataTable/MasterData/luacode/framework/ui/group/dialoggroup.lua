-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/group/dialoggroup.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CanvasGroupStaticFunction = ((CS.PixelNeko).Lua).CanvasGroupStaticFunction
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local UIManager = ((CS.PixelNeko).UI).UIManager
local CanvasStaticFunctions = (((CS.PixelNeko).Lua).UI).CanvasStaticFunctions
local AutoRender = ((CS.PixelNeko).UI).AutoRender
local Dialog = require("framework.ui.dialog")
local DialogGroup = class("DialogGroup")
DialogGroup.Ctor = function(self, name, sortinginitorder)
  -- function num : 0_0 , upvalues : UIManager, _ENV
  self._name = name
  self._dialogs = {}
  self._hasDialog = false
  self._root = (UIManager.CreateGroup)(name, name)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RemoveDialog, Common.n_DialogWillDestroy, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RemoveIndex, Common.n_RootWindowWillDestroy, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.DialogWillUnLoad, Common.n_DialogWillUnLoad, nil)
end

DialogGroup.CloseAllDialog = function(self)
  -- function num : 0_1 , upvalues : _ENV
  while (self._dialogs)[#self._dialogs] do
    (DialogManager.DestroySingletonDialog)(((self._dialogs)[#self._dialogs])._dialogName)
  end
  self._hasDialog = #self._dialogs > 0
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DialogGroup.AddDialog = function(self, dialog)
  -- function num : 0_2 , upvalues : CanvasStaticFunctions, _ENV
  dialog:Load(self._root)
  ;
  ((CanvasStaticFunctions.AddCanvasWithGraphicRaycaster)((dialog._rootWindow)._uiObject)).overrideSorting = true
  ;
  (table.insert)(self._dialogs, dialog)
  self._hasDialog = #self._dialogs > 0
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DialogGroup.ReSort = function(self)
  -- function num : 0_3 , upvalues : AutoRender
  if not self._hasDialog then
    return 
  end
  ;
  (AutoRender.ResortImmediate)(self._root)
end

DialogGroup.RemoveDialog = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV
  local dialog = notification.userInfo
  local index = self:IndexOf(dialog._dialogKey)
  if index then
    (table.remove)(self._dialogs, index)
    dialog:RootWindowDestroy()
  end
  self._hasDialog = #self._dialogs > 0
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DialogGroup.RemoveIndex = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  local dialog = notification.userInfo
  local index = self:IndexOf(dialog._dialogKey)
  if index then
    (table.remove)(self._dialogs, index)
  end
end

DialogGroup.DialogWillUnLoad = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV
  local dialog = notification.userInfo
  local index = self:IndexOf(dialog._dialogKey)
  if index then
    (table.remove)(self._dialogs, index)
  end
end

DialogGroup.SetObjectActive = function(self, alpha)
  -- function num : 0_7
  (self._root):SetActive(alpha)
end

DialogGroup.GetObjectActive = function(self)
  -- function num : 0_8 , upvalues : TransformStaticFunctions
  return (TransformStaticFunctions.IsActive)(self._root)
end

DialogGroup.IndexOf = function(self, dialogKey)
  -- function num : 0_9 , upvalues : _ENV
  for i,dialog in ipairs(self._dialogs) do
    if dialog._dialogKey == dialogKey then
      return i
    end
  end
end

DialogGroup.GetDialogGroupLen = function(self)
  -- function num : 0_10
  return #self._dialogs
end

return DialogGroup

