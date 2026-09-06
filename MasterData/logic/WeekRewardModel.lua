-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weekreward/model/WeekRewardModel.lua

module("logic.extensions.weekreward.model.WeekRewardModel", package.seeall)

local WeekRewardModel = class("WeekRewardModel", BaseModel)

function WeekRewardModel:ctor()
	return
end

function WeekRewardModel:getLoginDays()
	return self._loginDays
end

function WeekRewardModel:getPrizedDay()
	return self._prizedDay
end

function WeekRewardModel:onGetSignInData(msg)
	self._loginDays = msg.loginDays
	self._prizedDay = msg.prizedDay
end

function WeekRewardModel:onGainSignInReward()
	self._prizedDay = self._prizedDay + 1
end

function WeekRewardModel:getCurCanSignDay()
	if self._loginDays > self._prizedDay then
		return self._prizedDay
	else
		return -1
	end
end

WeekRewardModel.instance = WeekRewardModel.New()

return WeekRewardModel
