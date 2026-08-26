-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/boss/VersionActivity1_6DungeonBossView.lua

module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6DungeonBossView", package.seeall)

local VersionActivity1_6DungeonBossView = class("VersionActivity1_6DungeonBossView", BaseView)
local maxLv = 8
local maxBossOrder = VersionActivity1_6DungeonEnum.bossMaxOrder
local UnlockBossEpisodeKey = VersionActivity1_6Enum.ActivityId.DungeonBossRush .. "UnlockBossEpisode_"
local GotMaxScore = VersionActivity1_6Enum.ActivityId.DungeonBossRush .. "GotMaxScore_"
local FirstPassBoss = VersionActivity1_6Enum.ActivityId.DungeonBossRush .. "FirstPassBoss_"

function VersionActivity1_6DungeonBossView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._goNormalBG = gohelper.findChild(self.viewGO, "Left/#simage_NormalBG")
	self._goHardBG = gohelper.findChild(self.viewGO, "Left/#simage_HardBG")
	self._goNormalTitleBG = gohelper.findChild(self.viewGO, "Left/Title/image_NormalTitleBG")
	self._goHardTitleBG = gohelper.findChild(self.viewGO, "Left/Title/image_HardTitleBG")
	self._goLvNormalBG = gohelper.findChild(self.viewGO, "Left/Lv/image_LvNormalBG")
	self._goLvHardBG = gohelper.findChild(self.viewGO, "Left/Lv/image_LvHardBG")
	self._goBosslv = gohelper.findChild(self.viewGO, "Left/Lv")
	self._txtBosslv = gohelper.findChildText(self.viewGO, "Left/Lv/#txt_Lv")
	self._txtTipsNum = gohelper.findChildText(self.viewGO, "Left/Lv/Tips/#txt_TipsNum")
	self._btnPreLv = gohelper.findChildButtonWithAudio(self.viewGO, "Left/Lv/#btn_Left")
	self._imagePreLv = gohelper.findChildImage(self.viewGO, "Left/Lv/#btn_Left")
	self._goBtnPreLv = gohelper.findChild(self.viewGO, "Left/Lv/#btn_Left")
	self._btnNextLv = gohelper.findChildButtonWithAudio(self.viewGO, "Left/Lv/#btn_Right")
	self._imageNextLv = gohelper.findChildImage(self.viewGO, "Left/Lv/#btn_Right")
	self._goBtnNextLv = gohelper.findChild(self.viewGO, "Left/Lv/#btn_Right")
	self._goBtnNextLvLock = gohelper.findChild(self.viewGO, "Left/Lv/#txt_Lv/#btn_Lock")
	self._txtScoreNum = gohelper.findChildText(self.viewGO, "Left/Score/txt_ScoreNum")
	self._goMaxScoreTips = gohelper.findChild(self.viewGO, "Left/Score/txt_ScoreNum/#go_ScoreTips")
	self._btnInfo = gohelper.findChildButtonWithAudio(self.viewGO, "Left/Title/#btn_Info")
	self._btnScoreDetailInfo = gohelper.findChildButtonWithAudio(self.viewGO, "Left/Score/#btn_Score")
	self._btnCloseScoreDetailInfo = gohelper.findChildButtonWithAudio(self.viewGO, "Left/Score/#btn_Score/image_ScoreTipsBG/#btn_tipsClose")
	self._goScoreDetailTips = gohelper.findChild(self.viewGO, "Left/Score/#btn_Score/image_ScoreTipsBG")
	self._btnLock = gohelper.findChildButtonWithAudio(self.viewGO, "Left/Lv/#txt_Lv/#btn_Lock")
	self._goBtnReward = gohelper.findChild(self.viewGO, "Right/#btn_Reward")
	self._btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Reward")
	self._btnCloseReward = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Reward/RewardTips/#btn_closeReawrds")
	self._goRewardTips = gohelper.findChild(self.viewGO, "Right/#btn_Reward/RewardTips")
	self._goRewards = gohelper.findChild(self.viewGO, "Right/#btn_Reward/RewardTips/#scroll_Rewards/Viewport/#go_rewards")
	self._btnEnterNormal = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_EnterNormal")
	self._btnEnterHard = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_EnterHard")
	self._goEnterNormalLocked = gohelper.findChild(self.viewGO, "Right/#btn_EnterNormalLocked")
	self._goEnterHardLocked = gohelper.findChild(self.viewGO, "Right/#btn_EnterHardLocked")
	self._btnSchedule = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Reward/image_RewardBG")
	self._redDotSchedule = gohelper.findChild(self.viewGO, "Right/Reward/#go_reddot")
	self._imageScoreProgress = gohelper.findChildImage(self.viewGO, "Right/Reward/image_RewardSlider")
	self._rewardEffect = gohelper.findChild(self.viewGO, "Right/Reward/vx_collect")
	self._rewardEffectAnimator = self._rewardEffect:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_6DungeonBossView:addEvents()
	self._btnPreLv:AddClickListener(self._preLvclick, self)
	self._btnNextLv:AddClickListener(self._nextLvclick, self)
	self._btnLock:AddClickListener(self._lockLvclick, self)
	self._btnReward:AddClickListener(self._onClickRewardBtn, self)
	self._btnCloseReward:AddClickListener(self._onClicClosekRewardBtn, self)
	self._btnEnterHard:AddClickListener(self._enterFightClick, self)
	self._btnEnterNormal:AddClickListener(self._enterFightClick, self)
	self._btnSchedule:AddClickListener(self._btnScheduleOnClick, self)
	self._btnInfo:AddClickListener(self._btnInfoOnClick, self)
	self._btnScoreDetailInfo:AddClickListener(self._btnScoreDetailOnClick, self)
	self._btnCloseScoreDetailInfo:AddClickListener(self._btnCloseScoreDetailOnClick, self)
