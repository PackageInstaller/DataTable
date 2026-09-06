-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timeserverpetgain/model/TimeServerPetGainModel.lua

module("logic.extensions.timeserverpetgain.model.TimeServerPetGainModel", package.seeall)

local TimeServerPetGainModel = class("TimeServerPetGainModel", BaseModel)

function TimeServerPetGainModel:onInit()
	self:onReset()
end

function TimeServerPetGainModel:onReset()
	self._activityId2Data = {}
	self._petIndexList = {
		1,
		2,
		3,
		4,
		5
	}
end

function TimeServerPetGainModel:getOrNewMo(activityId)
	local mo = self._activityId2Data[activityId]

	if not mo then
		mo = TimeServerPetGainMo.New(activityId)
		self._activityId2Data[activityId] = mo
	end

	return mo
end

function TimeServerPetGainModel:TimeServerPetGainGetInfoRes(msg)
	local activityId = msg.activityId
	local mo = self:getOrNewMo(activityId)

	mo:TimeServerPetGainGetInfoRes(msg)
end

function TimeServerPetGainModel:TimeServerPetGainGetProgressPrizeRes(msg)
	local activityId = msg.activityId
	local mo = self:getOrNewMo(activityId)

	mo:TimeServerPetGainGetProgressPrizeRes(msg)
end

function TimeServerPetGainModel:getMoByActivityId(activityId)
	return self:getOrNewMo(activityId)
end

function TimeServerPetGainModel:savePetIndexList(list)
	self._petIndexList = list
end

function TimeServerPetGainModel:getPetIndexList()
	return self._petIndexList
end

TimeServerPetGainModel.instance = TimeServerPetGainModel.New()

return TimeServerPetGainModel
