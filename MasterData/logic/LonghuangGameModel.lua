-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/model/LonghuangGameModel.lua

module("logic.extensions.timelimitedchallenge.model.LonghuangGameModel", package.seeall)

local LonghuangGameModel = class("LonghuangGameModel", TLCBaseGameModel)

function LonghuangGameModel:ctor()
	self._challengeId = 3
end

function LonghuangGameModel:onInit()
	return
end

function LonghuangGameModel:onReset()
	self._isDataInit = false
	self._dodgeTime = 0
end

function LonghuangGameModel:getChallengeId()
	return self._challengeId
end

function LonghuangGameModel:isDataInit()
	return false
end

function LonghuangGameModel:setDodgeTime(value, isForce)
	self._isDataInit = true
	self._dodgeTime = (isForce == true or isForce == nil) and value or math.max(value, checknumber(self._dodgeTime))
end

function LonghuangGameModel:getDodgeTime()
	return checknumber(self._dodgeTime) / 1000
end

LonghuangGameModel.instance = LonghuangGameModel.New()

return LonghuangGameModel
