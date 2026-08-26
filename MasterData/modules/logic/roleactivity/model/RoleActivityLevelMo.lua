-- chunkname: @modules/logic/roleactivity/model/RoleActivityLevelMo.lua

module("modules.logic.roleactivity.model.RoleActivityLevelMo", package.seeall)

local RoleActivityLevelMo = pureTable("RoleActivityLevelMo")

function RoleActivityLevelMo:init(_config)
	self.config = _config
	self.isUnlock = DungeonModel.instance:isUnlock(_config)

	local dungeonMO = DungeonModel.instance:getEpisodeInfo(_config.id)

	if dungeonMO then
		self.star = dungeonMO.star or 0
	end
end

function RoleActivityLevelMo:update()
	self.isUnlock = DungeonModel.instance:isUnlock(self.config)

	local dungeonMO = DungeonModel.instance:getEpisodeInfo(self.config.id)

	if dungeonMO then
		self.star = dungeonMO.star or 0
	end
end

function RoleActivityLevelMo:episodeId()
	return self.config.id
end

function RoleActivityLevelMo:isEpisodeOpen()
	return DungeonModel.instance:isUnlock(self.config)
end

function RoleActivityLevelMo:hasPassLevelAndStory()
	return DungeonModel.instance:hasPassLevelAndStory(self:episodeId())
end

function RoleActivityLevelMo:hasPassLevel()
	return DungeonModel.instance:hasPassLevel(self:episodeId())
end

return RoleActivityLevelMo
