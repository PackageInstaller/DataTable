local ShopBagTypeRedPointChecker = BaseClass("ShopBagTypeRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = ShopBagTypeRedPointChecker

function M:__init()
    self.dataCenterId = { EGetterID.ShopData }
end

function M:Check(type)
    if not self:OnChanged(type) then
        return
    end

    self.checkResult = ShopDataMgr:CheckShopBagTypeRedPoint(type) and 1 or 0
end

return ShopBagTypeRedPointChecker
