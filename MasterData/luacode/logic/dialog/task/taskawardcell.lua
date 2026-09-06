local TaskAwardCell = class("TaskAwardCell", Dialog)
TaskAwardCell.AssetBundleName = "ui/layouts.basetasklist"
TaskAwardCell.AssetName = "TaskStoryItemCell"

function TaskAwardCell:Ctor(...)
  TaskAwardCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function TaskAwardCell:OnCreate()
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._selected = self:GetChild("ItemCell/_BackGround/Select")
  self._count = self:GetChild("ItemCell/_Count")
  self._rootWindow:Subscribe_PointerClickEvent(self.OnMouseClick, self)
end

function TaskAwardCell:RefreshCell()
  local icon = self._cellData:GetIcon()
  self._icon:SetSprite(icon.assetBundle, icon.assetName)
  local frame = self._cellData:GetPinJiImage()
  self._frame:SetSprite(frame.assetBundle, frame.assetName)
  self._count:SetText(NumberManager.GetShowNumber(self._cellData:GetCount()))
end

function TaskAwardCell:OnMouseClick()
  local width, height = self._rootWindow:GetRectSize()
  local tip = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  tip:Init({
    item = self._cellData,
    num = self._cellData:GetCount()
  })
  tip:UpdatePosition(self)
  tip:SetTipsPosition(width, height, self._rootWindow:GetLocalPointInUiRootPanel())
end

return TaskAwardCell
