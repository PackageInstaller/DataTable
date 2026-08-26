-- chunkname: @modules/versionactivitybase/fixed1/dungeon/view/map/VersionActivityFixedDungeonMapLevelView1.lua

module("modules.versionactivitybase.fixed1.dungeon.view.map.VersionActivityFixedDungeonMapLevelView1", package.seeall)

local VersionActivityFixedDungeonMapLevelView1 = class("VersionActivityFixedDungeonMapLevelView1", VersionActivityFixedDungeonMapLevelView)

function VersionActivityFixedDungeonMapLevelView1:onInitView()
	VersionActivityFixedDungeonMapLevelView1.super.onInitView(self)

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

function VersionActivityFixedDungeonMapLevelView1:addEvents()
	VersionActivityFixedDungeonMapLevelView1.super.addEvents(self)
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function VersionActivityFixedDungeonMapLevelView1:removeEvents()
	VersionActivityFixedDungeonMapLevelView1.super.removeEvents(self)
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function VersionActivityFixedDungeonMapLevelView1:_btnleftOnClick()
	local index = self:_getEposdeIndex()

	if index then
		local list = self:_getEpisodeList()
		local config = list[index - 1]

		if config then
			VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent1.ClickEpisodeItem, config.id)
		end
	end
end

function VersionActivityFixedDungeonMapLevelView1:_btnrightOnClick()
	local index = self:_getEposdeIndex()

	if index then
		local list = self:_getEpisodeList()
		local config = list[index + 1]

		if config then
			VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent1.ClickEpisodeItem, config.id)
		end
	end
end

function VersionActivityFixedDungeonMapLevelView1:_btncloseOnClick()
	self:closeThis()
end

function VersionActivityFixedDungeonMapLevelView1:_updateNavBtns()
	local index, maxIndex = self:_getEposdeIndex()

	if not index or not maxIndex then
		gohelper.setActive(self._btnleft, false)
		gohelper.setActive(self._btnright, false)

		return
	end

	gohelper.setActive(self._btnleft, index > 1)
	gohelper.setActive(self._btnright, index < maxIndex)
end

function VersionActivityFixedDungeonMapLevelView1:_getEposdeIndex()
	local storyEpisodeConfig = VersionActivityFixedDungeonConfig.instance:getStoryEpisodeCo(self.originEpisodeId)
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local dungeonEnum = VersionActivityFixedHelper.getVersionActivityDungeonEnum(bigVersion, smallVersion)
	local list = self:_getEpisodeList()
	local index, maxIndex

	for i, v in ipairs(list) do
		if not DungeonModel.instance:isFinishElementList(v) then
			break
		end

		if v.id == ((self.originEpisodeConfig.chapterId == dungeonEnum.DungeonChapterId.Hard or nil) and self.originEpisodeId) then
			index = i
		end

		if DungeonModel.instance:getEpisodeInfo(v.id) then
			maxIndex = i
		end
	end

	return index, maxIndex
end

function VersionActivityFixedDungeonMapLevelView1:_getEpisodeList()
	if self._episodeList then
		return self._episodeList
	end

	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local dungeonEnum = VersionActivityFixedHelper.getVersionActivityDungeonEnum(bigVersion, smallVersion)

	if self.originEpisodeConfig.chapterId == dungeonEnum.DungeonChapterId.Hard then
		local list = {}
		local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(self.originEpisodeConfig.chapterId)

		for i, v in ipairs(episodeList) do
			table.insert(list, v)
		end

		self._episodeList = list

		return episodeList
	end

	local episodeId = self.originEpisodeConfig.id
	local storyEpisodeConfig = VersionActivityFixedDungeonConfig.instance:getStoryEpisodeCo(episodeId)

	if not storyEpisodeConfig then
		logError("VersionActivityFixedDungeonMapLevelView1:_getEpisodeList storyEpisodeConfig is nil")

		return {}
	end

	local list = {}
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(storyEpisodeConfig.chapterId)

	for i, v in ipairs(episodeList) do
		table.insert(list, v)
	end

	self._episodeList = list

	return list
end

function VersionActivityFixedDungeonMapLevelView1:onOpen()
	VersionActivityFixedDungeonMapLevelView1.super.onOpen(self)
	self:_updateMapInfo(self.originEpisodeId)
	self:_updateNavBtns()
end

function VersionActivityFixedDungeonMapLevelView1:initViewParam()
	VersionActivityFixedDungeonMapLevelView1.super.initViewParam(self)

	self.index = VersionActivityFixedDungeonConfig.instance:getEpisodeIndex(self.originEpisodeId)
end

function VersionActivityFixedDungeonMapLevelView1:_updateMapInfo(episodeId)
	local storyEpisodeConfig = VersionActivityFixedDungeonConfig.instance:getStoryEpisodeCo(episodeId)

	if storyEpisodeConfig then
		episodeId = storyEpisodeConfig.id
	end

	local mapCfg = VersionActivityFixedDungeonConfig.instance:getEpisodeMapConfig(episodeId)

	self._txtTime.text = mapCfg.desc

	local extraConfig = VersionActivityFixedDungeonConfig1.instance:getChapterMap(episodeId)

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

function VersionActivityFixedDungeonMapLevelView1:onStoryFinished()
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(self.showEpisodeCo.id)
	self:closeThis()

	if not self:_isOpenPuzzleView() then
		DungeonRpc.instance:sendEndDungeonRequest(false)
	end
end

function VersionActivityFixedDungeonMapLevelView1:onReplayStoryFinished()
	self:_isOpenPuzzleView(true)
end

return VersionActivityFixedDungeonMapLevelView1
