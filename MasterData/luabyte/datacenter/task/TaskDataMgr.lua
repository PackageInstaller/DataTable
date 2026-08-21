local TaskDataMgr = BaseClass("TaskDataMgr")
local M = TaskDataMgr
local MessageId = Proto.MessageId
local tInsert = table.insert
local tIsNullOrEmpty = table.isNullOrEmpty
local CS_RedPointConst = CS.GameX.RedPointConst
-- 任务类型  1=指南 2=日常 3=周常 4=挑战 5=成就 6=远征任务 7=宿舍入驻任务 8=小剧场任务 9=觉醒任务

function M:__init(obj)
    self._responeLoadTask = NetPack:RegistResponse(MessageId.ResponseLoadTask, Bind(self, self.OnResponseLoadTask))
    self._responeLoadTaskByType = NetPack:RegistResponse(MessageId.ResponseLoadTaskByType, Bind(self, self.OnResponseLoadTaskByType))
    self._notifyUpdateTask = NetPack:RegistResponse(MessageId.NotifyUpdateTask, Bind(self, self.OnNotifyUpdateTask))
    self._notifyUpdateTasks = NetPack:RegistResponse(MessageId.NotifyUpdateTasks, Bind(self, self.OnNotifyUpdateTasks))
    self._responseCompleteTask = NetPack:RegistResponse(MessageId.ResponseCompleteTask, Bind(self, self.OnResponseCompleteTask))
    self._responseCompleteTasks = NetPack:RegistResponse(MessageId.ResponseCompleteTasks, Bind(self, self.OnResponseCompleteTasks))
    self._notifyCompleteActivity = NetPack:RegistResponse(MessageId.ResponseActivityAward, Bind(self, self.OnResponseActivityAward))
    self._notifyCompleteActivities = NetPack:RegistResponse(MessageId.ResponseActivityAwards, Bind(self, self.OnResponseActivityAwards))
    self._notifyRoleTask = NetPack:RegistResponse(MessageId.NotifyRoleTask, Bind(self, self.OnNotifyRoleTask))
    self._onFiveClockNotifyEvent = EventMgr:AddListener(UIMessageNames.FIVE_CLOCK_NOTIFY, Bind(self, self.OnFiveClockNotifyEvent))

    self._taskDataDict = {}
    self._guideLevelsData = nil
    self._dailyActivitiesData = nil
    self._weeklyActivitiesData = nil
    self._completeTaskCallback = nil
    self._hasActivityAward = nil
    self._taskAwards = nil
    -- self._taskIds = nil
    self._loadTaskByTypeCallback = nil
end

function M:Dispose()
    NetPack:UnRegistResponse(MessageId.ResponseLoadTask, self._responeLoadTask)
    NetPack:UnRegistResponse(MessageId.NotifyUpdateTask, self._notifyUpdateTask)
    NetPack:UnRegistResponse(MessageId.NotifyUpdateTasks, self._notifyUpdateTasks)
    NetPack:UnRegistResponse(MessageId.ResponseCompleteTask, self._responseCompleteTask)
    NetPack:UnRegistResponse(MessageId.ResponseCompleteTasks, self._responseCompleteTasks)
    NetPack:UnRegistResponse(MessageId.ResponseActivityAward, self._notifyCompleteActivity)
    NetPack:UnRegistResponse(MessageId.ResponseActivityAwards, self._notifyCompleteActivities)
    NetPack:UnRegistResponse(MessageId.NotifyRoleTask, self._notifyRoleTask)
    NetPack:UnRegistResponse(MessageId.ResponseLoadTaskByType, self._responeLoadTaskByType)

    EventMgr:RemoveListener(UIMessageNames.FIVE_CLOCK_NOTIFY, self._onFiveClockNotifyEvent)

    self._taskDataDict = nil
    self._guideLevelsData = nil
    self._dailyActivitiesData = nil
    self._weeklyActivitiesData = nil
    self._completeTaskCallback = nil
    self._hasActivityAward = nil
    self._taskAwards = nil
    -- self._taskIds = nil
    self._loadTaskByTypeCallback = nil
end

function M:Cleanup()
end

---------------------初始化数据Begin----------------------

-- IDataGetter start 
-- 用于在登录的时候初始化相关数据
function M:LoadData()
    self._isloading = true
    self._dataLoaded = false
    self._errorCode = 0

    self:_InitTasksData()
    self:_InitDailyActivitiesData()
    self:_InitWeeklyActivitiesData()
    self:RequestLoadTask()
end

function M:IsLoading()
    return self._isloading
end

function M:IsReady()
    return self._dataLoaded
end

function M:ErrorCode()
    return self._isloading
end

-- IDataGetter end 

-- 初始化任务数据
function M:_InitTasksData()
    local taskCfgs = ConfigHelper.GetCfgsByLua("task")

    if not taskCfgs then
        return
    end

    for key, taskCfg in pairs(taskCfgs) do
        local type = taskCfg.type

        if not self._taskDataDict[type] then
            self._taskDataDict[type] = {}
        end
        -- 为什么此处默认让所有任务都完成 TaskConst.TaskState.Doing ？？？ 我改成未完成  By Xiaokun
        taskCfg.state = TaskConst.TaskState.Doing
        taskCfg.isGet = false
        taskCfg.value0 = 0
        taskCfg.value1 = 0
        tInsert(self._taskDataDict[type], taskCfg)
    end
