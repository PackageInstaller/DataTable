-- 平行宇宙红点
local ActivityCopyTaskRedPointChecker = BaseClass("ActivityCopyTaskRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = ActivityCopyTaskRedPointChecker

function M:Check(param)
    if param <= 0 then
        self.checkResult = 0
        return
    end
    if not self:OnChanged(param) then
        return
    end
    local openCondition = ConfigHelper.GetCfgPropByLua("activity", param, "openCondition")
    local isUnlock = JumpMgr:GetInstance():CheckLockByOpenConditionIds(openCondition)
    if not isUnlock then
        self.checkResult = 0
        return
    end
    self.isChecking = true
    ActivityCopyDataMgr:GetInstance():CheckTaskRedPointById(param, Bind(self, self.AsynCallBack))
end

function M:AsynCallBack(data)
    self.isChecking = false
    self.checkResult = data and 1 or 0
end
return ActivityCopyTaskRedPointChecker
