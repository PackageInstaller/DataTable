local ShopUIContext = BaseClass("ShopUIContext", BaseContext)
local M = ShopUIContext

function M:__init()
end

function M:_Destory()
    M.super._Destory(self)
end

function M:Open(shopType, rechargeType, shopItemId)
    self._shopType = shopType 
    self._rechargeType = rechargeType
    self._shopItemId = shopItemId
    OtakuFurniturDataMgr:GetFurnituresByPage(-1, Bind(self, self.GetFurnitureDataCallBack))
end

function M:OnClose()
    M.super.OnClose(self)
end

function M:GetFurnitureDataCallBack(data)
    ShopDataMgr:RequestEnterShop(self._shopType, self._rechargeType, Bind(self, self.EnterShopCallBack))
end

function M:EnterShopCallBack(shopType, rechargeType)
    self:_Show( shopType, rechargeType , self._shopItemId)
end

return ShopUIContext