end

-- 初始化主线数据
function M:_InitGuideLevelsData()
    self._guideLevelsData = {}
    local cfgs = ConfigHelper.GetCfgsByLua("mainTask")

    if tIsNullOrEmpty(cfgs) then
        return
    end

    for i = 1, #cfgs do
        local data = cfgs[i]
        local uiState = self:_GetUIState(data.task, data.level)
        data.uiState = uiState
        data.select = false
        tInsert(self._guideLevelsData, data)
    end

    self:_UpdateGuideLevelStates()
    self:_SetSelectGuideLevel()
end


-- 初始化日常活跃度数据
function M:_InitDailyActivitiesData()
    local cycleType = protocol.ECycleEvent.ECET_Daily_Task
    local cycleData = CycleDataMgr:GetInstance():GetCycleDataByType(cycleType)
    local currentValue = cycleData:GetField0()
    local increment = self:GetDailyActivitiesUpperLimit()
    self._dailyActivitiesData = {}
    local dailyCfgs = ConfigHelper.GetCfgsByLua("taskActive", {type=1})

    for i = 1, #dailyCfgs do
        local id = i
        local value = dailyCfgs[i].activeValue
        local upper = increment[i] == nil and 0 or increment[i]
        local reward = dailyCfgs[i].activeReward
        local uiState = self:_GetDailyActivityUIState(i, currentValue, value + upper)

        local data = {id=id, value=value, increment=upper, reward=reward, uiState=uiState}
        tInsert(self._dailyActivitiesData, data)
    end
end

-- 初始化周常活跃度数据
function M:_InitWeeklyActivitiesData()
    local cycleType = protocol.ECycleEvent.ECET_Weekly_Task
    local cycleData = CycleDataMgr:GetInstance():GetCycleDataByType(cycleType)
    local currentValue = cycleData:GetField0()
    local increment = self:GetWeeklyActivitiesUpperLimit()
    self._weeklyActivitiesData = {}
    local weeklyCfgs = ConfigHelper.GetCfgsByLua("taskActive", {type=2})

    for i = 1, #weeklyCfgs do
        local id = i
        local upper = increment[i] == nil and 0 or increment[i]
        local value = weeklyCfgs[i].activeValue
        local reward = weeklyCfgs[i].activeReward
        local uiState = self:_GetWeeklyActivityUIState(i, currentValue, value + upper)
        local data = {id=id, value=value, increment=upper, reward=reward, uiState=uiState}
        tInsert(self._weeklyActivitiesData, data)
    end
end

---------------------初始化数据End----------------------

---------------------网络消息Begin----------------------

function M:RequestLoadTask()
    --  taskId = 0 时，服务器会返回以下协议列表
    --  MainTask 主线、EDailyTask 日常 、 EWeeklyTask 常周 、EChallenge 挑战任务 、 EDorm 宿舍入驻任务
    NetPack:SendMessage(MessageId.RequestLoadTask, {})
end

function M:OnResponseLoadTask(messageId, result, msg)
    self._errorCode = result
    self._dataLoaded = true
    self._isloading = false

    if result ~= 0 then
        return
    end

    local tasksData = msg.Data

    for i = 1, #tasksData do
        local data = self:GetTaskData(tasksData[i].Type, tasksData[i].TaskId)

        if data then
            data.state = tasksData[i].State
            data.value0 = tasksData[i].Value0
            data.value1 = tasksData[i].Value1
            data.isGet = true
        end
    end

    for i = 1, #msg.Finished do
        local data = self:GetTaskData(TaskConst.TaskType.Menu, msg.Finished[i])

        if data then
            data.state = TaskConst.TaskState.TaskComplete
            data.value0 = data.limitValue1
        end
    end

    for i = 1, 4 do
        TaskHelper.Sort(self._taskDataDict[i])
    end

    self:_InitGuideLevelsData()
end

function M:RequestLoadTaskByType(type, callBack)
    self._loadTaskByTypeCallback = callBack
    local request = {}
    request.Type = type
    NetPack:SendMessage(MessageId.RequestLoadTaskByType, request)
end

function M:OnResponseLoadTaskByType(messageId, result, msg)
    if result ~= 0 then
        return
    end

    local tasksData = msg.Data

    for i = 1, #tasksData do
        local data = self:GetTaskData(tasksData[i].Type, tasksData[i].TaskId)

        if data then
            data.state = tasksData[i].State
            data.value0 = tasksData[i].Value0
            data.value1 = tasksData[i].Value1
            data.isGet = true
        end
    end

    for i = 1, #msg.Finished do
        local data = self:GetTaskData(msg.Type, msg.Finished[i])

        if data then
            data.state = TaskConst.TaskState.TaskComplete
            data.value0 = data.limitValue1
            data.isGet = true
        end
    end

    TaskHelper.Sort(self._taskDataDict[msg.Type])

    if self._loadTaskByTypeCallback then
        self._loadTaskByTypeCallback()
        self._loadTaskByTypeCallback = nil
    end
end

function M:RequestActivityAward(index, type)
    local request = {}
    request.Idx = index
    request.Type = type
    NetPack:SendMessage(MessageId.RequestActivityAward, request)
end

