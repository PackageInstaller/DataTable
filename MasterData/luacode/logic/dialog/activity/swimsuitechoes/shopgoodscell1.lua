local ShopGoodsCellHelper = require("logic.dialog.activity.swimsuitechoes.shopgoodscellhelper")
local ShopGoodsCell = class("ShopGoodsCell", Dialog)
ShopGoodsCell.AssetBundleName = "ui/layouts.activitysummer2"
ShopGoodsCell.AssetName = "ActivitySummer2OtherShopCell"

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
