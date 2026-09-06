local ActiveAwardCell = class("ActiveAwardCell", Dialog)
ActiveAwardCell.AssetBundleName = "ui/layouts.basetasklist"
ActiveAwardCell.AssetName = "TaskActiveAwardShowCell"

function ActiveAwardCell:Ctor(...)
  ActiveAwardCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function ActiveAwardCell:OnCreate()
  self._icon = self:GetChild("_BackGround/Icon")
  self._frame = self:GetChild("_BackGround/Frame")
  self._selected = self:GetChild("_BackGround/Select")
  self._count = self:GetChild("_Count")
  self._rootWindow:Subscribe_PointerClickEvent(self.OnMouseClick, self)
end

function ActiveAwardCell:RefreshCell()
  local icon = self._cellData:GetIcon()
  self._icon:SetSprite(icon.assetBundle, icon.assetName)
  local frame = self._cellData:GetPinJiImage()
  self._frame:SetSprite(frame.assetBundle, frame.assetName)
  self._count:SetText(NumberManager.GetShowNumber(self._cellData:GetCount()))
end

function ActiveAwardCell:OnMouseClick()
  local width, height = self._rootWindow:GetRectSize()
  local tip = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  tip:Init({
    item = self._cellData,
    num = self._cellData:GetCount()
  })
  tip:UpdatePosition(self)
  tip:SetTipsPosition(width, height, self._rootWindow:GetLocalPointInUiRootPanel())
  self._delegate:OnItemClick(self._cellData)
end

return ActiveAwardCell
