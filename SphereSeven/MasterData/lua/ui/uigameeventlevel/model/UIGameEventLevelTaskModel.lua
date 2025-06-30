
--
-- <代码文件解释说明>
--

---@class UIGameEventLevelTaskModel : UIBaseModel
local UIGameEventLevelTaskModel = BaseClass("UIGameEventLevelTaskModel",UIBaseModel)
local base = UIBaseModel
local this = UIGameEventLevelTaskModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.eventId = data.eventId
    self.moduleId = data.moduleId
    self:OnRefresh()
end

local function SortTasks(tasks)
    ---@param a Task
    ---@param b Task
    table.sort(tasks,function(a,b)
        if a.status ~= b.status then
            if a.status == TaskStatus.TaskStatusCompleted then
                -- a 完成, b 其他
                return true
            elseif a.status == TaskStatus.TaskStatusProgressing then
                -- a 进行中.  b 完成(false), 其他(true)
                return b.status ~= TaskStatus.TaskStatusCompleted
            else
                -- a 已领取 排在最后
                return false
            end
        end
        return a.Id < b.Id
    end)
    return tasks
end

local function checkTaskShow(value)
    local currentTime = TimeUtil.GetServerTime()
    if not string.IsNullOrEmpty(value.VisibleStartTime) then
        if currentTime < TimeUtil.ParseDateTime(value.VisibleStartTime) then
            return false
        end
    end

    return true
end

function this:OnRefresh()
    ---@type GameEventComponent
    local gameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")
    self.gameEvent = gameEventComponent:GetGameEvent(self.eventId)
    self.module = gameEventComponent:GetGameEventModule(self.moduleId)
    self.entryModule = gameEventComponent:GetGameEventModule(self.gameEvent.entryModuleId)

    self.chapterId = self.module.config.ShowParams[1]
    self.UILandladyId = 1011
    self.imageIndex = 0
    if self.module.config.ImageParams[1] ~= nil then
        self.UILandladyId = self.module.config.ImageParams[1]
    end
    if self.module.config.ImageParams[2] ~= nil then
        self.imageIndex = self.module.config.ImageParams[2]
    end
    
    ---@type TaskComponent
    local taskComponent = Game.Scene.Player:GetComponent("TaskComponent")

    self.tasks = {}
    local taskGroup = self.module.config.ModuleParams[1]
    for id, value in pairs(Z_TaskGameEvent) do
        if value.Group == taskGroup then
            ---@type Task
            local task = taskComponent:GetTask(TaskType.TaskTypeGameEvent, id)
            if checkTaskShow(value) and task ~= nil then
                table.insert(self.tasks, task)
            end
        end
    end
    self.tasks = SortTasks(self.tasks)
end

function this:OnRefreshTask(type)
    self:OnRefresh()
    self:UIBroadcast(UIMessageNames.ON_TASK_UPDATE, type)
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddDataListener(DataMessageNames.ON_TASK_UPDATE, self.OnRefreshTask)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveDataListener(DataMessageNames.ON_TASK_UPDATE)
end

return this