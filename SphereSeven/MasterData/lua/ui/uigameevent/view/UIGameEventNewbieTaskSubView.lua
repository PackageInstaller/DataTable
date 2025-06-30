---@class UIGameEventNewbieTaskSubView
local PropSubView = {}
local this = PropSubView

local function OnTabClick(self, index)
    this.index = index
    ---@type GameEventModule
    local moduleData = this.moduleDataList[index]
    if moduleData == nil then
        return
    end

    for index, value in ipairs(this.tabList) do
        value.mask:SetActive(index ~= this.index)
        value.active:SetActive(index == this.index)
    end

    local taskGroup = moduleData.config.ModuleParams[1]
    local taskList = Game.Scene.Player:GetComponent("TaskComponent"):GetTasks(TaskType.TaskTypeGameEvent, taskGroup)
    table.sort(taskList, function(a, b)
        return a.Id < b.Id
    end)
    for i = table.count(taskList) - 1, table.count(this.taskItemList) do
        if this.taskItemList[i] ~= nil then
            this.taskItemList[i]:SetActive(false)
        end
    end

    for i = 1, table.count(taskList) do
        local item
        if i == table.count(taskList) then
            item = this.finalTaskItem
        else
            item = this.taskItemList[i]
            if item == nil then
                item = GameObject.Instantiate(this.taskItem)
                item.transform:SetParent(this.taskContent.transform, false)
                item:SetActive(true)
    
                this.taskItemList[i] = item
            end
        end

        item:SetActive(true)
        ---@type Task
        local task = taskList[i]
        local rc = item:GetComponent("ReferenceCollector")
        
        local reward = Z_Reward[task.config.RewardId][1]
        if i == table.count(taskList) then
            local itemPrefab = rc:GetObject("ItemPrefab")
            local fightVisitItem = rc:GetObject("FightVisitItem")
            local cardItem = rc:GetObject("CardItem")
            if reward.Type == RewardType.RewardTypeCharacter then
                itemPrefab:SetActive(false)
                fightVisitItem:SetActive(false)
                cardItem:SetActive(true)

                local cardData = {
                    Id = reward.ObjId,
                    Star = nil,
                    Level = nil,
                }
                UIPublic.InitCardItemLittle(cardData, cardItem)
            elseif reward.Type == RewardType.RewardTypeFightSoul then
                itemPrefab:SetActive(false)
                fightVisitItem:SetActive(true)
                cardItem:SetActive(false)
                
                local fightSoulData = {
                    TemplateId = reward.ObjId,
                    isEquip = false,
                    level = nil,
                    lock = false,
                    Star = nil,
                }
                UIPublic.InitVsFightSoulItemMId(fightSoulData, fightVisitItem, nil, true)
            else
                itemPrefab:SetActive(true)
                fightVisitItem:SetActive(false)
                cardItem:SetActive(false)

                ---@type RewardItemData
                local rewardData = {}
                rewardData.rewardId = task.config.RewardId
                rewardData.itemPrefab = itemPrefab
                rewardData.isShowThingsDetail = true
                rewardData.isBag = false
                rewardData.isShowCount = true
                UIPublic.InitRewardItem(rewardData)
            end
        else
            ---@type RewardItemData
            local rewardData = {}
            rewardData.rewardId = task.config.RewardId
            rewardData.itemPrefab = rc:GetObject("ItemPrefab")
            rewardData.isShowThingsDetail = true
            rewardData.isBag = false
            rewardData.isShowCount = true
            UIPublic.InitRewardItem(rewardData)
        end

        local descText = LangUtil.BindText(rc:GetObject("DescText"))
        local countText = LangUtil.BindText(rc:GetObject("CountText"))

        descText.text = task.config.Desc
        local count = task.Count
        if count > task.target then
            count = task.target
        end
        countText.text = count .. "/" .. task.target

        local jumpButton = rc:GetObject("JumpButton")
        local receiveButton = rc:GetObject("ReceiveButton")
        local jumpMaskImage = rc:GetObject("JumpMaskImage")
        local maskImage = rc:GetObject("MaskImage")

        LangUtil.BindText(jumpButton.transform:Find("Text")).text = LangUtil.GetSysLang(460) -- 前往
        LangUtil.BindText(receiveButton.transform:Find("Text")).text = LangUtil.GetSysLang(310) -- 领取
        if task.status == TaskStatus.TaskStatusProgressing then
            -- 进行中
            receiveButton:SetActive(false)
            jumpButton:SetActive(false)
            maskImage:SetActive(false)
            if task.config.LevelJump == nil or task.config.LevelJump[1] == nil then
                jumpButton:SetActive(false)
            else
                local zLevelJump = Z_LevelJump[task.config.LevelJump[1]]
                if zLevelJump == nil or zLevelJump[1] == nil then
                    jumpButton:SetActive(false)
                else
                    local isUnlock = UIPublic.CheckJumpLevel(zLevelJump[1].JumpType, zLevelJump[1].Arg1, zLevelJump[1].Arg2)
                    jumpMaskImage:SetActive(not isUnlock)
                    jumpButton:SetActive(true)
                    UIUtil.AddBtnEventNoBug(jumpButton, function()
                        if isUnlock then
                            UIPublic.JumpLevel(zLevelJump[1].JumpType, zLevelJump[1].Arg1, zLevelJump[1].Arg2)
                        end
                    end)
                end
            end
        elseif task.status == TaskStatus.TaskStatusCompleted then
            -- 已完成 待领取
            receiveButton:SetActive(true)
            jumpButton:SetActive(false)
            maskImage:SetActive(false)
            UIUtil.AddBtnEventNoBug(receiveButton, function()
                ---@param response protocol.TaskSubmitResp
                PublicRequest.SendRequest(
                    PROTOCOL.TaskSubmitReq,
                    {
                        type = TaskType.TaskTypeGameEvent,
                        task_id = task.Id,
                    },
                    function(response, error)
                        if error == 0 then
                            UIPublic.OpenRewardUI(response.reward_result)
                        end
                    end
                )
            end)
        elseif task.status == TaskStatus.TaskStatusReceived then
            -- 已领取
            receiveButton:SetActive(false)
            jumpButton:SetActive(false)
            maskImage:SetActive(true)
        end
    end
