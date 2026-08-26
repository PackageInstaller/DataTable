-- chunkname: @modules/logic/seasonver/act166/model/Season166BattleContext.lua

module("modules.logic.seasonver.act166.model.Season166BattleContext", package.seeall)

local Season166BattleContext = pureTable("Season166BattleContext")

function Season166BattleContext:init(actId, episodeId, baseId, talentId, trainId, teachId)
	self.actId = actId
	self.episodeId = episodeId
	self.baseId = baseId
	self.talentId = talentId
	self.trainId = trainId
	self.teachId = teachId

	local episodeCo = lua_episode.configDict[self.episodeId]

	self.episodeType = episodeCo and episodeCo.type
	self.battleId = episodeCo and episodeCo.battleId
end

return Season166BattleContext
