-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/group/tipsgroup.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DialogGroup = require("framework.ui.group.dialoggroup")
local CanvasStaticFunctions = (((CS.PixelNeko).Lua).UI).CanvasStaticFunctions
local TipsGroup = class("TipsGroup", DialogGroup)
TipsGroup.Ctor = function(self, name, sortinginitorder)
  -- function num : 0_0 , upvalues : TipsGroup
  ((TipsGroup.super).Ctor)(self, name, sortinginitorder)
  self._tips = {}
end

TipsGroup.AddDialog = function(self, dialog)
  -- function num : 0_1 , upvalues : _ENV, CanvasStaticFunctions
  local windowmask = (DialogManager.CreateFrameDialog)("group.windowmaskdialog", self._root)
  ;
  ((CanvasStaticFunctions.AddCanvasWithGraphicRaycaster)((windowmask:GetRootWindow())._uiObject)).overrideSorting = true
  ;
  (windowmask:GetRootWindow()):SetName(dialog._dialogName)
  ;
  (windowmask:GetRootWindow()):Subscribe_PointerDownEvent(nil, self)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._tips)[dialog._dialogKey] = windowmask
  ;
  (table.insert)(self._dialogs, dialog)
  windowmask:LoadDialog(dialog)
end

TipsGroup.RemoveDialog = function(self, notification)
  -- function num : 0_2 , upvalues : _ENV
  local dialog = notification.userInfo
  local index = self:IndexOf(dialog._dialogKey)
  if index then
    (table.remove)(self._dialogs, index)
    local windowmask = (self._tips)[dialog._dialogKey]
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._tips)[dialog._dialogKey] = nil
    windowmask:UnLoadDialog()
  end
end

TipsGroup.IndexOf = function(self, dialogKey)
  -- function num : 0_3 , upvalues : _ENV
  for i,dialog in ipairs(self._dialogs) do
    if dialog._dialogKey == dialogKey then
      return i
    end
  end
end

return TipsGroup

