-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signindaily/model/SigninDailyModel.lua

module("logic.extensions.signindaily.model.SigninDailyModel", package.seeall)

local SigninDailyModel = class("SigninDailyModel", BaseModel)

function SigninDailyModel:ctor()
	return
end

function SigninDailyModel:onInit()
	self:onReset()
end

function SigninDailyModel:onReset()
	self._roundId = nil
	self._prizeProcess = nil
	self._hasGainPrize = nil
	self._hasGetData = false
	self._timeStamp = nil
end

function SigninDailyModel:getRoundId()
	return self._roundId
end

function SigninDailyModel:getPrizeProcess()
	return self._prizeProcess
end

function SigninDailyModel:setPrizeProcess()
	self._prizeProcess = self._prizeProcess + 1
end

function SigninDailyModel:getGasGainPrize()
	return self._hasGainPrize
end

function SigninDailyModel:setGasGainPrize(torf)
	self._hasGainPrize = torf
end

function SigninDailyModel:getHasGetData()
	return self._hasGetData
end

function SigninDailyModel:setHasGetData(torf)
	self._hasGetData = torf
end

function SigninDailyModel:setData(msg)
	self._roundId = msg.roundId
	self._prizeProcess = msg.prizeProcess
	self._hasGainPrize = msg.hasGainPrize or false
	self._hasGetData = true
end

function SigninDailyModel:setLastTimeStamp()
	self._timeStamp = ServerTime.now()
end

function SigninDailyModel:getLastTimeStamp()
	return self._timeStamp
end

SigninDailyModel.instance = SigninDailyModel.New()

return SigninDailyModel
