-- chunkname: @modules/logic/act189/model/Activity189Model.lua

module("modules.logic.act189.model.Activity189Model", package.seeall)

local Activity189Model = class("Activity189Model", BaseModel)

function Activity189Model:onInit()
	self:reInit()
end

function Activity189Model:reInit()
	self._actInfo = {}
end

function Activity189Model:getActMO(activityId)
	return ActivityModel.instance:getActMO(activityId)
end

function Activity189Model:getRealStartTimeStamp(activityId)
	return self:getActMO(activityId):getRealStartTimeStamp()
end

function Activity189Model:getRealEndTimeStamp(activityId)
	return self:getActMO(activityId):getRealEndTimeStamp()
end

function Activity189Model:getRemainTimeSec(activityId)
	local remainTimeSec = ActivityModel.instance:getRemainTimeSec(activityId)

	return remainTimeSec or 0
end

function Activity189Model:onReceiveGetAct189InfoReply(msg)
	self._actInfo[msg.activityId] = msg
end

function Activity189Model:onReceiveGetAct189OnceBonusReply(msg)
	local actInfo = self._actInfo[msg.activityId]

	if not actInfo then
		return
	end

	rawset(actInfo, "hasGetOnceBonus", true)
end

function Activity189Model:isClaimed(activityId)
	local actInfo = self._actInfo[activityId]

	if not actInfo then
		return false
	end

	return actInfo.hasGetOnceBonus
end

function Activity189Model:isClaimable(activityId)
	local actInfo = self._actInfo[activityId]

	if not actInfo then
		return false
	end

	return not self:isClaimed(activityId)
end

Activity189Model.instance = Activity189Model.New()

return Activity189Model
