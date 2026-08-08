---@class ActivityCommonTaskPanel : ActivityCommonTaskPanel_Generate
---##################### 【ActivityCommonTaskPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ActivityCommonTaskPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ActivityCommonTaskPanel = require "ActivityCommonTaskPanel_Generate"

function ActivityCommonTaskPanel:InitLogic(data)

end

--function ActivityCommonTaskPanel:StartCreating(time)
--
--end

--function ActivityCommonTaskPanel:StartEnter(time)
--
--end

--function ActivityCommonTaskPanel:StartRemoving(time)
--
--end

--function ActivityCommonTaskPanel:StartExit(time)
--
--end

function ActivityCommonTaskPanel:OnOpen(data, initiative)
    self:initData(data)
    if initiative then
        self:initUI()
    end
    self:refreshUI()
end

function ActivityCommonTaskPanel:initData(data)
    self.tabIndexList = data.tabIndexList
    self.curSelType = self.tabIndexList[1]
    self.taskTable = {}
    self.tabList = {}
    self.curShowTaskData = {}
    local missionList = Me:getMissionList()
    for k, v in pairs(missionList) do
        local taskConfig = Config.GetTaskTableInfo(v.id)
        if taskConfig then
            local temp = {
                server = v, config = taskConfig
            }
            if taskConfig.taskType == GE.MissionType.ActivityTask 
            and tablex.find(self.tabIndexList, taskConfig.type) then
                if not self.taskTable[taskConfig.type] then
                    self.taskTable[taskConfig.type] = {}
                end
                table.insert(self.taskTable[taskConfig.type], temp)
            end
        end
    end
    for _, list in pairs(self.taskTable) do
        table.sort(list, function(a, b)
            if a.server.state ~= b.server.state then
                return a.server.state < b.server.state
            else
                return a.server.id < b.server.id
            end
        end)
    end
end

function ActivityCommonTaskPanel:initUI()
    self:FillTemplateContent(self.toggleBtn, self.toggleList, tablex.size(self.tabIndexList), function (index, itemObj)
        itemObj.isOn:SetActive(index == 1)
        itemObj.nameText.text.text = tostring(self.tabIndexList[index])
        itemObj.nameText2.text.text = tostring(self.tabIndexList[index])
        table.insert(self.tabList, {
            itemObj = itemObj,
            type = self.tabIndexList[index],
        })
        itemObj.scaleButton.onClick:RemoveAllListeners()
        itemObj.scaleButton.onClick:AddListener(function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            self.curSelType = self.tabIndexList[index]
            self:refreshUI()
        end)
    end)
    self.taskLoopList.loopListView2:InitListView(tablex.size(self.curShowTaskData), function(listView, index)
        local loopListViewItem2 = listView:GetShownItemByItemIndex(index)
        if loopListViewItem2 == nil then
            loopListViewItem2 = listView:NewListViewItem("CommonTaskBox")
        end
        local itemObj = loopListViewItem2.gameObject
        EngineUtil.FillPeer(self.commonTaskBox, itemObj)
        local taskData = self.curShowTaskData[index + 1]
        local taskProgressTarget = Me:getTaskProgressTarget(taskData.server.id, GE.MissionSystemType.task)
        itemObj.taskMsgTxt.text.text = taskData.config.TaskSynopsis

        local showTaskProgress = taskData.server.progress < taskProgressTarget and taskData.server.progress or taskProgressTarget
        if showTaskProgress == taskProgressTarget then
            itemObj.taskNameTxt.text.text = string.format("%s  (<color=#1b83d9>%s</color><color=#838383>/%s</color>)", taskData.config.taskName, showTaskProgress, taskProgressTarget)
        else
            itemObj.taskNameTxt.text.text = string.format("%s  (<color=#27ffed>%s</color><color=#838383>/%s</color>)", taskData.config.taskName, showTaskProgress, taskProgressTarget)
        end
        --itemObj.pointFull:SetActive(showTaskProgress == taskProgressTarget)
        -- itemObj.taskPoint.image.fillAmount = showTaskProgress / taskProgressTarget
        -- itemObj.inProgressText:SetActive(taskData.server.state == GE.MissionState.Progress)
        -- itemObj.finishText:SetActive(taskData.server.state == GE.MissionState.Received)
        itemObj.mask:SetActive(taskData.server.state == GE.MissionState.Received)
        if taskData.server.state == GE.MissionState.Unclaimed then
            itemObj.goToBtn.scaleButton.onClick:RemoveAllListeners()
            itemObj.getBtn:SetActive(true)
            itemObj.getBtn.scaleButton.onClick:AddListener(function()
                UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
                local missionId = {
                    taskData.server.id
                }
                Me:GetMissionRewardReq(missionId, function(data)
                    self.isNotRefreshCommonPoint = false
                    self:refreshUI()
                    --self:RefreshCommonPoint()
                end)
            end)
        else
            itemObj.getBtn:SetActive(false)
        end

        if taskData.server.state == GE.MissionState.Progress and taskData.config.TurnTo ~= 0 then
            itemObj.goToBtn:SetActive(true)
            itemObj.goToBtn.scaleButton.onClick:RemoveAllListeners()
            itemObj.goToBtn.scaleButton.onClick:AddListener(function()
                UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
                local canTurnTo = UICommonUtils.CanUseSkipJudge(taskData.config.TurnTo, true)
                if canTurnTo then
                    UICommonUtils.CommonTurnTo(taskData.config.TurnTo)
                end
            end)
        else
            itemObj.goToBtn:SetActive(false)
        end

        local rewardList = tablex.clone(taskData.config.Award)
        table.insert(rewardList, {GE.RewardType.ItemProp,Config.GetConfigInfo("TaskItem")[self.nowMode], taskData.config.extraScore})
        self:FillTemplateContent(self.customBox, itemObj.rewardList, tablex.size(rewardList), function(k, rewardObj)
            local customBox = rewardObj.customBox
            customBox:setMono(self)
            customBox:SetUIData(rewardList[k], { GE.NavigationType.TaskPanel})
        end)
        return loopListViewItem2
    end)
end
function ActivityCommonTaskPanel:refreshUI()
    for _, tab in pairs(self.tabList) do
        tab.itemObj.isOn:SetActive(tab.type == self.curSelType)
    end
    self.curShowTaskData = self.taskTable[self.curSelType] or {}
    self.taskLoopList.loopListView2:SetListItemCount(tablex.size(self.curShowTaskData))
    self.taskLoopList.loopListView2:RefreshAllShownItem2()
end

--function ActivityCommonTaskPanel:OnClose(initiative)
--
--end

--function ActivityCommonTaskPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function ActivityCommonTaskPanel:OnRefresh(data)
--
--end

--[[
/TaskLoopList/Viewport/Content/CommonTaskBox/GoToBtn onClick 
--]]
function ActivityCommonTaskPanel:goToBtn_ScaleButton_onClick(goToBtn)

end

--[[
/TaskLoopList/Viewport/Content/CommonTaskBox/GetBtn onClick 
--]]
function ActivityCommonTaskPanel:getBtn_ScaleButton_onClick(getBtn)

end

--[[
/ToggleBtn onClick 
--]]
function ActivityCommonTaskPanel:toggleBtn_ScaleButton_onClick(toggleBtn)

end

return ActivityCommonTaskPanel
