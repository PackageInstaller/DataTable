local Item = require("logic.manager.experimental.types.item")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local ShopItemBuyDetailCell = class("ShopItemBuyDetailCell", Dialog)
ShopItemBuyDetailCell.AssetBundleName = "ui/layouts.baseshop"
ShopItemBuyDetailCell.AssetName = "ItemBuyDetailCell"

function ShopItemBuyDetailCell:Ctor(...)
  ShopItemBuyDetailCell.super.Ctor(self, ...)
end

function ShopItemBuyDetailCell:OnCreate()
  self._buyDetail = self:GetChild("Detail")
end

function ShopItemBuyDetailCell:OnDestroy()
end

function ShopItemBuyDetailCell:RefreshCell(data)
  local buyDetail = ""
  if data.id > 10000 then
    local item = Item.Create(data.id)
    buyDetail = buyDetail .. item:GetName() .. "X" .. data.num
  end
  self._buyDetail:SetText(buyDetail)
end

return ShopItemBuyDetailCell
