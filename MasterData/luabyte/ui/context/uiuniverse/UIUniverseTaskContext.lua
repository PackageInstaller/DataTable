-- baoruichang
local UIUniverseTaskContext = BaseClass("UIUniverseTaskContext", BaseContext)
local M = UIUniverseTaskContext
local tInsert = table.insert
local EActivityState = EnumConst.EActivityState

function M:Init()
end

function M:Open(activityId)
    -- 主活动id
    self.mainActivityId = activityId
    local relationIds = ConfigHelper.GetCfgPropByLua("activity", self.mainActivityId, "relationId")
    -- 任务活动id
    self._activityId = relationIds[1]
    -- 任务活动详细信息
    ActivityDataMgr:GetInstance():GetActivityRoleDatasAsyn(self._activityId, Bind(self, self._OnLoadTaskCallBack))
end

function M:_OnLoadTaskCallBack(cRoleActivitys)
    self.task = {}
    -- 任务
    local activityCopyTasks = ConfigHelper.GetCfgsByLua("activityCopyTask", {activityId=self._activityId})
    for _, activityCopyTask in pairs(activityCopyTasks) do
        local CRoleActivity = self:_GetCRoleActivity(cRoleActivitys, activityCopyTask.id)
        local data = {}
        data.activityCopyTask = activityCopyTask
        if CRoleActivity then
            data.state = CRoleActivity.State
            data.value = CRoleActivity.Value0
            if data.state == EActivityState.Doing then
                data.sortIndex = 2
            elseif data.state == EActivityState.Finished then
                data.sortIndex = 3
            else
                data.sortIndex = 1
            end
        else
            data.state = 0
            data.value = 0
            data.sortIndex = 2
        end
        tInsert(self.task, data)
    end
    self:_Show()
end

function M:_GetCRoleActivity(CRoleActivitys, subActivityId)
    for _, CRoleActivity in pairs(CRoleActivitys) do
        if CRoleActivity.SubActivityId == subActivityId then
            return CRoleActivity
        end
    end
end

function M:GetTaskData()
    return self.task or {}
end

-- 请求新的任务信息
function M:GetNewTaskData()
    self.task = {}
    local data = ActivityDataMgr:GetInstance():GetActivityData(self._activityId)
    local cRoleActivitys = data:RoleActivity()
    local activityCopyTasks = ConfigHelper.GetCfgsByLua("activityCopyTask", {activityId=self._activityId})
    for _, activityCopyTask in pairs(activityCopyTasks) do
        local CRoleActivity = self:_GetCRoleActivity(cRoleActivitys, activityCopyTask.id)
        local data = {}
        data.activityCopyTask = activityCopyTask
        if CRoleActivity then
            data.state = CRoleActivity.State
            data.value = CRoleActivity.Value0
            if data.state == EActivityState.Doing then
                data.sortIndex = 2
            elseif data.state == EActivityState.Finished then
                data.sortIndex = 3
            else
                data.sortIndex = 1
            end
        else
            data.state = 0
            data.value = 0
            data.sortIndex = 2
        end
        tInsert(self.task, data)
    end
    self:GetCtrl():RefTaskList()
end

function M:GetActivityId()
    return self._activityId or 0
end

function M:OnClose()
    M.super.OnClose(self)
end

return UIUniverseTaskContext
