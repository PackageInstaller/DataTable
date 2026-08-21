local ShopBoxRedPointChecker = BaseClass("ShopBoxRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = ShopBoxRedPointChecker

function M:__init()
    self.dataCenterId = { EGetterID.ShopData }
end

function M:Check(id)
    if not self:OnChanged(id) then
        return
    end
    self.checkResult = ShopDataMgr:CheckBoxRedPoint(id) and 1 or 0
end

return ShopBoxRedPointChecker
