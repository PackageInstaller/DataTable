-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/view/LanShouPaMapViewStageItem.lua

module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaMapViewStageItem", package.seeall)

local LanShouPaMapViewStageItem = class("LanShouPaMapViewStageItem", LuaCompBase)

function LanShouPaMapViewStageItem:init(go)
	self.viewGO = go
	self._animator = go:GetComponent(typeof(UnityEngine.Animator))
	self._imagepoint = gohelper.findChildImage(self.viewGO, "#image_point")
	self._gounlock = gohelper.findChild(self.viewGO, "unlock")
	self._imagestageline = gohelper.findChildImage(self.viewGO, "unlock/#image_stageline")
	self._gostagefinish = gohelper.findChild(self.viewGO, "unlock/#go_stagefinish")
	self._gostagenormal = gohelper.findChild(self.viewGO, "unlock/#go_stagenormal")
	self._gogame = gohelper.findChild(self.viewGO, "unlock/#go_stagenormal/#go_Game")
	self._gostory = gohelper.findChild(self.viewGO, "unlock/#go_stagenormal/#go_Story")
	self._imageline = gohelper.findChildImage(self.viewGO, "unlock/#image_line")
	self._imageangle = gohelper.findChildImage(self.viewGO, "unlock/#image_angle")
	self._txtstagename = gohelper.findChildText(self.viewGO, "unlock/info/#txt_stagename")
	self._txtstagenum = gohelper.findChildText(self.viewGO, "unlock/info/#txt_stagename/#txt_stageNum")
	self._gostar = gohelper.findChild(self.viewGO, "unlock/info/#txt_stagename/#go_star")
	self._gohasstar = gohelper.findChild(self._gostar, "has/#image_Star")
	self._btnreview = gohelper.findChildButtonWithAudio(self.viewGO, "unlock/info/#txt_stagename/#btn_review")
	self._imagechess = gohelper.findChildImage(self.viewGO, "unlock/#image_chess")
	self._chessAnimator = gohelper.findChild(self._imagechess.gameObject, "ani"):GetComponent(typeof(UnityEngine.Animator))
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "unlock/#btn_click")

	self:_addEvents()
end

function LanShouPaMapViewStageItem:refreshItem(co, index)
	self._actId = VersionActivity2_1Enum.ActivityId.LanShouPa
	self._index = index
	self._config = co
	self._episodeId = self._config.id

	local curEpisodeId = Activity164Model.instance:getCurEpisodeId() or LanShouPaEnum.episodeId

	self._txtstagename.text = self._config.name
	self._txtstagenum.text = string.format("STAGE %02d", index)

	local isChessStage = self._config.mapIds ~= 0
	local isFinish = index <= Activity164Model.instance:getUnlockCount()
	local storyCos = Activity164Config.instance:getStoryList(self._actId, self._episodeId)

	gohelper.setActive(self._btnreview.gameObject, isChessStage and isFinish and storyCos and #storyCos > 0)
	gohelper.setActive(self._imagechess.gameObject, self._episodeId == curEpisodeId)
	gohelper.setActive(self._gounlock, Activity164Model.instance:getUnlockCount() >= index - 1)
	gohelper.setActive(self._gostagefinish, isChessStage)
	gohelper.setActive(self._gostagenormal, true)
	gohelper.setActive(self._gohasstar, isFinish)
	gohelper.setActive(self._gogame, isChessStage)
	gohelper.setActive(self._gostory, not isChessStage)
end

function LanShouPaMapViewStageItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnreview:AddClickListener(self._btnReviewOnClick, self)
end

function LanShouPaMapViewStageItem:removeEventListeners()
	if self._btnclick then
		self._btnclick:RemoveClickListener()
		self._btnreview:RemoveClickListener()
	end
end

function LanShouPaMapViewStageItem:_btnclickOnClick()
	local curEpisodeId = Activity164Model.instance:getCurEpisodeId()

	if curEpisodeId == self._episodeId then
		self:_realPlayStory()
	else
		LanShouPaController.instance:dispatchEvent(LanShouPaEvent.EpisodeClick, self._episodeId)
		UIBlockHelper.instance:startBlock("LanShouPaMapViewStageItemEpisodeClick", 0.5, self.viewName)
		TaskDispatcher.runDelay(self._delayPlayChessOpenAnim, self, 0.25)
	end
end

function LanShouPaMapViewStageItem:_delayPlayChessOpenAnim()
	if not self._imagechess then
		return
	end

	gohelper.setActive(self._imagechess, true)

	local curEpisodeId = Activity164Model.instance:getCurEpisodeId()

	if curEpisodeId > self._episodeId then
		self._chessAnimator:Play("open_left", 0, 0)
	else
		self._chessAnimator:Play("open_right", 0, 0)
	end

	Activity164Model.instance:setCurEpisodeId(self._episodeId)
	TaskDispatcher.runDelay(self._realPlayStory, self, 0.25)
end

function LanShouPaMapViewStageItem:_realPlayStory()
	if not self._config then
		return
	end

	local actId = VersionActivity2_1Enum.ActivityId.LanShouPa
	local episodeCfgList = Activity164Config.instance:getEpisodeCoList(actId)

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_1LanShouPaSelect .. actId, tostring(tabletool.indexOf(episodeCfgList, self._config)))

	local isSkipStory = self._config.storyBefore == 0 or self._config.mapIds ~= 0 and Activity164Model.instance.currChessGameEpisodeId == self._episodeId

	if isSkipStory then
		self:_storyEnd()
	else
		StoryController.instance:playStory(self._config.storyBefore, nil, self._storyEnd, self)
	end
end

function LanShouPaMapViewStageItem:_btnReviewOnClick()
	local isChessStage = self._config.mapIds ~= 0

	if isChessStage then
		LanShouPaController.instance:openStoryView(self._episodeId)
	else
		StoryController.instance:playStory(self._config.storyBefore, nil, self._storyEnd, self)
	end
end

function LanShouPaMapViewStageItem:_storyEnd()
	local isChessStage = self._config.mapIds ~= 0

	if isChessStage then
		Activity164Model.instance.currChessGameEpisodeId = self._episodeId

		LanShouPaController.instance:enterChessGame(self._actId, self._episodeId)
		LanShouPaController.instance:dispatchEvent(LanShouPaEvent.StartEnterGameView)
	else
		Activity164Model.instance:markEpisodeFinish(self._episodeId)
	end
end

function LanShouPaMapViewStageItem:_addEvents()
	LanShouPaController.instance:registerCallback(LanShouPaEvent.EpisodeClick, self._playChooseEpisode, self)
end

function LanShouPaMapViewStageItem:_removeEvents()
	LanShouPaController.instance:unregisterCallback(LanShouPaEvent.EpisodeClick, self._playChooseEpisode, self)
end

function LanShouPaMapViewStageItem:onPlayFinish()
	self:refreshItem(self._config, self._index)
	self._animator:Play("finish", 0, 0)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
end

function LanShouPaMapViewStageItem:onPlayUnlock()
	self:refreshItem(self._config, self._index)
	self._animator:Play("unlock", 0, 0)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
end

function LanShouPaMapViewStageItem:_playChooseEpisode(episodeId)
	local curEpisodeId = Activity164Model.instance:getCurEpisodeId()

	if self._episodeId == curEpisodeId then
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)

		if episodeId < self._episodeId then
			self._chessAnimator:Play("close_left", 0, 0)
		else
			self._chessAnimator:Play("close_right", 0, 0)
		end
	end
end

function LanShouPaMapViewStageItem:onDestroyView()
	self:_removeEvents()
	self:removeEventListeners()
end

return LanShouPaMapViewStageItem
