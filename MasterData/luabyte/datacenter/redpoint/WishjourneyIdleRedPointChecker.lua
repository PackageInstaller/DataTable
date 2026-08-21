--可开始远征红点
local M = BaseClass("WishjourneyIdleRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

function M:__init()
    self.dataCenterId = { EGetterID.OtakuData }
end

function M:Check()
    self.checkResult = OtakuRedPointMgr.SurveyIdleTask() and 1 or 0
end

return M
