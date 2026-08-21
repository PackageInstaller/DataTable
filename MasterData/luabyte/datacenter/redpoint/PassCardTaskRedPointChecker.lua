--通行证任务红点检测
local PassCardTaskRedPointChecker = BaseClass("PassCardTaskRedPointChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = PassCardTaskRedPointChecker

function M:__init()
    --checker 依赖的数据中心ID
    self.dataCenterId = {EGetterID.PassData}
end

function M:Check(id)
    if not self:OnChanged(id) then
        return
    end
    self.checkResult = PassDataMgr:GetInstance():CheckPassTaskRedPoint(id) and 1 or 0
end

return PassCardTaskRedPointChecker