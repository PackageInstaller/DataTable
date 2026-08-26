-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9DungeonMapEpisodeItem.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapEpisodeItem", package.seeall)

local VersionActivity2_9DungeonMapEpisodeItem = class("VersionActivity2_9DungeonMapEpisodeItem", VersionActivityFixedDungeonMapEpisodeItem)

function VersionActivity2_9DungeonMapEpisodeItem:onInitView()
	VersionActivity2_9DungeonMapEpisodeItem.super.onInitView(self)

	self._goselect1 = gohelper.findChild(self.viewGO, "#go_scale/section/#go_bgicon1/#go_select")
	self._gounselect1 = gohelper.findChild(self.viewGO, "#go_scale/section/#go_bgicon1/#go_unselect")
	self._goselect2 = gohelper.findChild(self.viewGO, "#go_scale/section/#go_bgicon2/#go_select")
	self._gounselect2 = gohelper.findChild(self.viewGO, "#go_scale/section/#go_bgicon2/#go_unselect")
	self._goprogress = gohelper.findChild(self.viewGO, "#go_scale/#go_progress")
	self._goprogressitem = gohelper.findChild(self.viewGO, "#go_scale/#go_progress/#go_progressitem")
	self._txtsection2 = gohelper.findChildText(self.viewGO, "#go_scale/section/mask/#txt_section")
	self._godnaclickarea = gohelper.findChild(self.viewGO, "#go_dnaclickarea")
end

function VersionActivity2_9DungeonMapEpisodeItem:refreshUI()
	VersionActivity2_9DungeonMapEpisodeItem.super.refreshUI(self)

	self._txtsection2.text = self._txtsection.text
end

function VersionActivity2_9DungeonMapEpisodeItem:refreshFocusStatus()
	VersionActivity2_9DungeonMapEpisodeItem.super.refreshFocusStatus(self)

	local isSelect = self._config.id == self.activityDungeonMo.episodeId

	gohelper.setActive(self._goselect1, isSelect)
	gohelper.setActive(self._gounselect1, not isSelect)
	gohelper.setActive(self._goselect2, isSelect)
	gohelper.setActive(self._gounselect2, not isSelect)
end

function VersionActivity2_9DungeonMapEpisodeItem:onClick()
	if self.isLock then
		ViewMgr.instance:openView(ViewName.DungeonMapTaskView, {
			viewParam = self._config.preEpisode
		})

		return
	end

	local mapLevelViewName = ViewName.VersionActivity2_9DungeonMapLevelView
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
	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnSelectEpisodeItem, self._levelIndex, true)
end

function VersionActivity2_9DungeonMapEpisodeItem:refreshStar()
	local episodeList = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(self._config)

	gohelper.CreateObjList(self, self.refreshEpisodeSingleProgress, episodeList, self._goprogress, self._goprogressitem)
end

function VersionActivity2_9DungeonMapEpisodeItem:refreshEpisodeSingleProgress(obj, episodeCo, index)
	local sliderprogress = gohelper.findChildSlider(obj, "slider_progress")
	local imagebg = gohelper.findChildImage(obj, "slider_progress/Fill Area/Fill")
	local txtprogress = gohelper.findChildText(obj, "txt_progress")
	local episodeId = episodeCo.id

	VersionActivity2_9DungeonHelper.setEpisodeProgressBg(episodeId, imagebg)

	local progress = VersionActivity2_9DungeonHelper.calcEpisodeProgress(episodeId)

	txtprogress.text = VersionActivity2_9DungeonHelper.formatEpisodeProgress(progress)

	sliderprogress:SetValue(progress)
	self:refreshModeIcon(episodeId, obj)
end

function VersionActivity2_9DungeonMapEpisodeItem:refreshModeIcon(episodeId, obj)
	local curMode = VersionActivity2_9DungeonHelper.getEpisodeMode(episodeId)

	for _, episodeMode in pairs(VersionActivityDungeonBaseEnum.DungeonMode) do
		local goicon = gohelper.findChild(obj, "image_icon" .. episodeMode)

		if not gohelper.isNil(goicon) then
			gohelper.setActive(goicon, curMode == episodeMode)
		end
	end
end

function VersionActivity2_9DungeonMapEpisodeItem:isScreenPosInDNAClickArea(screenPosition)
	if not screenPosition then
		return
	end

	return recthelper.screenPosInRect(self._godnaclickarea.transform, nil, screenPosition.x, screenPosition.y)
end

return VersionActivity2_9DungeonMapEpisodeItem