end

-- 初始化
---@param self UIGameEventMainView
---@param gameObject UnityEngine.GameObject
---@param eventId number
function this.OnCreate(self, gameObject, eventId)
    ---@type ReferenceCollector
    local rc = gameObject:GetComponent("ReferenceCollector")

    LangUtil.BindText(rc:GetObject("TitleText")).text = LangUtil.GetSysLang(1329) -- 新手任务
    LangUtil.BindText(rc:GetObject("TitleText2")).text = LangUtil.GetSysLang(1330) -- 获得众多好礼
    local texts = {
        LangUtil.GetSysLang(1331), -- 超越者 姒文命
        LangUtil.GetSysLang(1332), -- 第3日领取
        LangUtil.GetSysLang(1333), -- 战魂 姒文命
        LangUtil.GetSysLang(1334), -- 第5日领取
        LangUtil.GetSysLang(1335), -- 疗愈泳装
        LangUtil.GetSysLang(1336), -- 第7日领取
    }

    local rewardTexts = {
        rc:GetObject("Reward1").transform,
        rc:GetObject("Reward2").transform,
        rc:GetObject("Reward3").transform,
    }

    for index, value in ipairs(rewardTexts) do
        LangUtil.BindText(value:Find("Text1")).text = texts[index * 2 - 1]
        LangUtil.BindText(value:Find("Text2")).text = texts[index * 2]
    end
    this.tabLayout = rc:GetObject("TabLayout").transform
    this.taskItem = rc:GetObject("TaskItem").gameObject
    this.taskContent = rc:GetObject("TaskContent").transform
    this.finalTaskItem = rc:GetObject("FinalTaskItem").gameObject

    UIUtil.AddBtnEvent(rc:GetObject("Button1"), function()
        local showData ={}
        showData.tempId = 1018
        showData.showType = ShowType.Card
        UIUtil.OpenThingsDetailWindow(showData)
    end)
    
    UIUtil.AddBtnEvent(rc:GetObject("Button2"), function()
        local showData ={}
        showData.tempId = 30018
        showData.showType = ShowType.FightSoul
        UIUtil.OpenThingsDetailWindow(showData)
    end)

    UIUtil.AddBtnEvent(rc:GetObject("Button3"), function()
        local showData ={}
        showData.tempId = 101804
        showData.showType = ShowType.CardSkin
        UIUtil.OpenThingsDetailWindow(showData)
    end)


    ---@type HintComponent
    local hintComponent = Game.Scene:GetComponent("HintComponent")
    ---@type HintNode
    self.ActivityHint = hintComponent.Activity



    this.eventId = eventId
    this.config = Z_GameEvents[eventId]
    this.tabList = {}
    this.taskItemList = { this.taskItem }
    for i = this.tabLayout.childCount - 1, 0, -1 do
        local index = this.tabLayout.childCount - i
        local child = this.tabLayout:GetChild(i)
        this.tabList[index] = {}
        this.tabList[index].maskText = child:Find("Mask/Text").gameObject
        this.tabList[index].maskImage = child:Find("Mask/Image").gameObject
        local hint = child:Find("Hint").gameObject
        this.tabList[index].hint = hint
        hint:SetActive(false)
        this.tabList[index].enable = false

        local mask = child:Find("Mask").gameObject
        local active = child:Find("Active").gameObject

        mask:SetActive(true)
        active:SetActive(false)
        this.tabList[index].mask = mask
        this.tabList[index].active = active

        LangUtil.BindText(child:Find("Mask/Text")).text = index
        LangUtil.BindText(child:Find("Active/Text")).text = index
        UIUtil.AddBtnEventNoBug(child, function()
            if this.tabList[index].enable then
                OnTabClick(self, index)
            end
        end)
    end

    this.moduleDataList = {}
    local GetAllButton = rc:GetObject("GetAllButton")
    LangUtil.BindText(GetAllButton.transform:Find("Text")).text = LangUtil.GetSysLang(311) -- 一键领取
    UIUtil.AddBtnEvent(GetAllButton, function()
        local groups = {}
        for index, value in ipairs(this.tabList) do
            if value.enable then
                table.insert(groups, this.moduleDataList[index].config.ModuleParams[1])
            end
        end

        if table.count(groups) == 0 then
            return
        end
        PublicRequest.SendRequest(
            PROTOCOL.TaskSubmitByGroupReq,
            {
                type = TaskType.TaskTypeGameEvent,
                groups = groups,
            },
            function(response)
                UIPublic.OpenRewardUI(response.reward_result)
            end
        )
    end)
