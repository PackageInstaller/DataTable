-- chunkname: @modules/logic/sp01/act205/model/Act205GameInfoMo.lua

module("modules.logic.sp01.act205.model.Act205GameInfoMo", package.seeall)

local Act205GameInfoMo = pureTable("Act205GameInfoMo")

function Act205GameInfoMo:init(activityId, gameType)
	self.activityId = activityId
	self.gameType = gameType
	self.config = Act205Config.instance:getStageConfig(self.activityId, self.gameType)

	self:setHaveGameCount()

	self.gameInfo = ""
end

function Act205GameInfoMo:updateInfo(info)
	self.activityId = info.activityId
	self.gameType = info.gameType

	self:setHaveGameCount(info.haveGameCount)
end

function Act205GameInfoMo:setGameInfo(gameInfo)
	self.gameInfo = gameInfo
end

function Act205GameInfoMo:setHaveGameCount(count)
	self.haveGameCount = count or 0
end

function Act205GameInfoMo:getGameInfo()
	return self.gameInfo
end

function Act205GameInfoMo:getHaveGameCount()
	return self.haveGameCount
end

return Act205GameInfoMo