function M:OnResponseActivityAward(messageId, result, msg)
    if result ~= 0 then
        return
    end

    GameHelper.ShowGetItemsByItems(msg.Awards, nil)

    if msg.Type == TaskConst.EACTType.EACT_Daily then
        self:_UpdateDailyActivityData(msg.Idx)
    elseif msg.Type == TaskConst.EACTType.EACT_Weekly then
        self:_UpdateWeeklyActivityData(msg.Idx)
    end

    EventMgr:Broadcast(UIMessageNames.TASK_AWARD_REFRESH, msg.Type)

    RedPointMgr:GetInstance():ForceCheck(RedPointConst.TaskRedChecker)
    RedPointMgr:GetInstance():ForceCheck(RedPointConst.TaskChestAwardRedPointChecker)
end

function M:RequestActivityAwards(type)
    local request = {}
    request.Type = type
    NetPack:SendMessage(MessageId.RequestActivityAwards, request)
end

function M:OnResponseActivityAwards(messageId, result, msg)
    if result ~= 0 then
        return
    end

    local type = TaskConst.TaskType.Daily

    if msg.Type == TaskConst.EACTType.EACT_Daily then
        type = TaskConst.TaskType.Daily
        self:_UpdateDailyActivityDatas()
    elseif msg.Type == TaskConst.EACTType.EACT_Weekly then
        type = TaskConst.TaskType.Weekly
        self:_UpdateWeeklyActivityDatas()
    end

    local taskIds = self:GetRewardTaskIdsByType(type)

    if taskIds then
        self._taskAwards = msg.Awards
        self:RequestCompleteTasks(taskIds)
    else
        local awards = self:_GetItemDictByItems(msg.Awards)
        GameHelper.ShowGetItems(awards, nil)
    end

    EventMgr:Broadcast(UIMessageNames.TASK_AWARD_REFRESH, msg.Type)
    RedPointMgr:GetInstance():ForceCheck(RedPointConst.TaskChestAwardRedPointChecker)
    RedPointMgr:GetInstance():ForceCheck(RedPointConst.TaskRedChecker)
end

function M:OnNotifyRoleTask(messageId, result, msg)
    if result ~= 0 then
        return
    end

    local data = msg.data

    if data and #data > 0 then
        for i = 1, #data do
            self:_UpdateTask(data[i].TaskId, TaskConst.Opt.DB_UPDATE, data[i])
        end
    end
end

-- 完成任务、领奖
function M:RequestCompleteTask(taskId, callback)
    self._completeTaskCallback = callback
    local request = {}
    request.TaskId = taskId
    NetPack:SendMessage(MessageId.RequestCompleteTask, request)
end

function M:OnResponseCompleteTask(messageId, result, msg)
    if result ~= 0 then
        self._completeTaskCallback = nil
        return
    end

    GameHelper.ShowGetItemsByItems(msg.Awards, nil)
    self:_UpdateTask(msg.TaskId, TaskConst.Opt.DB_COMPLETE)

    if self._completeTaskCallback then
        self._completeTaskCallback(msg)
        self._completeTaskCallback = nil
    end

    RedPointMgr:ForceCheck(CS_RedPointConst.TaskRedChecker)
    -- 任务埋点
    local type = self:_GetTaskType(msg.TaskId)
    local dataValues = {type, msg.TaskId}
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Task, dataValues)
end

function M:RequestCompleteTasks(taskIds)
    local request = {}

    if #taskIds > 10 then
        request.TaskId = table.intercept(taskIds, 1, 10)
        -- self._taskIds = table.intercept(taskIds, 11, #taskIds)
    else
        request.TaskId = taskIds
    end

    NetPack:SendMessage(MessageId.RequestCompleteTasks, request)
end

-- 支持最多20个一键领取奖励（不包含活跃度奖励）
function M:OnResponseCompleteTasks(messageId, result, msg)
    if result ~= 0 then
        self._taskAwards = nil
        -- self._taskIds = nil
        return
    end

    local taskIds = msg.TaskId
    local type = self:_GetTaskType(taskIds[1])
    self:_UpdateCompleteTasksData(taskIds)

    if not tIsNullOrEmpty(msg.Awards) then
        if not tIsNullOrEmpty(self._taskAwards) then
            for i = 1, #msg.Awards do
                tInsert(self._taskAwards, msg.Awards[i])
            end
        else
            self._taskAwards = msg.Awards
        end
    end

    local awards = self:_GetItemDictByItems(self._taskAwards)
    self._taskAwards = nil
    GameHelper.ShowGetItems(awards, nil)

    EventMgr:Broadcast(UIMessageNames.TASK_TYPE_REFRESH, type)
    RedPointMgr:ForceCheck(CS_RedPointConst.TaskRedChecker)
    -- 任务埋点
    local strTaskId
    for k, taskId in pairs(taskIds) do
        if not strTaskId then
            strTaskId = tostring(taskId)
        else
            strTaskId = strTaskId .. "," .. taskId
        end
    end
    local dataValues = {type, strTaskId}
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Task, dataValues)
end

-- 通知单条任务数据
-- msg.Opt：0=更新 1=增加 2=删除
function M:OnNotifyUpdateTask(messageId, result, msg)
    if result ~= 0 then
        Logger.LogError("OnNotifyUpdateTask error")
        return
    end

    self:_UpdateTask(msg.Task.TaskId, msg.Opt, msg.Task)
