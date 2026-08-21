local ShopRedPointChecker = BaseClass("ShopRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = ShopRedPointChecker

function M:__init()
    self.dataCenterId = { EGetterID.ShopData }
end

function M:Check(shopItemId)
    if not self:OnChanged(shopItemId) then
        return
    end

    self.checkResult = ShopDataMgr:CheckNormalShopRedPoint(shopItemId) and 1 or 0
end

return ShopRedPointChecker
