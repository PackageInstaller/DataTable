-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5ResetView.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5ResetView", package.seeall)

local Season123_3_5ResetView = class("Season123_3_5ResetView", BaseView)

function Season123_3_5ResetView:onInitView()
	self._goheroitem = gohelper.findChild(self.viewGO, "Bottom/#scroll_herolist/Viewport/Content/#go_heroitem")
	self._goepisodeitem = gohelper.findChild(self.viewGO, "Top/#go_story/chapterlist/#scroll_chapter/Viewport/Content/#go_stageitem")
	self._goareaitem = gohelper.findChild(self.viewGO, "Top/#go_story/chapterlist/#scroll_chapter/Viewport/Content/#go_areaitem")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "Bottom/#btn_reset")
	self._txtlevel = gohelper.findChildText(self.viewGO, "Bottom/#txt_level")
	self._goempty3 = gohelper.findChild(self.viewGO, "Top/#go_story/chapterlist/#scroll_chapter/Viewport/Content/empty3")
	self._goempty4 = gohelper.findChild(self.viewGO, "Top/#go_story/chapterlist/#scroll_chapter/Viewport/Content/empty4")
	self._txtreset = gohelper.findChildText(self.viewGO, "Bottom/#btn_reset/Text")
	self._imagereset = gohelper.findChildImage(self.viewGO, "Bottom/#btn_reset")
	self._goheroexist = gohelper.findChild(self.viewGO, "Bottom/#scroll_herolist")
	self._goheroempty = gohelper.findChild(self.viewGO, "Bottom/#go_heroempty")
	self._goscrollchapter = gohelper.findChild(self.viewGO, "Top/#go_story/chapterlist/#scroll_chapter")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_3_5ResetView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function Season123_3_5ResetView:removeEvents()
	self._btnreset:RemoveClickListener()
end

function Season123_3_5ResetView:_editableInitView()
	self._heroItems = {}
	self._episodeItems = {}
	self._scrollchapter = gohelper.findChildScrollRect(self._goscrollchapter, "")

	self:createStageItem()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_mln_day_night)
end

function Season123_3_5ResetView:onDestroyView()
	TaskDispatcher.cancelTask(self.delayInitScrollAudio, self)

	for _, heroItem in pairs(self._heroItems) do
		if heroItem.icon then
			heroItem.icon:removeClickListener()
			heroItem.icon:onDestroy()
		end
	end

	if self._episodeItems then
		for _, episodeItem in pairs(self._episodeItems) do
			episodeItem.btnself:RemoveClickListener()
			episodeItem.simagechaptericon:UnLoadImage()
		end

		self._episodeItems = nil
	end

	if self._stageItem then
		self._stageItem.btnself:RemoveClickListener()
		self._stageItem.simageicon:UnLoadImage()

		self._stageItem = nil
	end

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end

	if self._touch then
		self._touch:RemoveClickDownListener()

		self._touch = nil
	end

	Season123ResetController.instance:onCloseView()
end

function Season123_3_5ResetView:onOpen()
	self.addEventCb(self, Season123Controller.instance, Season123Event.RefreshResetView, self.refreshUI, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.OnResetSucc, self.closeThis, self)
	Season123ResetController.instance:onOpenView(self.viewParam.actId, self.viewParam.stage, self.viewParam.layer)

	local actMO = ActivityModel.instance:getActMO(self.viewParam.actId)

	if not actMO or not actMO:isOpen() or actMO:isExpired() then
		return
	end

	self:refreshUI()
	TaskDispatcher.runDelay(self.delayInitScrollAudio, self, 0.1)
end

function Season123_3_5ResetView:onClose()
	return
end

function Season123_3_5ResetView:refreshUI()
	self:refreshStatus()
	self:refreshStage()
	self:refreshEpisodeItems()
	self:refreshHeroItems()
end

function Season123_3_5ResetView:refreshStatus()
	local layer = Season123ResetModel.instance.layer
	local colorStr = "#ffffff"
	local txtColorStr = "#b1b1b1"

	if not layer then
		self._txtlevel.text = luaLang("season123_reset_stage_level")
	elseif Season123ResetModel.EmptySelect ~= layer then
		local episodeCO = Season123ResetModel.instance:getSelectLayerCO()

		self._txtlevel.text = string.format("EP.%02d", episodeCO.layer)
	else
		self._txtlevel.text = "---"
		colorStr = "#808080"
		txtColorStr = "#808080"
	end

	SLFramework.UGUI.GuiHelper.SetColor(self._imagereset, colorStr)
	SLFramework.UGUI.GuiHelper.SetColor(self._txtreset, txtColorStr)
