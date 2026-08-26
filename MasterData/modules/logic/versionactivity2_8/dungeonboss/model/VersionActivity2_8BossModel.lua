-- chunkname: @modules/logic/versionactivity2_8/dungeonboss/model/VersionActivity2_8BossModel.lua

module("modules.logic.versionactivity2_8.dungeonboss.model.VersionActivity2_8BossModel", package.seeall)

local VersionActivity2_8BossModel = class("VersionActivity2_8BossModel", BaseModel)

function VersionActivity2_8BossModel:onInit()
	self:reInit()
end

function VersionActivity2_8BossModel:reInit()
	self._isFocusElement = false
	self._bossStoryFightEpisodeId = nil
end

function VersionActivity2_8BossModel:setFocusElement(value)
	self._isFocusElement = value
end

function VersionActivity2_8BossModel:isFocusElement()
	return self._isFocusElement
end

function VersionActivity2_8BossModel:enterBossStoryFight(episodeId)
	self._bossStoryFightEpisodeId = episodeId
end

function VersionActivity2_8BossModel:getBossStoryFightEpisodeId()
	return self._bossStoryFightEpisodeId
end

function VersionActivity2_8BossModel:getStoryBossCurEpisodeId()
	local list = DungeonConfig.instance:getChapterEpisodeCOList(DungeonEnum.ChapterId.BossStory)

	for i, v in ipairs(list) do
		local pass = DungeonModel.instance:hasPassLevelAndStory(v.id)

		if not pass then
			return v.id
		end
	end

	return list[#list].id
end

VersionActivity2_8BossModel.instance = VersionActivity2_8BossModel.New()

return VersionActivity2_8BossModel
