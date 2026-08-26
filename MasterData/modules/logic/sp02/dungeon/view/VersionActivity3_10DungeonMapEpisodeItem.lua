-- chunkname: @modules/logic/sp02/dungeon/view/VersionActivity3_10DungeonMapEpisodeItem.lua

module("modules.logic.sp02.dungeon.view.VersionActivity3_10DungeonMapEpisodeItem", package.seeall)

local VersionActivity3_10DungeonMapEpisodeItem = class("VersionActivity3_10DungeonMapEpisodeItem", VersionActivityFixedDungeonMapEpisodeItem)

function VersionActivity3_10DungeonMapEpisodeItem:onInitView()
	self.goScale = gohelper.findChild(self.viewGO, "#go_scale")
	self.goSection = gohelper.findChild(self.goScale, "section")
	self.goBgIcon1 = gohelper.findChild(self.goSection, "#go_bgicon1")
	self.goSelect1 = gohelper.findChild(self.goBgIcon1, "#go_select")
	self.goBgIcon2 = gohelper.findChild(self.goSection, "#go_bgicon2")
	self.goSelect2 = gohelper.findChild(self.goBgIcon2, "#go_select")
	self.txtSection = gohelper.findChildText(self.goSection, "#txt_section")
	self.txtSection2 = gohelper.findChildText(self.goSection, "#txt_section2")

	gohelper.setActive(self.txtSection2, true)

	self.txtSectionName = gohelper.findChildText(self.goScale, "#txt_sectionname")
	self.goProgress = gohelper.findChild(self.goScale, "#go_progress")
	self.goProgressItem = gohelper.findChild(self.goScale, "#go_progress/#go_progressitem")
	self.videoAnim = gohelper.findChildAnim(self.goScale, "section/#go_videomask/ani")
	self.simageVideo = gohelper.findChildSingleImage(self.goScale, "section/#go_videomask/ani/#go_video")
	self.goClickArea = gohelper.findChild(self.viewGO, "#go_clickarea")
	self._txtnameen = gohelper.findChildText(self.viewGO, "#go_scale/#txt_nameen")
	self._gotipcontent = gohelper.findChild(self.viewGO, "#go_scale/#go_tipcontent")
	self._gotipitem = gohelper.findChild(self.viewGO, "#go_scale/#go_tipcontent/#go_tipitem")

	gohelper.setActive(self._gotipitem, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_10DungeonMapEpisodeItem:_editableInitView()
	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.goClick = gohelper.getClick(self.goClickArea)

	self.goClick:AddClickListener(self.onClick, self)

	self._maxWidth = 400
	self.elementItemList = {}
end

function VersionActivity3_10DungeonMapEpisodeItem:addEvents()
	VersionActivity3_10DungeonMapEpisodeItem.super.addEvents(self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
end

function VersionActivity3_10DungeonMapEpisodeItem:removeEvents()
	VersionActivity3_10DungeonMapEpisodeItem.super.removeEvents(self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
end

function VersionActivity3_10DungeonMapEpisodeItem:refresh(config, dungeonMo)
	self._config = config
	self._dungeonMo = dungeonMo
	self._levelIndex = DungeonConfig.instance:getEpisodeLevelIndex(self._config)
	self.pass = DungeonModel.instance:hasPassLevelAndStory(self._config.id)
	self._map = lua_chapter_map.configDict[38510101]

	self:refreshUI()
	self:playAnimation("selected")

	self.isSelected = false
end

function VersionActivity3_10DungeonMapEpisodeItem:refreshUI()
	self.txtSection.text = string.format("%02d", self._levelIndex - 1)
	self.txtSection2.text = ""
	self.txtSectionName.text = self._config.name
	self._txtnameen.text = self._config.name_En

	self:refreshStar()
	self:refreshEpisodeVideo()
	self:_showAllElementTipView()

	local isHard = self.activityDungeonMo:isHardMode()

	gohelper.setActive(self.goBgIcon1, not isHard)
	gohelper.setActive(self.goBgIcon2, isHard)
end

function VersionActivity3_10DungeonMapEpisodeItem:onClick()
	AudioMgr.instance:trigger(AudioEnum3_10.Dungeon.play_ui_langchao_tv_click)

	if self.isLock then
		ViewMgr.instance:openView(ViewName.DungeonMapTaskView, {
			viewParam = self._config.preEpisode
		})

		return
	end

	local mapLevelViewName = ViewName.VersionActivity3_10DungeonMapLevelView
	local viewContainer = ViewMgr.instance:getContainer(mapLevelViewName)

	if viewContainer then
		viewContainer:stopCloseViewTask()

		if viewContainer:getOpenedEpisodeId() == self._config.id then
			ViewMgr.instance:closeView(mapLevelViewName)

			return
		end
	end

	self.activityDungeonMo:changeEpisode(self:getEpisodeId())
	self._layout:setSelectEpisodeItem(self)
	ViewMgr.instance:openView(mapLevelViewName, {
		episodeId = self._config.id
	})
	VersionActivity3_10DungeonController.instance:dispatchEvent(VersionActivity3_10Event.OnSelectEpisodeItem, self._levelIndex, true)
end

function VersionActivity3_10DungeonMapEpisodeItem:_onCloseView()
	local isTop = ViewHelper.instance:checkViewOnTheTop(ViewName.VersionActivity3_10DungeonMapView)

	if not isTop then
		return
	end

	self:refreshEpisodeVideo()
end

function VersionActivity3_10DungeonMapEpisodeItem:refreshStar()
	local progressList = {}

	if self.activityDungeonMo:isHardMode() then
		local episodeId = self._config.id
		local curMode = VersionActivity3_10DungeonHelper.getEpisodeMode(episodeId)
		local progress = VersionActivity3_10DungeonHelper.calcEpisodeProgress(episodeId)

		table.insert(progressList, {
			mode = curMode,
			progress = progress
		})
	else
		local episodeList = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(self._config)

		for i, episodeCo in ipairs(episodeList) do
			local episodeId = episodeCo.id
			local curMode = VersionActivity3_10DungeonHelper.getEpisodeMode(episodeId)
			local progress = VersionActivity3_10DungeonHelper.calcEpisodeProgress(episodeId)

			table.insert(progressList, {
				mode = curMode,
				progress = progress
			})
		end
	end

	gohelper.CreateObjList(self, self.refreshEpisodeSingleProgress, progressList, self.goProgress, self.goProgressItem, nil, nil, nil, 1)
end

function VersionActivity3_10DungeonMapEpisodeItem:refreshEpisodeSingleProgress(obj, data, index)
	local curMode = data.mode
	local progress = data.progress

	if curMode > VersionActivityDungeonBaseEnum.DungeonMode.Story3 then
		curMode = VersionActivityDungeonBaseEnum.DungeonMode.Story3
	end

	for i = 1, 3 do
		local goicon = gohelper.findChild(obj, "image_icon" .. i)

		if not gohelper.isNil(goicon) then
			gohelper.setActive(goicon, curMode == i)

			if curMode == i then
				local imgSlider = gohelper.findChildImage(goicon, "#image_fg")

				imgSlider.fillAmount = progress
			end
		end
	end
end

function VersionActivity3_10DungeonMapEpisodeItem:updateSelectStatus(selectedItem, ignoreAni)
	if not selectedItem then
		self.isSelected = false

		return
	end

	self.isSelected = selectedItem._config.id == self._config.id
end

function VersionActivity3_10DungeonMapEpisodeItem:refreshEpisodeVideo()
	local animConfig = AtomicConfig.instance:getEpisodeAnimConfig(self._config.id)

	if not animConfig then
		return
	end

	self.simageVideo:LoadImage(string.format("singlebg/sp02_dungeonmap/chapter_pic/%s.png", animConfig.res))

	local isHard = self.activityDungeonMo:isHardMode()

	if isHard then
		self.videoAnim:Play("video_idle")

		return
	end

	TaskDispatcher.cancelTask(self.playVideoAnim, self)

	local isUnlock = VersionActivity3_10DungeonController.instance:isHasUnlockEpisode(self._config.id)

	if isUnlock then
		if not VersionActivity3_10DungeonController.instance:isHasUnlockAnimEpisode(self._config.id) then
			self.videoAnim:Play("unlock_idle")
			TaskDispatcher.runDelay(self.playVideoAnim, self, 1)
		else
			self.videoAnim:Play("video_idle")
		end
	else
		self.videoAnim:Play("unlock_idle")
	end
end

function VersionActivity3_10DungeonMapEpisodeItem:playVideoAnim()
	VersionActivity3_10DungeonController.instance:setHasUnlockAnimEpisode(self._config.id)
	self.videoAnim:Play("video", 0, 0)
	AudioMgr.instance:trigger(AudioEnum3_10.Dungeon.play_ui_langchao_tv_unlock)
end

function VersionActivity3_10DungeonMapEpisodeItem:getMapAllElementListWithFinish()
	local finishElementCoList, mapAllElementList = VersionActivityFixedDungeonModel.instance:getElementCoListWithFinish(self._map.id, self._config.id)

	return finishElementCoList, mapAllElementList
end

function VersionActivity3_10DungeonMapEpisodeItem:onDestroyView()
	VersionActivity3_10DungeonMapEpisodeItem.super.onDestroyView(self)
	TaskDispatcher.cancelTask(self.playVideoAnim, self)

	if self.simageVideo then
		self.simageVideo:UnLoadImage()
	end
end

return VersionActivity3_10DungeonMapEpisodeItem