end

function VersionActivity1_6DungeonBossView:removeEvents()
	self._btnPreLv:RemoveClickListener()
	self._btnNextLv:RemoveClickListener()
	self._btnLock:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnCloseReward:RemoveClickListener()
	self._btnEnterNormal:RemoveClickListener()
	self._btnEnterHard:RemoveClickListener()
	self._btnSchedule:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnScoreDetailInfo:RemoveClickListener()
	self._btnCloseScoreDetailInfo:RemoveClickListener()
end

function VersionActivity1_6DungeonBossView:_editableInitView()
	return
end

function VersionActivity1_6DungeonBossView:onUpdateParam()
	return
end

function VersionActivity1_6DungeonBossView:onOpen()
	local modelInstance = VersionActivity1_6DungeonBossModel.instance
	local maxOrderEpisodeMo, maxEpisodeOrder = modelInstance:getMaxOrderMo()

	if self.viewParam then
		local preEpisodeId = DungeonModel.instance.lastSendEpisodeId
		local preBossEpisodeMo = VersionActivity1_6DungeonBossModel.instance:getAct149MoByEpisodeId(preEpisodeId)

		if self.viewParam and preBossEpisodeMo then
			self._curBossEpisodeMo = preBossEpisodeMo
			self._curBossEpisodeOrder = preBossEpisodeMo.cfg.order
		else
			self._curBossEpisodeMo = maxOrderEpisodeMo
			self._curBossEpisodeOrder = maxEpisodeOrder
		end

		self._curBossCfg = modelInstance:getAct149EpisodeCfgIdByOrder(self._curBossEpisodeOrder)
		self._curMaxOrder = maxEpisodeOrder
		self._lvIcons = self:getUserDataTb_()

		for i = 1, maxLv do
			self._lvIcons[i] = gohelper.findChild(self.viewGO, "Left/Lv/#txt_Lv/image_Lv" .. i)
		end

		gohelper.setActive(self._goRewardTips, false)
		gohelper.setActive(self._goScoreDetailTips, false)
		TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
		self.addEventCb(self, VersionActivity1_6DungeonController.instance, VersionActivity1_6DungeonEvent.DungeonBossInfoUpdated, self._onDungeonBossInfoUpdated, self)
		self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
		RedDotController.instance:addRedDot(self._redDotSchedule, RedDotEnum.DotNode.V1a6DungeonBossReward)
	end
end

function VersionActivity1_6DungeonBossView:onOpenFinish()
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonBossViewAmbient)
	self:_refreshUI()

	if self.viewParam then
		if self.viewParam then
			self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onDailyBonusViewCloase, self)
		else
			self:_playAnimations()
			self:dispatchGuideEvent()
		end
	end
end

function VersionActivity1_6DungeonBossView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonBossViewStopAmbient)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function VersionActivity1_6DungeonBossView:onDestroyView()
	return
end

function VersionActivity1_6DungeonBossView:_refreshUI()
	self:_refreshBossLvArea()
	self:_refreshScoreArea()
	self:_refreshScoreBtn()
	self:_refreshRuleView()
	self:_refreshRewardArea()
	self:_refreshBtnState()
