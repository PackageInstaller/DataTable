-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/traincamp/expupcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local ExpUpCell = class("ExpUpCell", Dialog)
ExpUpCell.AssetBundleName = "ui/layouts.yard"
ExpUpCell.AssetName = "TrainingExpUp"
ExpUpCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ExpUpCell
  ((ExpUpCell.super).Ctor)(self, ...)
end

ExpUpCell.OnCreate = function(self)
  -- function num : 0_1
end

ExpUpCell.OnDestroy = function(self)
  -- function num : 0_2
end

ExpUpCell.SetData = function(self, value)
  -- function num : 0_3
  self._delegate = value
end

ExpUpCell.UpdatePosition = function(self, x, y, z)
  -- function num : 0_4 , upvalues : UIManager
  local posX, posY = (UIManager.ScreenPointToLocalPointInRectangle)(((self._delegate)._rootWindow)._uiObject, (UIManager.WorldToScreenPointInMargin)("TrainCampMain", x, y, z))
  ;
  (self._rootWindow):SetAnchoredPosition(posX, posY)
end

ExpUpCell.PlayAppearAnimation = function(self)
  -- function num : 0_5
  (self._rootWindow):PlayAnimation("TrainingExpUp")
end

return ExpUpCell