end

function M:OnNotifyUpdateTasks(messageId, result, msg)
    if result ~= 0 then
        Logger.LogError("OnNotifyUpdateTasks error")
        return
    end

    for i = 1, #msg.Data do
        self:_UpdateTask(msg.Data[i].TaskId, msg.Opt, msg.Data[i])
    end
end

---------------------网络消息End----------------------

---------------------事件监听Begin--------------------

function M:OnFiveClockNotifyEvent()
    self:RequestLoadTaskByType(TaskConst.TaskType.Daily, function()
        EventMgr:Broadcast(UIMessageNames.TASK_TYPE_REFRESH, TaskConst.TaskType.Daily)
        EventMgr:Broadcast(UIMessageNames.TASK_AWARD_REFRESH, TaskConst.EACTType.Daily)
    end)

    if TimeUtil.IsMonday() then
        self:RequestLoadTaskByType(TaskConst.TaskType.Weekly, function()
            EventMgr:Broadcast(UIMessageNames.TASK_TYPE_REFRESH, TaskConst.TaskType.Weekly)
            EventMgr:Broadcast(UIMessageNames.TASK_AWARD_REFRESH, TaskConst.EACTType.EACT_Weekly)
        end)
    end
end

---------------------事件监听End----------------------

---------------------设置数据Begin--------------------

function M:SetGuideLevelDatas(data)
    self._guideLevelsData = data
end


function M:SetGuideLevelToUnlock()
    local hasUnlock = false

    for i = 1, #self._guideLevelsData do
        if self._guideLevelsData[i].uiState == TaskConst.TaskUIState.Unlock then
            self._guideLevelsData[i].select = true
            hasUnlock = true
        else
            self._guideLevelsData[i].select = false
        end
    end

    if not hasUnlock then
        for i = #self._guideLevelsData, 1, -1 do
            if self._guideLevelsData[i].uiState == TaskConst.TaskUIState.Complete then
                self._guideLevelsData[i].select = true
                return
            end
        end
    end
end

function M:_UpdateDailyActivityData(index)
    if self._dailyActivitiesData and #self._dailyActivitiesData > 0 then
        local id = index + 1

        for i = 1, #self._dailyActivitiesData do
            if self._dailyActivitiesData[i].id == id then
                self._dailyActivitiesData[i].uiState = TaskConst.TaskUIState.Complete
            end
        end
    end
end

function M:_UpdateWeeklyActivityData(index)
    if self._weeklyActivitiesData and #self._weeklyActivitiesData > 0 then
        local id = index + 1

        for i = 1, #self._weeklyActivitiesData do
            if self._weeklyActivitiesData[i].id == id then
                self._weeklyActivitiesData[i].uiState = TaskConst.TaskUIState.Complete
            end
        end
    end
end

function M:_UpdateDailyActivityDatas()
    if self._dailyActivitiesData and #self._dailyActivitiesData > 0 then
        for i = 1, #self._dailyActivitiesData do
            if self._dailyActivitiesData[i].uiState ~= TaskConst.TaskUIState.Complete then
                self._dailyActivitiesData[i].uiState = TaskConst.TaskUIState.Complete
            end
        end
    end
end

function M:_UpdateWeeklyActivityDatas()
    if self._weeklyActivitiesData and #self._weeklyActivitiesData > 0 then
        for i = 1, #self._weeklyActivitiesData do
            if self._weeklyActivitiesData[i].uiState ~= TaskConst.TaskUIState.Complete then
                self._weeklyActivitiesData[i].uiState = TaskConst.TaskUIState.Complete
            end
        end
    end
end

function M:_SetSelectGuideLevel()
    if self._guideLevelsData then
        for i = #self._guideLevelsData, 1, -1 do
            if self._guideLevelsData[i].uiState == TaskConst.TaskUIState.Unlock then
                self._guideLevelsData[i].select = true
            end
        end
    end
end

function M:_UpdateGuideLevelStates()
    for i = #self._guideLevelsData, 1, -1 do
        if self._guideLevelsData[i].uiState == TaskConst.TaskUIState.Complete then
            return
        end

        if self._guideLevelsData[i].uiState == TaskConst.TaskUIState.Unlock then
            local preData = self:_GetGuideLevelData(i - 1)

            if preData and preData.uiState == TaskConst.TaskUIState.Unlock then
                if self._guideLevelsData[i].level <= IPlayerData.level then
                    self._guideLevelsData[i].uiState = TaskConst.TaskUIState.Lock_PreTaskNotComplete
                else
                    self._guideLevelsData[i].uiState = TaskConst.TaskUIState.Lock_Level
                end
            end
        end
    end
end

function M:UpdateGuideStates()
    if not self._guideLevelsData then
        return
    end

    local mainTaskCfgs = ConfigHelper.GetCfgs("mainTask")

    for i = 1, #mainTaskCfgs do
        local task = mainTaskCfgs[i].task
        local level = mainTaskCfgs[i].level
        local uiState = self:_GetUIState(task, level)
        self._guideLevelsData[i].uiState = uiState
    end

    self:_UpdateGuideLevelStates()
end

