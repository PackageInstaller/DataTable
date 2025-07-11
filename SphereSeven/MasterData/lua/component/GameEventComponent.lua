---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/4/11 20:08
---
---@class GameEventComponent
---@field gameEventMap GameEvent[]
---@field gameEventModuleMap GameEventModule[]
---@field activityHint HintNode
---@field singleActivityHint HintNode
local GameEventComponent = BaseClass("GameEventComponent", Component)
local base = Component
local this = GameEventComponent

local passTaskIndex = {
    [1] = "DailyTaskGroups",
    [2] = "WeeklyTaskGroups",
    [3] = "TaskGroups",
}

local GameEventModuleTaskTypes = {
    GameEventModuleType.GameEventModuleTask,
    GameEventModuleType.GameEventModuleDailyTask,
    GameEventModuleType.GameEventModuleWeeklyTask,
}

function GameEventComponent:Awake()
    base.Awake(self)

    self.gameEventMap = {}
    self.gameEventModuleMap = {}
    self.gameEventLevelIds = {}

    ---@type HintComponent
    local hintComponent = Game.Scene:GetComponent("HintComponent")
    self.activityHint = hintComponent.Activity -- eventId - moduleId --  checkInId, task, pass (定死名称) -- 对应各个不同的id.
    self.singleActivityHint = hintComponent.SingleActivity
    self.activityHint:SetCount(0)
    self.singleActivityHint:SetCount(0)
end

function GameEventComponent:CoLoadData()
    ---@type protocol.GameEventResp
    local info = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
            PROTOCOL.GameEventReq, {})
    if info.events ~= nil then
        for _, event in pairs(info.events) do
            self:RefreshEventData(event)
        end
    end

    if info.modules ~= nil then
        for _, module in pairs(info.modules) do
            self:RefreshModuleData(module)
        end
    end
    
    return coroutine.yieldbreak(info)
end

---@param event protocol.GameEvent
function GameEventComponent:RefreshEventData(event)
    local config = Z_GameEvents[event.event_id]
    local gameEventType = 0
    for i, v in pairs(config) do
        if v.GameEventType ~= 0 then
            gameEventType = v.GameEventType
            break
        end
    end
    
    if self.gameEventMap[event.event_id] == nil then
        if gameEventType == GameEventType.Normal or gameEventType == GameEventType.Special then
            self.activityHint:AddChild(event.event_id, 0)
        else
            self.singleActivityHint:AddChild(event.event_id, 0)
        end
        self.gameEventMap[event.event_id] = Game.Registry:NewObject("GameEvent", event)
    else
        self.gameEventMap[event.event_id]:UpdateData(event)
    end
end

---@param module protocol.GameEventModule
function GameEventComponent:RefreshModuleData(module)
    if self.gameEventModuleMap[module.module_id] == nil then
        self.gameEventModuleMap[module.module_id] = Game.Registry:NewObject("GameEventModule", module)

        local eventHint = self.activityHint:GetChild(module.event_id)
        if eventHint == nil then
            eventHint = self.singleActivityHint:GetChild(module.event_id)
        end
        
        if eventHint ~= nil then
            if eventHint:GetChild(module.module_id) == nil then
                eventHint:AddChild(module.module_id, 0)
            end
        end

        self:InitModule(self.gameEventModuleMap[module.module_id])
    else
        self.gameEventModuleMap[module.module_id]:UpdateData(module)
        self:RefreshModule(self.gameEventModuleMap[module.module_id])
    end

    self:RefreshModuleHint(self.gameEventModuleMap[module.module_id])

end


