---@class WeeklyBossMainPanel : WeeklyBossMainPanel_Generate
---##################### 【WeeklyBossMainPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【WeeklyBossMainPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local WeeklyBossMainPanel = require "WeeklyBossMainPanel_Generate"

function WeeklyBossMainPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RedPointRefresh, function()
            self:refreshRedPoint()
        end},
    }

    self.fristOpen = false
end

--function WeeklyBossMainPanel:StartCreating(time)
--
--end

--function WeeklyBossMainPanel:StartEnter(time)
--
--end

--function WeeklyBossMainPanel:StartRemoving(time)
--
--end

--function WeeklyBossMainPanel:StartExit(time)
--
--end

function WeeklyBossMainPanel:OnOpen(data, initiative)
    self.fristOpen = true
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.WeeklyBossMainPanel)
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        self:animationAndClose()
        --清空返回方法
        self.customBackPanel.customBackPanel:ClearBackFunc()
    end)
    self:SetUIVolume()
    self:setBossData()
    self:setCountdown()
    self:refreshRedPoint()
    LoadingMgr:SetLoadingOver(nil, nil, "WeeklyBossMainPanel")
    GuideMgr:StartGuideTrigger("WeeklyBossMainPanel")
end

--设置当期Boss数据
function WeeklyBossMainPanel:setBossData()
    self.bossActData = Me:getBossActivityData()
    local bossBattleCfg = Config.GetPveBossBattleInfoByIssue(self.bossActData.nowPeriod)
    --当期boss列表
    local bossNum = #bossBattleCfg.BossBattleId
    self:FillTemplateContent(self.bossBox, self.bossBoxList, bossNum, function (index, bossBox)
        local bossId = bossBattleCfg.BossBattleId[index]
        local bossLevelConfig = Config.GetPveBossBattleLevelInfo(bossId)
        --boss头像
        self:LoadSpriteAsync(string.format(Config.SpritePath.WeeklybossIcon, bossLevelConfig.id), bossBox.headIcon.image)
        --boss名称
        bossBox.nameTxt.text.text = bossLevelConfig.Name
        --通关积分
        local bossData = self.bossActData.bossLevelMap and self.bossActData.bossLevelMap[bossId] or {}
        bossBox.maxScoreTxt.text.text = bossData.nowScore and bossData.nowScore ~= 0 and string.format("积分:%s分", bossData.nowScore) or "暂无积分"
        bossBox.maxScoreTxt.text.color = bossData.nowScore and bossData.nowScore ~= 0 and Color.NewFromStr("FBCE78") or Color.NewFromStr("656769")
        bossBox.scoreBg.image.enabled = bossData.nowScore and bossData.nowScore ~= 0
        --点击事件
        bossBox.button.onClick:RemoveAllListeners()
        bossBox.button.onClick:AddListener(function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            if self.isResetting then
                UICommonUtils.PopToast(LocalStrEnum.PveBossBattleSettlingTips)
                self:animationAndClose()
                return
            end
            --选中当前Boss
            self:selectBossBox(index, bossId, bossBox)
        end)
        --初始化选中
        if SeaMapMgr:getNowWeeklyBossIndex() == index then
            self:selectBossBox(index, bossId, bossBox)
        end
    end)
end

--选中boss格子方法
function WeeklyBossMainPanel:selectBossBox(index, bossId, bossBox)
    if UICommonUtils.Checkobj(self.nowSelectBoxObj) then
        self.nowSelectBoxObj.isSelect:SetActive(false)
        self.nowSelectBoxObj.rectTransform:DOSizeDelta(Vector2.New(296,121),0.2)
    end
    self.bossPicIcon.canvasGroup.alpha = 0
    self.effect_Ui_ZhouChangBoss_2:SetActive(false)
    SeaMapMgr:setNowWeeklyBossIndex(index)
    self.nowSelectBossId = bossId
    self.nowSelectBoxObj = bossBox
    self.nowSelectBoxObj.isSelect:SetActive(true)
    self.nowSelectBoxObj.rectTransform:DOSizeDelta(Vector2.New(337,121),0.2)
    self:refreshBossDetailInfo()
end

