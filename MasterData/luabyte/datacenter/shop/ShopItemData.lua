local ShopItemData = BaseClass("ShopItemData")
local M = ShopItemData

function M:__init(shopItem, shopId)
    self.shopItem = shopItem
    self.shopId = shopId
    local type = ConfigHelper.GetCfgPropByLua("shop", shopId, "type")
    if type == ShopConst.ShopType.GiftPack then
        self.shopItemConfig = ConfigHelper.GetCfgByLua("shopBag", self.shopItem.ItemId)
    end

    if type == ShopConst.ShopType.Normal then
        self.shopItemConfig = ConfigHelper.GetCfgByLua("shopItem", self.shopItem.ItemId)
        self:CheckType()
    end

    if type == ShopConst.ShopType.Cloth then
        if shopItem then
            self.shopItemConfig = ConfigHelper.GetCfgByLua("shopSkin", self.shopItem.ItemId)
        else
            Logger.Log("[Cloth] shopItem is nil, shopId = " .. shopId)
            return
        end
    end

    self.Num = self.shopItem.BuyTimes
end

function M:UpdateData(shopItem)
    if self.shopItem then
        self.shopItem = shopItem
        self.Num = self.shopItem.BuyTimes
        self:CheckType()
    end
end

function M:CheckType(...)
    if self.shopItemConfig.finalNum == 0 then
        self.type = ShopConst.ShopItemType.Free
    elseif self.shopItemConfig.discount ~= 0 then
        self.type = ShopConst.ShopItemType.Discount
    else
        self.type = ShopConst.ShopItemType.Normal
    end
end

return ShopItemData