---@param module GameEventModule @ 这个模块
---@param hint HintNode @ 这个模块节点 下的 对应system的红点 (Task, CheckIn等)
---@param self GameEventComponent
local function RefreshHint(self, module, hint, key, param)
    if param == nil then param = {} end
    -- name 最后面为Task, CheckIn等
    if key == "Task" then
        if table.contains(GameEventModuleTaskTypes, module.config.ModuleType) then
            ---@type TaskComponent
            local taskComponent = Game.Scene.Player:GetComponent("TaskComponent")
            local taskGroup = module.config.ModuleParams[1]

            for id, value in pairs(Z_TaskGameEvent) do
                if value.Group == taskGroup then
                    if hint:GetChild(id) == nil then
                        hint:AddChild(id)
                    end

                    local hintCount = 0
                    ---@type Task
                    local task = taskComponent:GetTask(TaskType.TaskTypeGameEvent, id)
                    if task ~= nil then
                        if task.status == TaskStatus.TaskStatusCompleted then
                            hintCount = 1
                        end
                    end
                    hint:GetChild(id):SetCount(hintCount)
                end
            end
        end
    elseif key == "CheckIn" then
        if module.config.ModuleType == GameEventModuleType.GameEventModuleCheckIn then
            ---@type CheckInComponent
            local checkInComponent = Game.Scene.Player:GetComponent("CheckInComponent")
            local checkInId = module.config.ModuleParams[1]
            local checkInGroupData = checkInComponent:GetCheckInGroupData(checkInId)
            if checkInGroupData ~= nil then
                for index, checkInItem in pairs(checkInGroupData.group) do
                    local hintCount = 0
                    if checkInItem.receiveStatus == CheckInReceiveStatus.CheckInReceiveNotReceived then
                        hintCount = 1
                    end
                    if hint:GetChild(checkInItem.id) == nil then
                        hint:AddChild(checkInItem.id)
                    end
                    hint:GetChild(checkInItem.id):SetCount(hintCount)
                end
            end
        end
    elseif key == "PassReward" then
        if module.config.ModuleType == GameEventModuleType.GameEventModulePass then
            local passId = module.config.ModuleParams[1]

            if param.id ~= nil and passId ~= param.id then
                return
            end

            -- 奖励部分

            ---@type PassComponent
            local passComponent = Game.Scene.Player:GetComponent("PassComponent")
            local pass = passComponent:GetPass(passId)
            if pass ~= nil then
                if pass.canReceiveNormal or pass.canReceiveSpecial then
                    hint:SetCount(1)
                else
                    hint:SetCount(0)
                end
            end
        end
    elseif key == "PassTask" then
        if module.config.ModuleType == GameEventModuleType.GameEventModulePass then
            -- 任务部分
            local passId = module.config.ModuleParams[1]

            ---@type PassComponent
            local passComponent = Game.Scene.Player:GetComponent("PassComponent")
            local pass = passComponent:GetPass(passId)

            ---@type TaskComponent
            local taskComponent = Game.Scene.Player:GetComponent("TaskComponent")
            local taskRootHint = hint
            for i, v in ipairs(passTaskIndex) do
                if pass ~= nil and table.count(pass.config[v]) > 0 then
                    if taskRootHint:GetChild(i) == nil then
                        taskRootHint:AddChild(i, 0)
                    end
                    for _, taskGroupId in ipairs(pass.config[v]) do
                        for id, value in pairs(Z_PassTask) do
                            if value.Group == taskGroupId then
                                if taskRootHint:GetChild(i):GetChild(id) == nil then
                                    taskRootHint:GetChild(i):AddChild(id)
                                end

                                local hintCount = 0
                                local task = taskComponent:GetTask(TaskType.TaskTypePass, id)
                                if task ~= nil then
                                    if task.status == TaskStatus.TaskStatusCompleted then
                                        hintCount = 1
                                    end
                                end
                                taskRootHint:GetChild(i):GetChild(id):SetCount(hintCount)
                            end
                        end
                    end
                end
            end
        end
    else
        -- ("hint name not found")
    end
end


---@param module GameEventModule
---@param self GameEventComponent
local function RefreshModuleHint(self, module, str, params)
    local eventHint = self.activityHint:GetChild(module.eventId)
    if eventHint == nil then
        eventHint = self.singleActivityHint:GetChild(module.eventId)
    end
    if eventHint ~= nil and eventHint:GetChild(module.moduleId) ~= nil then
        local moduleHint = eventHint:GetChild(module.moduleId)
        if str == nil then
            if moduleHint:GetChild("Task") ~= nil then
                RefreshHint(self, module, moduleHint:GetChild("Task"), "Task", params)
            end

            if moduleHint:GetChild("CheckIn") ~= nil then
                RefreshHint(self, module, moduleHint:GetChild("CheckIn"), "CheckIn", params)
            end

            if moduleHint:GetChild("PassReward") ~= nil then
                RefreshHint(self, module, moduleHint:GetChild("PassReward"), "PassReward", params)
            end

            if moduleHint:GetChild("PassTask") ~= nil then
                RefreshHint(self, module, moduleHint:GetChild("PassTask"), "PassTask", params)
            end
        else
            if moduleHint:GetChild(str) ~= nil then
                RefreshHint(self, module, moduleHint:GetChild(str), str, params)
            end

            if moduleHint:GetChild("PassTask") ~= nil and str == "Task" then
                RefreshHint(self, module, moduleHint:GetChild("PassTask"), "PassTask", params)
            end

            if str == "Pass" then
                if moduleHint:GetChild("PassReward") ~= nil then
                    RefreshHint(self, module, moduleHint:GetChild("PassReward"), "PassReward", params)
                end
                if moduleHint:GetChild("PassTask") ~= nil then
                    RefreshHint(self, module, moduleHint:GetChild("PassTask"), "PassTask", params)
                end
            end
        end
    end