--刷新boss详情信息
function WeeklyBossMainPanel:refreshBossDetailInfo()
    local bossLevelConfig = Config.GetPveBossBattleLevelInfo(self.nowSelectBossId)
    --boss名称
    self.bossName.text.text = bossLevelConfig.Name
    --boss积分
    local bossData = self.bossActData.bossLevelMap and self.bossActData.bossLevelMap[self.nowSelectBossId] or {}
    self.nowBossScoreTxt.text.text = bossData.nowScore and bossData.nowScore ~= 0 and string.format("最高积分：%s分", bossData.nowScore) or "暂无积分"
    --优势角色
    local roleNum = #bossLevelConfig.AdvantageRole
    self:FillTemplateContent(self.roleBox, self.buffRoleList, roleNum, function (index, roleBox)
        local roleId = bossLevelConfig.AdvantageRole[index]
        local roleConfig = Config.GetCharacterInfo(roleId)
        local baseSkinID = roleConfig.baseSkinID
        local skinConfig = Config.GetCharacterSkinInfo(baseSkinID)
        local resourceFolder = tonumber(skinConfig.resourceFolder)
        local CutRolePath = string.format(Config.SpritePath.CutRolePath, resourceFolder, skinConfig.halfimgKey)
        self:LoadSpriteAsync(CutRolePath, roleBox.roleCutIcon.image)
        local RoleTypeIconPath = string.format(Config.SpritePath.RoleTypeIconPath, roleConfig.attribute)
        self:LoadSpriteAsync(RoleTypeIconPath, roleBox.shipTypeIcon.image)
    end)
    --boss难度
    local modeNum = #bossLevelConfig.LevelId
    self:FillTemplateContent(self.modeBox, self.modeBtnList, modeNum, function (index, modeBox)
        local levelId = bossLevelConfig.LevelId[index]
        modeBox.modeTypeTxt.text.text = tostring(index)

        --点击逻辑
        modeBox.scaleButton.onClick:RemoveAllListeners()
        modeBox.scaleButton.onClick:AddListener(function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            if self.isResetting then
                UICommonUtils.PopToast(LocalStrEnum.PveBossBattleSettlingTips)
                self:animationAndClose()
                return
            end
            self:selectMode(levelId, modeBox)
        end)
        local maxMode = bossData.maxDifficulty and bossData.maxDifficulty + 1 or 1
        maxMode = math.min(maxMode, modeNum)
        if index > maxMode then
            modeBox.isLocked:SetActive(true)
            modeBox.scaleButton.interactable = false
        else
            modeBox.isLocked:SetActive(false)
            modeBox.scaleButton.interactable = true
        end
        --默认选中能选中的最高难度
        if index == maxMode then
            self:selectMode(levelId, modeBox)
        end
    end)

    --boss立绘
    local roleId = bossLevelConfig.id
    local roleBreakBg = string.format(Config.SpritePath.WeeklybossPicture, roleId)
    self:LoadSpriteAsync(roleBreakBg, function (s)
        self.bossPicIcon.image.sprite = s
        if self.fristOpen then
            self.animator:SetTrigger("Init")
            self.bossPicIcon.canvasGroup:DOFade(1, 0.5):SetEase(DG.Tweening.Ease.InQuart)
        else
            self.bossPicIcon.canvasGroup:DOFade(1, 0.2):SetEase(DG.Tweening.Ease.InQuart)
        end
        self.effect_Ui_ZhouChangBoss_2:SetActive(true)
        self.fristOpen = false
    end)
    --显示当前积分倍率
    self:showCurrentScoreMul()
end

--显示当前积分倍率
function WeeklyBossMainPanel:showCurrentScoreMul()
    self.bossActData = Me:getBossActivityData()
    local bossData = self.bossActData.bossLevelMap and self.bossActData.bossLevelMap[self.nowSelectBossId] or {}
    local totalAddition = 1
    for _, tagId in pairs(bossData.tagList or {}) do
        local tagConfig = Config.GetPveBossBattleEffectInfo(tagId)
        totalAddition = totalAddition + (tagConfig.ScoreAddition or 0)
    end
    local ptcTxt = string.format("%s%%", tostring(totalAddition * 100))
    self.nowMultiplierTxt.text.text = string.format("积分倍率：%s", ptcTxt)
end

--选中难度方法
function WeeklyBossMainPanel:selectMode(levelId, modeBox)
    if UICommonUtils.Checkobj(self.nowSelectModeObj) then
        self.nowSelectModeObj.isSelect:SetActive(false)
        self.nowSelectModeObj.modeTypeTxt.text.color = Color.NewFromStr("FFFFFF")
        self.nowSelectModeObj.modeTypeTxt.canvasGroup.alpha = 0.5
    end
    self.nowSelectLevelId = levelId
    self.nowSelectModeObj = modeBox
    self.nowSelectModeObj.modeTypeTxt.text.color = Color.NewFromStr("333333")
    self.nowSelectModeObj.modeTypeTxt.canvasGroup.alpha = 1
    self.nowSelectModeObj.isSelect:SetActive(true)
    self.modeTxt.text.text = LocalStrEnum[string.format("BossBattleLevelDiff_%s", modeBox.modeTypeTxt.text.text)]
end

--危境攻坚界面倒计时
function WeeklyBossMainPanel:setCountdown()
    if self.countDownTimer then
        DLuaTimer:RemoveTimer(self.countDownTimer)
    end
    self:timeChange()
    self.countDownTimer = DLuaTimer:DoRepeatForever(1, function()
        self:timeChange()
    end)
end

