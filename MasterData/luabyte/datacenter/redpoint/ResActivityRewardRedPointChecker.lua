local M = BaseClass("ResActivityRewardRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

function M:__init()
    self.dataCenterId = { EGetterID.ActivityData }
end

function M:Check()
    self.checkResult = 0
    self.isChecking = true
    ActivityDataMgr:GetInstance():GetActivitysByTypeAsyn(ActivityType.RES_ACTIVITY_COPY, function(datas)
        local actData = datas and datas[1] or nil
        if actData and actData:IsOpen() then
            local isToday = false
            for _, v in ipairs(actData:RoleActivity() or {}) do
                if v.SubActivityId == 0 then
                    isToday = TimeUtil.IsToday(v.Value1, TimeUtil.DailyRefreshTime)
                    break
                end
            end
            self.checkResult = isToday and 0 or 1
        end
        self.isChecking = false
    end)
end

return M
