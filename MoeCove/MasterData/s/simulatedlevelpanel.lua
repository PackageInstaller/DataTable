---@class SimulatedLevelPanel : SimulatedLevelPanel_Generate
---##################### 【SimulatedLevelPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SimulatedLevelPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SimulatedLevelPanel = require "SimulatedLevelPanel_Generate"

function SimulatedLevelPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshSimulatedLevel, self.setFloorData},
    }
    self.maxLevelCount = 6 --最大关卡数
end

--function SimulatedLevelPanel:StartCreating(time)
--
--end

--function SimulatedLevelPanel:StartEnter(time)
--
--end

--function SimulatedLevelPanel:StartRemoving(time)
--
--end

--function SimulatedLevelPanel:StartExit(time)
--
--end

function SimulatedLevelPanel:OnOpen(data, initiative)
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.SimulatedLevelPanel)
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        self:animationAndClose()
        --清空返回方法
        self.customBackPanel.customBackPanel:ClearBackFunc()
    end)
    self:setFloorData()
    self:setCountdown()
    LoadingMgr:SetLoadingOver(nil, nil, "SimulatedLevelPanel")
end

function SimulatedLevelPanel:setFloorData()
    local activityData = Me:getSimulatedActivityData()
    local nowFloorId = 1001
    local floorConfig, floorData = {}, {}
    local floorConfigMap = Config.GetAllConfig("PveExerciseStoreyTable")
    local floorConfigList = {}
    for _, value in pairs(floorConfigMap) do
        table.insert(floorConfigList, value)
    end
    table.sort(floorConfigList, function(a, b)
        return a.storeyNum < b.storeyNum
    end)

    --判断当前层
    local isFinish = true
    local isMaxFloor = false
    for index, fConfig in pairs(floorConfigList) do
        floorData = activityData.simulatedLevelMap and activityData.simulatedLevelMap[fConfig.id] or {}
        if not next(floorData) or not floorData.getReward then
            nowFloorId = fConfig.id
            floorConfig = fConfig
            isFinish = false
            if index == #floorConfigList then
                isMaxFloor = true
            end
            break
        end
    end
    if isFinish then
        nowFloorId = floorConfigList[#floorConfigList].id
        floorConfig = floorConfigList[#floorConfigList]
    end
    local nowProgress = 0
    for _, levelId in pairs(next(floorData) and floorData.levelList or {}) do
        local levelConfig = Config.GetPveExerciseLevelInfo(levelId)
        if levelConfig then
            nowProgress = nowProgress + levelConfig.progressReward
        end
    end

    --显示历史层及可扫荡层
    local quickFloor = 0
    local nowFloor = floorConfig.storeyNum
    local hisMaxFloor = activityData and activityData.maxFloor
    if nowFloor > hisMaxFloor then
        hisMaxFloor = nowFloor - 1
    end
    if hisMaxFloor - Config.GetConfigInfo("PveExerciseStoreyPass") > 0 then
        quickFloor = hisMaxFloor - Config.GetConfigInfo("PveExerciseStoreyPass")
    end
    self.historyTxt.text.text = string.format(LocalStrEnum.PveExerciseFloorNum, hisMaxFloor ~= 0 and hisMaxFloor or "--")
    self.quickTxt.text.text = string.format(LocalStrEnum.PveExerciseFloorNum, quickFloor ~= 0 and quickFloor or "--")

    --按钮状态
    self.canSweepBattle = false
    self.isNextFloor = false
    self.isInProgress = false
    self.noSweepFloor = false
    self.canGetReward = nowProgress >= floorConfig.progressNeed and (floorData and not floorData.getReward)
    if quickFloor >= 1 then
        --如果当前层小于等于可扫荡层，并且当前层没有数据或者当前层没有关卡数据且未领取奖励
        if (nowFloor <= quickFloor) and ((not next(floorData)) or ((not next(floorData.levelList)) and not floorData.getReward)) then
            self.canSweepBattle = true
        end
    end
    if self.canGetReward then
        self.goBtnTxt.text.text = LocalStrEnum.PveExerciseGerReward
        self.goBtnEng.text.text = "CLAIM REWARDS"
        self.tipsTxt.text.text = LocalStrEnum.PveExerciseGerRewardTips
    elseif self.canSweepBattle then
        self.goBtnTxt.text.text = LocalStrEnum.PveExerciseSweep
        self.goBtnEng.text.text = "SWEEP OPERATIONS"
    elseif isFinish then
        self.finishBtnTxt.text.text = LocalStrEnum.PveExerciseReceived
        self.finishBtnEng.text.text = "RECEIVED ALREADY"
    else
        if nowProgress > 0 then
            self.isInProgress = true
        elseif quickFloor == 0 then
            self.noSweepFloor = true
        else
            self.isNextFloor = true
        end
        self.finishBtnTxt.text.text = self.isInProgress and LocalStrEnum.PveExerciseGerReward or LocalStrEnum.PveExerciseSweep
        self.finishBtnEng.text.text = "SWEEP OPERATIONS"
    end
    if isFinish or isMaxFloor then
        self.tipsTxt.text.text = LocalStrEnum.PveExerciseHighestFloor
    end
    self.goBtn:SetActive(self.canGetReward or self.canSweepBattle)
    self.tipsBg:SetActive(self.canGetReward or isFinish or isMaxFloor)
    self.finishBtn:SetActive(not self.canGetReward and not self.canSweepBattle)

    self.nowFloorId = nowFloorId
    self.floorCountTxt.text.text = string.format(LocalStrEnum.PveExerciseFloorNum2, nowFloor)

    --层奖励格子
    self:FillTemplateContent(self.customBox, self.rewardList, #floorConfig.Reward, function (index,itemObj)
        local customBox = itemObj.customBox
        local rewardData = floorConfig.Reward[index]
        customBox:setMono(self)
        customBox:SetUIData(rewardData)
    end)

    --进度格子
    self:FillTemplateContent(self.progressBox, self.progressList, floorConfig.progressNeed, function (index,progressBox)
        progressBox.isActive:SetActive(index <= nowProgress)
    end)

    --关卡格子
    local levelConfigList = Config.GetPveExerciseLevelByIssueAndStorey(activityData.nowPeriod, nowFloor)
    self:FillTemplateContent(self.levelBox, self.levelBoxList, self.maxLevelCount, function (index,levelBox)
        local levelConfig = levelConfigList[index]

        --关卡索引序号
        self:LoadSpriteAsync(string.format(Config.SpritePath.SimulatedLevelNumIcon, index), levelBox.levelNum.image)
        --关卡背景
        self:LoadSpriteAsync(string.format(Config.SpritePath.SimulatedLevelTypeBg, levelConfig.quality), levelBox.boxBg.image)
        --英文标题
        self:LoadSpriteAsync(string.format(Config.SpritePath.SimulatedLevelEngIcon, levelConfig.quality), levelBox.levelDiffEng.image)

        --角色图片
        local function is_numeric(str)
            return tonumber(str) ~= nil
        end
        local skinConfig = Config.GetCharacterSkinInfo(levelConfig.pic)
        local resourceFolder = nil
        if is_numeric(skinConfig.resourceFolder) then
            resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
        else
            resourceFolder = skinConfig.resourceFolder
        end
        local CutRolePath = string.format(Config.SpritePath.CutRolePath, resourceFolder, skinConfig.halfimgKey)
        self:LoadSpriteAsync(CutRolePath, levelBox.roleIcon.image)
        --通关奖励进度
        local finishIdList = {}
        if activityData.simulatedLevelMap and next(activityData.simulatedLevelMap) and activityData.simulatedLevelMap[nowFloorId] then
            finishIdList = activityData.simulatedLevelMap[nowFloorId].levelList
        end
        levelBox.isClear:SetActive(tablex.find(finishIdList, levelConfig.id))
        levelBox.addNumTxt.text.text = "+"..levelConfig.progressReward

        --位置偏移及动画
        if not isFinish then
            levelBox.canvasGroup.alpha = 0
            levelBox.canvasGroup.interactable = false
            local isEvenNumber = 1
            if index % 2 == 0 then
                isEvenNumber = -1
            end
            DLuaTimer:DoAfter(0.05 * index, function()
                levelBox.boxBg.rectTransform.anchoredPosition = Vector2.New(0, isEvenNumber * 150)
                levelBox.canvasGroup:DOFade(1, 0.3):SetEase(DG.Tweening.Ease.InCubic)
                levelBox.boxBg.rectTransform:DOAnchorPos(Vector2.New(0, isEvenNumber * 30), 0.3):SetEase(DG.Tweening.Ease.InCubic):OnComplete(function()
                    levelBox.canvasGroup.interactable = true
                    self:setGuideTrigger(index, self.maxLevelCount)
                end)
            end)
        else
            self:setGuideTrigger(index, self.maxLevelCount)
        end
        
        --点击事件
        levelBox.scaleButton.onClick:RemoveAllListeners()
        levelBox.scaleButton.onClick:AddListener(function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            if self.isResetting then
                UICommonUtils.PopToast(LocalStrEnum.PveExerciseSettlingTips)
                self:animationAndClose()
                return
            end
            UIMgr:popUICover("SimulatedInfoPanel", {levelId = levelConfig.id})
        end)
    end)
end

--引导触发器
function SimulatedLevelPanel:setGuideTrigger(nowIndex, maxCount)
    if nowIndex == maxCount then
        GuideMgr:StartGuideTrigger("SimulatedLevelPanel")
    end
end

function SimulatedLevelPanel:OpenCustomMsgPanel(data)
    self.customMsgPanel:SetActive(true)
    self.customMsgPanel.customMsgPanel:setMono(self)
    self.customMsgPanel.customMsgPanel:SetView(data)
end

--模拟演习界面倒计时
function SimulatedLevelPanel:setCountdown()
    if self.countDownTimer then
        DLuaTimer:RemoveTimer(self.countDownTimer)
    end
    self:timeChange()
    self.countDownTimer = DLuaTimer:DoRepeatForever(1, function()
        self:timeChange()
    end)
end

--模拟演习倒计时变化
function SimulatedLevelPanel:timeChange()
    local offsetStringMap = DLuaUtil.getNextWeekRemainingTime(Me.servertime, Me:getTimeZone())
    if offsetStringMap.day == 0 and offsetStringMap.hour == 0 and offsetStringMap.min < 10 then
        self.resetTimeTxt.text.text = LocalStrEnum.PveExerciseSettling
        self.isResetting = true
    elseif offsetStringMap.day == 0 then
        self.resetTimeTxt.text.text = string.format("%d时%d分", offsetStringMap.hour, offsetStringMap.min)
    else
        self.resetTimeTxt.text.text = string.format("%d天%d时", offsetStringMap.day, offsetStringMap.hour)
    end
end

--变换为已领取按钮
function SimulatedLevelPanel:changeToFinishBtn()
    self.finishBtn:SetActive(true)
    self.goBtn:SetActive(false)
    self.tipsBg:SetActive(false)
    self.finishBtnTxt.text.text = LocalStrEnum.PveExerciseReceived
    self.finishBtnEng.text.text = "RECEIVED ALREADY"
end

--界面关闭
function SimulatedLevelPanel:animationAndClose()
    self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = false
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
        self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = true
    end)
end

--function SimulatedLevelPanel:OnClose(initiative)
--
--end

function SimulatedLevelPanel:OnDestroy()
	if self.countDownTimer then
        DLuaTimer:RemoveTimer(self.countDownTimer)
    end
    self.super:OnDestroy(self)
end

--function SimulatedLevelPanel:OnRefresh(data)
--
--end

--[[
/LevelBtnInfo/GoBtn onClick 
--]]
function SimulatedLevelPanel:goBtn_ScaleButton_onClick(goBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.isResetting then
        UICommonUtils.PopToast(LocalStrEnum.PveExerciseSettlingTips)
        self:animationAndClose()
        return
    end
    if self.canGetReward then
        Me:getSimulatedAwardReq({floorId = self.nowFloorId}, function()
            GameMsgMgr:sendEvent(GameMsgType.RefreshSimulatedLevel)
        end)
    elseif self.canSweepBattle then
        UIMgr:popUICover("BattleRepeatPanel", {battleType = GE.LevelBattleType.Simulated})
    end
end

--[[
/LevelBtnInfo/FinishBtn onClick 
--]]
function SimulatedLevelPanel:finishBtn_ScaleButton_onClick(finishBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.isResetting then
        UICommonUtils.PopToast(LocalStrEnum.PveExerciseSettlingTips)
        self:animationAndClose()
        return
    end
    if self.isInProgress then
        UICommonUtils.PopToast(LocalStrEnum.PveExerciseRewardFailed)
    end
    if self.noSweepFloor then
        UICommonUtils.PopToast(LocalStrEnum.PveExerciseSweepNone)
    end
    if self.isNextFloor then
        UICommonUtils.PopToast(LocalStrEnum.PveExerciseSweepFailed)
    end
end

--[[
/PreviewRewardBtn onClick 
--]]
function SimulatedLevelPanel:previewRewardBtn_ScaleButton_onClick(previewRewardBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.isResetting then
        UICommonUtils.PopToast(LocalStrEnum.PveExerciseSettlingTips)
        self:animationAndClose()
        return
    end
    UIMgr:popUICover("SimulatedRewardPanel")
end

return SimulatedLevelPanel