end

--- 对外接口, 用于刷新对应系统所有红点. 目前str可以传入 nil, CheckIn, Task
---@param module GameEventModule @ 刷新哪个module. 如果为nil, 就查找所有
---@param str string @ 刷新哪个系统的红点. 目前str可以传入 nil, CheckIn, Task
function this:RefreshModuleHint(module, str, params)
    if module ~= nil then
        RefreshModuleHint(self, module, str, params)
    else
        -- 不传入module 就是所有的都检查一遍
        for moduleId, m in pairs(self.gameEventModuleMap) do
            RefreshModuleHint(self, m, str, params)
        end
    end
end

function GameEventComponent:RemoveEvent(id)
    if self.gameEventMap[id] ~= nil then
        for moduleId, _ in pairs(self.gameEventMap[id].config) do
            self.gameEventModuleMap[moduleId] = nil
        end
        self.gameEventMap[id] = nil
    end
end

---@param module GameEventModule
function GameEventComponent:InitModule(module)
    if module.status == GameEventStatus.GameEventStatusInProgress and module.config.ModuleType == GameEventModuleType.GameEventModuleCheckIn then
        ---@type CheckInComponent
        local CheckInComponent = Game.Scene.Player:GetComponent("CheckInComponent")
        CheckInComponent:RequestCheckInData(module.config.ModuleParams[1])

        local eventHint = self.activityHint:GetChild(module.eventId)
        if eventHint == nil then
            eventHint = self.singleActivityHint:GetChild(module.eventId)
        end
        if eventHint ~= nil then
            if eventHint:GetChild(module.moduleId) == nil then
                eventHint:AddChild(module.moduleId, 0)
            end
            eventHint:GetChild(module.moduleId):AddChild("CheckIn")
        end
    elseif module.status == GameEventStatus.GameEventStatusInProgress and table.contains(GameEventModuleTaskTypes, module.config.ModuleType) then
        ---@type TaskComponent
        local taskComponent = Game.Scene.Player:GetComponent("TaskComponent")

        local eventHint = self.activityHint:GetChild(module.eventId)
        if eventHint == nil then
            eventHint = self.singleActivityHint:GetChild(module.eventId)
        end
        if eventHint ~= nil then
            if eventHint:GetChild(module.moduleId) == nil then
                eventHint:AddChild(module.moduleId, 0)
            end
            local moduleTaskHint = eventHint:GetChild(module.moduleId):AddChild("Task")

            local taskGroup = module.config.ModuleParams[1]
            for id, value in pairs(Z_TaskGameEvent) do
                if value.Group == taskGroup then
                    if moduleTaskHint:GetChild(id) == nil then
                        moduleTaskHint:AddChild(id)
                    end

                    local hintCount = 0
                    if taskComponent ~= nil then
                        local task = taskComponent:GetTask(TaskType.TaskTypeGameEvent, id)
                        if task ~= nil then
                            if task.status == TaskStatus.TaskStatusCompleted then
                                hintCount = 1
                            end
                        end
                    end
                    moduleTaskHint:GetChild(id):SetCount(hintCount)
                end
            end
        end
    elseif module.status == GameEventStatus.GameEventStatusInProgress and module.config.ModuleType == GameEventModuleType.GameEventModuleBossraid then
        
    elseif module.status == GameEventStatus.GameEventStatusInProgress and module.config.ModuleType == GameEventModuleType.GameEventModulePass then

        local eventHint = self.activityHint:GetChild(module.eventId)
        if eventHint == nil then
            eventHint = self.singleActivityHint:GetChild(module.eventId)
        end
        if eventHint ~= nil then
            if eventHint:GetChild(module.moduleId) == nil then
                eventHint:AddChild(module.moduleId, 0)
            end

            
            -- 奖励部分

            local rewardHint = eventHint:GetChild(module.moduleId):GetChild("PassReward")
            if rewardHint == nil then
                rewardHint = eventHint:GetChild(module.moduleId):AddChild("PassReward", 0)
            end
            
            local passId = module.config.ModuleParams[1]
            ---@type PassComponent
            local passComponent = Game.Scene.Player:GetComponent("PassComponent")
            local pass = passComponent:GetPass(passId)
            if pass ~= nil then
                if pass.canReceiveNormal or pass.canReceiveSpecial then
                    rewardHint:SetCount(1)
                else
                    rewardHint:SetCount(0)
                end
            end

            -- 任务部分
            
            ---@type TaskComponent
            local taskComponent = Game.Scene.Player:GetComponent("TaskComponent")

            local taskRootHint = eventHint:GetChild(module.moduleId):GetChild("PassTask")
            if taskRootHint == nil then
                taskRootHint = eventHint:GetChild(module.moduleId):AddChild("PassTask", 0)
            end
            
            for i, v in ipairs(passTaskIndex) do
                if pass ~=nil and table.count(pass.config[v]) > 0 then
                    if taskRootHint:GetChild(i) == nil then
                        taskRootHint:AddChild(i, 0)
                    end
                    for _, taskGroupId in ipairs(pass.config[v]) do
                        for id, value in pairs(Z_PassTask) do
                            if value.Group == taskGroupId then
                                if taskRootHint:GetChild(i):GetChild(id) == nil then
                                    taskRootHint:GetChild(i):AddChild(id)
                                end

                                local hintCount = 0
                                if taskComponent ~= nil then
                                    local task = taskComponent:GetTask(TaskType.TaskTypePass, id)
                                    if task ~= nil then
                                        if task.status == TaskStatus.TaskStatusCompleted then
                                            hintCount = 1
                                        end
                                    end
                                end
                                taskRootHint:GetChild(i):GetChild(id):SetCount(hintCount)
                            end
                        end
                    end
                end
            end
        end
    end
