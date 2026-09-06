-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyhoundingclg/agent/FamilyHoundingAgent.lua

module("logic.extensions.familyhounding.agent.FamilyHoundingAgent", package.seeall)

local FamilyHoundingAgent = class("FamilyHoundingAgent", BaseAgent)

function FamilyHoundingAgent:sendPM_FamilyHounding_GetInfoReq()
	local req = FamilyHoundingExtension_pb.PM_FamilyHounding_GetInfoReq()

	self:sendMsg(req)
end

function FamilyHoundingAgent:handlePM_FamilyHounding_GetInfoRes(status, msg)
	if status == 0 then
		FamilyHoudingClgController.instance:handlePM_FamilyHounding_GetInfoRes(msg)
	end
end

function FamilyHoundingAgent:sendPM_FamilyHounding_ViewFamilyRankReq()
	local req = FamilyHoundingExtension_pb.PM_FamilyHounding_ViewFamilyRankReq()

	self:sendMsg(req)
end

function FamilyHoundingAgent:handlePM_FamilyHounding_ViewFamilyRankRes(status, msg)
	if status == 0 then
		FamilyHoudingClgController.instance:handlePM_FamilyHounding_ViewFamilyRankRes(msg)
	end
end

function FamilyHoundingAgent:sendPM_FamilyHounding_ViewPersonRankReq()
	local req = FamilyHoundingExtension_pb.PM_FamilyHounding_ViewPersonRankReq()

	self:sendMsg(req)
end

function FamilyHoundingAgent:handlePM_FamilyHounding_ViewPersonRankRes(status, msg)
	if status == 0 then
		FamilyHoudingClgController.instance:handlePM_FamilyHounding_ViewPersonRankRes(msg)
	end
end

function FamilyHoundingAgent:sendPM_FamilyHounding_FightReq(dayIndex, form)
	local req = FamilyHoundingExtension_pb.PM_FamilyHounding_FightReq()

	req.dayIndex = dayIndex

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function FamilyHoundingAgent:handlePM_FamilyHounding_FightRes(status, msg)
	FamilyHoudingClgController.instance:handlePM_FamilyHounding_FightRes(status, msg)
end

function FamilyHoundingAgent:sendPM_FamilyHounding_PracticeReq(dayIndex, form)
	local req = FamilyHoundingExtension_pb.PM_FamilyHounding_PracticeReq()

	req.dayIndex = dayIndex

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function FamilyHoundingAgent:handlePM_FamilyHounding_PracticeRes(status, msg)
	FamilyHoudingClgController.instance:handlePM_FamilyHounding_PracticeRes(status, msg)
end

function FamilyHoundingAgent:handlePM_FamilyHounding_NotifyFightResultRes(status, msg)
	if status == 0 then
		FamilyHoudingClgController.instance:handlePM_FamilyHounding_NotifyFightResultRes(msg)
	end
end

function FamilyHoundingAgent:handlePM_FamilyHounding_NotifyPracticeResultRes(status, msg)
	if status == 0 then
		FamilyHoudingClgController.instance:handlePM_FamilyHounding_NotifyPracticeResultRes(msg)
	end
end

FamilyHoundingAgent.instance = FamilyHoundingAgent.New()

return FamilyHoundingAgent
