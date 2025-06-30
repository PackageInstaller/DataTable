-- 没有考虑 进度点数
-- 没有考虑任务是否达到进度
-- 没有考虑新增删除任务(每日刷新)
-- 没有发奖励

local TaskMock = BaseClass("TaskMock", Singleton);

local TaskExcel = {
    [TaskType.TaskTypeMain] = Z_TaskMain,
    [TaskType.TaskTypeDaily] = Z_TaskDaily,
    [TaskType.TaskTypeWeekly] = Z_TaskWeekly,
    [TaskType.TaskTypeAchievement] = Z_TaskAchievement,
}

local mockData = {}

local function updateData(type, updateIds, removeIds)
    ---@type protocol.TaskUpdatePush
    local ret = {}

    ret.removeds = removeIds or {}
    ret.type = type
    ret.last_refresh_time = mockData[type].lastRefreshTime
    ret.task_stage = {}
    ret.task_stage.activity_point = mockData[type].activityPoint
    ret.task_stage.received_stage = mockData[type].receivedStage
    
    ret.tasks = {}
    for _, id in ipairs(updateIds) do
        table.insert(ret.tasks, mockData[type].tasks[id])
    end

    Game.Scene:GetComponent("MessageDispatcherComponent"):Handle(PROTOCOL.TaskUpdatePush, ret)
end

local function getReward(type, taskId)

    local excel = TaskExcel[type]
    if excel == nil then
        Logger.LogError("不存在的任务类型" .. type)
        return {}
    end
    local task = excel[taskId]
    if task == nil then
        Logger.LogError("不存在的任务: " .. "type ".. type .. " task_id " .. taskId)
        return {}
    end
    local rewardId = task.RewardId
    if Z_Reward[rewardId] == nil then
        Logger.LogError("不存在的奖励: " .. "type ".. type .. " task_id " .. taskId .. " reward_id " .. rewardId)
        return {}
    end

    local rewards = {}
    for index, value in ipairs(Z_Reward[rewardId]) do
        table.insert(rewards, {
            type = value.Type,
            id = value.ObjId,
            count = value.Count,
        })
    end

    return rewards
end

local function TaskPackReq(reqMsg)
    ---@type protocol.TaskPackResp
    local ret = {}
    ret.task_packs = {}
    for type, excel in pairs(TaskExcel) do
        ---@type protocol.TaskPack
        local taskPack = {}
        taskPack.type = type
        taskPack.tasks = {}
        mockData[type] = { tasks = {} }

        for _, value in pairs(excel) do
            if value.PreTaskId == 0 then -- 只含有 没有前置任务 的任务
                local task = {
                    id = value.Id,
                    status = math.random(1,10) > 7 and TaskStatus.TaskStatusCompleted or TaskStatus.TaskStatusProgressing,
                    progress = 0,
                }
                local target = tonumber(value.Params[#value.Params])
                if task.status == TaskStatus.TaskStatusProgressing then
                    task.progress = math.random(0, target - 1)
                else
                    task.progress = target
                end
                mockData[type].tasks[task.id] = task
                table.insert(taskPack.tasks, task)
            end
        end
        taskPack.task_stage = {}
        taskPack.task_stage.activity_point = 0
        taskPack.task_stage.received_stage = {}
        taskPack.last_refresh_time = 0

        mockData[type].lastRefreshTime = taskPack.last_refresh_time
        mockData[type].receivedStage = taskPack.task_stage.received_stage
        mockData[type].activityPoint = taskPack.task_stage.activity_point
        table.insert(ret.task_packs, taskPack)
    end

    return ret
end

---@param req protocol.TaskSubmitReq
local function TaskSubmitReq(req)
    ---@type protocol.TaskSubmitResp
    local ret = {}

    if mockData[req.type] == nil then
        Logger.LogError("不存在的任务类型" .. req.type)
        return {}
    end

    if mockData[req.type].tasks[req.task_id] == nil then
        Logger.LogError("不存在的任务: " .. "type ".. req.type .. " task_id " .. req.task_id)
        return {}
    end
    
    if mockData[req.type].tasks[req.task_id].status ~= TaskStatus.TaskStatusCompleted then
        Logger.LogError("任务未完成: " .. "type ".. req.type .. " task_id " .. req.task_id)
        return {}
    end

    mockData[req.type].tasks[req.task_id].status = TaskStatus.TaskStatusReceived

    updateData(req.type, {req.task_id})

    ret.type = req.type
    ret.task_id = req.task_id
    ret.reward_result = getReward(req.type, req.task_id)

    return ret
end

---@param req protocol.TaskSubmitAllReq
local function TaskSubmitAllReq(req)
    ---@type protocol.TaskSubmitAllResp
    local ret = {}
    
    if mockData[req.type] == nil then
        Logger.LogError("不存在的任务类型" .. req.type)
        return {}
    end
    
    local updateIds = {}
    for _, task in pairs(mockData[req.type].tasks) do
        if task.status == TaskStatus.TaskStatusCompleted then
            task.status = TaskStatus.TaskStatusReceived
            table.insert(updateIds, task.id)
        end
    end
    
    updateData(req.type, updateIds)

    ret.type = req.type
    ret.reward_result = {}

    for index, value in ipairs(updateIds) do
        local rewards = getReward(req.type, value)
        for _, reward in ipairs(rewards) do
            table.insert(ret.reward_result, reward)
        end
    end

    return ret
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.TaskPackReq, TaskPackReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.TaskSubmitReq, TaskSubmitReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.TaskSubmitAllReq, TaskSubmitAllReq)
end

local function __delete(self)
end

TaskMock.__init = __init
TaskMock.__delete = __delete


return TaskMock