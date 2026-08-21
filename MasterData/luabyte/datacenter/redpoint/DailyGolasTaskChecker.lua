local DailyGolasTaskChecker = BaseClass("DailyGolasTaskChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = DailyGolasTaskChecker

function M:Check(day)
    if not self:OnChanged(day) then
        return
    end
    
    local data = ActivityDataMgr:GetInstance():GetActivityByType(ActivityType.DAILY_GOALS)
    if data == nil then 
        self.checkResult = 0
        return 
    end
    self._day = day;
    self._isReady = data:IsActivityReady()

    if self._isReady then 
        self:AsynCallBack(data);
        return
    end
    self.isChecking = true 
    DailyGolasDataMgr:GetInstance():GetActivityData(Bind(self, self.AsynCallBack))
end

function M:AsynCallBack(data)   
    self.checkResult = 0
    self.isChecking = false 
    local isShow = false

    if not data then
        return 
    end

    local curDay = ActivityHelper.CountDayByStartTime(data:StartTime())
    if curDay < self._day then
        return 
    end

    local activityId = data:ActivityId() 
    local data = data:RoleActivity()
    if not data then
        return 
    end
    
    if self._day > 0 then
        isShow = DailyGolasDataMgr:GetInstance():CurDayRedPoint(self._day, activityId, data)
    else
        isShow = DailyGolasDataMgr:GetInstance():AllRedPoint(curDay, activityId, data)
    end    
    
    self.checkResult = isShow and 1 or 0 

    -- 特别注释 * 因活动详情内容需要异步读取， 所以 (* 防止数据未到 红点判断先行 ) 这里特别处理 在第一次数据返回后 进行强制 check 如后续有方法解决 可干掉
    if not self._isReady then
        IRedPointMgr:NoScruplesCheckByType(RedPointConst.ThreeDayGoalAwardChecker)
    end
end

return DailyGolasTaskChecker