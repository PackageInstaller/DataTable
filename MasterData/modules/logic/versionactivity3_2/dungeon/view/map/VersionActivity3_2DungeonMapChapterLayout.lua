-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/map/VersionActivity3_2DungeonMapChapterLayout.lua

module("modules.logic.versionactivity3_2.dungeon.view.map.VersionActivity3_2DungeonMapChapterLayout", package.seeall)

local VersionActivity3_2DungeonMapChapterLayout = class("VersionActivity3_2DungeonMapChapterLayout", VersionActivityFixedDungeonMapChapterLayout)

function VersionActivity3_2DungeonMapChapterLayout:_editableInitView()
	VersionActivity3_2DungeonMapChapterLayout.super._editableInitView(self)

	self._episodeSPContainerItemList = self:getUserDataTb_()
	self.episodeItemSpPath = self.viewContainer:getSetting().otherRes.spItem
end

function VersionActivity3_2DungeonMapChapterLayout:refreshEpisodeNodes()
	self._episodeItemDict = self:getUserDataTb_()

	local containerIndexList = {}
	local spIndex = 0
	local index = 0
	local dungeonMo, episodeContainerItem
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(self.activityDungeonMo.chapterId)

	for _, config in ipairs(episodeList) do
		dungeonMo = config and DungeonModel.instance:getEpisodeInfo(config.id) or nil

		if dungeonMo then
			if config.type ~= DungeonEnum.EpisodeType.V3_2SP then
				index = index + 1
				episodeContainerItem = self:getEpisodeContainerItem(index)
				self._episodeItemDict[config.id] = episodeContainerItem.episodeItem
				episodeContainerItem.containerTr.name = config.id

				episodeContainerItem.episodeItem:refresh(config, dungeonMo)
				self:_setEpisodeItemAnchorX(index, episodeContainerItem)

				containerIndexList[config.id] = index
			else
				local preEpisode = config.preEpisode

				spIndex = spIndex + 1
				episodeContainerItem = self:getSPEpisodeContainerItem(spIndex)
				self._episodeItemDict[config.id] = episodeContainerItem.episodeItem
				episodeContainerItem.containerTr.name = config.id

				episodeContainerItem.episodeItem:refresh(config, dungeonMo)

				local preContainerIndex = containerIndexList[preEpisode]
				local preEpisodeContainerItem = self._episodeContainerItemList[preContainerIndex]
				local prePosX = recthelper.getAnchorX(preEpisodeContainerItem.containerTr) or 0

				recthelper.setAnchorX(episodeContainerItem.containerTr, prePosX + 300)
			end
		end
	end

	local lastContainerItem = self._episodeContainerItemList[index]
	local pos = recthelper.rectToRelativeAnchorPos(lastContainerItem.containerTr.position, self.rectTransform)
	local width = pos.x + self._offsetX

	recthelper.setSize(self.contentTransform, width, self._rawHeight)

	self._contentWidth = width

	for i = index + 1, #self._episodeContainerItemList do
		gohelper.setActive(self._episodeContainerItemList[i].containerTr.gameObject, false)
	end

	for i = spIndex + 1, #self._episodeSPContainerItemList do
		gohelper.setActive(self._episodeSPContainerItemList[i].containerTr.gameObject, false)
	end

	self:setFocusEpisodeId(self.activityDungeonMo.episodeId, false)
end

function VersionActivity3_2DungeonMapChapterLayout:getEpisodeContainerItem(index)
	local episodeContainerItem = self._episodeContainerItemList[index]

	if episodeContainerItem then
		gohelper.setActive(episodeContainerItem.containerTr.gameObject, true)
		episodeContainerItem.episodeItem:clearElementIdList()

		return episodeContainerItem
	end

	episodeContainerItem = self:getUserDataTb_()

	local go = gohelper.cloneInPlace(self._gotemplatenormal, tostring(index))

	gohelper.setActive(go, true)

	episodeContainerItem.containerTr = go.transform

	recthelper.setAnchorY(episodeContainerItem.containerTr, self._constDungeonNormalPosY)

	local episodeItemViewGo = self.viewContainer:getResInst(self.episodeItemPath, go)
	local episodeItem = self.activityDungeonMo:getEpisodeItemClass().New()

	episodeItem.viewContainer = self.viewContainer
	episodeItem.activityDungeonMo = self.activityDungeonMo

	episodeItem:initView(episodeItemViewGo, {
		self.contentTransform,
		self
	})

	episodeContainerItem.episodeItem = episodeItem

	table.insert(self._episodeContainerItemList, episodeContainerItem)

	return episodeContainerItem
end

function VersionActivity3_2DungeonMapChapterLayout:getSPEpisodeContainerItem(index)
	local episodeContainerItem = self._episodeSPContainerItemList[index]

	if episodeContainerItem then
		gohelper.setActive(episodeContainerItem.containerTr.gameObject, true)
		episodeContainerItem.episodeItem:clearElementIdList()

		return episodeContainerItem
	end

	episodeContainerItem = self:getUserDataTb_()

	local go = gohelper.cloneInPlace(self._gotemplatenormal, tostring(index))

	gohelper.setActive(go, true)

	episodeContainerItem.containerTr = go.transform

	recthelper.setAnchorY(episodeContainerItem.containerTr, -600)

	local episodeItemViewGo = self.viewContainer:getResInst(self.episodeItemSpPath, go)
	local episodeItem = self.activityDungeonMo:getEpisodeItemClass().New()

	episodeItem.viewContainer = self.viewContainer
	episodeItem.activityDungeonMo = self.activityDungeonMo

	episodeItem:initView(episodeItemViewGo, {
		self.contentTransform,
		self
	})

	episodeContainerItem.episodeItem = episodeItem

	table.insert(self._episodeSPContainerItemList, episodeContainerItem)

	return episodeContainerItem
end

function VersionActivity3_2DungeonMapChapterLayout:onClose()
	VersionActivity3_2DungeonMapChapterLayout.super.onClose(self)

	for i, v in pairs(self._episodeSPContainerItemList) do
		v.episodeItem:destroyView()
	end
end

return VersionActivity3_2DungeonMapChapterLayout
