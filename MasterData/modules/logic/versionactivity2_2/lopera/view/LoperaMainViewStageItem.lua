-- chunkname: @modules/logic/versionactivity2_2/lopera/view/LoperaMainViewStageItem.lua

module("modules.logic.versionactivity2_2.lopera.view.LoperaMainViewStageItem", package.seeall)

local LoperaMainViewStageItem = class("LoperaMainViewStageItem", LuaCompBase)
local loperaActId = VersionActivity2_2Enum.ActivityId.Lopera
local mapCfgIdx = LoperaEnum.MapCfgIdx

function LoperaMainViewStageItem:init(go)
	self.viewGO = go
	self._animator = go:GetComponent(typeof(UnityEngine.Animator))
	self._imagepoint = gohelper.findChildImage(self.viewGO, "#image_point")
	self._goImagepointfinished = gohelper.findChild(self.viewGO, "#image_pointfinished")
	self._gostagefinish = gohelper.findChild(self.viewGO, "unlock/#go_stagefinish")
	self._gostar = gohelper.findChild(self.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star")
	self._gohasstar = gohelper.findChild(self._gostar, "has/#image_Star")
	self._gounlock = gohelper.findChild(self.viewGO, "unlock")
	self._imagestageline = gohelper.findChildImage(self.viewGO, "unlock/#image_stageline")
	self._gogame = gohelper.findChild(self.viewGO, "unlock/#go_stage/#go_Game")
	self._gostory = gohelper.findChild(self.viewGO, "unlock/#go_stagenormal/#go_Story")
	self._imageline = gohelper.findChildImage(self.viewGO, "unlock/#image_line")
	self._imageangle = gohelper.findChildImage(self.viewGO, "unlock/#image_angle")
	self._txtstagename = gohelper.findChildText(self.viewGO, "unlock/#go_stage/info/#txt_stagename")
	self._txtstagenum = gohelper.findChildText(self.viewGO, "unlock/#go_stage/info/#txt_stagename/#txt_stageNum")
	self._goArrowSign = gohelper.findChild(self.viewGO, "#image_Sign")
	self._btnreview = gohelper.findChildButtonWithAudio(self.viewGO, "unlock/#go_stage/info/#txt_stagename/#btn_review")
	self._imagechess = gohelper.findChildImage(self.viewGO, "unlock/#image_chess")
	self._chessAnimator = gohelper.findChild(self._imagechess.gameObject, "ani"):GetComponent(typeof(UnityEngine.Animator))
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "unlock/#btn_click")

	self:_addEvents()
end

function LoperaMainViewStageItem:refreshItem(cfg, index)
	self._actId = VersionActivity2_2Enum.ActivityId.Lopera
	self._index = index
	self._config = cfg
	self._episodeId = self._config.id
	self._battleEpisodeId = self._config.episodeId

	local curEpisodeId = Activity168Model.instance:getCurEpisodeId()

	self:refreshTitle()

	local isChessStage = self._config.mapId ~= 0
	local isFinish = Activity168Model.instance:isEpisodeFinished(self._episodeId)
	local isUnlock = Activity168Model.instance:isEpisodeUnlock(self._episodeId)

	gohelper.setActive(self._btnreview.gameObject, false)
	gohelper.setActive(self._imagechess.gameObject, self._episodeId == curEpisodeId)
	gohelper.setActive(self._goArrowSign, self._episodeId == curEpisodeId)
	gohelper.setActive(self._gounlock, isUnlock)
	gohelper.setActive(self._gostagefinish, isChessStage)
	gohelper.setActive(self._gohasstar, isFinish)
	gohelper.setActive(self._gogame, isChessStage)
	gohelper.setActive(self._goImagepointfinished, isFinish)
end

function LoperaMainViewStageItem:refreshTitle()
	self._txtstagename.text = self._config.name
	self._txtstagenum.text = string.format("STAGE %02d", self._index)
end

function LoperaMainViewStageItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnreview:AddClickListener(self._btnReviewOnClick, self)
end

