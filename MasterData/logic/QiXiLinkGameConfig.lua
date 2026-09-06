-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qixilinkgame/config/QiXiLinkGameConfig.lua

module("logic.extensions.qixilinkgame.config.QiXiLinkGameConfig", package.seeall)

local QiXiLinkGameConfig = class("QiXiLinkGameConfig", BaseConfig)

function QiXiLinkGameConfig:onInit()
	QiXiLinkGameConfig.super.onInit(self)
end

function QiXiLinkGameConfig:getNames()
	QiXiLinkGameConfig.super.getNames(self)

	return {
		"linkendless_game_progress",
		"linkendless_game_activity",
		"linkendless_game_mini_game",
		"linkendless_game_icon",
		"linkendless_game_rule"
	}
end

function QiXiLinkGameConfig:handleConfig(name, content)
	if name == "linkendless_game_progress" then
		self.prizeCfg = content
	elseif name == "linkendless_game_activity" then
		self.gameActCfg = content
	elseif name == "linkendless_game_mini_game" then
		self.gameMiniGameCfg = content
	elseif name == "linkendless_game_icon" then
		self.gameIconCfg = content
	elseif name == "linkendless_game_rule" then
		self.gameRuleCfg = content
	end
end

function QiXiLinkGameConfig:getPrizeCfgs(actId)
	return self.prizeCfg[actId]
end

function QiXiLinkGameConfig:getGameActCfg(gameActId)
	return self.gameActCfg[gameActId]
end

function QiXiLinkGameConfig:getGameMiniGameCfgs(gameId)
	print("QiXiLinkGameConfig:传入的gameId = ", gameId)

	return self.gameMiniGameCfg[gameId]
end

function QiXiLinkGameConfig:getGameIconCfgs(iconPlan)
	return self.gameIconCfg[iconPlan]
end

function QiXiLinkGameConfig:getGameRuleCfgs(ruleId)
	return self.gameRuleCfg[ruleId]
end

QiXiLinkGameConfig.instance = QiXiLinkGameConfig.New()

return QiXiLinkGameConfig
