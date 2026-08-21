---@class WeeklyBossAchievementPanel : WeeklyBossAchievementPanel_Generate
---##################### 【WeeklyBossAchievementPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【WeeklyBossAchievementPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local WeeklyBossAchievementPanel = require "WeeklyBossAchievementPanel_Generate"

function WeeklyBossAchievementPanel:InitLogic(data)
    self.finishTaskIdList = {}
end

--function WeeklyBossAchievementPanel:StartCreating(time)
--
--end

--function WeeklyBossAchievementPanel:StartEnter(time)
--
--end

--function WeeklyBossAchievementPanel:StartRemoving(time)
--
--end

--function WeeklyBossAchievementPanel:StartExit(time)
--
--end

function WeeklyBossAchievementPanel:OnOpen(data, initiative)
    self.closeFunc = data.closeFunc
    self:setBossData()
end

--设置boss数据
function WeeklyBossAchievementPanel:setBossData()
    self.bossActData = Me:getBossActivityData()
    local bossBattleCfg = Config.GetPveBossBattleInfoByIssue(self.bossActData.nowPeriod)
    local bossBattleLevelCfg = Config.GetAllConfig("PveBossBattleLevelTable")
    self.bossLevelList = {}
    for _, value in pairs(bossBattleLevelCfg) do
        table.insert(self.bossLevelList, value)
    end
    table.sort(self.bossLevelList, function(a, b)
        return a.id < b.id
    end)
    --初始化任务表数据
    self:initBossTaskList()
    self:setBossBox(1)
end

function WeeklyBossAchievementPanel:setBossBox(selIndex)
    --boss列表
local bossBattleCfg = Config.GetPveBossBattleInfoByIssue(self.bossActData.nowPeriod)
    self:FillTemplateContent(self.bossBox, self.bossContent, #self.bossLevelList, function (index, bossBox)
        local bossLevelConfig = self.bossLevelList[index]
        local bossId = bossLevelConfig.id
        local isOpen = tablex.find(bossBattleCfg.BossBattleId, bossId)
        --boss头像
        local roleId = bossLevelConfig.Icon
        local CutRolePath = string.format(Config.SpritePath.CutRolePath, roleId, "CutRole_"..roleId)
        self:LoadSpriteAsync(CutRolePath, bossBox.bossIcon.image)
        bossBox.notOpen:SetActive(not isOpen)
        bossBox.redPoint:SetActive(RedPointMgr:WeeklyBossAchievementPanelBossToggleRedJudge(bossId))
        --选择逻辑
        bossBox.scaleButton.onClick:RemoveAllListeners()
        bossBox.scaleButton.onClick:AddListener(function()
            if not isOpen then
                return
            end
            --选中当前Boss
            self:selectBossBox(bossId, bossBox)
        end)
        if selIndex and index == selIndex then
            self:selectBossBox(bossId, bossBox)
        end
    end)
end

--选中Boss逻辑
function WeeklyBossAchievementPanel:selectBossBox(bossId, bossBox)
    if UICommonUtils.Checkobj(self.nowSelectBoxObj) then
    self.nowSelectBoxObj.isSelect:SetActive(false)
    end
    self.nowSelectBossId = bossId
    self.nowSelectBoxObj = bossBox
    self.nowSelectBoxObj.isSelect:SetActive(true)
    self:updateAchievementList()
end

--初始化任务列表
function WeeklyBossAchievementPanel:initBossTaskList()
    self.bossTaskDataMap = {}
    local achiTaskCfglist = Config.GetTaskInfoByTaskType(GE.MissionType.BossTask)
    for _, taskCfg in pairs(achiTaskCfglist) do
        if not self.bossTaskDataMap[taskCfg.type] then
            self.bossTaskDataMap[taskCfg.type] = {}
        end
        local taskData = Me:getMissionListById(taskCfg.id)
        table.insert(self.bossTaskDataMap[taskCfg.type], {taskCfg = taskCfg, taskData = taskData})
    end

    --排序
    for key, value in pairs(self.bossTaskDataMap) do
        table.sort(value, function(a, b)
            if a.taskData.state == b.taskData.state then
                return a.taskData.id < b.taskData.id
            else
                return a.taskData.state < b.taskData.state
            end
        end)
    end
end

