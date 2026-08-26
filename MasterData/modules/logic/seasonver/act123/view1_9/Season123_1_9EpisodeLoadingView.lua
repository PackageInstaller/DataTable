-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9EpisodeLoadingView.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9EpisodeLoadingView", package.seeall)

local Season123_1_9EpisodeLoadingView = class("Season123_1_9EpisodeLoadingView", BaseView)

function Season123_1_9EpisodeLoadingView:onInitView()
	self._gostageitem = gohelper.findChild(self.viewGO, "#go_story/chapterlist/#scroll_chapter/Viewport/Content/#go_stageitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_1_9EpisodeLoadingView:addEvents()
	return
end

function Season123_1_9EpisodeLoadingView:removeEvents()
	return
end

function Season123_1_9EpisodeLoadingView:_editableInitView()
	self._stageItems = {}
end

function Season123_1_9EpisodeLoadingView:onDestroyView()
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

function Season123_1_9EpisodeLoadingView:onOpen()
	local actId = self.viewParam.actId
	local stage = self.viewParam.stage
	local layer = self.viewParam.layer

	logNormal(string.format("Season123_1_9EpisodeLoadingView actId=%s, stage=%s", actId, stage))
	Season123EpisodeLoadingController.instance:onOpenView(actId, stage, layer)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_jinye_film_slide)
	self:refreshUI()
	TaskDispatcher.runDelay(self.handleDelayAnimTransition, self, 3)
end

function Season123_1_9EpisodeLoadingView:onClose()
	return
end

function Season123_1_9EpisodeLoadingView:refreshUI()
	self:refreshStageList()
end

function Season123_1_9EpisodeLoadingView:refreshStageList()
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

function Season123_1_9EpisodeLoadingView:getOrCreateStageItem(index)
	local item = self._stageItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gostageitem, "stage_item")

		item = self:getUserDataTb_()
		item.go = go
		item.txtName = gohelper.findChildText(go, "#txt_name")
		item.imageicon = gohelper.findChildImage(go, "#simage_chapterIcon")
		item.simagechaptericon = gohelper.findChildSingleImage(go, "#simage_chapterIcon")
		item.gofinish = gohelper.findChild(go, "#go_done")
		item.gounfinish = gohelper.findChild(go, "#go_unfinished")
		item.txtPassRound = gohelper.findChildText(go, "#go_done/#txt_num")
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

function Season123_1_9EpisodeLoadingView:refreshSingleItem(index, item, data)
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

function Season123_1_9EpisodeLoadingView:refreshSingleItemLock(index, item, data)
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

function Season123_1_9EpisodeLoadingView:refreshSingleItemFinished(index, item, data)
	if data.emptyIndex then
		gohelper.setActive(item.gofinish, false)
		gohelper.setActive(item.txtPassRound, false)
		gohelper.setActive(item.gounfinish, false)

		item.txtPassRound.text = ""
	else
		local isFinished = data.isFinished

		gohelper.setActive(item.gofinish, isFinished)
		gohelper.setActive(item.txtPassRound, isFinished)

		local isLock = not Season123EpisodeLoadingModel.instance:isEpisodeUnlock(data.cfg.layer)

		gohelper.setActive(item.gounfinish, not isFinished and not isLock)

		if isFinished then
			item.txtPassRound.text = tostring(data.round)
		end
	end
end

function Season123_1_9EpisodeLoadingView:handleDelayAnimTransition()
	Season123EpisodeLoadingController.instance:openEpisodeDetailView()
	TaskDispatcher.runDelay(self.closeThis, self, 1.5)
end

return Season123_1_9EpisodeLoadingView
