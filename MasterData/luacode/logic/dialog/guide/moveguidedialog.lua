local MoveGuideDialog = class("MoveGuideDialog", Dialog)
MoveGuideDialog.AssetBundleName = "ui/layouts.guide"
MoveGuideDialog.AssetName = "MoveGuide"

function MoveGuideDialog:Ctor(...)
  MoveGuideDialog.super.Ctor(self, ...)
  self._groupName = "Guide"
end

function MoveGuideDialog:OnCreate()
  self._rockPos = self:GetChild("Hint")
end

function MoveGuideDialog:OnDestroy()
  local rockerdialog = DialogManager.GetDialog("dungeon.rockerdialog")
  if rockerdialog then
    rockerdialog:SwichTipAnim(false)
  end
end

function MoveGuideDialog:GetBackGroundPosition()
  local UIManager = CS.PixelNeko.UI.UIManager
  local screenPos = UIManager.GetLocalPointInScreenPos(self._rockPos._uiObject)
  return screenPos
end

return MoveGuideDialog
