local OtakuEaterRedPointChecker = BaseClass("OtakuEaterRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = OtakuEaterRedPointChecker

function M:__init()
    self.dataCenterId = {EGetterID.OtakuData}    
end

function M:Check(roomType)
    --显示所有舱室饱食度为0的总数
    self.checkResult = OtakuRedPointMgr.RommHerosEaters()
end

return OtakuEaterRedPointChecker
