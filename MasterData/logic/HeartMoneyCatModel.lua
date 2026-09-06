-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartmoneycat/model/HeartMoneyCatModel.lua

module("logic.extensions.heartmoneycat.model.HeartMoneyCatModel", package.seeall)

local HeartMoneyCatModel = class("HeartMoneyCatModel", BaseModel)

function HeartMoneyCatModel:onReset()
	HeartMoneyCatModel.super.onReset(self)

	self._times = nil
end

function HeartMoneyCatModel:setTimes(times)
	self._times = times
end

function HeartMoneyCatModel:getTimes()
	return self._times
end

function HeartMoneyCatModel:setNum(num)
	self._num = num
end

function HeartMoneyCatModel:getNum()
	return self._num
end

function HeartMoneyCatModel:setChangeSetId(changeSetId)
	self._changeSetId = changeSetId
end

function HeartMoneyCatModel:getChangeSetId()
	return self._changeSetId
end

HeartMoneyCatModel.instance = HeartMoneyCatModel.New()

return HeartMoneyCatModel
