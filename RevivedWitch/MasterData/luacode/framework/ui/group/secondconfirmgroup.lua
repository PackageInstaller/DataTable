-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/group/secondconfirmgroup.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CanvasStaticFunctions = (((CS.PixelNeko).Lua).UI).CanvasStaticFunctions
local DialogGroup = require("framework.ui.group.dialoggroup")
local SecondConfirmGroup = class("SecondConfirmGroup", DialogGroup)
SecondConfirmGroup.Ctor = function(self, name, sortinginitorder)
  -- function num : 0_0 , upvalues : SecondConfirmGroup
  ((SecondConfirmGroup.super).Ctor)(self, name, sortinginitorder)
end

SecondConfirmGroup.AddDialog = function(self, dialog)
  -- function num : 0_1 , upvalues : CanvasStaticFunctions, _ENV
  dialog:Load(self._root)
  ;
  ((CanvasStaticFunctions.AddCanvasWithGraphicRaycaster)((dialog._rootWindow)._uiObject)).overrideSorting = true
  ;
  (table.insert)(self._dialogs, dialog)
end

SecondConfirmGroup.RemoveDialog = function(self, notification)
  -- function num : 0_2 , upvalues : _ENV
  local dialog = notification.userInfo
  local index = self:IndexOf(dialog._dialogKey)
  if index then
    (table.remove)(self._dialogs, index)
    dialog:RootWindowDestroy()
  end
end

SecondConfirmGroup.IndexOf = function(self, dialogKey)
  -- function num : 0_3 , upvalues : _ENV
  for i,dialog in ipairs(self._dialogs) do
    if dialog._dialogKey == dialogKey then
      return i
    end
  end
end

return SecondConfirmGroup

