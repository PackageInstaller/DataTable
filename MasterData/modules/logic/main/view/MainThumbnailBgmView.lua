-- chunkname: @modules/logic/main/view/MainThumbnailBgmView.lua

module("modules.logic.main.view.MainThumbnailBgmView", package.seeall)

local MainThumbnailBgmView = class("MainThumbnailBgmView", BaseView)

function MainThumbnailBgmView:onInitView()
	self._goBgm = gohelper.findChild(self.viewGO, "#go_bgm")
	self._goNone = gohelper.findChild(self.viewGO, "#go_bgm/none")
	self._btnNoneBgm = gohelper.findChildButton(self.viewGO, "#go_bgm/none/#btn_nonebgm")
	self._goPlay0 = gohelper.findChild(self.viewGO, "#go_bgm/playing_0")
	self._btnPlay0Bgm = gohelper.findChildButton(self.viewGO, "#go_bgm/playing_0/#btn_play0bgm")
	self._btnPlay0Open = gohelper.findChildButton(self.viewGO, "#go_bgm/playing_0/#btn_play0open")
	self._goPlay1 = gohelper.findChild(self.viewGO, "#go_bgm/playing_1")
	self._play1Ani = self._goPlay1:GetComponent(typeof(UnityEngine.Animator))
	self._btnPlay1Bgm = gohelper.findChildButton(self.viewGO, "#go_bgm/playing_1/#btn_play1bgm")
	self._txtPlay1BgmName = gohelper.findChildText(self.viewGO, "#go_bgm/playing_1/#txt_play1bgmname")
	self._btnPlay1Close = gohelper.findChildButton(self.viewGO, "#go_bgm/playing_1/#btn_play1close")
	self._goloop = gohelper.findChild(self.viewGO, "#go_bgm/playing_1/loop")
	self._goSingleLoop = gohelper.findChild(self.viewGO, "#go_bgm/playing_1/SingleLoop")
	self._btnPlay1Love = gohelper.findChildButton(self.viewGO, "#go_bgm/playing_1/#btn_play1love")
	self._goLoveSelect = gohelper.findChild(self.viewGO, "#go_bgm/playing_1/#btn_play1love/select")
	self._goLoveSelectEmpty = gohelper.findChild(self.viewGO, "#go_bgm/playing_1/#btn_play1love/empty")
	self._goReddot = gohelper.findChild(self.viewGO, "#go_bgm/bgm_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainThumbnailBgmView:addEvents()
	self._btnNoneBgm:AddClickListener(self._btnNoneBgmOnClick, self)
	self._btnPlay0Bgm:AddClickListener(self._btnPlay0BgmOnClick, self)
	self._btnPlay0Open:AddClickListener(self._btnPlay0OpenOnClick, self)
	self._btnPlay1Bgm:AddClickListener(self._btnPlay1BgmOnClick, self)
	self._btnPlay1Close:AddClickListener(self._btnPlay1CloseOnClick, self)
	self._btnPlay1Love:AddClickListener(self._btnPlay1LoveOnClick, self)
end

function MainThumbnailBgmView:removeEvents()
	self._btnNoneBgm:RemoveClickListener()
	self._btnPlay0Bgm:RemoveClickListener()
	self._btnPlay0Open:RemoveClickListener()
	self._btnPlay1Bgm:RemoveClickListener()
	self._btnPlay1Close:RemoveClickListener()
	self._btnPlay1Love:RemoveClickListener()
end

function MainThumbnailBgmView:_btnNoneBgmOnClick()
	local isUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch)
	local forbidGuides = GuideController.instance:isForbidGuides()
	local isBGMGuideFirstStepFinished = GuideModel.instance:isStepFinish(BGMSwitchEnum.BGMGuideId, 1)

	if isUnlock and not forbidGuides and not isBGMGuideFirstStepFinished then
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ClickBgmEntranceInGuide)
	else
		self:_clickToOpenBGMSwitchView()
	end
end

function MainThumbnailBgmView:_btnPlay0BgmOnClick()
	local isUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch)
	local forbidGuides = GuideController.instance:isForbidGuides()
	local isBGMGuideFirstStepFinished = GuideModel.instance:isStepFinish(BGMSwitchEnum.BGMGuideId, 1)

	if isUnlock and not forbidGuides and not isBGMGuideFirstStepFinished then
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ClickBgmEntranceInGuide)
	else
		self:_clickToOpenBGMSwitchView()
	end
end

function MainThumbnailBgmView:_btnPlay0OpenOnClick()
	BGMSwitchModel.instance:setPlayingState(BGMSwitchEnum.PlayingState.UnfoldPlaying)
	self:_refreshView()
	BGMSwitchAudioTrigger.play_ui_replay_tinyopen()
end

function MainThumbnailBgmView:_btnPlay1BgmOnClick()
	local isUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch)
	local forbidGuides = GuideController.instance:isForbidGuides()
	local isBGMGuideFirstStepFinished = GuideModel.instance:isStepFinish(BGMSwitchEnum.BGMGuideId, 1)

	if isUnlock and not forbidGuides and not isBGMGuideFirstStepFinished then
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ClickBgmEntranceInGuide)
	else
		self:_clickToOpenBGMSwitchView()
	end
