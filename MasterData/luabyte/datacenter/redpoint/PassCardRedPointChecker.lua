local PassCardRedPointChecker = BaseClass("PassCardRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = PassCardRedPointChecker

function M:Check(day)
    if not self:OnChanged(day) then
        return
    end
    self.checkResult = 0
    -- self.checkResult = PassDataMgr:GetInstance():EnterPass() and 1 or 0
end

return PassCardRedPointChecker