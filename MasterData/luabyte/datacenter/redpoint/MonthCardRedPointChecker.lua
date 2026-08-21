local MonthCardRedPointChecker = BaseClass("MonthCardRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = MonthCardRedPointChecker

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end
end

return MonthCardRedPointChecker