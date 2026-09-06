local ShopGoodsCellHelper = require("logic.dialog.activity.doubleeleven.shopgoodscellhelper")
local ShopGoodsCell = class("ShopGoodsCell", Dialog)
ShopGoodsCell.AssetBundleName = "ui/layouts.activityeleven"
ShopGoodsCell.AssetName = "ActivityElevenShopCell"

function ShopGoodsCell:Ctor(...)
  ShopGoodsCell.super.Ctor(self, ...)
end

function ShopGoodsCell:OnCreate()
  self._rootElement = self:GetRootWindow()
  self._goodsCellHelper = ShopGoodsCellHelper.Create(self._rootElement)
end

function ShopGoodsCell:OnDestroy()
  if self._goodsCellHelper then
    self._goodsCellHelper:OnDestroy()
  end
end

function ShopGoodsCell:RefreshCell(data)
  if self._goodsCellHelper then
    self._goodsCellHelper:RefreshCell(data.data, self._delegate._shopID, data.index)
  end
end

return ShopGoodsCell
