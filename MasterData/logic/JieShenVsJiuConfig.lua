-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenvsjiu/config/JieShenVsJiuConfig.lua

module("logic.extensions.jieshenvsjiu.config.JieShenVsJiuConfig", package.seeall)

local JieShenVsJiuConfig = class("JieShenVsJiuConfig", BaseConfig)

function JieShenVsJiuConfig:getNames()
	JieShenVsJiuConfig.super.getNames(self)

	return {
		"jieshen_vs_jiu_activity",
		"jieshen_vs_jiu_progress_prize",
		"linkendless_game_activity",
		"linkendless_game_mini_game",
		"linkendless_game_icon",
		"linkendless_game_rule"
	}
end

function JieShenVsJiuConfig:handleConfig(name, content)
	if name == "jieshen_vs_jiu_activity" then
		self.activityCfg = content
	elseif name == "jieshen_vs_jiu_progress_prize" then
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

function JieShenVsJiuConfig:getActivityCfg(actId)
	return self.activityCfg[actId]
end

function JieShenVsJiuConfig:getPrizeCfgs(actId)
	return self.prizeCfg[actId]
end

function JieShenVsJiuConfig:getGameActCfg(gameActId)
	return self.gameActCfg[gameActId]
end

function JieShenVsJiuConfig:getGameMiniGameCfgs(gameId)
	print("JieShenVsJiuConfig:传入的gameId = ", gameId)

	return self.gameMiniGameCfg[gameId]
end

function JieShenVsJiuConfig:getGameIconCfgs(iconPlan)
	return self.gameIconCfg[iconPlan]
end

function JieShenVsJiuConfig:getGameRuleCfgs(ruleId)
	return self.gameRuleCfg[ruleId]
end

JieShenVsJiuConfig.instance = JieShenVsJiuConfig.New()

return JieShenVsJiuConfig