end

function Season123_3_5ResetView:refreshStage()
	local item = self._stageItem
	local stageCO = Season123ResetModel.instance:getStageCO()

	if stageCO then
		item.txtname.text = stageCO.name
	end

	local seasonMO = Season123Model.instance:getActInfo(Season123ResetModel.instance.activityId)

	if seasonMO then
		local round = seasonMO:getTotalRound(Season123ResetModel.instance.stage)

		item.txtnum.text = tostring(round)
	else
		item.txtnum.text = "--"
	end

	local folder = Season123Model.instance:getSingleBgFolder()

	item.simageicon:LoadImage(ResUrl.getSeason123ResetStageIcon(folder, Season123ResetModel.instance.stage))
	gohelper.setActive(item.goselected, Season123ResetModel.instance.layer == nil)
end

function Season123_3_5ResetView:refreshEpisodeItems()
	local moList = Season123ResetModel.instance:getList()

	for i = 1, #moList do
		self:refreshEpisodeItem(i, moList[i])
	end

	for i = #moList + 1, #self._episodeItems do
		gohelper.setActive(self._episodeItems[i].go, false)
	end

	gohelper.setAsLastSibling(self._goempty3)
	gohelper.setAsLastSibling(self._goempty4)
end

function Season123_3_5ResetView:refreshEpisodeItem(index, data)
	local item = self:getOrCreateEpisodeItem(index)

	gohelper.setActive(item.go, true)

	item.txtchapter.text = string.format("%02d", data.cfg.layer)

	local folder = Season123Model.instance:getSingleBgFolder()

	item.simagechaptericon:LoadImage(ResUrl.getSeason123EpisodeIcon(folder, data.cfg.stagePicture))
	gohelper.setActive(item.goselected, data.cfg.layer == Season123ResetModel.instance.layer)
	self:refreshSingleItemFinished(index, item, data)
end

function Season123_3_5ResetView:refreshSingleItemFinished(index, item, data)
	local isUnlock = Season123ResetModel.instance:isEpisodeUnlock(data.cfg.layer)
	local isFinished = data.isFinished
	local isLock = not isUnlock or not isFinished

	gohelper.setActive(item.godone, isFinished)
	gohelper.setActive(item.txttime, isFinished)
	gohelper.setActive(item.gounfinish, not isLock)

	if isFinished then
		local isReduceRound = Season123Controller.instance:isReduceRound(self.viewParam.actId, self.viewParam.stage, data.cfg.layer)
		local passRoundFormat = isReduceRound and "<color=#eecd8c>%s</color>" or "%s"

		item.txttime.text = string.format(passRoundFormat, tostring(data.round))
	end

	ZProj.UGUIHelper.SetGrayscale(item.simagechaptericon.gameObject, isLock)
	SLFramework.UGUI.GuiHelper.SetColor(item.imagechaptericon, isLock and "#808080" or "#ffffff")
end

function Season123_3_5ResetView:refreshHeroItems()
	if Season123ResetModel.instance.layer == Season123ResetModel.EmptySelect or Season123ResetModel.instance.layer == nil then
		gohelper.setActive(self._goheroexist, false)
		gohelper.setActive(self._goheroempty, true)
	else
		gohelper.setActive(self._goheroexist, true)
		gohelper.setActive(self._goheroempty, false)

		local moList = Season123ResetModel.instance:getHeroList()

		for i = 1, Activity123Enum.PickHeroCount do
			local item = self:getOrCreateHeroItem(i)
			local data = moList[i]

			self:refreshHero(item, data)
			self:refreshHeroHp(item, data)
		end
	end
end

function Season123_3_5ResetView:refreshHero(item, data)
	if not data then
		gohelper.setActive(item.goempty, true)
		gohelper.setActive(item.gohero, false)
	else
		gohelper.setActive(item.goempty, false)
		gohelper.setActive(item.gohero, true)
		item.icon:onUpdateMO(data.heroMO)
	end
end