end

function VersionActivity1_6DungeonBossView:_refreshUIOnBossChange()
	self:_refreshBossLvArea()
	self:_refreshRuleView()
	self:_refreshBtnState()
	self:_playAnimations()
end

function VersionActivity1_6DungeonBossView:_refreshBossLvArea()
	local lvNum = self._curBossEpisodeOrder

	self._txtBosslv.text = "Lv." .. lvNum

	for i = 1, maxLv do
		local iconGo = self._lvIcons[i]

		if iconGo then
			gohelper.setActive(iconGo, i == lvNum and self._curBossEpisodeMo ~= nil)
		end
	end

	local multiPercent = math.floor(self._curBossCfg.multi * 100)

	self._txtTipsNum.text = multiPercent .. "%"

	gohelper.setActive(self._goBtnNextLv, true)
	gohelper.setActive(self._goBtnPreLv, true)
	gohelper.setActive(self._goBtnNextLvLock, false)

	local isMaxLvBoss = self._curBossEpisodeOrder == maxBossOrder

	ZProj.UGUIHelper.SetColorAlpha(self._imageNextLv, isMaxLvBoss and 0.5 or 1)
	ZProj.UGUIHelper.SetColorAlpha(self._imagePreLv, self._curBossEpisodeOrder == 1 and 0.5 or 1)
	gohelper.setActive(self._goNormalBG, not isMaxLvBoss)
	gohelper.setActive(self._goHardBG, isMaxLvBoss)
	gohelper.setActive(self._goLvNormalBG, not isMaxLvBoss)
	gohelper.setActive(self._goLvHardBG, isMaxLvBoss)
	gohelper.setActive(self._goNormalTitleBG, not isMaxLvBoss)
	gohelper.setActive(self._goHardTitleBG, isMaxLvBoss)
end

function VersionActivity1_6DungeonBossView:_refreshBtnState()
	local canEnterFight = self._curBossEpisodeMo ~= nil

	gohelper.setActive(self._btnEnterNormal.gameObject, canEnterFight)
	gohelper.setActive(self._btnEnterHard.gameObject, canEnterFight)
	gohelper.setActive(self._goEnterNormalLocked, not canEnterFight)
	gohelper.setActive(self._goEnterHardLocked, not canEnterFight)
end

function VersionActivity1_6DungeonBossView:_refreshScoreArea()
	local curMaxScore = VersionActivity1_6DungeonBossModel.instance:getCurMaxScore()

	self._txtScoreNum.text = curMaxScore

	gohelper.setActive(self._goBtnReward, false)

	local curEpisodeMaxScore = Activity149Config.instance:getEpisodeMaxScore(self._curBossCfg.id, VersionActivity1_6Enum.ActivityId.DungeonBossRush)

	gohelper.setActive(self._goMaxScoreTips, curMaxScore == curEpisodeMaxScore)
end

function VersionActivity1_6DungeonBossView:_refreshScoreBtn()
	local curScore = VersionActivity1_6DungeonBossModel.instance:getTotalScore()
	local maxScore = Activity149Config.instance:getBossRewardMaxScore()

	self._imageScoreProgress.fillAmount = curScore / (1 * maxScore)
end

function VersionActivity1_6DungeonBossView:_refreshRuleView()
	local episodeBossId = self._curBossCfg.id
	local bossCfg = self._curBossCfg
	local extraBattleId
	local modelInstance = VersionActivity1_6DungeonBossModel.instance

	if bossCfg.order == maxLv and not modelInstance:isLastBossEpisode() then
		local nextBossCfg = Activity149Config.instance:getNextBossEpisodeCfgById(bossCfg.id)
		local extraEpisodeCfg = Activity149Config.instance:getDungeonEpisodeCfg(nextBossCfg.id)

		extraBattleId = extraEpisodeCfg.battleId
	end

	local dungeonEpisodeCfg = Activity149Config.instance:getDungeonEpisodeCfg(episodeBossId)
	local battleId = dungeonEpisodeCfg.battleId
	local ruleView = self.viewContainer:getBossRuleView()

	ruleView:refreshUI(battleId, extraBattleId)
end

function VersionActivity1_6DungeonBossView:_refreshRewardArea()
	local dailyRewardConstId = 2
	local str = Activity149Config.instance:getAct149ConstValue(dailyRewardConstId)
	local itemList = ItemModel.instance:getItemDataListByConfigStr(str)

	IconMgr.instance:getCommonPropItemIconList(self, self._onRewardItemShow, itemList, self._goRewards)
