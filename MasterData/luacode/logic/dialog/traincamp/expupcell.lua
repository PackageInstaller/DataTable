local UIManager = CS.PixelNeko.UI.UIManager
local ExpUpCell = class("ExpUpCell", Dialog)
ExpUpCell.AssetBundleName = "ui/layouts.yard"
ExpUpCell.AssetName = "TrainingExpUp"

function ExpUpCell:Ctor(...)
  ExpUpCell.super.Ctor(self, ...)
end

function ExpUpCell:OnCreate()
end

function ExpUpCell:OnDestroy()
end

function ExpUpCell:SetData(value)
  self._delegate = value
end

function ExpUpCell:UpdatePosition(x, y, z)
  local posX, posY = UIManager.ScreenPointToLocalPointInRectangle(self._delegate._rootWindow._uiObject, UIManager.WorldToScreenPointInMargin("TrainCampMain", x, y, z))
  self._rootWindow:SetAnchoredPosition(posX, posY)
end

function ExpUpCell:PlayAppearAnimation()
  self._rootWindow:PlayAnimation("TrainingExpUp")
end

return ExpUpCell
