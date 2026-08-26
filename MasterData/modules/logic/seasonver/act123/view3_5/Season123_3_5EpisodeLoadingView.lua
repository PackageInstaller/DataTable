-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EpisodeLoadingView.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EpisodeLoadingView", package.seeall)

local Season123_3_5EpisodeLoadingView = class("Season123_3_5EpisodeLoadingView", BaseView)

function Season123_3_5EpisodeLoadingView:onInitView()
	self._gostageitem = gohelper.findChild(self.viewGO, "#go_story/chapterlist/#scroll_chapter/Viewport/Content/#go_stageitem")
	self._viewAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._btnskipAnim = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skipAnim")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_3_5EpisodeLoadingView:addEvents()
	self._btnskipAnim:AddClickListener(self._btnSkilAnimOnClick, self)
end

function Season123_3_5EpisodeLoadingView:removeEvents()
	self._btnskipAnim:RemoveClickListener()
end

function Season123_3_5EpisodeLoadingView:_btnSkilAnimOnClick()
	gohelper.setActive(self._btnskipAnim.gameObject, false)
	self._viewAnim:Play("season123episodeloadingview_open", 0, 0.7)
	TaskDispatcher.cancelTask(self.handleDelayAnimTransition, self)
	TaskDispatcher.runDelay(self.handleDelayAnimTransition, self, 0.2)

	if self.audioId then
		AudioMgr.instance:stopPlayingID(self.audioId)

		self.audioId = nil
	end
end

function Season123_3_5EpisodeLoadingView:_editableInitView()
	self._stageItems = {}
end

function Season123_3_5EpisodeLoadingView:onDestroyView()
	if self._stageItems then
		for _, item in pairs(self._stageItems) do
			item.simagechaptericon:UnLoadImage()
		end

		self._stageItems = nil
	end

	Season123EpisodeLoadingController.instance:onCloseView()
	TaskDispatcher.cancelTask(self.closeThis, self)
	TaskDispatcher.cancelTask(self.handleDelayAnimTransition, self)
end

function Season123_3_5EpisodeLoadingView:onOpen()
	local actId = self.viewParam.actId
	local stage = self.viewParam.stage
	local layer = self.viewParam.layer

	logNormal(string.format("Season123_3_5EpisodeLoadingView actId=%s, stage=%s", actId, stage))
	Season123EpisodeLoadingController.instance:onOpenView(actId, stage, layer)

	self.audioId = AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_jinye_film_slide)

	self:refreshUI()
	TaskDispatcher.runDelay(self.handleDelayAnimTransition, self, 3)
end

function Season123_3_5EpisodeLoadingView:onClose()
	return
end

function Season123_3_5EpisodeLoadingView:refreshUI()
	self:refreshStageList()
end

function Season123_3_5EpisodeLoadingView:refreshStageList()
	local stageDatas = Season123EpisodeLoadingModel.instance:getList()
	local processSet = {}

	for i, stageData in ipairs(stageDatas) do
		local item = self:getOrCreateStageItem(i)

		self:refreshSingleItem(i, item, stageData)

		processSet[item] = true
	end

	for _, item in pairs(self._stageItems) do
		gohelper.setActive(item.go, processSet[item])
	end
end

function Season123_3_5EpisodeLoadingView:getOrCreateStageItem(index)
	local item = self._stageItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gostageitem, "stage_item")

		item = self:getUserDataTb_()
		item.go = go
		item.txtName = gohelper.findChildText(go, "#txt_name")
		item.imageicon = gohelper.findChildImage(go, "#simage_chapterIcon")
		item.simagechaptericon = gohelper.findChildSingleImage(go, "#simage_chapterIcon")
		item.gounfinish = gohelper.findChild(go, "#go_unfinished")
		item.golock = gohelper.findChild(go, "#go_locked")
		item.gounlocklight = gohelper.findChild(go, "#go_chpt/light")
		item.goEnemyList = gohelper.findChild(go, "enemyList")
		item.goEnemyItem = gohelper.findChild(go, "enemyList/#go_enemyteam/enemyList/go_enemyitem")
		item.txtchapter = gohelper.findChildText(go, "#go_chpt/#txt_chpt")
		item.goselected = gohelper.findChild(go, "selectframe")

		gohelper.setActive(item.go, true)

		self._stageItems[index] = item
	end

	return item
end

function Season123_3_5EpisodeLoadingView:refreshSingleItem(index, item, data)
	if data.emptyIndex then
		item.txtchapter.text = ""
	else
		item.txtchapter.text = string.format("%02d", data.cfg.layer)

		local folder = Season123Model.instance:getSingleBgFolder()

		item.simagechaptericon:LoadImage(ResUrl.getSeason123EpisodeIcon(folder, data.cfg.stagePicture))
	end

	self:refreshSingleItemLock(index, item, data)
	self:refreshSingleItemFinished(index, item, data)

	if data.emptyIndex then
		UISpriteSetMgr.instance:setSeason123Sprite(item.imageicon, Season123ProgressUtils.getEmptyLayerName(data.emptyIndex))
	end
end

function Season123_3_5EpisodeLoadingView:refreshSingleItemLock(index, item, data)
	if data.emptyIndex then
		gohelper.setActive(item.golock, false)
	else
		local isLock = not Season123EpisodeLoadingModel.instance:isEpisodeUnlock(data.cfg.layer)

		gohelper.setActive(item.golock, isLock)
		gohelper.setActive(item.gounlocklight, not item.gounlocklight)

		local color = isLock and "#FFFFFF" or "#FFFFFF"

		SLFramework.UGUI.GuiHelper.SetColor(item.txtchapter, color)
	end
end

function Season123_3_5EpisodeLoadingView:refreshSingleItemFinished(index, item, data)
	if data.emptyIndex then
		gohelper.setActive(item.gounfinish, false)
	else
		local isFinished = data.isFinished
		local isLock = not Season123EpisodeLoadingModel.instance:isEpisodeUnlock(data.cfg.layer)

		gohelper.setActive(item.gounfinish, not isFinished and not isLock)
	end
end

function Season123_3_5EpisodeLoadingView:handleDelayAnimTransition()
	Season123EpisodeLoadingController.instance:openEpisodeDetailView()
	TaskDispatcher.runDelay(self.closeThis, self, 1.5)
end

return Season123_3_5EpisodeLoadingView