end

function VersionActivity1_6DungeonBossView:_onRewardItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
end

function VersionActivity1_6DungeonBossView:_onDailyRefresh()
	local activityStatus = ActivityHelper.getActivityStatus(VersionActivity1_6Enum.ActivityId.DungeonBossRush)
	local isOpenStatus = activityStatus == ActivityEnum.ActivityStatus.Normal

	if isOpenStatus then
		VersionActivity1_6DungeonRpc.instance:sendGet149InfoRequest()
	end
end

function VersionActivity1_6DungeonBossView:_onDungeonBossInfoUpdated()
	local modelInstance = VersionActivity1_6DungeonBossModel.instance
	local maxOrderEpisodeMo, maxEpisodeOrder = modelInstance:getMaxOrderMo()

	self._curMaxOrder = maxEpisodeOrder
	self._curBossCfg = modelInstance:getAct149EpisodeCfgIdByOrder(self._curBossEpisodeOrder)
	self._curBossEpisodeMo = modelInstance:getAct149MoByOrder(self._curBossEpisodeOrder)

	self:_refreshUI()
	self:_playAnimations()
	self:_showUnlockAnimation()
	self:dispatchGuideEvent()
end

function VersionActivity1_6DungeonBossView:_onDailyBonusViewCloase(viewName)
	if viewName == ViewName.CommonPropView then
		self:_playAnimations()
	end
end

function VersionActivity1_6DungeonBossView:dispatchGuideEvent()
	local order = self._curMaxOrder

	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.DungeonBossOrder, order)
end

function VersionActivity1_6DungeonBossView:_enterFightClick()
	if self._curBossEpisodeMo then
		VersionActivity1_6DungeonController.instance:enterBossFightScene(self._curBossCfg.id)
	end
end

function VersionActivity1_6DungeonBossView:_btnScheduleOnClick()
	ViewMgr.instance:openView(ViewName.VersionActivity1_6_BossScheduleView)
end

function VersionActivity1_6DungeonBossView:_preLvclick()
	if self._curBossEpisodeOrder <= 1 then
		return
	end

	self._curBossEpisodeOrder = self._curBossEpisodeOrder - 1

	local modelInstance = VersionActivity1_6DungeonBossModel.instance

	self._curBossCfg = modelInstance:getAct149EpisodeCfgIdByOrder(self._curBossEpisodeOrder)
	self._curBossEpisodeMo = modelInstance:getAct149MoByOrder(self._curBossEpisodeOrder)

	self:_refreshUIOnBossChange()
end

function VersionActivity1_6DungeonBossView:_nextLvclick()
	if self._curBossEpisodeOrder >= VersionActivity1_6DungeonEnum.bossMaxOrder then
		return
	end

	self._curBossEpisodeOrder = self._curBossEpisodeOrder + 1

	local modelInstance = VersionActivity1_6DungeonBossModel.instance

	self._curBossCfg = modelInstance:getAct149EpisodeCfgIdByOrder(self._curBossEpisodeOrder)
	self._curBossEpisodeMo = modelInstance:getAct149MoByOrder(self._curBossEpisodeOrder)

	self:_refreshUIOnBossChange()
end

function VersionActivity1_6DungeonBossView:_lockLvclick()
	local modelInstance = VersionActivity1_6DungeonBossModel.instance

	self._curBossCfg = modelInstance:getAct149EpisodeCfgIdByOrder(self._curBossEpisodeOrder)
	self._curBossEpisodeMo = VersionActivity1_6DungeonBossModel.instance:getAct149MoByOrder(self._curBossEpisodeOrder)

	local episodeInfo = DungeonModel.instance:getEpisodeInfo(self._curBossCfg.episodeId)
	local episodeFinished = episodeInfo and episodeInfo.star > 0

	if episodeFinished then
		GameFacade.showToast(ToastEnum.Act1_6DungeonToast60205)
	else
		GameFacade.showToast(ToastEnum.Act1_6DungeonToast60204)
	end
end

function VersionActivity1_6DungeonBossView:_onClickRewardBtn()
	gohelper.setActive(self._goRewardTips, true)
end

function VersionActivity1_6DungeonBossView:_onClicClosekRewardBtn()
	gohelper.setActive(self._goRewardTips, false)
end

