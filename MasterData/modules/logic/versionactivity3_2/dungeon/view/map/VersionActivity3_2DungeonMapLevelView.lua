-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/map/VersionActivity3_2DungeonMapLevelView.lua

module("modules.logic.versionactivity3_2.dungeon.view.map.VersionActivity3_2DungeonMapLevelView", package.seeall)

local VersionActivity3_2DungeonMapLevelView = class("VersionActivity3_2DungeonMapLevelView", VersionActivityFixedDungeonMapLevelView)

function VersionActivity3_2DungeonMapLevelView:onInitView()
	VersionActivity3_2DungeonMapLevelView.super.onInitView(self)

	self._txtactivitydesc = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/bg/mask/#txt_activitydesc")
	self._goMask = gohelper.findChild(self.viewGO, "anim/versionactivity/right/bg/mask")
	self._verticalLayoutGroup = self._goMask:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))
	self._goTitle = gohelper.findChild(self.viewGO, "anim/versionactivity/right/title")
	self._txtTime = gohelper.findChildText(self.viewGO, "anim/versionactivity/#go_tips/#txt_time")
	self._txtPlace = gohelper.findChildText(self.viewGO, "anim/versionactivity/#go_tips/#txt_place")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/#btn_left")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/#btn_right")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")
end

function VersionActivity3_2DungeonMapLevelView:addEvents()
	VersionActivity3_2DungeonMapLevelView.super.addEvents(self)
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function VersionActivity3_2DungeonMapLevelView:removeEvents()
	VersionActivity3_2DungeonMapLevelView.super.removeEvents(self)
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function VersionActivity3_2DungeonMapLevelView:_btnleftOnClick()
	local index = self:_getEposdeIndex()

	if index then
		local list = self:_getEpisodeList()
		local config = list[index - 1]

		if config then
			VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivity3_2DungeonEvent.V3a2ClickEpisodeItem, config.id)
		end
	end
end

function VersionActivity3_2DungeonMapLevelView:_btnrightOnClick()
	local index = self:_getEposdeIndex()

	if index then
		local list = self:_getEpisodeList()
		local config = list[index + 1]

		if config then
			VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivity3_2DungeonEvent.V3a2ClickEpisodeItem, config.id)
		end
	end
end

function VersionActivity3_2DungeonMapLevelView:_btncloseOnClick()
	self:closeThis()
end

function VersionActivity3_2DungeonMapLevelView:_updateNavBtns()
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self.originEpisodeId)

	if episodeConfig and episodeConfig.type == DungeonEnum.EpisodeType.V3_2SP then
		gohelper.setActive(self._btnleft, false)
		gohelper.setActive(self._btnright, false)

		return
	end

	local index, maxIndex = self:_getEposdeIndex()

	if not index or not maxIndex then
		gohelper.setActive(self._btnleft, false)
		gohelper.setActive(self._btnright, false)

		return
	end

	gohelper.setActive(self._btnleft, index > 1)
	gohelper.setActive(self._btnright, index < maxIndex)
end

function VersionActivity3_2DungeonMapLevelView:_getEposdeIndex()
	local storyEpisodeConfig = VersionActivityFixedDungeonConfig.instance:getStoryEpisodeCo(self.originEpisodeId)
	local list = self:_getEpisodeList()
	local index, maxIndex

	for i, v in ipairs(list) do
		if not DungeonModel.instance:isFinishElementList(v) then
			break
		end

		if v.id == ((self.originEpisodeConfig.chapterId == VersionActivity3_2DungeonEnum.DungeonChapterId.Hard or nil) and self.originEpisodeId) then
			index = i
		end

		if DungeonModel.instance:getEpisodeInfo(v.id) then
			maxIndex = i
		end
	end

	return index, maxIndex
end

function VersionActivity3_2DungeonMapLevelView:_getEpisodeList()
	if self._episodeList then
		return self._episodeList
	end

	if self.originEpisodeConfig.chapterId == VersionActivity3_2DungeonEnum.DungeonChapterId.Hard then
		local list = {}
		local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(self.originEpisodeConfig.chapterId)

		for i, v in ipairs(episodeList) do
			if v.type ~= DungeonEnum.EpisodeType.V3_2SP then
				table.insert(list, v)
			end
		end

		self._episodeList = list

		return list
	end

	local episodeId = self.originEpisodeConfig.id
	local storyEpisodeConfig = VersionActivityFixedDungeonConfig.instance:getStoryEpisodeCo(episodeId)

	if not storyEpisodeConfig then
		logError("VersionActivity3_2DungeonMapLevelView:_getEpisodeList storyEpisodeConfig is nil")

		return {}
	end

	local list = {}
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(storyEpisodeConfig.chapterId)

	for i, v in ipairs(episodeList) do
		if v.type ~= DungeonEnum.EpisodeType.V3_2SP then
			table.insert(list, v)
		end
	end

	self._episodeList = list

	return list
end

function VersionActivity3_2DungeonMapLevelView:onOpen()
	VersionActivity3_2DungeonMapLevelView.super.onOpen(self)
	self:_updateMapInfo(self.originEpisodeId)
	self:_updateNavBtns()
end

function VersionActivity3_2DungeonMapLevelView:initViewParam()
	VersionActivity3_2DungeonMapLevelView.super.initViewParam(self)

	self.index = VersionActivityFixedDungeonConfig.instance:getEpisodeIndex(self.originEpisodeId, DungeonEnum.EpisodeType.V3_2SP)
end

function VersionActivity3_2DungeonMapLevelView:_updateMapInfo(episodeId)
	local storyEpisodeConfig = VersionActivityFixedDungeonConfig.instance:getStoryEpisodeCo(episodeId)

	if storyEpisodeConfig then
		episodeId = storyEpisodeConfig.id
	end

	local mapCfg = VersionActivityFixedDungeonConfig.instance:getEpisodeMapConfig(episodeId)

	self._txtTime.text = mapCfg.desc

	local extraConfig = lua_v3a2_chapter_map.configDict[episodeId]

	if extraConfig then
		self._txtPlace.text = extraConfig.locationDesc

		local titleRotation = extraConfig.titleRotation
		local titlePos = extraConfig.titlePos
		local descRotation = extraConfig.descRotation
		local descPos = extraConfig.descPos

		transformhelper.setLocalPos(self._goTitle.transform, titlePos[1], titlePos[2], titlePos[3])
		transformhelper.setLocalRotation(self._goTitle.transform, titleRotation[1], titleRotation[2], titleRotation[3])
		transformhelper.setLocalRotation(self._goMask.transform, descRotation[1], descRotation[2], descRotation[3])
		transformhelper.setLocalPos(self._goMask.transform, descPos[1], descPos[2], descPos[3])

		local descOffset = extraConfig.descOffset

		if descOffset then
			self._verticalLayoutGroup.padding.left = descOffset
		end
	end
end

return VersionActivity3_2DungeonMapLevelView
