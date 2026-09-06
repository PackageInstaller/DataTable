-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/agent/ChopKingAgent.lua

module("logic.extensions.chopking.agent.ChopKingAgent", package.seeall)

local ChopKingAgent = class("ChopKingAgent", BaseAgent)

function ChopKingAgent:sendPM_ChopKingFirstClgInfoReq(activityId)
	local req = ChopKingExtension_pb.PM_ChopKingFirstClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ChopKingAgent:handlePM_ChopKingFirstClgInfoRes(status, msg)
	if status == 0 then
		ChopKingController.instance:handlePM_ChopKingFirstClgInfoRes(msg)
	end
end

function ChopKingAgent:sendPM_ChopKingRerandomDropBuffReq(activityId)
	local req = ChopKingExtension_pb.PM_ChopKingRerandomDropBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ChopKingAgent:handlePM_ChopKingRerandomDropBuffRes(status, msg)
	if status == 0 then
		ChopKingController.instance:handlePM_ChopKingRerandomDropBuffRes(msg)
	end
end

function ChopKingAgent:sendPM_ChopKingSelectDropBuffReq(activityId, buffId)
	local req = ChopKingExtension_pb.PM_ChopKingSelectDropBuffReq()

	req.activityId = activityId
	req.buffId = buffId

	self:sendMsg(req)
end

function ChopKingAgent:handlePM_ChopKingSelectDropBuffRes(status, msg)
	if status == 0 then
		ChopKingController.instance:handlePM_ChopKingSelectDropBuffRes(msg)
	end
end

function ChopKingAgent:sendPM_ChopKingReShuffleDropBuffReq(activityId)
	local req = ChopKingExtension_pb.PM_ChopKingReShuffleDropBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ChopKingAgent:handlePM_ChopKingReShuffleDropBuffRes(status, msg)
	if status == 0 then
		ChopKingController.instance:handlePM_ChopKingReShuffleDropBuffRes(msg)
	end
end

function ChopKingAgent:sendPM_ChopKingFirstClgStartFightReq(activityId, form)
	local req = ChopKingExtension_pb.PM_ChopKingFirstClgStartFightReq()

	req.activityId = activityId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function ChopKingAgent:handlePM_ChopKingFirstClgStartFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ChopKingAgent:sendPM_ChopKingFirstClgContinueFightReq(activityId)
	local req = ChopKingExtension_pb.PM_ChopKingFirstClgContinueFightReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ChopKingAgent:handlePM_ChopKingFirstClgContinueFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ChopKingAgent:handlePM_NotifyChopKingFirstClgFightResultRes(status, msg)
	if status == 0 then
		ChopKingController.instance:PM_NotifyChopKingFirstClgFightResultRes(msg)
	end
end

function ChopKingAgent:sendPM_ChopKingLoopClgInfoReq(activityId)
	local req = ChopKingExtension_pb.PM_ChopKingLoopClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ChopKingAgent:handlePM_ChopKingLoopClgInfoRes(status, msg)
	if status == 0 then
		ChopKingController.instance:handlePM_ChopKingLoopClgInfoRes(msg)
	end
end

function ChopKingAgent:sendPM_ChopKingLoopClgFightReq(activityId, loopId, stageId, form)
	local req = ChopKingExtension_pb.PM_ChopKingLoopClgFightReq()

	req.activityId = activityId
	req.loopId = loopId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function ChopKingAgent:handlePM_ChopKingLoopClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ChopKingAgent:handlePM_NotifyChopKingLoopClgFightResultRes(status, msg)
	if status == 0 then
		ChopKingController.instance:handlePM_NotifyChopKingLoopClgFightResultRes(msg)
	end
end

function ChopKingAgent:sendPM_ChopKingCircleClgInfoReq(activityId)
	local req = ChopKingExtension_pb.PM_ChopKingCircleClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ChopKingAgent:handlePM_ChopKingCircleClgInfoRes(status, msg)
	if status == 0 then
		ChopKingController.instance:handlePM_ChopKingCircleClgInfoRes(msg)
	end
end

function ChopKingAgent:sendPM_ChopKingCircleClgFightReq(activityId, stageId, form)
	local req = ChopKingExtension_pb.PM_ChopKingCircleClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function ChopKingAgent:handlePM_ChopKingCircleClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ChopKingAgent:handlePM_NotifyChopKingCircleClgFightResultRes(status, msg)
	if status == 0 then
		ChopKingController.instance:handlePM_NotifyChopKingCircleClgFightResultRes(msg)
	end
end

function ChopKingAgent:sendPM_ChopKingAgainstTwoClgInfoReq(activityId)
	local req = ChopKingExtension_pb.PM_ChopKingAgainstTwoClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ChopKingAgent:handlePM_ChopKingAgainstTwoClgInfoRes(status, msg)
	if status == 0 then
		ChopKingController.instance:handlePM_ChopKingAgainstTwoClgInfoRes(msg)
	end
end

function ChopKingAgent:sendPM_ChopKingAgainstTwoClgFightReq(activityId, stageId, form)
	local req = ChopKingExtension_pb.PM_ChopKingAgainstTwoClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function ChopKingAgent:handlePM_ChopKingAgainstTwoClgFightRes(status, msg)
	if status == 0 then
		ChopKingController.instance:handlePM_ChopKingAgainstTwoClgFightRes(msg)
	end
end

function ChopKingAgent:sendPM_ChopKingRankReq(activityId, typeId)
	local req = ChopKingExtension_pb.PM_ChopKingRankReq()

	req.activityId = activityId
	req.typeId = typeId

	self:sendMsg(req)
end

function ChopKingAgent:handlePM_ChopKingRankRes(status, msg)
	if status == 0 then
		ChopKingController.instance:handlePM_ChopKingRankRes(msg)
	end
end

ChopKingAgent.instance = ChopKingAgent.New()

return ChopKingAgent