function M:_UpdateCompleteTasksData(ids)
    local type = self:_GetTaskType(ids[1])

    if type and self._taskDataDict[type] then
        local len = #self._taskDataDict[type]

        for i = 1, len do
            for j = 1, #ids do
                if self._taskDataDict[type][i].id == ids[j] then
                    self._taskDataDict[type][i].state = TaskConst.TaskState.TaskComplete
                end
            end
        end

        TaskHelper.Sort(self._taskDataDict[type])
    end
end

-- 更新任务数据
function M:_UpdateTask(id, opt, taskMsg)
    local cfg = ConfigHelper.GetCfgByLua("task", id)

    if not cfg then
        return
    end

    local type = cfg.type
    local data = self:GetTaskData(type, id)

    if opt == TaskConst.Opt.DB_UPDATE then
        -- 更新
        if not data then
            return
        end

        data.state = taskMsg.State
        data.value0 = taskMsg.Value0
        data.value1 = taskMsg.Value1
        data.isGet = true
    elseif opt == TaskConst.Opt.DB_ADD then
        -- 增加
        if data then
            return
        end

        if not self._taskDataDict[type] then
            self._taskDataDict[type] = {}
        end

        data = ConfigHelper.GetCfgByLua("task", id)
        data.state = taskMsg.State
        data.value0 = taskMsg.Value0
        data.value1 = taskMsg.Value1
        tInsert(self._taskDataDict[type], data)
    elseif opt == TaskConst.Opt.DB_COMPLETE then
        -- 完成
        if not data then
            return
        end

        data.state = TaskConst.TaskState.TaskComplete
        data.value0 = data.limitValue1
        local recordType = nil

        if type == TaskConst.TaskType.Guide then
            recordType = EGameKeyNode.CommanderTasksRewarded
        elseif type == TaskConst.TaskType.Daily then
            recordType = EGameKeyNode.DailyTasksRewarded
        elseif type == TaskConst.TaskType.Weekly then
            recordType = EGameKeyNode.WeekTasksRewarded
        elseif type == TaskConst.TaskType.Challenge then
            recordType = EGameKeyNode.ChallengeTasksRewarded
        end

        GameKeyNodeMgr:GetInstance():Record(recordType)
    end

    if type == TaskConst.TaskType.Guide then
        self:UpdateGuideStates()
    end

    TaskHelper.Sort(self._taskDataDict[type])
    EventMgr:Broadcast(UIMessageNames.TASK_TYPE_REFRESH, type)
end

---------------------设置数据End----------------------

---------------------获取数据Begin--------------------

function M:GetAwakeDoingTaskId(heroId)
    local cfgs = ConfigHelper.GetCfgsByLua("heroAwake", {heroId=heroId})

    if not tIsNullOrEmpty(cfgs) then
        for i = 1, #cfgs do
            local taskId = cfgs[i].task

            if taskId > 0 then
                local data = self:GetTaskData(TaskConst.TaskType.Awake, taskId)

                if data == nil then
                    return nil
                end
                if data.isGet and data.state == TaskConst.TaskState.Doing then
                    return data.id
                end
            end
        end
    end
    return nil
end

function M:_GetItemDictByItems(awards)
    if not tIsNullOrEmpty(awards) then
        local awardsDict = {}

        for i = 1, #awards do
            if not awardsDict[awards[i].Id] then
                awardsDict[awards[i].Id] = awards[i].Cnt
            else
                awardsDict[awards[i].Id] = awardsDict[awards[i].Id] + awards[i].Cnt
            end
        end
        return awardsDict
    end
    return nil
end

-- 获得某类型所有任务数据
function M:GetTasksDataByType(type)
    if self._taskDataDict and self._taskDataDict[type] then
        return self._taskDataDict[type]
    end
    return nil
end

-- 获得某类型解锁的任务数据
function M:GetUnLockTasksDataByType(type)
    if self._taskDataDict and self._taskDataDict[type] then
        local result = {}
        for k, v in pairs(self._taskDataDict[type]) do
            -- body
            if GameHelper.CheckLockByOpenConditionIds(v.openCondition) then
                tInsert(result, v)
            end
        end
        return result
    end
    return nil
end

function M:GetRewardTaskIdsByType(type)
    local data = self:GetTasksDataByType(type)
    local taskIds = nil

    if data then
        for i = 1, #data do
            if data[i].state == TaskConst.TaskState.MissionComplete then
                if taskIds == nil then
                    taskIds = {}
                end

                tInsert(taskIds, data[i].id)
            end
        end
    end
    return taskIds
end

-- 获取等待领奖的日常活跃度Ids
function M:GetRewardDailyActivityIds()
    local idList = nil

    if self._dailyActivitiesData then
        for i = 1, #self._dailyActivitiesData do
            if self._dailyActivitiesData[i].uiState == TaskConst.TaskUIState.Unlock then
                if idList == nil then
                    idList = {}
                end

                tInsert(idList, self._dailyActivitiesData[i].id)
            end
        end
    end
    return idList
end

-- 获取等待领奖的周常活跃度Ids
function M:GetRewardWeeklyActivityIds()
    local idList = nil

    if self._weeklyActivitiesData then
        for i = 1, #self._weeklyActivitiesData do
            if self._weeklyActivitiesData[i].uiState == TaskConst.TaskUIState.Unlock then
                if idList == nil then
                    idList = {}
                end

                tInsert(idList, self._weeklyActivitiesData[i].id)
            end
        end
    end
    return idList
