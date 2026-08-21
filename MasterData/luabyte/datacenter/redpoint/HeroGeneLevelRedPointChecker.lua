-- 基因链红点
local M = BaseClass("HeroGeneLevelRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end
    if param == -1 then
        self.checkResult = 0
        return
    end
    local isShow = DevelopMgr:GetInstance():IsUpGeneLevelRedPoint(param)
    self.checkResult = isShow and 1 or 0
end

return M
