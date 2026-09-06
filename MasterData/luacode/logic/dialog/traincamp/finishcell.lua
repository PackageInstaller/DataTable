local UIManager = CS.PixelNeko.UI.UIManager
local FinishCell = class("FinishCell", Dialog)
FinishCell.AssetBundleName = "ui/layouts.yard"
FinishCell.AssetName = "TrainingFinish"

function FinishCell:Ctor(...)
  FinishCell.super.Ctor(self, ...)
end

function FinishCell:OnCreate()
end

function FinishCell:OnDestroy()
end

function FinishCell:SetData(value)
  self._delegate = value
end

function FinishCell:UpdatePosition(x, y, z)
  local posX, posY = UIManager.ScreenPointToLocalPointInRectangle(self._delegate._rootWindow._uiObject, UIManager.WorldToScreenPointInMargin("TrainCampMain", x, y, z))
  self._rootWindow:SetAnchoredPosition(posX, posY)
end

return FinishCell
