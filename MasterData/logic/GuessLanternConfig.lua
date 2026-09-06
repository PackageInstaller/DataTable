-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesslantern/config/GuessLanternConfig.lua

module("logic.extensions.guesslantern.config.GuessLanternConfig", package.seeall)

local GuessLanternConfig = class("GuessLanternConfig", BaseConfig)

function GuessLanternConfig:onInit()
	GuessLanternConfig.super.onInit(self)

	self.guess_lantern_activity = nil
	self.guess_lantern_problem = nil
	self.guess_lantern_prize = nil
end

function GuessLanternConfig:getNames()
	return {
		"guess_lantern_activity",
		"guess_lantern_problem",
		"guess_lantern_prize"
	}
end

function GuessLanternConfig:handleConfig(name, content)
	if name == "guess_lantern_activity" then
		self.guess_lantern_activity = content
	elseif name == "guess_lantern_problem" then
		self.guess_lantern_problem = content
	elseif name == "guess_lantern_prize" then
		self.guess_lantern_prize = content
	end
end

function GuessLanternConfig:getActivityCfg(id)
	return self.guess_lantern_activity[id]
end

function GuessLanternConfig:getProblemCfgList(problemPlanId)
	return self.guess_lantern_problem[problemPlanId] or {}
end

function GuessLanternConfig:getProblemCfg(problemPlanId, problemId)
	return self.guess_lantern_problem[problemPlanId] and self.guess_lantern_problem[problemPlanId][problemId]
end

function GuessLanternConfig:getPrizeCfgList(activityId)
	return self.guess_lantern_prize[activityId]
end

function GuessLanternConfig:getPrizeCfg(activityId, prizeId)
	return self.guess_lantern_prize[activityId] and self.guess_lantern_prize[activityId][prizeId]
end

GuessLanternConfig.instance = GuessLanternConfig.New()

return GuessLanternConfig