--危境攻坚倒计时变化
function WeeklyBossMainPanel:timeChange()
    local offsetStringMap = DLuaUtil.getBossActivityRemainingTime(self.bossActData.closingTime)
    if offsetStringMap.day == 0 and offsetStringMap.hour == 0 and offsetStringMap.min < 10 then
        self.resetTimeTxt.text.text = LocalStrEnum.PveExerciseSettling
        self.isResetting = true
    elseif offsetStringMap.day == 0 then
        self.resetTimeTxt.text.text = string.format(LocalStrEnum.PveExerciseTimeHour, offsetStringMap.hour, offsetStringMap.min)
    else
        self.resetTimeTxt.text.text = string.format(LocalStrEnum.PveExerciseTimeDay, offsetStringMap.day, offsetStringMap.hour)
    end
end

function WeeklyBossMainPanel:refreshRedPoint()
    self.currentRewardsBtn.redPoint:SetActive(RedPointMgr:WeeklyBossMainPanelCurrentRewardsBtnRedJudge())
    self.achievementBtn.redPoint:SetActive(RedPointMgr:WeeklyBossMainPanelAchievementBtnRedJudge())
end

--设置界面特效显影
function WeeklyBossMainPanel:effectSwitch(isShow)
    if isShow then
        self.effect_Ui_ZhouChangBoss_1:SetActive(true)
    else
        self.effect_Ui_ZhouChangBoss_1:SetActive(false)
    end
end

--设置相机的后处理
function WeeklyBossMainPanel:SetUIVolume()
    --特效相关
    --local UICamera = UIMgr.uiCamera
    --local cameraData = UICamera:GetComponent(typeof(UnityEngine.Rendering.Universal.UniversalAdditionalCameraData))
    --if cameraData then
    --    cameraData.renderPostProcessing = true                      --后处理
    --    cameraData.volumeTrigger = self.uiVolume.transform          --特效触发器
    --    cameraData.volumeLayerMask = LayerMask.GetMask("UI")            --默认层和UI层
    --end
end

--界面关闭
function WeeklyBossMainPanel:animationAndClose()
    self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = false
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
        self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = true
    end)
end

--function WeeklyBossMainPanel:OnClose(initiative)
--
--end

--function WeeklyBossMainPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function WeeklyBossMainPanel:OnRefresh(data)
--
--end

--[[
/BossInfoBg/BossInfoBtn onClick 
--]]
function WeeklyBossMainPanel:bossInfoBtn_ScaleButton_onClick(bossInfoBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.isResetting then
        UICommonUtils.PopToast(LocalStrEnum.PveBossBattleSettlingTips)
        self:animationAndClose()
        return
    end
    self:effectSwitch(false)
    UIMgr:popUICover("LevelMapMsgPanel", {id = 0, levelId = self.nowSelectLevelId, mode = 1, closeFunc = function()
        self:effectSwitch(true)
    end})
end

--[[
/CurrentRewardsBtn onClick 
--]]
function WeeklyBossMainPanel:currentRewardsBtn_ScaleButton_onClick(currentRewardsBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.isResetting then
        UICommonUtils.PopToast(LocalStrEnum.PveBossBattleSettlingTips)
        self:animationAndClose()
        return
    end
    self:effectSwitch(false)
    UIMgr:popUICover("WeeklyBossRewardPanel", {closeFunc = function()
        self:effectSwitch(true)
    end})
end

--[[
/AchievementBtn onClick 
--]]
function WeeklyBossMainPanel:achievementBtn_ScaleButton_onClick(achievementBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.isResetting then
        UICommonUtils.PopToast(LocalStrEnum.PveBossBattleSettlingTips)
        self:animationAndClose()
        return
    end
    self:effectSwitch(false)
    UIMgr:popUICover("WeeklyBossAchievementPanel", {closeFunc = function()
        self:effectSwitch(true)
    end})
end

--[[
/PlanningBtn onClick 
--]]
function WeeklyBossMainPanel:planningBtn_ScaleButton_onClick(planningBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.isResetting then
        UICommonUtils.PopToast(LocalStrEnum.PveBossBattleSettlingTips)
        self:animationAndClose()
        return
    end
    self:effectSwitch(false)
    UIMgr:popUICover("WeeklyBossPlanPanel", {bossId = self.nowSelectBossId, closeFunc = function()
        self:showCurrentScoreMul()
        self:effectSwitch(true)
    end})
end

--[[
/ChallengeBtn onClick 
--]]
function WeeklyBossMainPanel:challengeBtn_ScaleButton_onClick(challengeBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.isResetting then
        UICommonUtils.PopToast(LocalStrEnum.PveBossBattleSettlingTips)
        self:animationAndClose()
        return
    end
    Me:setNowSelectLevel(self.nowSelectLevelId)
    LoadingMgr:SetLoadingStart(function()
        StateMgr:ChangeToState(GameFlowState.BattleState)
    end, nil, nil, "WeeklyBossMainPanel2")
end

return WeeklyBossMainPanel
