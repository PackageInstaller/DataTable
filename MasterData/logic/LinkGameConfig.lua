-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkgame/config/LinkGameConfig.lua

module("logic.extensions.linkgame.config.LinkGameConfig", package.seeall)

local LinkGameConfig = class("LinkGameConfig", BaseConfig)

function LinkGameConfig:onInit()
	LinkGameConfig.super.onInit(self)
end

function LinkGameConfig:getNames()
	return {
		"link_game_activity",
		"link_game_stage",
		"link_game_mini_game",
		"link_game_icon",
		"link_game_rule"
	}
end

function LinkGameConfig:handleConfig(name, content)
	if name == "link_game_activity" then
		self._link_game_activity = content
	elseif name == "link_game_stage" then
		self._link_game_stage = content
	elseif name == "link_game_mini_game" then
		self._link_game_mini_game = content
	elseif name == "link_game_icon" then
		self._link_game_icon = content
	elseif name == "link_game_rule" then
		self._link_game_rule = content
	end
end

function LinkGameConfig:getActivityCfg(actId)
	return self._link_game_activity[actId]
end

function LinkGameConfig:getStageCfgs(actId)
	return self._link_game_stage[actId]
end

function LinkGameConfig:getStageCfg(actId, stageId)
	return self._link_game_stage[actId][stageId]
end

function LinkGameConfig:getMiniGameCfg(gameId)
	return self._link_game_mini_game[gameId]
end

function LinkGameConfig:getRuleCfgs(ruleId)
	return self._link_game_rule[ruleId]
end

function LinkGameConfig:getIconCfgs(iconPlan)
	return self._link_game_icon[iconPlan]
end

LinkGameConfig.instance = LinkGameConfig.New()

return LinkGameConfig