function LoperaMainViewStageItem:removeEventListeners()
	if self._btnclick then
		self._btnclick:RemoveClickListener()
		self._btnreview:RemoveClickListener()
	end
end

function LoperaMainViewStageItem:_btnclickOnClick()
	local curEpisodeId = Activity168Model.instance:getCurEpisodeId()

	if curEpisodeId == self._episodeId then
		self:_delayEnterLoperaLevel()
	else
		LoperaController.instance:dispatchEvent(LoperaEvent.ClickOtherEpisode, self._episodeId)
		UIBlockHelper.instance:startBlock("LoperaMainViewStageItemEpisodeClick", 0.5, self.viewName)
		TaskDispatcher.runDelay(self._delayPlayChessOpenAnim, self, 0.25)
	end
end

function LoperaMainViewStageItem:_delayPlayChessOpenAnim()
	if not self._imagechess then
		return
	end

	gohelper.setActive(self._imagechess, true)

	local curEpisodeId = Activity168Model.instance:getCurEpisodeId()

	if curEpisodeId > self._episodeId then
		self._chessAnimator:Play("open_left", 0, 0)
	else
		self._chessAnimator:Play("open_right", 0, 0)
	end

	gohelper.setActive(self._goArrowSign, true)
	TaskDispatcher.runDelay(self._delayEnterLoperaLevel, self, 0.35)
end

function LoperaMainViewStageItem:_delayEnterLoperaLevel()
	if not self._config then
		return
	end

	LoperaController.instance:dispatchEvent(LoperaEvent.BeforeEnterEpisode)
	TaskDispatcher.runDelay(self._enterLoperaLevel, self, 0.5)
end

function LoperaMainViewStageItem:_enterLoperaLevel()
	LoperaController.instance:enterEpisode(self._episodeId)
end

function LoperaMainViewStageItem:_btnReviewOnClick()
	local isChessStage = self._config.mapId ~= 0

	if isChessStage then
		LanShouPaController.instance:openStoryView(self._episodeId)
	else
		StoryController.instance:playStory(self._config.storyBefore, nil, self._storyEnd, self)
	end
end

function LoperaMainViewStageItem:_addEvents()
	LoperaController.instance:registerCallback(LoperaEvent.ClickOtherEpisode, self._playChooseEpisode, self)
	LoperaController.instance:registerCallback(LoperaEvent.EnterEpisode, self._onEnterEpisode, self)
end

function LoperaMainViewStageItem:_removeEvents()
	LoperaController.instance:unregisterCallback(LoperaEvent.ClickOtherEpisode, self._playChooseEpisode, self)
	LoperaController.instance:unregisterCallback(LoperaEvent.EnterEpisode, self._onEnterEpisode, self)
end

function LoperaMainViewStageItem:playFinishAni()
	self:refreshItem(self._config, self._index)
	self._animator:Play(UIAnimationName.Finish, 0, 0)
end

function LoperaMainViewStageItem:playUnlockAni()
	self:refreshItem(self._config, self._index)
	self._animator:Play(UIAnimationName.Unlock, 0, 0)
end

function LoperaMainViewStageItem:_playChooseEpisode(clickEpisodeId)
	local curEpisodeId = Activity168Model.instance:getCurEpisodeId()

	if self._episodeId == curEpisodeId then
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)

		if clickEpisodeId < self._episodeId then
			self._chessAnimator:Play("close_left", 0, 0)
		else
			self._chessAnimator:Play("close_right", 0, 0)
		end
	end

	gohelper.setActive(self._goArrowSign, false)
end

