local TaskItemCell = class("TaskItemCell", Dialog)
TaskItemCell.AssetBundleName = "ui/layouts.activityeleven"
TaskItemCell.AssetName = "TaskCellItem"

function TaskItemCell:Ctor(...)
  TaskItemCell.super.Ctor(self, ...)
  self._item = nil
end

function TaskItemCell:OnCreate()
  self._itemCount = self:GetChild("Panel/ItemCell/_Count")
  self._itemFrame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._itemIcon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
end

function TaskItemCell:OnDestroy()
end

function TaskItemCell:RefreshCell(data)
  self._item = data
  self._itemCount:SetText(NumberManager.GetShowNumber(self._item:GetCount()))
  self._itemIcon:SetSprite(self._item:GetIcon().assetBundle, self._item:GetIcon().assetName)
  self._itemFrame:SetSprite(self._item:GetPinJiImage().assetBundle, self._item:GetPinJiImage().assetName)
end

function TaskItemCell:OnItemCellClicked()
  local dialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if dialog then
    dialog:Init({
      item = self._item
    })
  end
end

return TaskItemCell
