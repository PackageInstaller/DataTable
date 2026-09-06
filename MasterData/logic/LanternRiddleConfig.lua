-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternriddle/config/LanternRiddleConfig.lua

module("logic.extensions.guesslantern.config.LanternRiddleConfig", package.seeall)

local LanternRiddleConfig = class("LanternRiddleConfig", BaseConfig)

function LanternRiddleConfig:onInit()
	LanternRiddleConfig.super.onInit(self)

	self.guess_lantern_activity = nil
	self.guess_lantern_problem = nil
	self.guess_lantern_prize = nil
end

function LanternRiddleConfig:getNames()
	return {
		"guess_lantern_activity",
		"guess_lantern_problem",
		"guess_lantern_prize",
		"lantern_riddle_activity",
		"lantern_riddle_stage",
		"lantern_riddle_progress_prize",
		"lantern_riddle_find_difference"
	}
end

function LanternRiddleConfig:handleConfig(name, content)
	if name == "guess_lantern_activity" then
		self.guess_lantern_activity = content
	elseif name == "guess_lantern_problem" then
		self.guess_lantern_problem = content
	elseif name == "guess_lantern_prize" then
		self.guess_lantern_prize = content
	elseif name == "lantern_riddle_activity" then
		self._lantern_riddle_activity = content
	elseif name == "lantern_riddle_stage" then
		self._lantern_riddle_stage = content
	elseif name == "lantern_riddle_progress_prize" then
		self._lantern_riddle_progress_prize = content
	elseif name == "lantern_riddle_find_difference" then
		self._lantern_riddle_find_difference = content
	end
end

function LanternRiddleConfig:getActivityCfg(id)
	return self.guess_lantern_activity[id]
end

function LanternRiddleConfig:getProblemCfgList(problemPlanId)
	return self.guess_lantern_problem[problemPlanId] or {}
end

function LanternRiddleConfig:getProblemCfg(problemPlanId, problemId)
	return self.guess_lantern_problem[problemPlanId] and self.guess_lantern_problem[problemPlanId][problemId]
end

function LanternRiddleConfig:getPrizeCfgList(activityId)
	return self.guess_lantern_prize[activityId]
end

function LanternRiddleConfig:getPrizeCfg(activityId, prizeId)
	return self.guess_lantern_prize[activityId] and self.guess_lantern_prize[activityId][prizeId]
end

function LanternRiddleConfig:getLanternRiddleActCfg(activityId)
	return self._lantern_riddle_activity[activityId]
end

function LanternRiddleConfig:getLanternRiddleStageCfg(activityId)
	return self._lantern_riddle_stage[activityId]
end

function LanternRiddleConfig:getLanternRiddleProgressPrizeCfg(activityId)
	return self._lantern_riddle_progress_prize[activityId]
end

function LanternRiddleConfig:getLanternRiddleFindDifferenceCfg(pictureId)
	return self._lantern_riddle_find_difference[pictureId]
end

LanternRiddleConfig.instance = LanternRiddleConfig.New()

return LanternRiddleConfig
