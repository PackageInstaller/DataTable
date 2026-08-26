-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/view/FeiLinShiDuoEpisodeItem.lua

module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoEpisodeItem", package.seeall)

local FeiLinShiDuoEpisodeItem = class("FeiLinShiDuoEpisodeItem", LuaCompBase)

function FeiLinShiDuoEpisodeItem:onInit(go)
	self._go = go
	self._goGet = gohelper.findChild(self._go, "unlock/Reward/#go_Get")
	self._gostagenormal = gohelper.findChild(self._go, "unlock/#go_stagenormal")
	self._btnclick = gohelper.findChildButtonWithAudio(self._go, "unlock/#btn_click")
	self._btnGameClick = gohelper.findChildButtonWithAudio(self._go, "unlock/#go_gameEpisode/#btn_gameClick")
	self._gostar = gohelper.findChild(self._go, "unlock/star/#go_star")
	self._gostarIdle = gohelper.findChild(self._go, "unlock/star/star_idle")
	self._imageStar = gohelper.findChildImage(self._go, "unlock/star/#go_star/#image_Star")
	self._txtstagename = gohelper.findChildText(self._go, "unlock/#txt_stagename")
	self._txtstageNum = gohelper.findChildText(self._go, "unlock/#txt_stageNum")
	self._goGameEpisode = gohelper.findChild(self._go, "unlock/#go_gameEpisode")
	self._goGameFinished = gohelper.findChild(self._go, "unlock/#go_gameEpisode/#go_gameFinished")
	self._goStageLock = gohelper.findChild(self._go, "unlock/#go_stageLock")
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self._go)
	self._animGamePlayer = SLFramework.AnimatorPlayer.Get(self._goGameEpisode)
end

function FeiLinShiDuoEpisodeItem:setInfo(index, config)
	self.index = index
	self.actId = config.activityId
	self.episodeId = config.episodeId
	self.config = config
	self.preEpisodeId = config.preEpisodeId

	self:refreshUI()
end

function FeiLinShiDuoEpisodeItem:refreshUI()
	self._txtstagename.text = self.config.name
	self._txtstageNum.text = string.format("0%s", self.index)

	self:isShowItem(true)

	local finishState = FeiLinShiDuoModel.instance:getEpisodeFinishState(self.episodeId)

	self.isUnlock = FeiLinShiDuoModel.instance:isUnlock(self.actId, self.episodeId)

	gohelper.setActive(self._goStageLock, not self.isUnlock)
	gohelper.setActive(self._gostar, finishState)
	gohelper.setActive(self._gostarIdle, finishState)

	if finishState then
		self._animPlayer:Play("finish_idle", nil, self)
	end

	self.gameEpisodeConfig = FeiLinShiDuoConfig.instance:getGameEpisode(self.episodeId)

	gohelper.setActive(self._goGameEpisode, finishState and self.gameEpisodeConfig)

	if self.gameEpisodeConfig then
		local isGameFinished = FeiLinShiDuoModel.instance:getEpisodeFinishState(self.gameEpisodeConfig.episodeId)

		gohelper.setActive(self._goGameFinished, finishState and self.gameEpisodeConfig)
	end
end

function FeiLinShiDuoEpisodeItem:isShowItem(state)
	gohelper.setActive(self._go, state)
end

function FeiLinShiDuoEpisodeItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnGameClick:AddClickListener(self._btnGameClickOnClick, self)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.EpisodeItemPlayFinishAnim, self.playEpisodeItemFinishAnim, self)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.NextEpisodePlayUnlockAnim, self.playEpisodeItemUnlockAnim, self)
end

function FeiLinShiDuoEpisodeItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	self._btnGameClick:RemoveClickListener()
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.EpisodeItemPlayFinishAnim, self.playEpisodeItemFinishAnim, self)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.NextEpisodePlayUnlockAnim, self.playEpisodeItemUnlockAnim, self)
end

