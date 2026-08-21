local NoticeActiveRedPointChecker = BaseClass("NoticeActiveRedPointChecker",
    require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = NoticeActiveRedPointChecker

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end

    self.checkResult = INoticeDataMgr:CheckNoticeRedPoindByType(param) and 1 or 0
end

return NoticeActiveRedPointChecker