end

---@param module GameEventModule
function GameEventComponent:RefreshModule(module)

end


function GameEventComponent:CheckIsOpen(eventId, moduleId)
    if eventId == nil and moduleId == nil then
        return false
    end

    if eventId ~= nil then
        local event = self.gameEventMap[eventId]
        if moduleId == nil then
            return event ~= nil and event.status == GameEventStatus.GameEventStatusInProgress
        else
            local module = self.gameEventModuleMap[moduleId]
            -- 需要 event module 都不是空, 并且都是开启中
            return event ~= nil
                and event.status == GameEventStatus.GameEventStatusInProgress
                and module ~= nil
                and module.status == GameEventStatus.GameEventStatusInProgress
        end
    else
        local module = self.gameEventModuleMap[moduleId]
        return module ~= nil and module.status == GameEventStatus.GameEventStatusInProgress
    end
end

---@return GameEvent | GameEvent[]
function GameEventComponent:GetGameEvent(id)
    if id == nil then
        local list = {}
        for key, value in pairs(self.gameEventMap) do
            if value.config.GameEventType ~= GameEventType.None then
                table.insert(list, value)
            end
        end
        table.sort(list, function(a,b) return a.eventId < b.eventId end)
        return list
    else
        return self.gameEventMap[id]
    end
end

---@return GameEventModule | GameEventModule[]
function GameEventComponent:GetGameEventModule(id)
    if id == nil then
        local list = {}
        for key, value in pairs(self.gameEventModuleMap) do
            table.insert(list, value)
        end
        table.sort(list, function(a,b) return a.moduleId < b.moduleId end)
        return list
    else
        return self.gameEventModuleMap[id]
    end
end


------------------------------------------------------------------------------------------------------------------

--触发限时礼包开启
function this.GetGiftBag(self,id,func)
    local info = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
            OuterOpcode.Name2Code.ETModel_C2M_ActivityOpenGift,{Id = id})
    if info.Error == ErrorCode.ERR_Success then
        self.ActivityGifts[info.GiftInfo.Id] = info.GiftInfo
        if func ~=nil then
             func()
        end
    else
        UIUtil.ToolTipFourth(LangUtil.GetServerError(info.Error), 1.5)
    end
end

function this.ReceiveReward(self, activityId, id, callback)--活动兑换奖励
    if not self:ActiveIsOpen(activityId) then
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(839))--活动已结束
        if callback ~= nil then callback() end
        return
    end
    local sendReqData = {}
    sendReqData.Id = id

    local info = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
            OuterOpcode.Name2Code.ETModel_C2M_ActivityDemonReceive, sendReqData)
    if info.Error == ErrorCode.ERR_Success then
        table.insert(self.ActivityInfos[activityId].Records, id)
        
        if callback ~= nil then
            callback()
        end
        DataManager:GetInstance():Broadcast(DataMessageNames.ON_ACTIVITY_DEMON_CHG)
    else
        UIUtil.ToolTipFourth(LangUtil.GetServerError(info.Error), 1.5)
    end
