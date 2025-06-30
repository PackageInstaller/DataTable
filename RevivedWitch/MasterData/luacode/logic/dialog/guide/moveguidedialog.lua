-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guide/moveguidedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MoveGuideDialog = class("MoveGuideDialog", Dialog)
MoveGuideDialog.AssetBundleName = "ui/layouts.guide"
MoveGuideDialog.AssetName = "MoveGuide"
MoveGuideDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MoveGuideDialog
  ((MoveGuideDialog.super).Ctor)(self, ...)
  self._groupName = "Guide"
end

MoveGuideDialog.OnCreate = function(self)
  -- function num : 0_1
  self._rockPos = self:GetChild("Hint")
end

MoveGuideDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local rockerdialog = (DialogManager.GetDialog)("dungeon.rockerdialog")
  if rockerdialog then
    rockerdialog:SwichTipAnim(false)
  end
end

MoveGuideDialog.GetBackGroundPosition = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local UIManager = ((CS.PixelNeko).UI).UIManager
  local screenPos = (UIManager.GetLocalPointInScreenPos)((self._rockPos)._uiObject)
  return screenPos
end

return MoveGuideDialog

