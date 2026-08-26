-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicChapterItem.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicChapterItem", package.seeall)

local VersionActivity2_4MusicChapterItem = class("VersionActivity2_4MusicChapterItem", ListScrollCellExtend)

function VersionActivity2_4MusicChapterItem:onInitView()
	self._goSpecial = gohelper.findChild(self.viewGO, "root/#go_Special")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/#txt_num")
	self._txtname = gohelper.findChildText(self.viewGO, "root/image_txtBG/#txt_name")
	self._txten = gohelper.findChildText(self.viewGO, "root/image_txtBG/#txt_name/#txt_en")
	self._imagestargray = gohelper.findChildImage(self.viewGO, "root/#image_stargray")
	self._imagestarlight = gohelper.findChildImage(self.viewGO, "root/#image_starlight")
	self._imagecurrentdown = gohelper.findChildImage(self.viewGO, "root/#image_currentdown")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4MusicChapterItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function VersionActivity2_4MusicChapterItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function VersionActivity2_4MusicChapterItem:_btnclickOnClick()
	if not self._hasOpen then
		GameFacade.showToast(ToastEnum.PreLevelNotCompleted)

		return
	end

	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.ClickChapterItem, self._episodeId)
end

function VersionActivity2_4MusicChapterItem:_onClickHandler()
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Version2_4MusicSelectEpisode, self._episodeId)

	if self._episodeConfig.episodeType == VersionActivity2_4MusicEnum.EpisodeType.Story then
		StoryController.instance:playStory(self._episodeConfig.storyBefore, nil, self._onFinishStory, self)

		if not self._hasFinished then
			Activity179Rpc.instance:sendSet179ScoreRequest(Activity179Model.instance:getActivityId(), self._episodeId, 0)
		end

		return
	end

	if self._episodeConfig.episodeType == VersionActivity2_4MusicEnum.EpisodeType.Beat then
		if not StoryModel.instance:isStoryFinished(self._episodeConfig.storyBefore) or self._hasFinished then
			StoryController.instance:playStory(self._episodeConfig.storyBefore, nil, self._enterBeatView, self)
		else
			self:_enterBeatView()
		end
	end
end

function VersionActivity2_4MusicChapterItem:_enterBeatView()
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicBeatView(self._episodeId)
end

function VersionActivity2_4MusicChapterItem:_onFinishStory()
	if not self._hasFinished then
		VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.EpisodeStoryBeforeFinished)
	end
end

function VersionActivity2_4MusicChapterItem:_editableInitView()
	self._canvas = self.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(self._imagecurrentdown, false)
	self.addEventCb(self, VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.ClickChapterItem, self._onClickChapterItem, self)
end

function VersionActivity2_4MusicChapterItem:_onClickChapterItem(episodeId)
	local oldSelected = self._isSelected

	self._isSelected = self._episodeId == episodeId

	gohelper.setActive(self._imagecurrentdown, self._isSelected)

	if self._episodeId == episodeId then
		local time = 0.3

		TaskDispatcher.cancelTask(self._onClickHandler, self)
		TaskDispatcher.runDelay(self._onClickHandler, self, time)
		UIBlockHelper.instance:startBlock("VersionActivity2_4MusicChapterItem ClickChapterItem", time)
	end

	if not oldSelected and self._isSelected then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)
	end
end

function VersionActivity2_4MusicChapterItem:_editableAddEvents()
	return
end

function VersionActivity2_4MusicChapterItem:_editableRemoveEvents()
	return
end

function VersionActivity2_4MusicChapterItem:getEpisodeId()
	return self._episodeId
end

function VersionActivity2_4MusicChapterItem:onUpdateMO(mo)
	self._episodeConfig = mo
	self._episodeId = self._episodeConfig.id
	self._txtname.text = self._episodeConfig.name
	self._txten.text = self._episodeConfig.name_En
	self._txtnum.text = self._episodeConfig.orderId

	local isSpecial = self._episodeConfig.episodeType == VersionActivity2_4MusicEnum.EpisodeType.Beat

	gohelper.setActive(self._goSpecial, isSpecial)
	self:updateSelectedFlag()
	self:updateView()
end

function VersionActivity2_4MusicChapterItem:updateSelectedFlag()
	local episodeId = Activity179Model.instance:getSelectedEpisodeId()

	self._isSelected = episodeId == self._episodeId

	gohelper.setActive(self._imagecurrentdown, self._isSelected)
end

function VersionActivity2_4MusicChapterItem:updateView()
	self._hasOpen = self._episodeConfig.preEpisode == 0 or Activity179Model.instance:episodeIsFinished(self._episodeConfig.preEpisode)
	self._hasFinished = Activity179Model.instance:episodeIsFinished(self._episodeId)

	gohelper.setActive(self._imagestargray, not self._hasFinished)
	gohelper.setActive(self._imagestarlight, self._hasFinished)

	self._canvas.alpha = self._hasFinished and 1 or 0.8
end

function VersionActivity2_4MusicChapterItem:getHasFinished()
	return self._hasFinished
end

function VersionActivity2_4MusicChapterItem:getHasOpened()
	return self._hasOpen
end

function VersionActivity2_4MusicChapterItem:onDestroyView()
	TaskDispatcher.cancelTask(self._onClickHandler, self)
end

return VersionActivity2_4MusicChapterItem
