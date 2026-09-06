local TowerV2PackCell = class("TowerV2PackCell", Dialog)
local Item = require("logic.manager.experimental.types.item")
TowerV2PackCell.AssetBundleName = "ui/layouts.stair"
TowerV2PackCell.AssetName = "StairItemListCell"
local cimagepath = BeanManager.GetTableByName("ui.cimagepath")

function TowerV2PackCell:Ctor(...)
  TowerV2PackCell.super.Ctor(self, ...)
end

function TowerV2PackCell:OnCreate()
  self._itemCell = {
    cell = self:GetChild("ItemCell"),
    mask = self:GetChild("ItemCell/_BackGround/Mask"),
    frame = self:GetChild("ItemCell/_BackGround/Frame"),
    icon = self:GetChild("ItemCell/_BackGround/Icon"),
    count = self:GetChild("ItemCell/_Count")
  }
  self._itemCell.icon:Subscribe_PointerClickEvent(self.OnItemClicked, self)
end

function TowerV2PackCell:OnItemClicked()
  if self._item then
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = self._item
      })
      local width, height = self._itemCell.cell:GetRectSize()
      tipsDialog:SetTipsPosition(width, height, self._itemCell.cell:GetLocalPointInUiRootPanel())
    end
  end
end

function TowerV2PackCell:OnDestroy()
end

function TowerV2PackCell:RefreshCell()
  if self._cellData.itemId then
    self._item = Item.Create(self._cellData.itemId)
    if self._item then
      self._itemCell.icon:SetSprite(self._item:GetIconAB())
      self._itemCell.frame:SetSprite(self._item:GetPinJiImageAB())
      self._itemCell.count:SetNumber(self._cellData.itemNum)
    end
  end
end

return TowerV2PackCell
