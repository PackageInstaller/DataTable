-- chunkname: @modules/versionactivitybase/dungeon/model/VersionActivityDungeonBaseMo.lua

module("modules.versionactivitybase.dungeon.model.VersionActivityDungeonBaseMo", package.seeall)

local VersionActivityDungeonBaseMo = pureTable("VersionActivityDungeonBaseMo")

function VersionActivityDungeonBaseMo:ctor()
	self.actId = nil
	self.chapterId = nil
	self.episodeId = nil
	self.mode = nil
	self.activityDungeonConfig = nil
	self.unlockHardModeEpisodeId = nil
	self.layoutClass = nil
	self.episodeItemCls = nil
	self.layoutPrefabUrl = nil
	self.layoutOffsetY = nil
end

function VersionActivityDungeonBaseMo:init(actId, chapterId, episodeId)
	self.actId = actId
	self.activityDungeonConfig = ActivityConfig.instance:getActivityDungeonConfig(actId)
	self.unlockHardModeEpisodeId = self:getUnlockActivityHardDungeonEpisodeId()

	if not chapterId and not episodeId then
		self.chapterId = self.activityDungeonConfig.story1ChapterId
	elseif episodeId then
		local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

		self.chapterId = episodeCo.chapterId
	else
		self.chapterId = chapterId
	end

	if self.chapterId == self.activityDungeonConfig.story2ChapterId or self.chapterId == self.activityDungeonConfig.story3ChapterId then
		self.chapterId = self.activityDungeonConfig.story1ChapterId
	end

	self:updateMode()
	self:updateEpisodeId(episodeId)
end

function VersionActivityDungeonBaseMo:update(chapterId, episodeId)
	self:init(self.actId, chapterId, episodeId)
end

function VersionActivityDungeonBaseMo:getUnlockActivityHardDungeonEpisodeId()
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(self.activityDungeonConfig.hardChapterId)

	return episodeList and #episodeList > 0 and episodeList[1].preEpisode
end

function VersionActivityDungeonBaseMo:updateMode()
	if self.chapterId == self.activityDungeonConfig.story1ChapterId then
		self.mode = VersionActivityDungeonBaseEnum.DungeonMode.Story
	elseif self.chapterId == self.activityDungeonConfig.story2ChapterId then
		self.mode = VersionActivityDungeonBaseEnum.DungeonMode.Story2
	elseif self.chapterId == self.activityDungeonConfig.story3ChapterId then
		self.mode = VersionActivityDungeonBaseEnum.DungeonMode.Story3
	elseif self.chapterId == self.activityDungeonConfig.hardChapterId then
		self.mode = VersionActivityDungeonBaseEnum.DungeonMode.Hard
	end
end

function VersionActivityDungeonBaseMo:updateEpisodeId(episodeId)
	if episodeId then
		self.episodeId = episodeId

		local episodeCo = DungeonConfig.instance:getEpisodeCO(self.episodeId)

		if episodeCo.chapterId == self.activityDungeonConfig.story2ChapterId or episodeCo.chapterId == self.activityDungeonConfig.story3ChapterId then
			while episodeCo.chapterId ~= self.activityDungeonConfig.story1ChapterId do
				episodeCo = DungeonConfig.instance:getEpisodeCO(episodeCo.preEpisode)
			end
		end

		self.episodeId = episodeCo.id

		return
	end

	if DungeonModel.instance:hasPassAllChapterEpisode(self.chapterId) then
		self.episodeId = VersionActivityDungeonBaseController.instance:getChapterLastSelectEpisode(self.chapterId)
	else
		local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(self.chapterId)
		local dungeonMo

		for _, config in ipairs(episodeList) do
			if config and DungeonModel.instance:getEpisodeInfo(config.id) or nil then
				self.episodeId = config.id
			end
		end
	end
end

function VersionActivityDungeonBaseMo:changeMode(mode)
	self.mode = mode
	self.chapterId = self.activityDungeonConfig[VersionActivityDungeonBaseEnum.DungeonMode2ChapterIdKey[self.mode]]

	self:updateEpisodeId()
	VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnModeChange)
end

function VersionActivityDungeonBaseMo:changeEpisode(episodeId)
	self:updateEpisodeId(episodeId)
	VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnActivityDungeonMoChange)
end

function VersionActivityDungeonBaseMo:isHardMode()
	return self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard
end

function VersionActivityDungeonBaseMo:setLayoutClass(cls)
	self.layoutClass = cls
end

function VersionActivityDungeonBaseMo:getLayoutClass()
	return self.layoutClass or VersionActivityDungeonBaseChapterLayout
end

function VersionActivityDungeonBaseMo:setMapEpisodeItemClass(cls)
	self.episodeItemCls = cls
end

function VersionActivityDungeonBaseMo:getEpisodeItemClass()
	return self.episodeItemCls or VersionActivityDungeonBaseEpisodeItem
end

function VersionActivityDungeonBaseMo:setLayoutPrefabUrl(url)
	self.layoutPrefabUrl = url
end

function VersionActivityDungeonBaseMo:getLayoutPrefabUrl()
	return self.layoutPrefabUrl or "ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab"
end

function VersionActivityDungeonBaseMo:setLayoutOffsetY(offsetY)
	self.layoutOffsetY = offsetY
end

function VersionActivityDungeonBaseMo:getLayoutOffsetY()
	return self.layoutOffsetY or 100
end

return VersionActivityDungeonBaseMo
