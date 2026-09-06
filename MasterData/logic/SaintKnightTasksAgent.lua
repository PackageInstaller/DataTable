-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/agent/SaintKnightTasksAgent.lua

module("logic.extensions.saintknighttasks.agent.SaintKnightTasksAgent", package.seeall)

local SaintKnightTasksAgent = class("SaintKnightTasksAgent", BaseAgent)

function SaintKnightTasksAgent:sendPM_CollectionTasksGetInfoReq(actId)
	local req = SaintKnightTasksExtension_pb.PM_CollectionTasksGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function SaintKnightTasksAgent:handlePM_CollectionTasksGetInfoRes(status, msg)
	if status == 0 then
		SaintKnightTaskController.instance:handleCollectionTasksGetInfoRes(msg)
	end
end

function SaintKnightTasksAgent:sendPM_CollectionTasksGetRankInfoReq(actId, rankId)
	local req = SaintKnightTasksExtension_pb.PM_CollectionTasksGetRankInfoReq()

	req.actId = actId
	req.rankId = rankId

	self:sendMsg(req)
end

function SaintKnightTasksAgent:handlePM_CollectionTasksGetRankInfoRes(status, msg)
	if status == 0 then
		SaintKnightTaskController.instance:handleCollectionTasksGetRankInfoRes(msg)
	end
end

function SaintKnightTasksAgent:sendPM_CollectionTasksGainPrizeReq(actId)
	local req = SaintKnightTasksExtension_pb.PM_CollectionTasksGainPrizeReq()

	req.actId = actId

	self:sendMsg(req)
end

function SaintKnightTasksAgent:handlePM_CollectionTasksGainPrizeRes(status, msg)
	if status == 0 then
		SaintKnightTaskController.instance:handleCollectionTasksGainPrizeRes(msg)
	end
end

function SaintKnightTasksAgent:sendPM_SK_GetPersonTaskReq(actId)
	local req = SaintKnightTasksExtension_pb.PM_SK_GetPersonTaskReq()

	req.actId = actId

	self:sendMsg(req)
end

function SaintKnightTasksAgent:handlePM_SK_GetPersonTaskRes(status, msg)
	SaintKnightTaskController.instance:handleSK_GetPersonTaskRes(status, msg)
end

function SaintKnightTasksAgent:sendPM_SK_GainPersonTaskPrizeReq(actId, taskId)
	local req = SaintKnightTasksExtension_pb.PM_SK_GainPersonTaskPrizeReq()

	req.actId = actId
	req.taskId = taskId

	self:sendMsg(req)
end

function SaintKnightTasksAgent:handlePM_SK_GainPersonTaskPrizeRes(status, msg)
	if status == 0 then
		SaintKnightTaskController.instance:handleSK_GainPersonTaskPrizeRes(msg)
	end
end

function SaintKnightTasksAgent:sendPM_WorldTasksGetInfoReq(actId)
	local req = SaintKnightTasksExtension_pb.PM_WorldTasksGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function SaintKnightTasksAgent:handlePM_WorldTasksGetInfoRes(status, msg)
	if status == 0 then
		SaintKnightTaskController.instance:handleWorldTasksGetInfoRes(msg)
	end
end

function SaintKnightTasksAgent:sendPM_WorldTasksGainPrizeReq(actId, worldTaskPlanId, index)
	local req = SaintKnightTasksExtension_pb.PM_WorldTasksGainPrizeReq()

	req.actId = actId
	req.worldTaskPlanId = worldTaskPlanId
	req.index = index

	self:sendMsg(req)
end

function SaintKnightTasksAgent:handlePM_WorldTasksGainPrizeRes(status, msg)
	if status == 0 then
		SaintKnightTaskController.instance:handleWorldTasksGainPrizeRes(msg)
	end
end

function SaintKnightTasksAgent:sendPM_SKVerifyFormZdlReq(actId, form)
	local req = SaintKnightTasksExtension_pb.PM_SKVerifyFormZdlReq()

	req.actId = actId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function SaintKnightTasksAgent:handlePM_SKVerifyFormZdlRes(status, msg)
	if status == 0 then
		SaintKnightTaskController.instance:handleSKVerifyFormZdlRes(msg)
	end
end

function SaintKnightTasksAgent:sendPM_SKGainVerifyPrizeReq(actId)
	local req = SaintKnightTasksExtension_pb.PM_SKGainVerifyPrizeReq()

	req.actId = actId

	self:sendMsg(req)
end

function SaintKnightTasksAgent:handlePM_SKGainVerifyPrizeRes(status, msg)
	if status == 0 then
		SaintKnightTaskController.instance:handleSKGainVerifyPrizeRes(msg)
	end
end

function SaintKnightTasksAgent:sendPM_SK_GainTeamPrizeReq(actId)
	local req = SaintKnightTasksExtension_pb.PM_SK_GainTeamPrizeReq()

	req.actId = actId

	self:sendMsg(req)
end

function SaintKnightTasksAgent:handlePM_SK_GainTeamPrizeRes(status, msg)
	if status == 0 then
		SaintKnightTaskController.instance:handleSK_GainTeamPrizeRes(msg)
	end
end

function SaintKnightTasksAgent:sendPM_SK_JoinTeamReq(activityId, captainId)
	local req = SaintKnightTasksExtension_pb.PM_SK_JoinTeamReq()

	req.activityId = activityId
	req.captainId = captainId

	self:sendMsg(req)
end

function SaintKnightTasksAgent:handlePM_SK_JoinTeamRes(status, msg)
	if status == 0 then
		SaintKnightTaskController.instance:handleSK_JoinTeamRes(msg)
	end
end

SaintKnightTasksAgent.instance = SaintKnightTasksAgent.New()

return SaintKnightTasksAgent
