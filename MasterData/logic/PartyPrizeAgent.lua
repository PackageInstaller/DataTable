-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partyprize/agent/PartyPrizeAgent.lua

module("logic.extensions.partyprize.agent.PartyPrizeAgent", package.seeall)

local PartyPrizeAgent = class("PartyPrizeAgent", BaseAgent)

function PartyPrizeAgent:sendPM_PartyPrizeGetInfoReq(activityId)
	local req = PartyPrizeExtension_pb.PM_PartyPrizeGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PartyPrizeAgent:handlePM_PartyPrizeGetInfoRes(status, msg)
	if status == 0 then
		PartyPrizeController.instance:handleGetInfo(msg)
	end
end

function PartyPrizeAgent:sendPM_PartyPrizeGainPrizeReq(activityId, day)
	local req = PartyPrizeExtension_pb.PM_PartyPrizeGainPrizeReq()

	req.activityId = activityId
	req.day = day
	self._day = day

	self:sendMsg(req)
end

function PartyPrizeAgent:handlePM_PartyPrizeGainPrizeRes(status, msg)
	if status == 0 then
		PartyPrizeController.instance:handleGainPrize(self._day, msg)
	end

	self._day = nil
end

function PartyPrizeAgent:sendPM_PartyPrizeGainAccumulatePrizeReq(activityId)
	local req = PartyPrizeExtension_pb.PM_PartyPrizeGainAccumulatePrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PartyPrizeAgent:handlePM_PartyPrizeGainAccumulatePrizeRes(status, msg)
	if status == 0 then
		PartyPrizeController.instance:handleAccumulatePrize(msg)
	end
end

function PartyPrizeAgent:sendPM_PartyPrizeGainDailyPrizeReq(activityId, id)
	local req = PartyPrizeExtension_pb.PM_PartyPrizeGainDailyPrizeReq()

	req.activityId = activityId
	req.id = id
	self._dailyId = id

	self:sendMsg(req)
end

function PartyPrizeAgent:handlePM_PartyPrizeGainDailyPrizeRes(status, msg)
	if status == 0 then
		PartyPrizeController.instance:handleGainDailyPrize(self._dailyId, msg)
	end

	self._dailyId = nil
end

PartyPrizeAgent.instance = PartyPrizeAgent.New()

return PartyPrizeAgent
