-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/config/PinBallConfig.lua

module("logic.extensions.pinball.config.PinBallConfig", package.seeall)

local PinBallConfig = class("PinBallConfig", BaseConfig)

function PinBallConfig:getNames()
	return {
		"pin_ball_activity",
		"pin_ball_progress_prize",
		"pin_ball_stage",
		"pin_ball_ext_prize"
	}
end

function PinBallConfig:handleConfig(name, content)
	if name == "pin_ball_activity" then
		self._pin_ball_activity = content
	elseif name == "pin_ball_progress_prize" then
		self._pin_ball_progress_prize = content
	elseif name == "pin_ball_stage" then
		self._pin_ball_stage = content
	elseif name == "pin_ball_ext_prize" then
		self._pin_ball_ext_prize = content
	end
end

function PinBallConfig:getActCfg(activityId)
	return self._pin_ball_activity[activityId]
end

function PinBallConfig:getPrizeCfgs(activityId)
	return self._pin_ball_progress_prize[activityId]
end

function PinBallConfig:getStageCfgs(activityId)
	return self._pin_ball_stage[activityId]
end

function PinBallConfig:getStageCfgById(activityId, stageId)
	return self._pin_ball_stage[activityId] and self._pin_ball_stage[activityId][stageId]
end

function PinBallConfig:getExtPrizeCfgs(activityId)
	return self._pin_ball_ext_prize[activityId]
end

function PinBallConfig:getExtPrizeCfgById(activityId, prizeId)
	return self._pin_ball_ext_prize[activityId] and self._pin_ball_ext_prize[activityId][prizeId]
end

PinBallConfig.instance = PinBallConfig.New()

return PinBallConfig
