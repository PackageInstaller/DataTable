---@class NewbieTaskPage : NewbieTaskPage__Generate
---##################### 【NewbieTaskPage Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【NewbieTaskPage Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local NewbieTaskPage = require "NewbieTaskPage_Generate"

function NewbieTaskPage:InitLogic(data)
    self.activityId = 0
    self.activityContent = nil
    self._dayBtns = {}
    self.newbieDay = 1
    self.selectedDay = 1
end

function NewbieTaskPage:RefreshPage(activityId, content)
    -- print("NewbieTaskPage:RefreshPage")
    --积分奖励
    self.activityId = activityId
    self.activityContent = content
    -- local userDataInfo = ClientData:GetUserDataInfo()
    -- self.newbieDay = userDataInfo.NewbieDay
    -- self.newbieDay = math.max(1, self.newbieDay)
    -- self.selectedDay = self.newbieDay
    self:_SetNewbieDay()
    self:_RefreshInfo()
    self:_RefreshDayBtns()
    self:_RefreshDayBtnsState()
    DLuaTimer:DoAfter(0.1, function()
        --延迟等待列表加载完成
        self:_ScrollToSelectedDay()
    end)
end

function NewbieTaskPage:_SetNewbieDay()
    local activityInfo = ClientData:GetActivityInfo(self.activityId)
    local newbieDay = math.ceil((ClientData:GetNextResetTime() - activityInfo.startTime)/3600/24.0)
    self.newbieDay = newbieDay
    self.selectedDay = newbieDay
end

function NewbieTaskPage:_RefreshInfo()
    self:_RefreshBonusPoints()
    self:_SetNewbieTaskList()
    self:_RefreshTaskList()
    self:_RefreshDayBtnsState()
end

function NewbieTaskPage:_RefreshBonusPoints()
    local activityInfo = ClientData:GetActivityInfo(self.activityId)
    self.pointsText.text.text = activityInfo.points
    local itemIconPath = Config.SpritePath.Item
    local maxPoint = 0
    local lastPoint = 0
    for index, info in ipairs(self.activityContent) do
        local rewardPoint = info[2]
        local awardInfo = info[3]
        local rewardBtn = self.bonusPoints["rewardBtn"..index]
        if (rewardBtn) then
            local iconImg = awardInfo[2]
            if (awardInfo[1] == GE.RewardType.Cat) then
                itemIconPath = Config.SpritePath.CatHeadIcon
                local catConfig = Config.GetCatConfigInfo(awardInfo[2])
                iconImg = catConfig.MiniIcon
            else
                itemIconPath = Config.SpritePath.Item
            end
            local iconPath = string.format(itemIconPath, iconImg)
            rewardBtn.icon:SetActive(true)
            self:LoadSpriteAsync(iconPath, rewardBtn.icon.image)
            rewardBtn.numText.text.text = awardInfo[3]
            rewardBtn.pointText.text.text = rewardPoint..LocalStrEnum["UI_RankPanel_pointStr"]
            local isClaimed = tablex.contains(activityInfo.claimedRewards, index)
            rewardBtn.getMask:SetActive(isClaimed)
            rewardBtn.scaleButton.onClick:RemoveAllListeners()
            if (not isClaimed and activityInfo.points >= rewardPoint) then
                rewardBtn.rewardMask:SetActive(true)
                rewardBtn.scaleButton.onClick:AddListener(function()
                    Me:GetActivityPointsBonusReq(self.activityId, index, function()
                        self:_RefreshBonusPoints()
                    end)
                end)
            else
                rewardBtn.rewardMask:SetActive(false)
            end
        end
        lastPoint = maxPoint
        maxPoint = math.max(maxPoint, rewardPoint)
        self.bonusPoints["pointsSlider"..index].slider.value = (activityInfo.points - lastPoint) / (maxPoint - lastPoint)
    end
    -- self.bonusPoints.pointsSlider.slider.value = activityInfo.points / maxPoint