end

function M:GetGuideLevelsData()
    return self._guideLevelsData
end

function M:GetSelectGuideLevelData()
    if self._guideLevelsData then
        for i = 1, #self._guideLevelsData do
            if self._guideLevelsData[i].select then
                return self._guideLevelsData[i]
            end
        end
    end
    return nil
end

function M:GetGuideTasksData(taskIds)
    local list = nil

    if taskIds then
        for i = 1, #taskIds do
            local data = self:GetTaskData(TaskConst.TaskType.Guide, taskIds[i])

            if not list then
                list = {}
            end

            tInsert(list, data)
        end
    end
    return list
end

-- 获取日常活跃度数据
function M:GetDailyActivitiesData()
    local cycleType = protocol.ECycleEvent.ECET_Daily_Task
    local cycleData = CycleDataMgr:GetInstance():GetCycleDataByType(cycleType)
    local currentValue = cycleData:GetField0()
    local increment = self:GetDailyActivitiesUpperLimit()
    if self._dailyActivitiesData == nil then
        return
    end
    for i = 1, #self._dailyActivitiesData do
        local value = self._dailyActivitiesData[i].value
        local upper = increment[i] == nil and 0 or increment[i]
        self._dailyActivitiesData[i].increment = upper
        local uiState = self:_GetDailyActivityUIState(i, currentValue, value + upper)
        self._dailyActivitiesData[i].uiState = uiState
    end
    return self._dailyActivitiesData
end

function M:GetDailyActivitiesUpperLimit()
    local dailyData = self:GetUnLockTasksDataByType(TaskConst.TaskType.Daily)
    local upper = {}
    if dailyData == nil then
        return upper
    end
    for k, v in pairs(dailyData) do
        if v.upActive then
            for i = 1, #v.upActive do
                if upper[i] == nil then
                    upper[i] = 0
                end
                upper[i] = upper[i] + v.upActive[i]
            end
        end
    end
    return upper
end