end

function this.ReceiveLoginReward(self, activityId, id, callback)--活动兑换奖励
    if not self:LoginIsOpen(activityId) then
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(839))--活动已结束
        if callback ~= nil then callback() end
        return
    end
    local sendReqData = {}
    sendReqData.Id = id--1-20

    local info = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
            OuterOpcode.Name2Code.ETModel_C2M_ActivitySignin, sendReqData)
    if info.Error == ErrorCode.ERR_Success then
        if activityId == 1001 then
            table.insert(self.ActivityLogins[activityId].Records, id)
        else
            table.insert(self.ActivityLogins[activityId].Records, id-20)
        end
        
        --UIUtil.UpdateRewardInfoList({info.Reward}, true)
        if callback ~= nil then
            callback()
        end
        DataManager:GetInstance():Broadcast(DataMessageNames.ON_ACTIVITY_LOGIN_CHG)
    else
        UIUtil.ToolTipFourth(LangUtil.GetServerError(info.Error), 1.5)
    end
end

function this.GetStartDate(self, activityId)
    -- if self.TimeSlots[activityId] then
    --     return self.TimeSlots[activityId].Start
    -- end
    return nil
end

function this.GetEndDate(self, activityId)
    -- if self.TimeSlots[activityId] then
    --     return self.TimeSlots[activityId].End
    -- end
    return nil
end

function this.ActiveIsOpen(self, activityId, type)
    -- if not self.TimeSlots[activityId] then
    --     return false
    -- end
    -- if not self.ActivityInfos[activityId] then
    --     return false
    -- end
    -- if not self.isReqData then
    --     local request = coroutine.yieldstart(self.CoLoadData, nil, self)
    --     if request == nil or request.Error ~= ErrorCode.ERR_Success then
    --         return false
    --     end
    -- end

    -- if type ~= nil and type == 1 then--多一周
    --     if self.TimeSlots[activityId].Start <= 0 or self.TimeSlots[activityId].Start > TimeUtil.OSTime() 
    --             or TimeUtil.getNewDate(self.TimeSlots[activityId].End, 7,"DAY") < TimeUtil.OSTime() then
    --         return false
    --     end
    -- else
    --     if self.TimeSlots[activityId].Start <= 0 or self.TimeSlots[activityId].Start > TimeUtil.OSTime() 
    --             or self.TimeSlots[activityId].End < TimeUtil.OSTime() then
    --         return false
    --     end 
    -- end

    return true
end


function this.GetLoginStartDate(self, activityId)
    -- if self.LoginTimeSlots[activityId] then
    --     return self.LoginTimeSlots[activityId].Start
    -- end
    return nil
end

function this.LoginIsOpen(self, activityId)
    -- if not self.LoginTimeSlots[activityId] then
    --     return false
    -- end
    -- if not self.ActivityLogins[activityId] then
    --     return false
    -- end

    -- if self.LoginTimeSlots[activityId].Start <= 0 or self.LoginTimeSlots[activityId].Start > TimeUtil.OSTime()
    --         or self.LoginTimeSlots[activityId].End < TimeUtil.OSTime() then
    --     return false
    -- end

    return true
end


function this.AdActiveStoryIsOpen(self, activityId, type)--1.上线、 2.已下线
    if not self.isReqData then
        local request = coroutine.yieldstart(self.CoLoadData, nil, self)
        if request == nil or request.Error ~= ErrorCode.ERR_Success then
            return nil
        end
    end
    if not self.TimeSlots[activityId] then
        return nil
    end
    
    if self.TimeSlots[activityId].Start < Game.Scene:GetComponent("SessionComponent").DateTime 
            or self.TimeSlots[activityId].Start > TimeUtil.OSTime() then
        return nil--未开放
    end

    if type ~= nil and type == 1 then--出击模式、物语关卡开放限制
        if TimeUtil.getNewDate(self.TimeSlots[activityId].End, 7,"DAY") < TimeUtil.OSTime() then
            return nil
        end
    else
        if self.TimeSlots[activityId].End < TimeUtil.OSTime() then
            return {limit = 2}
        end
    end

    return {limit = 1, StartDate = self.TimeSlots[activityId].Start, EndDate = self.TimeSlots[activityId].End}
end

function GameEventComponent:Dispose()
    base.Dispose(self)
end

return GameEventComponent