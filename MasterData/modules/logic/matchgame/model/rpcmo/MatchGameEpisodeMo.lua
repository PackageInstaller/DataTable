-- chunkname: @modules/logic/matchgame/model/rpcmo/MatchGameEpisodeMo.lua

module("modules.logic.matchgame.model.rpcmo.MatchGameEpisodeMo", package.seeall)

local MatchGameEpisodeMo = class("MatchGameEpisodeMo")

function MatchGameEpisodeMo:init(info)
	self.episodeId = info.episodeId
	self.episodeCo = lua_activity244_episode.configDict[self.episodeId]

	if not self.episodeCo then
		logError(string.format("三消关卡配置不存在 episodeId = %s", self.episodeId))
	end

	self.matchLevelId = self.episodeCo and self.episodeCo.matchLevelId
	self.levelCo = lua_activity244_episode_level.configDict[self.matchLevelId]
	self.isPass = info.isPass

	self:_initStarList(info.stars)
end

function MatchGameEpisodeMo:_initStarList(stars)
	if stars then
		self.starNum = #stars or 0
	end

	self.lightStarMap = {}

	for _, starIndex in ipairs(stars) do
		self.lightStarMap[starIndex] = true
	end
end

function MatchGameEpisodeMo:isConditionPass(index)
	return self.lightStarMap and self.lightStarMap[index] == true
end

return MatchGameEpisodeMo