function M:GetDailyActivitiesUpperLimitMaxValue()
    local upper = self:GetDailyActivitiesUpperLimit()
    if upper == nil or #upper == 0 then
        return 0
    end
    return upper[#upper]
end

-- 获取周常活跃度数据
function M:GetWeeklyActivitiesData()
    local cycleType = protocol.ECycleEvent.ECET_Weekly_Task
    local cycleData = CycleDataMgr:GetInstance():GetCycleDataByType(cycleType)
    local currentValue = cycleData:GetField0()
    local increment = self:GetWeeklyActivitiesUpperLimit()
    if self._weeklyActivitiesData == nil then
        return
    end
    for i = 1, #self._weeklyActivitiesData do
        local value = self._weeklyActivitiesData[i].value
        local upper = increment[i] == nil and 0 or increment[i]
        self._weeklyActivitiesData[i].increment = upper
        local uiState = self:_GetWeeklyActivityUIState(i, currentValue, value + upper)
        self._weeklyActivitiesData[i].uiState = uiState
    end
    return self._weeklyActivitiesData
end

function M:GetWeeklyActivitiesUpperLimit()
    local weeklyData = self:GetUnLockTasksDataByType(TaskConst.TaskType.Weekly)
    local upper = {}
    if weeklyData == nil then
        return upper
    end
    for k, v in pairs(weeklyData) do
        if v.upActive then
            for i = 1, #v.upActive do
                if upper[i] == nil then
                    upper[i] = 0
                end
                upper[i] = upper[i] + v.upActive[i]
            end
        end
    end
    return upper
end

function M:GetWeeklyActivitiesUpperLimitMaxValue()
    local upper = self:GetWeeklyActivitiesUpperLimit()
    if upper == nil or #upper == 0 then
        return 0
    end
    return upper[#upper]
end

function M:_GetDailyActivityUIState(index, currentValue, value)
    local uiState = nil
    local cycleType = protocol.ECycleEvent.ECET_Daily_Task
    local cycleData = CycleDataMgr:GetInstance():GetCycleDataByType(cycleType)
    local complete = cycleData:GetIntegerSomeBit(index - 1) == 1

    if complete then
        uiState = TaskConst.TaskUIState.Complete
    else
        if currentValue < value then
            uiState = TaskConst.TaskUIState.Lock
        else
            uiState = TaskConst.TaskUIState.Unlock
        end
    end
    return uiState
end

function M:_GetWeeklyActivityUIState(index, currentValue, value)
    local uiState = nil
    local cycleType = protocol.ECycleEvent.ECET_Weekly_Task
    local cycleData = CycleDataMgr:GetInstance():GetCycleDataByType(cycleType)
    local complete = cycleData:GetIntegerSomeBit(index - 1) == 1

    if complete then
        uiState = TaskConst.TaskUIState.Complete
    else
        if currentValue < value then
            uiState = TaskConst.TaskUIState.Lock
        else
            uiState = TaskConst.TaskUIState.Unlock
        end
    end
    return uiState
end

function M:_GetUnlockGuideData()
    if self._guideLevelsData then
        for i = 1, #self._guideLevelsData do
            if self._guideLevelsData[i].uiState == TaskConst.TaskUIState.Unlock then
                return self._guideLevelsData[i]
            end
        end
    end
    return nil
end

function M:_GetGuideLevelData(index)
    if self._guideLevelsData and index > 0 and index <= #self._guideLevelsData then
        return self._guideLevelsData[index]
    end
    return nil
end

-- 获取任务状态
function M:GetState(type, taskId)
    local taskDatas = self:GetTasksDataByType(type)

    if taskDatas then
        for i = 1, #taskDatas do
            if taskDatas[i].id == taskId then
                return taskDatas[i].state
            end
        end
    end
    return nil
end

function M:_GetGuideLevelStateByTaskId(taskId)
    if self._guideLevelsData then
        for i = 1, #self._guideLevelsData do
            for j = 1, #self._guideLevelsData[i].task do
                if self._guideLevelsData[i].task[j] == taskId then
                    return self._guideLevelsData[i].uiState
                end
            end
        end
    end
    return nil
end

function M:GetCompleteState(taskId)
    if taskId then
        local type = self:_GetTaskType(taskId)
        local state = self:GetState(type, taskId)

        if type == TaskConst.TaskType.Guide then
            local uiState = self:_GetGuideLevelStateByTaskId(taskId)

            if uiState == TaskConst.TaskUIState.Complete or uiState == TaskConst.TaskUIState.Unlock then
                return state == TaskConst.TaskState.TaskComplete
            end
        else
            return state == TaskConst.TaskState.TaskComplete
        end
    end
    return false
end

function M:GetDoingState(taskId)
    if taskId then
        local type = self:_GetTaskType(taskId)
        local state = self:GetState(type, taskId)
        return state == TaskConst.TaskState.Doing
    end
    return false
end

function M:_GetUIState(taskIds, level)
    local completeNum = 0

    for i = 1, #taskIds do
        local taskData = self:GetTaskData(TaskConst.TaskType.Guide, taskIds[i])

        if taskData then
            if IPlayerData.level >= level then
                if taskData.state == TaskConst.TaskState.Doing or taskData.state == TaskConst.TaskState.MissionComplete then
                    return TaskConst.TaskUIState.Unlock
                elseif taskData.state == TaskConst.TaskState.TaskComplete then
                    completeNum = completeNum + 1
                end
            else
                return TaskConst.TaskUIState.Lock_Level
            end
        else
            return TaskConst.TaskUIState.Lock_Level
        end
    end

    if completeNum == #taskIds then
        return TaskConst.TaskUIState.Complete
    else
        return TaskConst.TaskUIState.Unlock
    end
end

function M:_GetTaskCfg(id)
    local taskCfg = ConfigHelper.GetCfgByLua("task", id)

    if not taskCfg then
        Logger.LogError("taskId " .. tostring(id) .. "cannot find")
    end
    return taskCfg
end

function M:_GetTaskType(id)
    local type = nil

    if self._taskDataDict then
        local taskCfg = self:_GetTaskCfg(id)

        if taskCfg then
            type = taskCfg.type
        end
    end
    return type
end

-- 获得同一类型所有任务 如果是0则获得所有任务
function M:GetAllTaskList()
    return self._taskDataDict
end

-- 获得同一类型所有任务 如果是0则获得所有任务
function M:GetTaskListByType(type)
    return self._taskDataDict[type]
end

-- 获得某类型，任务id的任务
function M:GetTaskData(type, id)
    if type == 0 then
        for key, tasksData in pairs(self._taskDataDict) do
            for index, task in pairs(tasksData) do
                if task.id == id then
                    return task
                end
            end
        end
        return nil
    end

    local tasksData = self._taskDataDict[type]

    if tasksData then
        for index, task in pairs(tasksData) do
            if task.id == id then
                return task
            end
        end
    end
    return nil
end

function M:_GetMissionCompleteNumByType(type)
    local num = 0

    if self._taskDataDict and self._taskDataDict[type] and #self._taskDataDict[type] > 0 then
        if type == TaskConst.TaskType.Guide then
            local guideData = self:_GetUnlockGuideData()

            if guideData then
                for i = 1, #guideData.task do
                    local data = self:GetTaskData(TaskConst.TaskType.Guide, guideData.task[i])

                    if data.state == TaskConst.TaskState.MissionComplete then
                        num = num + 1
                    end
                end
            end
        else
            for i = 1, #self._taskDataDict[type] do
                if self._taskDataDict[type][i].state == TaskConst.TaskState.MissionComplete then
                    num = num + 1
                end
            end

            num = num + self:GetActivityAwardRedNum(type)
        end
    end
    return num
end

function M:GetMissionCompleteNum(type)
    local num = 0
    local lockReason = 0
    -- 0为全部
    if type == TaskConst.TaskType.Menu then
        for i = 1, #TaskConst.TaskJumpId do
            lockReason = GameHelper.CheckLockByJumpId(TaskConst.TaskJumpId[i])
            if lockReason == 0 then
                num = num + self:_GetMissionCompleteNumByType(i)
            end
        end
        return num
    end
    lockReason = GameHelper.CheckLockByJumpId(TaskConst.TaskJumpId[type])
    if lockReason == 0 then
        if type == TaskConst.TaskType.Menu then
            for i = 1, 4 do
                num = num + self:_GetMissionCompleteNumByType(i)
            end
        else
            num = self:_GetMissionCompleteNumByType(type)
        end
    end
    return num
end

function M:GetActivationDailyValue()
    local cycleType = protocol.ECycleEvent.ECET_Daily_Task
    local cycleData = CycleDataMgr:GetInstance():GetCycleDataByType(cycleType)
    return cycleData:GetField0()
end

function M:GetActivationWeeklyValue()
    local cycleType = protocol.ECycleEvent.ECET_Weekly_Task
    local cycleData = CycleDataMgr:GetInstance():GetCycleDataByType(cycleType)
    return cycleData:GetField0()
end

function M:GetActivationDailyFinished(num)
    local cycleType = protocol.ECycleEvent.ECET_Daily_Task
    local cycleData = CycleDataMgr:GetInstance():GetCycleDataByType(cycleType)
    return cycleData:GetIntegerSomeBit(num) == 1
end

function M:GetActivationWeeklyFinished(num)
    local cycleType = protocol.ECycleEvent.ECET_Weekly_Task
    local cycleData = CycleDataMgr:GetInstance():GetCycleDataByType(cycleType)
    return cycleData:GetIntegerSomeBit(num) == 1
end

-- type == 0 时表示日常或周常是否有奖励
-- type == 2 时表示日常
-- type == 3 时表示周常
function M:GetActivityAwardRedNum(type)
    if type == 0 then
        local num = self:_GetDailyActivityAwardRedNum()
        num = num + self:_GetWeeklyActivityAwardRedNum()
        return num
    elseif type == TaskConst.TaskType.Daily then
        return self:_GetDailyActivityAwardRedNum()
    elseif type == TaskConst.TaskType.Weekly then
        return self:_GetWeeklyActivityAwardRedNum()
    end
    return 0
end

function M:_GetDailyActivityAwardRedNum()
    local num = 0

    if not tIsNullOrEmpty(self._dailyActivitiesData) then
        for i = 1, #self._dailyActivitiesData do
            if self._dailyActivitiesData[i].uiState == TaskConst.TaskUIState.Unlock then
                num = num + 1
            end
        end
    end
    return num
end

function M:_GetWeeklyActivityAwardRedNum()
    local num = 0

    if not tIsNullOrEmpty(self._weeklyActivitiesData) then
        for i = 1, #self._weeklyActivitiesData do
            if self._weeklyActivitiesData[i].uiState == TaskConst.TaskUIState.Unlock then
                num = num + 1
            end
        end
    end
    return num
end

---------------------获取数据End----------------------

---------------------数据判断Begin--------------------

function M:HasRewardTaskDatasByType(type)
    local data = self:GetTasksDataByType(type)

    if data then
        for i = 1, #data do
            if data[i].state == TaskConst.TaskState.MissionComplete then
                return true
            end
        end
    end
    return false
end

function M:_IsGuideLevelComplete(taskIds)
    local completeNum = 0

    for i = 1, #taskIds do
        local taskData = self:GetTaskData(TaskConst.TaskType.Guide, taskIds[i])

        if taskData then
            if taskData.state == TaskConst.TaskState.Doing or taskData.state == TaskConst.TaskState.MissionComplete then
                return false
            elseif taskData.state == TaskConst.TaskState.TaskComplete then
                completeNum = completeNum + 1
            end
        else
            return false
        end
    end

    if completeNum == #taskIds then
        return true
    else
        return false
    end
end

-- type == 0 时表示日常或周常是否有奖励
-- type == 2 时表示日常
-- type == 3 时表示周常
function M:HasActivityAward(type)
    if type == 0 then
        return self:_HasDailyActivityAward() or self:_HasWeeklyActivityAward()
    elseif type == TaskConst.TaskType.Daily then
        return self:_HasDailyActivityAward()
    elseif type == TaskConst.TaskType.Weekly then
        return self:_HasWeeklyActivityAward()
    end
end

function M:_HasDailyActivityAward()
    local cycleType = protocol.ECycleEvent.ECET_Daily_Task
    local cycleData = CycleDataMgr:GetInstance():GetCycleDataByType(cycleType)
    local currentValue = cycleData:GetField0()
    local increment = self:GetDailyActivitiesUpperLimit()
    local cfgs = ConfigHelper.GetCfgsByLua("taskActive", {type=1})

    for i = 1, #cfgs do
        local upper = increment[i] == nil and 0 or increment[i]
        local value = cfgs[i].activeValue + upper
        local complete = self:GetActivationDailyFinished(i - 1)

        if currentValue >= value and complete == false then
            return true
        end
    end
    return false
end

function M:_HasWeeklyActivityAward()
    local cycleType = protocol.ECycleEvent.ECET_Weekly_Task
    local cycleData = CycleDataMgr:GetInstance():GetCycleDataByType(cycleType)
    local currentValue = cycleData:GetField0()
    local increment = self:GetWeeklyActivitiesUpperLimit()
    local cfgs = ConfigHelper.GetCfgsByLua("taskActive", {type=2})

    for i = 1, #cfgs do
        local upper = increment[i] == nil and 0 or increment[i]
        local value = cfgs[i].activeValue + upper
        local complete = self:GetActivationWeeklyFinished(i - 1)

        if currentValue >= value and complete == false then
            return true
        end
    end
    return false
end

---------------------数据判断End----------------------

return TaskDataMgr
