---@class UIGameEventNewbieTaskSubView
local PropSubView = {}
local this = PropSubView

-- 初始化
---@param self UIGameEventMainView
---@param gameObject UnityEngine.GameObject
---@param eventId number
function this.OnCreate(self, gameObject, eventId)
    ---@type ReferenceCollector
    local rc = gameObject:GetComponent("ReferenceCollector")
    
    local taskItems = {
        rc:GetObject("TaskItem1").transform,
        rc:GetObject("TaskItem2").transform,
    }

    this.eventId = eventId
    this.config = Z_GameEvents[eventId]
    this.taskItemList = {}
    for index, taskItem in ipairs(taskItems) do
        this.taskItemList[index] = {
            root = taskItem.gameObject,
            itemIcon = taskItem:Find("ItemIcon"):GetComponent("Image"),
            canReceive = taskItem:Find("ItemIcon/CanReceive").gameObject,
            received = taskItem:Find("ItemIcon/Received").gameObject,
            text = LangUtil.BindText(taskItem:Find("Text")),
        }
    end
end

function this.Receive(taskId)
    PublicRequest.SendRequest(
        PROTOCOL.TaskSubmitReq,
        {
            type = TaskType.TaskTypeGameEvent,
            task_id = taskId,
        },
        function(response, error)
            UIPublic.OpenRewardUI(response.reward_result)
        end
)
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
    for i, v in ipairs(this.taskItemList) do
        if taskList[i] ~= nil then
            local task = taskList[i]
            v.root:SetActive(true)
            v.text.text = task.config.Desc
            local zReward = Z_Reward[task.config.RewardId]
            local reward = zReward[1]
            if reward.Type == RewardType.RewardTypeItem then
                UIUtil.SetSprite(v.itemIcon, AtlasConfig.Item, GetItemIcon(Z_Item[reward.ObjId]))
            else
                Logger.LogError("task reward is not item, taskId : " .. task.Id)
            end
            UIUtil.AddBtnEvent(v.itemIcon, function()
                if task.status == TaskStatus.TaskStatusCompleted then
                    this.Receive(task.Id)
                    return
                end
                
                UIUtil.OpenThingsDetailWindow({
                    showType = ShowType.Item,
                    tempId = reward.ObjId,
                })
            end)
            v.canReceive:SetActive(task.status == TaskStatus.TaskStatusCompleted)
            v.received:SetActive(task.status == TaskStatus.TaskStatusReceived)
            if task.status == TaskStatus.TaskStatusReceived then
                v.itemIcon.color = Color.New(0.5,0.5,0.5)
            else
                v.itemIcon.color = Color.New(1,1,1)
            end
            UIUtil.AddBtnEvent(v.root, function()
                if task.status ~= TaskStatus.TaskStatusCompleted then
                    return
                end
                this.Receive(task.Id)
            end)
        else
            v.root:SetActive(false)
        end
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