local ShopUIContext = BaseClass("ExtremeShopContext", BaseContext)
local M = ShopUIContext

function M:__init()

end

function M:_Destory()
    M.super._Destory(self)
end

function M:Open()
    LimitDataMgr:GetInstance():RequestGetExtremeBattleBuyInfo(Bind(self, self.GetLimitShopDataCallBack))
end

function M:OnClose()
    M.super.OnClose(self)
end

function M:GetLimitShopDataCallBack(data)
    self.limitData = data
    self:_Show(data)
end

return ShopUIContext