end

---@param self UIGameEventMainView
function this.OnRefresh(self)
    ---@type GameEventComponent
    local gameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")
    this.moduleDataList = {}
    local eventHint = self.ActivityHint:GetChild(this.eventId)

    for key, value in pairs(this.config) do
        if value.ShowParams ~= nil and value.ShowParams[1] ~= nil then
            local moduleData = gameEventComponent:GetGameEventModule(value.ModuleId)
            this.tabList[value.ShowParams[1]].enable = moduleData.status == GameEventStatus.GameEventStatusInProgress
            this.tabList[value.ShowParams[1]].maskText:SetActive(moduleData.status == GameEventStatus.GameEventStatusInProgress)
            this.tabList[value.ShowParams[1]].maskImage:SetActive(moduleData.status ~= GameEventStatus.GameEventStatusInProgress)
            this.moduleDataList[value.ShowParams[1]] = moduleData

            if eventHint ~= nil then
                local moduleHint = eventHint:GetChild(value.ModuleId)
                if moduleHint ~= nil then
                    moduleHint:AddObject(this.tabList[value.ShowParams[1]].hint, "NewbieTaskDayTab")
                end
            else
                this.tabList[value.ShowParams[1]].hint:SetActive(false)
            end
    
        end
    end

    OnTabClick(self, this.index or 1)
end

---@param self UIGameEventMainView
function this.OnGameEventUpdate(self)
    this.OnRefresh(self)
end

---@param self UIGameEventMainView
function this.OnTaskUpdate(self)
    OnTabClick(self, this.index)
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
    -- local seconds
    -- if self.currentTaskType == TaskType.TaskTypeDaily then
    --     seconds = TimeUtil.GetWeekLastSeconds()
    -- elseif self.currentTaskType == TaskType.TaskTypeWeekly then
    --     seconds = TimeUtil.GetWeekLastSeconds(1)
    -- else
    --     seconds = 0
    -- end

    local tb = TimeUtil.ConvertTimeForm(seconds)
    -- if self.currentTaskType == 6 or self.currentTaskType == 5  then
    --     if tb.day > 0 then
    --         self.lastTimeText.text = string.format(LangUtil.GetSysLang(904).." %d"..LangUtil.GetSysLang(2005).." %02d:%02d:%02d", tb.day, tb.hour, tb.minute, tb.second)
    --     else
    --         self.lastTimeText.text = string.format(LangUtil.GetSysLang(904).." %02d:%02d:%02d", tb.hour, tb.minute, tb.second)
    --     end
    -- else
        if tb.day > 0 then
            return LangUtil.GetSysLang(1326) .. string.format("%d"..LangUtil.GetSysLang(2005).." %02d:%02d:%02d", tb.day, tb.hour, tb.minute, tb.second)
        else
            return LangUtil.GetSysLang(1326) .. string.format("%02d:%02d:%02d", tb.hour, tb.minute, tb.second)
        end
    -- end
end

return this