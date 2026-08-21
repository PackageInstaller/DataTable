-- 签到类型(4类型主动弹出检测)
local M = BaseClass("OpenLoginReward", BaseJumpCommand)
local HOURS5 = 18000
local tSort = table.sort

function M:Execute()
    if IGuideMgr.IsGuiding then
        CommandMgr:GetInstance():FinishExcute()
        return
    end
    local module = ModuleMgr:GetInstance():GetCurrentModule()
    if module.moduleId ~= ModuleConfig.MainSceneModule.id then
        CommandMgr:GetInstance():FinishExcute()
        return
    end
    self:_LoadSimpleDatas()
end

function M._SortFunc(data1, data2)
    return data1:ActivityId() < data2:ActivityId()
end

function M:_LoadSimpleDatas()
    self.signActivityDatas = ActivityDataMgr:GetInstance():GetActivitySimpleByType(ActivityType.SIGN)
    tSort(self.signActivityDatas, self._SortFunc)
    self.selectActivityIndex = 0
    self:_NextActivity()
end

function M:_NextActivity()
    self.selectActivityIndex = self.selectActivityIndex + 1
    if self.selectActivityIndex > #self.signActivityDatas then
        CommandMgr:GetInstance():FinishExcute()
        return
    end
    local activityData = self.signActivityDatas[self.selectActivityIndex]
    local activityId = activityData:ActivityId()
    ActivityDataMgr:GetInstance():GetActivityRoleDatasAsyn(activityId, Bind(self, self._OpenLoginSignActivity, activityId))
end

function M:_OpenLoginSignActivity(activityId, roleActivitys)
    roleActivitys = roleActivitys or {}
    local roleActivity = roleActivitys[1]
    local nowTimer = TimeUtil.GetNowTimeStamp()
    local activityLogins = ConfigHelper.GetCfgsByLua("activityLogin", {activityId=activityId})
    local dataNum = #activityLogins
    if not roleActivity then
        local ui = ConfigHelper.GetCfgPropByLua("activity", activityId, "prefabPath")
        UIContextMgr:GetInstance():Show(ui, activityId, Bind(self, self._NextActivity))
        return
    end
    -- 可以签到并且今天还没有签到
    if roleActivity.Value0 < dataNum and not TimeUtil.IsOneDay(nowTimer - HOURS5, roleActivity.Value1 - HOURS5) then
        UIContextMgr:GetInstance():Show(UIDefine.UIActivity, activityId, Bind(self, self._NextActivity))
        return
    end
    self:_NextActivity()
end

return M
