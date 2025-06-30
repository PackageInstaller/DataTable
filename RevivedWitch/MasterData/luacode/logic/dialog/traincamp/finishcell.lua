-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/traincamp/finishcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local FinishCell = class("FinishCell", Dialog)
FinishCell.AssetBundleName = "ui/layouts.yard"
FinishCell.AssetName = "TrainingFinish"
FinishCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FinishCell
  ((FinishCell.super).Ctor)(self, ...)
end

FinishCell.OnCreate = function(self)
  -- function num : 0_1
end

FinishCell.OnDestroy = function(self)
  -- function num : 0_2
end

FinishCell.SetData = function(self, value)
  -- function num : 0_3
  self._delegate = value
end

FinishCell.UpdatePosition = function(self, x, y, z)
  -- function num : 0_4 , upvalues : UIManager
  local posX, posY = (UIManager.ScreenPointToLocalPointInRectangle)(((self._delegate)._rootWindow)._uiObject, (UIManager.WorldToScreenPointInMargin)("TrainCampMain", x, y, z))
  ;
  (self._rootWindow):SetAnchoredPosition(posX, posY)
end

return FinishCell