end

function MainThumbnailBgmView:_btnPlay1CloseOnClick()
	BGMSwitchModel.instance:setPlayingState(BGMSwitchEnum.PlayingState.FoldPlaying)
	self._play1Ani:Play("close")
	TaskDispatcher.runDelay(self._refreshView, self, 0.34)
	BGMSwitchAudioTrigger.play_ui_replay_tinyclose()
end

function MainThumbnailBgmView:_btnPlay1LoveOnClick()
	local _, mainBgmCo = self:getIdRandomAndNeedShowBgm()
	local bgmId = mainBgmCo.id
	local favorite = not BGMSwitchModel.instance:isBgmFavorite(bgmId)

	BgmRpc.instance:sendSetFavoriteBgmRequest(bgmId, favorite)
	BGMSwitchAudioTrigger.play_ui_replay_heart(favorite)
end

function MainThumbnailBgmView:_clickToOpenBGMSwitchView()
	self:_bgmMarkRead()
	BGMSwitchController.instance:openBGMSwitchView(true)
end

function MainThumbnailBgmView:getIdRandomAndNeedShowBgm()
	local mainBgmAudioId = BGMSwitchController.instance:getMainBgmAudioId()
	local mainBgmCo = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(mainBgmAudioId)
	local isRandom = BGMSwitchModel.instance:getUsedBgmIdFromServer() == BGMSwitchModel.RandomBgmId

	return isRandom, mainBgmCo
end

function MainThumbnailBgmView:_refreshView()
	local playingState = BGMSwitchModel.instance:getPlayingState()
	local isPlaying = BGMSwitchModel.instance:machineGearIsNeedPlayBgm()

	gohelper.setActive(self._goNone, not isPlaying or playingState == BGMSwitchEnum.PlayingState.None)
	gohelper.setActive(self._goPlay0, isPlaying and playingState == BGMSwitchEnum.PlayingState.FoldPlaying)
	gohelper.setActive(self._goPlay1, isPlaying and playingState == BGMSwitchEnum.PlayingState.UnfoldPlaying)

	if isPlaying and playingState == BGMSwitchEnum.PlayingState.UnfoldPlaying then
		local isRandom, mainBgmCo = self:getIdRandomAndNeedShowBgm()

		gohelper.setActive(self._goloop, isRandom)
		gohelper.setActive(self._goSingleLoop, not isRandom)

		self._txtPlay1BgmName.text = mainBgmCo.audioName

		local isFavorite = BGMSwitchModel.instance:isBgmFavorite(mainBgmCo.id)

		gohelper.setActive(self._goLoveSelect, isFavorite)
		gohelper.setActive(self._goLoveSelectEmpty, not isFavorite)
	end
end

function MainThumbnailBgmView:onOpen()
	self.isUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch)

	if self.isUnlock then
		self:_addSelfEvents()
		self:_refreshView()
	end

	gohelper.setActive(self._goBgm, self.isUnlock)
end

function MainThumbnailBgmView:_addSelfEvents()
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.SelectPlayGear, self._refreshView, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BgmSwitched, self._refreshView, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BgmFavorite, self._refreshView, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.RandomFinished, self._refreshView, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BGMSwitchClose, self._refreshView, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BgmMarkRead, self._bgmMarkRead, self)
	self.addEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.OnPlayMainBgm, self._onPlayMainBgm, self)
end

function MainThumbnailBgmView:_removeSelfEvents()
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.SelectPlayGear, self._refreshView, self)
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BgmSwitched, self._refreshView, self)
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BgmFavorite, self._refreshView, self)
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.RandomFinished, self._refreshView, self)
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BGMSwitchClose, self._refreshView, self)
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.BgmMarkRead, self._bgmMarkRead, self)
	self.removeEventCb(self, BGMSwitchController.instance, BGMSwitchEvent.OnPlayMainBgm, self._onPlayMainBgm, self)
end

function MainThumbnailBgmView:_editableInitView()
	self._redDotComp = RedDotController.instance:addNotEventRedDot(self._goReddot, self._isNotRead, self)
end

function MainThumbnailBgmView:_onPlayMainBgm(audioId)
	self:_refreshView()
end

function MainThumbnailBgmView:_bgmMarkRead()
	local unReadCount = BGMSwitchModel.instance:getUnReadCount()

	PlayerPrefsHelper.setNumber(BGMSwitchController.instance:getPlayerPrefKey(), unReadCount)

	if self._redDotComp then
		self._redDotComp:refreshRedDot()
	end
end

function MainThumbnailBgmView:_isNotRead()
	return BGMSwitchController.instance:hasBgmRedDot()
end

function MainThumbnailBgmView:onDestroyView()
	if self.isUnlock then
		TaskDispatcher.cancelTask(self._refreshView, self)
		self:_removeSelfEvents()
	end
end

return MainThumbnailBgmView