end

function NewbieTaskPage:_SetNewbieTaskList()
    local taskTable = Config.GetAllConfig("TaskTable")
    self.newbieTaskList = {}
    self.newbieTaskKeyList = {}
    for _, taskInfo in pairs(taskTable) do
        if (taskInfo.taskType == GE.MissionType.Newbie) then
            if (not self.newbieTaskList[taskInfo.condition[2]]) then
                self.newbieTaskList[taskInfo.condition[2]] = {}
            end
            table.insert(self.newbieTaskList[taskInfo.condition[2]], taskInfo)
        end
    end
    local maxDay = 0
    for k, v in pairs(self.newbieTaskList) do
        maxDay = math.max(maxDay, k)
        table.insert(self.newbieTaskKeyList, k)
    end
    table.sort(self.newbieTaskKeyList, function(a,b)
        return a < b
    end)

    self.selectedDay = math.min(self.selectedDay, maxDay)
end

function NewbieTaskPage:_RefreshDayBtns()
    -- local userDataInfo = ClientData:GetUserDataInfo()
    self._dayBtns = {}
    -- local showBtnsCnt = math.min(#self.newbieTaskKeyList, userDataInfo.NewbieDay)
    self:FillTemplateContent(self.dayBtn, self.dayBtnContent, #self.newbieTaskKeyList, function (index, dayBtn)
		dayBtn.dayText.text.text = string.format(LocalStrEnum["TipDayNum"]," <size=32>"..index.."</size> ")
        dayBtn.selectedDayText.text.text = string.format(LocalStrEnum["TipDayNum"]," <size=32>"..index.."</size> ")
        dayBtn.lockMask:SetActive(index > self.newbieDay)
        if (index <= self.newbieDay) then
            dayBtn.clickListener.onClickEvent = function ()
                self.selectedDay = index
                self:_RefreshInfo()
                self:_RefreshDayBtnsState()
            end
        else
            dayBtn.clickListener.onClickEvent = nil
        end
        self._dayBtns[index] = dayBtn
	end)
end

function NewbieTaskPage:_RefreshDayBtnsState()
    for index, dayBtn in pairs(self._dayBtns) do
        dayBtn.selectedMask:SetActive(self.selectedDay == index)

        --红点提示
        dayBtn.dayRedPoint:SetActive(false)
        -- local userDataInfo = ClientData:GetUserDataInfo()
        local taskList = self.newbieTaskList[index]
        for k,v in pairs(taskList) do
            local taskInfo = ClientData:GetTaskInfo(v.id)
            if taskInfo.state == GE.MissionState.Unclaimed and index <= self.newbieDay then
                dayBtn.dayRedPoint:SetActive(true)
                break
            end
        end
    end
end

function NewbieTaskPage:_RefreshTaskList()
    local taskKey = self.newbieTaskKeyList[self.selectedDay]
    local taskList = self.newbieTaskList[taskKey]
    -- print("taskConfig",tablex.dump(taskList))
    local itemIconPath = Config.SpritePath.Item
    local canGetCnt = 0
    table.sort(taskList, function(a, b)
        local taskInfoA = ClientData:GetTaskInfo(a.id)
        local taskInfoB = ClientData:GetTaskInfo(b.id)
        if (taskInfoA.state ~= taskInfoB.state and taskInfoA.state == GE.MissionState.Unclaimed) then
            return true
        end
        if (taskInfoA.state ~= taskInfoB.state and taskInfoB.state == GE.MissionState.Received) then
            return true
        end
        return false
    end)
    self:FillTemplateContent(self.taskBox, self.taskContent, #taskList, function (index, taskBox)
        local taskConfig = taskList[index]
        local taskInfo = ClientData:GetTaskInfo(taskConfig.id)
        local taskProgressTarget = Me:getTaskProgressTarget(taskConfig.id)
        taskBox.taskTitleText.text.text = string.format("%s(%s/%s)",LocalStrEnum[taskConfig.taskName],taskInfo.progress, taskProgressTarget)
        taskBox.getBtn:SetActive(taskInfo.state == GE.MissionState.Unclaimed)
        taskBox.goBtn:SetActive(taskInfo.state == GE.MissionState.Progress and taskConfig.TurnTo ~= nil)
        taskBox.goBtnGery:SetActive(taskInfo.state == GE.MissionState.Progress and not taskConfig.TurnTo)
        taskBox.lockMask:SetActive(self.selectedDay > self.newbieDay)
        taskBox.claimedImg:SetActive(taskInfo.state == GE.MissionState.Received)
        taskBox.getBtn.scaleButton.onClick:RemoveAllListeners()
        taskBox.getBtn.scaleButton.onClick:AddListener(function()
            local missionId = {
                taskConfig.id
            }
            Me:GetMissionRewardReq(missionId, function(data)
                self:_RefreshTaskList()
                self:_RefreshDayBtnsState()
            end)
        end)
        if (taskInfo.state == GE.MissionState.Unclaimed) then
            canGetCnt = canGetCnt + 1
        end
        if taskConfig.Award[1] ==  GE.AwardType.Common then
            self:FillTemplateContent(self.itemBox, taskBox.rewardGroup, #taskConfig.Award[2], function(key, itemBox)
                itemBox:SetActive(true)
                local itemData = Config.GetItemPropInfo(taskConfig.Award[2][key][2])
                self:LoadSpriteAsync(string.format(itemIconPath, itemData.id), itemBox.itemIcon.image)
                local itemBgPath = Config.SpritePath.ItemPropBg
                local iconPath = string.format(itemBgPath, itemData.Quality)
                self:LoadSpriteAsync(iconPath, itemBox.itemBgIcon.image)
                itemBox.itemNum.text.text = "x"..taskConfig.Award[2][key][3]
            end)
        end
        taskBox.goBtn.scaleButton.onClick:RemoveAllListeners()
        if (taskConfig.TurnTo) then
            if (taskConfig.TurnTo[1] == GE.TurnToType.OpenUI) then
                taskBox.goBtn.scaleButton.onClick:AddListener(function()
                    UIMgr:closeUI("ActivityPanel")
                    local uiName = taskConfig.TurnTo[2][1]
                    UIMgr:popUI(uiName)
                end)
            end
        end
	end)

    self.getAllRoot:SetActive(canGetCnt > 1)
end

function NewbieTaskPage:_ScrollToSelectedDay()
    local viewProtW = self.daysBtnViewport.rectTransform.rect.width - self.dayBtnContent.rectTransform.rect.width
    if (viewProtW < 0) then
        local cellX = self.dayBtn.rectTransform.rect.width
        local spacingX = self.dayBtnContent.horizontalLayoutGroup.spacing
        local length = (self.selectedDay - 1) * (cellX + spacingX) * -1
        length = math.max(length, viewProtW)
        self.dayBtnContent.rectTransform:DoMoveToX(length, 0.5)
    end
end

--function NewbieTaskPage:OnDestroy()
--	self.super:OnDestroy(self)
--end

--[[
/TaskGroup/TaskGroup1/GetAllRoot/GetAllBg/GetAllBtn onClick 
--]]
function NewbieTaskPage:getAllBtn_Button_onClick(getAllBtn)
    local missionId = {}
    local taskKey = self.newbieTaskKeyList[self.selectedDay]
    local taskList = self.newbieTaskList[taskKey]
    for index, taskConfig in pairs(taskList) do
        local taskInfo = ClientData:GetTaskInfo(taskConfig.id)
        if (taskInfo.state == GE.MissionState.Unclaimed) then
            table.insert(missionId, taskConfig.id)
        end
    end
    Me:GetMissionRewardReq(missionId, function(data)
        self:_RefreshInfo()
    end)
end

return NewbieTaskPage
