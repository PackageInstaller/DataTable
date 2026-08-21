local FirseRechargeRedPointChecker = BaseClass("FirseRechargeRedPointChecker",
    require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = FirseRechargeRedPointChecker

function M:__init()
    self.dataCenterId = { EGetterID.RechargeData }
end

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end

    self.checkResult = RechargeDataMgr:GetInstance():GetFirstRechargeRedPoint()
end

return FirseRechargeRedPointChecker
