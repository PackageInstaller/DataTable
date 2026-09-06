local Item = require("logic.manager.experimental.types.item")
local RecommendShopPageItemCell = class("RecommendShopPageItemCell", Dialog)
RecommendShopPageItemCell.AssetBundleName = "ui/layouts.baseshop"
RecommendShopPageItemCell.AssetName = "RecommendShopPage1Item"

function RecommendShopPageItemCell:Ctor(...)
  RecommendShopPageItemCell.super.Ctor(self, ...)
  self._item = {}
end

function RecommendShopPageItemCell:OnCreate()
  self._itemBack = self:GetChild("Item/Back")
  self._itemIcon = self:GetChild("Item/Item")
  self._count = self:GetChild("Item/Num")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function RecommendShopPageItemCell:OnDestroy()
end

function RecommendShopPageItemCell:RefreshCell(data)
  self._item = Item.Create(data.id)
  local imageRecord = self._item:GetIcon()
  self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._count:SetText(data.count)
end

function RecommendShopPageItemCell:OnCellClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return RecommendShopPageItemCell