function LoperaMainViewStageItem:_onEnterEpisode(episodeId)
	if self._episodeId ~= episodeId then
		return
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_2LoperaSelect .. loperaActId, tostring(self._index))

	if self._config.episodeType == LoperaEnum.EpisodeType.Explore then
		local isSkipStory = self._config.storyBefore == 0
		local isPlayedStoryLastTime = Activity168Model.instance:getCurEpisodeId() == episodeId

		if isSkipStory or isPlayedStoryLastTime then
			self:_storyEnd()
		else
			StoryController.instance:playStory(self._config.storyBefore, nil, self._storyEnd, self)
		end
	elseif self._config.episodeType == LoperaEnum.EpisodeType.Battle then
		if self._battleEpisodeId <= 0 then
			logError("没有配置对应的关卡")

			return
		end

		local episodeData = Activity168Model.instance:getEpisodeData(self._episodeId)
		local dungeonEpisodeCfg = DungeonConfig.instance:getEpisodeCO(self._battleEpisodeId)
		local storyBefore = dungeonEpisodeCfg.beforeStory
		local endStory = dungeonEpisodeCfg.afterStory
		local isSkipStory = storyBefore == 0 or episodeData.status == LoperaEnum.EpisodeStatus.PlayStartStory
		local playEndStory = endStory == 0 and episodeData.status == LoperaEnum.EpisodeStatus.PlayEndStory

		if isSkipStory then
			self:_enterBattleHeroGroupView()
		elseif playEndStory then
			StoryController.instance:playStory(endStory, nil, self._storyEnd, self)
		else
			StoryController.instance:playStory(storyBefore, nil, self._storyEnd, self)
		end
	elseif self._config.episodeType == LoperaEnum.EpisodeType.Story then
		local isSkipStory = self._config.storyBefore == 0 or self._config.mapId ~= 0 and Activity168Model.instance.currChessGameEpisodeId == self._episodeId

		if isSkipStory then
			self:_storyEnd()
		else
			StoryController.instance:playStory(self._config.storyBefore, nil, self._storyEnd, self)
		end
	elseif self._config.episodeType == LoperaEnum.EpisodeType.ExploreEndless then
		LoperaController.instance:openLoperaLevelView()
	end

	Activity168Model.instance:setCurEpisodeId(episodeId)
end

function LoperaMainViewStageItem:_storyEnd()
	if self._config.episodeType == LoperaEnum.EpisodeType.Explore then
		local curGameState = Activity168Model.instance:getCurGameState()
		local isNewGame = curGameState.round == 1

		if isNewGame then
			local firstCellData = Activity168Config.instance:getMapStartCell()
			local startStory = firstCellData[mapCfgIdx.storyId]

			if startStory ~= 0 then
				StoryController.instance:playStory(startStory, nil, self._gameFirstStoryEnd, self)
			else
				self:_gameFirstStoryEnd()
			end
		else
			LoperaController.instance:openLoperaLevelView()
		end
	elseif self._config.episodeType == LoperaEnum.EpisodeType.Battle then
		local episodeData = Activity168Model.instance:getEpisodeData(self._episodeId)
		local dungeonEpisodeCfg = DungeonConfig.instance:getEpisodeCO(self._battleEpisodeId)
		local endStory = dungeonEpisodeCfg.afterStory
		local playEndStory = endStory == 0 and episodeData.status == LoperaEnum.EpisodeStatus.PlayEndStory

		if playEndStory then
			LoperaController.instance:finishStoryPlay()
		else
			LoperaController.instance:finishStoryPlay()
			self:_enterBattleHeroGroupView()
		end
	elseif self._config.episodeType == LoperaEnum.EpisodeType.Story then
		LoperaController.instance:finishStoryPlay()
	end
end

function LoperaMainViewStageItem:_gameFirstStoryEnd()
	LoperaController.instance:openLoperaLevelView()
end

function LoperaMainViewStageItem:_enterBattleHeroGroupView()
	local loperaCtrler = LoperaController.instance
	local episodeId = self._battleEpisodeId
	local config = DungeonConfig.instance:getEpisodeCO(self._battleEpisodeId)

	Activity168Model.instance:setCurBattleEpisodeId(self._battleEpisodeId)
	DungeonFightController.instance:setBattleRequestAction(loperaCtrler.startBattle, loperaCtrler)
	DungeonFightController.instance:enterFight(config.chapterId, episodeId)
end

function LoperaMainViewStageItem:onDestroy()
	self:_removeEvents()
	self:removeEventListeners()
end

return LoperaMainViewStageItem
