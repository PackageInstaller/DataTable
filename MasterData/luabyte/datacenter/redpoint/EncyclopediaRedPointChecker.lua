-- 百科图鉴红点
local M = BaseClass("EncyclopediaRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end

    local isShow = PlotAtlasDataMgr:GetInstance():CheckEncyclopediaRedPointById(param)
    self.checkResult = isShow and 1 or 0
end

return M
