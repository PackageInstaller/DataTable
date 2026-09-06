-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickupidea/model/PickupideaModel.lua

module("logic.extensions.pickupidea.view.PickupideaModel", package.seeall)

local PickupideaModel = class("PickupideaModel", BaseModel)

function PickupideaModel:ctor()
	return
end

function PickupideaModel:onInit()
	self:onReset()
end

function PickupideaModel:onReset()
	self._activityId = 0
	self._hasPlayTimes = 0
	self._gainedPrizeIds = {}
end

function PickupideaModel:setActivityId(actId)
	self._activityId = actId
end

function PickupideaModel:getActivityId()
	return self._activityId
end

function PickupideaModel:setInfo(msg)
	self._hasPlayTimes = msg.hasPlayTimes
	self._gainedPrizeIds = msg.gainedPrizeIds
end

function PickupideaModel:getHasPlayTimes()
	return self._hasPlayTimes
end

function PickupideaModel:getGainedPrizeIds()
	return self._gainedPrizeIds
end

function PickupideaModel:gainPrizeId(prizeId)
	self._gainedPrizeIds:append(prizeId)
end

PickupideaModel.instance = PickupideaModel.New()

return PickupideaModel