function VersionActivity1_6DungeonBossView:_btnInfoOnClick()
	if self._curBossCfg then
		local episodeCo = DungeonConfig.instance:getEpisodeCO(self._curBossCfg.episodeId)
		local battleId = episodeCo and episodeCo.battleId

		if battleId then
			EnemyInfoController.instance:openEnemyInfoViewByBattleId(battleId)
		end
	end
end

function VersionActivity1_6DungeonBossView:_btnScoreDetailOnClick()
	gohelper.setActive(self._goScoreDetailTips, true)
end

function VersionActivity1_6DungeonBossView:_btnCloseScoreDetailOnClick()
	gohelper.setActive(self._goScoreDetailTips, false)
end

function VersionActivity1_6DungeonBossView:_playAnimations()
	self:_showUnlockAnimation()
	self:_showTodayMaxScoreAnimation()

	local show = self:_showFirstPassBossAnimation()

	if not show then
		self:_showGotScroeAnimation()
	else
		local modelInstance = VersionActivity1_6DungeonBossModel.instance

		modelInstance:applyPreScoreToCurScore()
	end
end

function VersionActivity1_6DungeonBossView:_showUnlockAnimation()
	local order = self._curBossEpisodeOrder
	local canEnterFight = self._curBossEpisodeMo ~= nil
	local playerPrefsKeyStr = UnlockBossEpisodeKey .. order
	local unlockBossEpisodeKey = PlayerModel.instance:getPlayerPrefsKey(playerPrefsKeyStr)
	local playerPrefsKeyValue = PlayerPrefsHelper.getNumber(unlockBossEpisodeKey)

	if canEnterFight and playerPrefsKeyValue ~= 1 then
		PlayerPrefsHelper.setNumber(unlockBossEpisodeKey, 1)

		local unLockLvAnimator = self._goBosslv:GetComponent(typeof(UnityEngine.Animator))

		unLockLvAnimator:Play(UIAnimationName.Unlock, 0, 0)
	end
end

function VersionActivity1_6DungeonBossView:_showTodayMaxScoreAnimation()
	local order = self._curBossEpisodeOrder
	local curMaxScore = VersionActivity1_6DungeonBossModel.instance:getCurMaxScore()
	local curEpisodeMaxScore = Activity149Config.instance:getEpisodeMaxScore(self._curBossCfg.id, VersionActivity1_6Enum.ActivityId.DungeonBossRush)
	local isGotMaxScore = curMaxScore == curEpisodeMaxScore

	if not isGotMaxScore then
		return
	end

	local playerPrefsKeyStr = GotMaxScore .. order
	local gotMaxScoreKey = PlayerModel.instance:getPlayerPrefsKey(playerPrefsKeyStr)
	local playerPrefsKeyValue = PlayerPrefsHelper.getNumber(gotMaxScoreKey)
	local isPlayed = playerPrefsKeyValue == 1

	if not isPlayed then
		PlayerPrefsHelper.setNumber(gotMaxScoreKey, 1)

		local goScore = gohelper.findChild(self.viewGO, "Left/Score/vx_highscore")

		gohelper.setActive(goScore, false)
		gohelper.setActive(goScore, true)
	end
end

function VersionActivity1_6DungeonBossView:_showFirstPassBossAnimation()
	local order = self._curBossEpisodeOrder
	local modelInstance = VersionActivity1_6DungeonBossModel.instance
	local isPassBoss = modelInstance:checkEpisodePassedByOrder(order)

	if not isPassBoss then
		return
	end

	local playerPrefsKeyStr = FirstPassBoss .. order
	local firstPassKey = PlayerModel.instance:getPlayerPrefsKey(playerPrefsKeyStr)
	local playerPrefsKeyValue = PlayerPrefsHelper.getNumber(firstPassKey)
	local isPlayed = playerPrefsKeyValue == 1

	if not isPlayed then
		PlayerPrefsHelper.setNumber(firstPassKey, 1)
		gohelper.setActive(self._rewardEffect, true)
		self._rewardEffectAnimator:Play(UIAnimationName.Finish .. 1, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonBossViewGetScore)

		return true
	end
end

function VersionActivity1_6DungeonBossView:_showGotScroeAnimation()
	local modelInstance = VersionActivity1_6DungeonBossModel.instance
	local hasGotHigherScore = modelInstance:HasGotHigherScore()

	if hasGotHigherScore then
		modelInstance:applyPreScoreToCurScore()
		gohelper.setActive(self._rewardEffect, true)
		self._rewardEffectAnimator:Play(UIAnimationName.Finish .. 2, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonBossViewGetScore)
	end
end

return VersionActivity1_6DungeonBossView
