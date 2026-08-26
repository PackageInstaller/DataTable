-- chunkname: @modules/logic/versionactivity2_6/xugouji/view/XugoujiLevelViewStageItem.lua

local UIAnimationName = require("modules.logic.common.defines.UIAnimationName")

module("modules.logic.versionactivity2_6.xugouji.view.XugoujiLevelViewStageItem", package.seeall)

local XugoujiLevelViewStageItem = class("XugoujiLevelViewStageItem", LuaCompBase)
local actId = VersionActivity2_6Enum.ActivityId.Xugouji

function XugoujiLevelViewStageItem:init(go)
	self.viewGO = go

	gohelper.setActive(self.viewGO, true)

	self._goStageType1Item = gohelper.findChild(self.viewGO, "#go_StageType1")
	self._goStageType2Item = gohelper.findChild(self.viewGO, "#go_StageType2")
	self._goStageType1Lock = gohelper.findChild(self._goStageType1Item, "#go_Lock")
	self._goStageType2Lock = gohelper.findChild(self._goStageType2Item, "#go_Lock")
	self._animator = go:GetComponent(typeof(UnityEngine.Animator))
	self._imageStageIcon = gohelper.findChildImage(self.viewGO, "#go_StageType1")
	self._imageStageIconLock = gohelper.findChildImage(self.viewGO, "#go_StageType1/#go_Lock")
	self._txtType1StageName = gohelper.findChildText(self.viewGO, "#go_StageType1/#txt_StageName")
	self._txtType1StageNum = gohelper.findChildText(self.viewGO, "#go_StageType1/#txt_ChapterNum")
	self._txtType2StageNum = gohelper.findChildText(self.viewGO, "#go_StageType2/#txt_ChapterNum")
	self._goCompleteEffect = gohelper.findChild(self.viewGO, "vx_complete")
	self._completeEffectAnimator = ZProj.ProjAnimatorPlayer.Get(self._goCompleteEffect)
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "btnClick")

	self:_addEvents()
end

function XugoujiLevelViewStageItem:refreshItem(cfg, index)
	self._actId = VersionActivity2_6Enum.ActivityId.Xugouji
	self._index = index
	self._config = cfg
	self.episodeId = self._config.episodeId

	if self.episodeId == XugoujiEnum.ChallengeEpisodeId then
		gohelper.setActive(self.viewGO, false)

		return
	end

	if cfg.gameId ~= 0 then
		self._stageType = XugoujiEnum.LevelType.Level or XugoujiEnum.LevelType.Story
	end

	local curEpisodeId = Activity188Model.instance:getCurEpisodeId()

	self:refreshTitle()

	local isFinish = Activity188Model.instance:isEpisodeFinished(self.episodeId)
	local isUnlock = Activity188Model.instance:isEpisodeUnlock(self.episodeId)

	if not string.nilorempty(cfg.resource) then
		UISpriteSetMgr.instance:setXugoujiSprite(self._imageStageIcon, cfg.resource)
		UISpriteSetMgr.instance:setXugoujiSprite(self._imageStageIconLock, cfg.resource)
	end

	gohelper.setActive(self._goStageType1Item, self._stageType == XugoujiEnum.LevelType.Story)
	gohelper.setActive(self._goStageType2Item, self._stageType == XugoujiEnum.LevelType.Level)
	gohelper.setActive(self._goStageType1Lock, not isUnlock)
	gohelper.setActive(self._goStageType2Lock, not isUnlock)
	gohelper.setActive(self._goCompleteEffect, isFinish)
	self._completeEffectAnimator:Play(UIAnimationName.Idle, nil, nil)
end

function XugoujiLevelViewStageItem:refreshTitle()
	self._txtType1StageName.text = self._config.name
	self._txtType1StageNum.text = string.format("%02d", self._index)
	self._txtType2StageNum.text = string.format("%02d", self._index)
end

function XugoujiLevelViewStageItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function XugoujiLevelViewStageItem:removeEventListeners()
	if self._btnclick then
		self._btnclick:RemoveClickListener()
	end
end

function XugoujiLevelViewStageItem:_btnclickOnClick()
	if self:checkIsOpen() then
		self:_delayEnterEpisode()
	end
end

function XugoujiLevelViewStageItem:checkIsOpen()
	local mo = ActivityModel.instance:getActMO(actId)
	local isOpen = true

	if mo == nil then
		logError("not such activity id: " .. self.actId)

		isOpen = false
	end

	if not mo:isOpen() or mo:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		isOpen = false
	end

	local isUnlock = Activity188Model.instance:isEpisodeUnlock(self.episodeId)

	if not isUnlock then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		isOpen = false
	end

	return isOpen
end

function XugoujiLevelViewStageItem:_delayEnterEpisode()
	if not self._config then
		return
	end

	XugoujiController.instance:dispatchEvent(XugoujiEvent.BeforeEnterEpisode)
	TaskDispatcher.runDelay(self._enterGameView, self, 0.1)
end

function XugoujiLevelViewStageItem:_enterGameView()
	XugoujiController.instance:enterEpisode(self.episodeId)
end

function XugoujiLevelViewStageItem:_addEvents()
	XugoujiController.instance:registerCallback(XugoujiEvent.EnterEpisode, self._onEnterEpisode, self)
end

function XugoujiLevelViewStageItem:_removeEvents()
	XugoujiController.instance:unregisterCallback(XugoujiEvent.EnterEpisode, self._onEnterEpisode, self)
end

function XugoujiLevelViewStageItem:playFinishAni()
	self:refreshItem(self._config, self._index)
	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.episodeFinish)
	self._animator:Play(UIAnimationName.Finish, 0, 0)
	self._completeEffectAnimator:Play(UIAnimationName.Open, nil, nil)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
end

function XugoujiLevelViewStageItem:playUnlockAni()
	self:refreshItem(self._config, self._index)
	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.episodeUnlock)
	self._animator:Play(UIAnimationName.Unlock, 0, 0)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
end

function XugoujiLevelViewStageItem:_onEnterEpisode(episodeId)
	if self.episodeId ~= episodeId then
		return
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_6XugoujiSelect .. actId, tostring(self._index))

	if self._config.gameId and self._config.gameId ~= 0 then
		local isSkipStory = self._config.storyId == 0
		local isPlayedStoryLastTime = Activity188Model.instance:getCurEpisodeId() == episodeId

		if isSkipStory or isPlayedStoryLastTime then
			self:_storyEnd()
		else
			StoryController.instance:playStory(self._config.storyId, nil, self._storyEnd, self)
		end
	else
		local isSkipStory = self._config.storyId == 0

		if isSkipStory then
			self:_storyEnd()
		else
			StoryController.instance:playStory(self._config.storyId, nil, self._storyEnd, self)
		end
	end

	Activity188Model.instance:setCurEpisodeId(episodeId)
end

function XugoujiLevelViewStageItem:_storyEnd()
	if self._config.gameId and self._config.gameId ~= 0 then
		XugoujiGameStepController.instance:insertStepListClient({
			{
				stepType = XugoujiEnum.GameStepType.WaitGameStart
			},
			{
				stepType = XugoujiEnum.GameStepType.UpdateInitialCard
			}
		})
		XugoujiController.instance:openXugoujiGameView()
	else
		XugoujiController.instance:finishStoryPlay()
	end
end

function XugoujiLevelViewStageItem:onDestroy()
	self:_removeEvents()
	self:removeEventListeners()
end

return XugoujiLevelViewStageItem
