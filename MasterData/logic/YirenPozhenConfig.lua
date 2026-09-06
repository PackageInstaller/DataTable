-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/config/YirenPozhenConfig.lua

module("logic.extensions.yirenpozhen.config.YirenPozhenConfig", package.seeall)

local YirenPozhenConfig = class("YirenPozhenConfig", BaseConfig)

function YirenPozhenConfig:onInit()
	YirenPozhenConfig.super.onInit(self)

	self._diagramsCfg = nil
	self._stageCfg = nil
	self._teamCfg = nil
	self._creepsCfg = nil
	self._gameCfg = nil
	self._hexagramCfg = nil
end

function YirenPozhenConfig:getNames()
	return {
		"the_outcast_challenge_diagrams",
		"the_outcast_challenge_stage",
		"the_outcast_challenge_team",
		"the_outcast_challenge_creeps",
		"the_outcast_challenge_game",
		"hexagram_game",
		"the_outcast_challenge_rule"
	}
end

function YirenPozhenConfig:handleConfig(name, content)
	if name == "the_outcast_challenge_diagrams" then
		self._diagramsCfg = content
	elseif name == "the_outcast_challenge_stage" then
		self._stageCfg = content
	elseif name == "the_outcast_challenge_team" then
		self._teamCfg = content
	elseif name == "the_outcast_challenge_creeps" then
		self._creepsCfg = content
	elseif name == "the_outcast_challenge_game" then
		self._gameCfg = content
	elseif name == "hexagram_game" then
		self._hexagramCfg = content
	elseif name == "the_outcast_challenge_rule" then
		self._ruleCfg = content
	end
end

function YirenPozhenConfig:getDiagramsCfg(diagramsId)
	return self._diagramsCfg[diagramsId]
end

function YirenPozhenConfig:getDiagramsCfgList()
	local list = {}

	for k, v in ipairs(self._diagramsCfg) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.diagramsId < b.diagramsId
	end)

	return list
end

function YirenPozhenConfig:getGameCfg(gameId)
	return self._gameCfg[gameId]
end

function YirenPozhenConfig:getHexagramCfg(planId)
	return self._hexagramCfg[planId]
end

function YirenPozhenConfig:getStageCfg(stageId)
	return self._stageCfg[stageId]
end

function YirenPozhenConfig:getStageList()
	return self._stageCfg.dataList
end

function YirenPozhenConfig:getTeamCfg(creepsMasterIds)
	return self._teamCfg[creepsMasterIds]
end

function YirenPozhenConfig:getMonsterCfg(creepsMasterIds)
	return self._creepsCfg[creepsMasterIds]
end

function YirenPozhenConfig:getRuleCfg(ruleId)
	return self._ruleCfg[ruleId]
end

YirenPozhenConfig.instance = YirenPozhenConfig.New()

return YirenPozhenConfig