function Season123_3_5ResetView:refreshHeroHp(item, data)
	if not data then
		gohelper.setActive(item.godead, false)
		gohelper.setActive(item.sliderhp, false)
	else
		gohelper.setActive(item.sliderhp, true)

		local hp100Per = math.floor(data.hpRate / 10)
		local rate = Mathf.Clamp(hp100Per / 100, 0, 1)

		item.sliderhp:SetValue(rate)

		if data.hpRate <= 0 then
			gohelper.setActive(item.godead, true)
		else
			gohelper.setActive(item.godead, false)
		end

		Season123HeroGroupUtils.setHpBar(item.imagehp, rate)
	end
end

function Season123_3_5ResetView:createStageItem()
	local item = self:getUserDataTb_()

	item.godone = gohelper.findChild(self._goareaitem, "#go_done")
	item.goselected = gohelper.findChild(self._goareaitem, "selectframe")
	item.txtname = gohelper.findChildText(self._goareaitem, "#txt_areaname")
	item.simageicon = gohelper.findChildSingleImage(self._goareaitem, "#simage_areaIcon")
	item.btnself = gohelper.findChildButtonWithAudio(self._goareaitem, "#btn_self")
	item.txtnum = gohelper.findChildText(self._goareaitem, "#txt_num")

	item.btnself:AddClickListener(self.onClickStageItem, self)

	self._stageItem = item
end

function Season123_3_5ResetView:getOrCreateEpisodeItem(index)
	local item = self._episodeItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._goepisodeitem, "episode" .. tostring(index))
		item.simagechaptericon = gohelper.findChildSingleImage(item.go, "#simage_chapterIcon")
		item.imagechaptericon = gohelper.findChildImage(item.go, "#simage_chapterIcon")
		item.gounfinish = gohelper.findChild(item.go, "#go_unfinished")
		item.godone = gohelper.findChild(item.go, "#go_done")
		item.txttime = gohelper.findChildText(item.go, "#go_done/#txt_num")
		item.txtchapter = gohelper.findChildText(item.go, "#go_chpt/#txt_chpt")
		item.goselected = gohelper.findChild(item.go, "selectframe")
		item.btnself = gohelper.findChildButtonWithAudio(item.go, "#btn_self")

		item.btnself:AddClickListener(self.onClickEpisodeItem, self, index)

		self._episodeItems[index] = item
	end

	return item
end

function Season123_3_5ResetView:getOrCreateHeroItem(index)
	local item = self._heroItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._goheroitem, "hero" .. tostring(index))
		item.goempty = gohelper.findChild(item.go, "empty")
		item.gohero = gohelper.findChild(item.go, "hero")
		item.godead = gohelper.findChild(item.go, "#dead")
		item.sliderhp = gohelper.findChildSlider(item.go, "#slider_hp")
		item.imagehp = gohelper.findChildImage(item.go, "#slider_hp/Fill Area/Fill")
		item.icon = IconMgr.instance:getCommonHeroIconNew(item.gohero)

		item.icon:isShowRare(false)
		gohelper.setActive(item.go, true)

		self._heroItems[index] = item
	end

	return item
end

function Season123_3_5ResetView:delayInitScrollAudio()
	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._goscrollchapter, Season123_3_5ResetViewAudio, self._scrollchapter)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._goscrollchapter)

	self._drag:AddDragBeginListener(self.onDragAudioBegin, self)
	self._drag:AddDragEndListener(self.onDragAudioEnd, self)

	self._touch = SLFramework.UGUI.UIClickListener.Get(self._goscrollchapter)

	self._touch:AddClickDownListener(self.onClickAudioDown, self)
end

function Season123_3_5ResetView:onDragAudioBegin()
	self._audioScroll:onDragBegin()
end

function Season123_3_5ResetView:onDragAudioEnd()
	self._audioScroll:onDragEnd()
end

function Season123_3_5ResetView:onClickAudioDown()
	self._audioScroll:onClickDown()
end

function Season123_3_5ResetView:onClickStageItem()
	logNormal("onClickStageItem")

	if Season123ResetController.instance:selectLayer(nil) then
		AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_activity_reward_ending)
	end
end

function Season123_3_5ResetView:onClickEpisodeItem(index)
	logNormal("onClickEpisodeItem : " .. tostring(index))

	if Season123ResetController.instance:selectLayer(index) then
		AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_activity_reward_ending)
	end
end

function Season123_3_5ResetView:_btnresetOnClick()
	Season123ResetController.instance:tryReset()
end

return Season123_3_5ResetView
