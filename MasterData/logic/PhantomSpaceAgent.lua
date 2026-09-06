-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/phantomspace/agent/PhantomSpaceAgent.lua

module("logic.extensions.phantomspace.agent.PhantomSpaceAgent", package.seeall)

local PhantomSpaceAgent = class("PhantomSpaceAgent", BaseAgent)

function PhantomSpaceAgent:sendPM_PhantomSpaceGetInfoReq(activityId)
	local req = PhantomSpaceExtension_pb.PM_PhantomSpaceGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PhantomSpaceAgent:handlePM_PhantomSpaceGetInfoRes(status, msg)
	if status == 0 then
		PhantomSpaceController.instance:onGetInfo(msg)
	end
end

function PhantomSpaceAgent:sendPM_PhantomSpaceChallengeReq(stageKey_pb, form_pb)
	local req = PhantomSpaceExtension_pb.PM_PhantomSpaceChallengeReq()

	if stageKey_pb ~= nil then
		req.stageKey:ParseFromString(stageKey_pb:SerializeToString())
	end

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function PhantomSpaceAgent:handlePM_PhantomSpaceChallengeRes(status, msg)
	if status == 0 then
		PhantomSpaceController.instance:onFight(msg)
	end
end

function PhantomSpaceAgent:sendPM_PhantomSpaceResetReq(stageKey_pb)
	local req = PhantomSpaceExtension_pb.PM_PhantomSpaceResetReq()

	if stageKey_pb ~= nil then
		req.stageKey:ParseFromString(stageKey_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function PhantomSpaceAgent:handlePM_PhantomSpaceResetRes(status, msg)
	if status == 0 then
		PhantomSpaceController.instance:onResetInfo(msg)
	end
end

function PhantomSpaceAgent:sendPM_PhantomSpaceGetRankInfoReq(activityId, mode)
	local req = PhantomSpaceExtension_pb.PM_PhantomSpaceGetRankInfoReq()

	req.activityId = activityId
	req.mode = mode

	self:sendMsg(req)
end

function PhantomSpaceAgent:handlePM_PhantomSpaceGetRankInfoRes(status, msg)
	if status == 0 then
		PhantomSpaceController.instance:onGetRankInfo(msg)
	end
end

function PhantomSpaceAgent:handlePM_Notify_PhantomSpaceChallengeResult(status, msg)
	if status == 0 then
		PhantomSpaceController.instance:onGetFighMsg(msg)
	end
end

function PhantomSpaceAgent:sendPM_PhantomSpaceGetEndlessInfoReq(activityId, pageStartStageId, pageSize)
	local req = PhantomSpaceExtension_pb.PM_PhantomSpaceGetEndlessInfoReq()

	req.activityId = activityId
	req.pageStartStageId = pageStartStageId
	req.pageSize = pageSize

	self:sendMsg(req)
end

function PhantomSpaceAgent:handlePM_PhantomSpaceGetEndlessInfoRes(status, msg)
	if status == 0 then
		PhantomSpaceController.instance:handlePM_PhantomSpaceGetEndlessInfoRes(msg)
	end
end

function PhantomSpaceAgent:sendPM_PhantomSpaceChallengeEndlessReq(activityId, stageId, form)
	local req = PhantomSpaceExtension_pb.PM_PhantomSpaceChallengeEndlessReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function PhantomSpaceAgent:handlePM_PhantomSpaceChallengeEndlessRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function PhantomSpaceAgent:sendPM_PhantomSpaceResetEndlessReq(activityId, stageId)
	local req = PhantomSpaceExtension_pb.PM_PhantomSpaceResetEndlessReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function PhantomSpaceAgent:handlePM_PhantomSpaceResetEndlessRes(status, msg)
	if status == 0 then
		PhantomSpaceController.instance:handlePM_PhantomSpaceResetEndlessRes(msg)
	end
end

function PhantomSpaceAgent:handlePM_Notify_PhantomSpaceEndlessChallengeResult(status, msg)
	if status == 0 then
		PhantomSpaceController.instance:handlePM_Notify_PhantomSpaceEndlessChallengeResult(msg)
	end
end

PhantomSpaceAgent.instance = PhantomSpaceAgent.New()

return PhantomSpaceAgent
