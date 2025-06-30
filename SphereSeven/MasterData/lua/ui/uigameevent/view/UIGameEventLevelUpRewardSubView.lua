---@class UIGameEventNewbieTaskSubView
local PropSubView = {}
local this = PropSubView

-- 初始化
---@param self UIGameEventMainView
---@param gameObject UnityEngine.GameObject
---@param eventId number
---@param self UIGameEventMainView
---@param gameObject UnityEngine.GameObject
---@param eventId number
function this.OnCreate(self, gameObject, eventId)
    ---@type ReferenceCollector
    local rc = gameObject:GetComponent("ReferenceCollector")
    this.eventId = eventId
    this.config = Z_GameEvents[eventId]
    this.content = rc:GetObject("Content")
    this.rawTaskItem = rc:GetObject("RawTaskItem")
    this.rawTaskItem:SetActive(false)
    this.taskItemList = {}
end

---@param task Task
function this.RefreshTaskItem(self, index, task)
    local go = this.taskItemList[index]
    if go == nil then
        go = GameObject.Instantiate(this.rawTaskItem)
        go.transform:SetParent(this.rawTaskItem.transform.parent, false)
        go.transform:SetParent(this.rawTaskItem.transform.parent)
        go.transform.localPosition = Vector3.New(0,0,0)
        go.transform.localScale = Vector3.New(1,1,1)
        this.taskItemList[index] = go
    end
    go:SetActive(true)
    local taskRc = go:GetComponent("ReferenceCollector")
    LangUtil.BindText(taskRc:GetObject("Desc")).text = task.config.Desc
    
    UIPublic.InitRewardItem({
        rewardId = task.config.RewardId,
        itemPrefab = taskRc:GetObject("ItemPrefab"),
        isShowCount = true,
        isShowThingsDetail = true,
    })
    taskRc:GetObject("Mask"):SetActive(task.status == TaskStatus.TaskStatusReceived)
    taskRc:GetObject("ReceiveButton"):SetActive(task.status == TaskStatus.TaskStatusCompleted)
    LangUtil.BindText(taskRc:GetObject("ReceiveText")).text = LangUtil.GetSysLang(310) -- 领取
    LangUtil.BindText(taskRc:GetObject("ReceivedText")).text = LangUtil.GetSysLang(313) -- 已领取

    UIUtil.AddBtnEvent(taskRc:GetObject("ReceiveButton"), function()
        if task.status ~=  TaskStatus.TaskStatusCompleted then
            return
        end
        PublicRequest.SendRequest(
                PROTOCOL.TaskSubmitReq,
                {
                    type = TaskType.TaskTypeGameEvent,
                    task_id = task.Id,
                },
                function(response, error)
                    UIPublic.OpenRewardUI(response.reward_result)
                end
        )
    end)
end

---@param self UIGameEventMainView
function this.OnRefresh(self)
    ---@type GameEventComponent
    local gameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")
    for key, value in pairs(this.config) do
        if value.ModuleType == GameEventModuleType.GameEventModuleTask then
            ---@type GameEventModule
            local module = gameEventComponent:GetGameEventModule(value.ModuleId)
            if module.status == GameEventStatus.GameEventStatusInProgress then
                this.gameEventModule = module
                break
            end
        end
    end
    
    local taskGroup = this.gameEventModule.config.ModuleParams[1]
    ---@type Task[]
    local taskList = Game.Scene.Player:GetComponent("TaskComponent"):GetTasks(TaskType.TaskTypeGameEvent, taskGroup)
    table.sort(taskList, function(a, b)
        return a.Id < b.Id
    end)
    for index, task in ipairs(taskList) do
        this.RefreshTaskItem(self, index, task)
    end
    for i = table.count(taskList) + 1, table.count(this.taskItemList) do
        this.taskItemList[i]:SetActive(false)
    end
end

---@param self UIGameEventMainView
function this.OnGameEventUpdate(self)
    this.OnRefresh(self)
end

---@param self UIGameEventMainView
function this.OnTaskUpdate(self)
    this.OnRefresh(self)
end

---@param self UIGameEventMainView
function this.showEndTime(self)
    local entryModuleId = self.model.data[self.model.index].gameEvent.entryModuleId
    ---@type GameEventModule
    local module = Game.Scene.Player:GetComponent("GameEventComponent"):GetGameEventModule(entryModuleId)
    if module.config.GameEventType == GameEventType.Normal then
        return ""
    end
    local seconds = module.endTime - TimeUtil.GetServerTime()
    local tb = TimeUtil.ConvertTimeForm(seconds)
    if tb.day > 0 then
        return LangUtil.GetSysLang(1326) .. string.format("%d"..LangUtil.GetSysLang(2005).." %02d:%02d:%02d", tb.day, tb.hour, tb.minute, tb.second)
    else
        return LangUtil.GetSysLang(1326) .. string.format("%02d:%02d:%02d", tb.hour, tb.minute, tb.second)
    end
    -- end
end

return this