--更新成就列表
function WeeklyBossAchievementPanel:updateAchievementList()
    local taskList = self.bossTaskDataMap[self.nowSelectBossId] or {}
    --LuaLogger.ds(">>>>>>taskList", tablex.dump(taskList))
    self:FillTemplateContent(self.rewardBox, self.content, #taskList, function (index, rewardBox)
        rewardBox.canvasGroup.alpha = 0
        local taskConfig = taskList[index].taskCfg
        self:FillTemplateContent(self.customBox, rewardBox.rewardList, #taskConfig.Award, function (index2,itemObj)
            local customBox = itemObj.customBox
            local rewardData = taskConfig.Award[index2]
            --[[local data = {
                id = rewardData[2],
            }
            local needConfig, needType = nil, 1
           if rewardData[1] == GE.RewardType.ItemProp then
                needType = GE.CustomMsgType.Item
                needConfig = Config.GetItemInfo(rewardData[2])
                data.itemType = GE.ItemTypeIndex.item
            elseif rewardData[1] == GE.RewardType.Equipment then
                needType = GE.CustomMsgType.Equip
                needConfig = Config.GetEquipmentInfo(rewardData[2])
                data.itemType = GE.ItemTypeIndex.equip
            elseif rewardData[1] == GE.RewardType.Weapon then
                needType = GE.CustomMsgType.Weapon
                needConfig = Config.GetWeaponInfo(rewardData[2])
                data.itemType = GE.ItemTypeIndex.weapon
            end
            if rewardData[3] ~= 0 then
                data.itemNum = rewardData[3]
            end
            data.listener = function()
                UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
                local data = {
                    type = needType,
                    config = needConfig,
                    Id = rewardData[2],
                }
                self:OpenCustomMsgPanel(data)
            end]]
            customBox:setMono(self)
            customBox:SetUIData(rewardData)
        end)

        --领取奖励按钮逻辑
        rewardBox.taskGetBtn.button.onClick:RemoveAllListeners()
        rewardBox.taskGetBtn.button.onClick:AddListener(function()
            self:getBossTaskReward({taskConfig.id})
        end)

        local taskData = taskList[index].taskData

        local taskProgressTarget = Me:getTaskProgressTarget(taskData.id, GE.MissionSystemType.task)
        rewardBox.taskDesc.text.text = taskConfig.TaskSynopsis
        local showTaskProgress = taskData.progress < taskProgressTarget and taskData.progress or taskProgressTarget
        if showTaskProgress == taskProgressTarget then
            rewardBox.taskType.text.text = string.format("%s  (<color=#1b83d9>%s</color><color=#838383>/%s</color>)", taskConfig.taskName, showTaskProgress, taskProgressTarget)
        else
            rewardBox.taskType.text.text = string.format("%s  (<color=#e8703b>%s</color><color=#838383>/%s</color>)", taskConfig.taskName, showTaskProgress, taskProgressTarget)
        end
        rewardBox.progressFull:SetActive(showTaskProgress >= taskProgressTarget)
        rewardBox.progressing:SetActive(showTaskProgress < taskProgressTarget)
        rewardBox.progressing.image.fillAmount = showTaskProgress / taskProgressTarget
        local isGetReward = taskData.state == GE.MissionState.Received--任务奖励已领取
        local isFinish = taskData.state == GE.MissionState.Unclaimed--任务已完成，未领取奖励
        rewardBox.taskOkBtn:SetActive(isGetReward)
        rewardBox.mask:SetActive(isGetReward)
        rewardBox.taskGetBtn:SetActive(isFinish)

        --显示动画
        DLuaTimer:DoAfter(0.05 * index, function()
            rewardBox.canvasGroup:DOFade(1, 0.2)
        end)
    end)

    local bossLevelData = self.bossActData.bossLevelMap and self.bossActData.bossLevelMap[self.nowSelectBossId] or {}
    local maxDifficulty = bossLevelData.maxDifficulty and bossLevelData.maxDifficulty ~= 0 and bossLevelData.maxDifficulty or nil
    local maxScore = bossLevelData.maxScore and bossLevelData.maxScore ~= 0 and bossLevelData.maxScore or nil
    self.historyDiffTxt.text.text = maxDifficulty and LocalStrEnum[string.format("BossBattleLevelDiff_%s", maxDifficulty)] or "暂无记录"
    self.historyScoreTxt.text.text = maxScore and string.format("%s分", maxScore) or "————"

    --筛选可领取任为id
    self.finishTaskIdList = {}
    for _, taskMap in pairs(taskList) do
        local taskCfg = taskMap.taskCfg
        local taskData = taskMap.taskData
        local isFinish = taskData.state == GE.MissionState.Unclaimed--任务已完成，未领取奖励
        if isFinish then
            table.insert(self.finishTaskIdList, taskCfg.id)
        end
    end
    self.oneClickBtn:SetActive(#self.finishTaskIdList > 0)
    self.oneClickDisable:SetActive(#self.finishTaskIdList == 0)
end

--领取奖励按钮逻辑
function WeeklyBossAchievementPanel:getBossTaskReward(idList)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    Me:GetMissionRewardReq(idList, function()
        self:initBossTaskList()
        self:updateAchievementList()
        self:setBossBox()
        GameMsgMgr:sendEvent(GameMsgType.RedPointRefresh)
    end)
end

function WeeklyBossAchievementPanel:OpenCustomMsgPanel(data)
    self.customMsgPanel:SetActive(true)
    self.customMsgPanel.customMsgPanel:SetPassEventState(false)
    self.customMsgPanel.customMsgPanel:setMono(self)
    self.customMsgPanel.customMsgPanel:SetView(data)
end

--界面关闭
function WeeklyBossAchievementPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        if self.closeFunc then
            self.closeFunc()
        end
        UIMgr:closeSpecificUI(self)
    end)
end

--function WeeklyBossAchievementPanel:OnClose(initiative)
--
--end

--function WeeklyBossAchievementPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function WeeklyBossAchievementPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function WeeklyBossAchievementPanel:mask_Button_onClick(mask)
    self:playCloseAnim()
end

--[[
/BoxBg/OneClickBtn onClick 
--]]
function WeeklyBossAchievementPanel:oneClickBtn_ScaleButton_onClick(oneClickBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:getBossTaskReward(self.finishTaskIdList)
end

return WeeklyBossAchievementPanel
