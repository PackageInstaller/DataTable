-- chunkname: @modules/logic/dungeon/model/UserDungeonMO.lua

module("modules.logic.dungeon.model.UserDungeonMO", package.seeall)

local UserDungeonMO = pureTable("UserDungeonMO")

function UserDungeonMO:init(info)
	self.chapterId = info.chapterId
	self.episodeId = info.episodeId
	self.star = info.star
	self.challengeCount = info.challengeCount
	self.hasRecord = info.hasRecord
	self.todayPassNum = info.todayPassNum
	self.todayTotalNum = info.todayTotalNum
end

function UserDungeonMO:initFromManual(chapterId, episodeId, star, challengeCount)
	self.chapterId = chapterId
	self.episodeId = episodeId
	self.star = star
	self.challengeCount = challengeCount
	self._manual = true
	self.isNew = true
	self.hasRecord = false

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	self.todayPassNum = 0
	self.todayTotalNum = episodeConfig.dayNum
end

function UserDungeonMO:setNewStatus(isNew)
	self.isNew = isNew
end

return UserDungeonMO