function FeiLinShiDuoEpisodeItem:_btnclickOnClick()
	local isOpen = self:checkIsOpen()

	if not isOpen then
		return
	end

	FeiLinShiDuoModel.instance:setCurEpisodeId(self.episodeId)
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.SelectEpisode, self.index, self.episodeId, false)
	FeiLinShiDuoStatHelper.instance:initEpisodeStartTime(self.episodeId)
end

function FeiLinShiDuoEpisodeItem:_btnGameClickOnClick()
	local isOpen = self:checkIsOpen()

	if not isOpen then
		return
	end

	FeiLinShiDuoModel.instance:setCurEpisodeId(self.episodeId)
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.SelectEpisode, self.index, self.episodeId, true)
end

function FeiLinShiDuoEpisodeItem:checkIsOpen()
	local mo = ActivityModel.instance:getActMO(self.actId)
	local isOpen = true

	if mo == nil then
		logError("not such activity id: " .. self.actId)

		isOpen = false
	end

	if not mo:isOpen() or mo:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		isOpen = false
	end

	self.isUnlock = FeiLinShiDuoModel.instance:isUnlock(self.actId, self.episodeId)

	if not self.isUnlock then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		isOpen = false
	end

	return isOpen
end

function FeiLinShiDuoEpisodeItem:playEpisodeItemFinishAnim(episodeId)
	self.curFinishEpisodeId = episodeId
	self.finishGameConfig = FeiLinShiDuoConfig.instance:getGameEpisode(episodeId)

	if episodeId == self.episodeId then
		gohelper.setActive(self._gostar, true)
		self._animPlayer:Play("finish", nil, self)
		UIBlockMgr.instance:startBlock("FeiLinShiDuoEpisodeItemAnim")
		UIBlockMgrExtend.setNeedCircleMv(false)
		self:playNextEpisodeShowAnim()

		if episodeId == FeiLinShiDuoModel.instance:getLastEpisodeId() then
			FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.SwitchBG, true)
		end

		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_jinye_story_star)
	elseif self.gameEpisodeConfig and self.gameEpisodeConfig.episodeId == episodeId then
		gohelper.setActive(self._goGameEpisode, true)
		self._animGamePlayer:Play("finish_idle", nil, self)
		gohelper.setActive(self._goGameFinished, true)
		self:playNextEpisodeUnlockAnim()
	end
end

function FeiLinShiDuoEpisodeItem:playNextEpisodeShowAnim()
	gohelper.setActive(self._gostarIdle, true)

	if self.finishGameConfig then
		gohelper.setActive(self._goGameEpisode, true)
		self._animGamePlayer:Play("open", self.playGameShowAnimFinish, self)
	else
		self:playNextEpisodeUnlockAnim()
	end
end

function FeiLinShiDuoEpisodeItem:playNextEpisodeUnlockAnim()
	self._animPlayer:Play("finish_idle", nil, self)

	local nextEpisodeCo = FeiLinShiDuoConfig.instance:getNextEpisode(self.curFinishEpisodeId)

	if nextEpisodeCo then
		FeiLinShiDuoModel.instance:setCurEpisodeId(nextEpisodeCo.episodeId)
		FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.NextEpisodePlayUnlockAnim, nextEpisodeCo.episodeId)
		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_leimi_level_difficulty)
	else
		FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.SwitchBG, false)
		UIBlockMgr.instance:endBlock("FeiLinShiDuoEpisodeItemAnim")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function FeiLinShiDuoEpisodeItem:playGameShowAnimFinish()
	UIBlockMgr.instance:endBlock("FeiLinShiDuoEpisodeItemAnim")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function FeiLinShiDuoEpisodeItem:playEpisodeItemUnlockAnim(episodeId)
	if episodeId == self.episodeId then
		self._animPlayer:Play("unlock", self.playUnlockAnimFinish, self)
		gohelper.setActive(self._goStageLock, false)
	end
end

function FeiLinShiDuoEpisodeItem:playUnlockAnimFinish()
	UIBlockMgr.instance:endBlock("FeiLinShiDuoEpisodeItemAnim")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function FeiLinShiDuoEpisodeItem:onDestroy()
	return
end

return FeiLinShiDuoEpisodeItem
