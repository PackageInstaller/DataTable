-- 长官笔记
local M = BaseClass("CommondNoticeRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end

    local isShow = ChiefNoteDataMgr:GetInstance():CheckRedPointById(param)
    self.checkResult = isShow and 1 or 0
end

return M
