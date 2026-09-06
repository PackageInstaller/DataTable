-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiuclg/agent/HeartOfAoJiuClgAgent.lua

module("logic.extensions.heartofaojiuclg.agent.HeartOfAoJiuClgAgent", package.seeall)

local HeartOfAoJiuClgAgent = class("HeartOfAoJiuClgAgent", BaseAgent)

function HeartOfAoJiuClgAgent:sendPM_HeartOfAoJiuClgGetInfoReq(activityId)
	local req = HeartOfAoJiuClgExtension_pb.PM_HeartOfAoJiuClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HeartOfAoJiuClgAgent:handlePM_HeartOfAoJiuClgGetInfoRes(status, msg)
	if status == 0 then
		HeartOfAoJiuClgController.instance:handlePM_HeartOfAoJiuClgGetInfoRes(msg)
	end
end

function HeartOfAoJiuClgAgent:sendPM_HeartOfAoJiuClgChallengeReq(activityId, stageId, form)
	local req = HeartOfAoJiuClgExtension_pb.PM_HeartOfAoJiuClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function HeartOfAoJiuClgAgent:handlePM_HeartOfAoJiuClgChallengeRes(status, msg)
	if status == 0 then
		HeartOfAoJiuClgController.instance:handlePM_HeartOfAoJiuClgChallengeRes(msg)
	end
end

function HeartOfAoJiuClgAgent:sendPM_HeartOfAoJiuClgConfirmReq(activityId, stageId, confirm)
	local req = HeartOfAoJiuClgExtension_pb.PM_HeartOfAoJiuClgConfirmReq()

	req.activityId = activityId
	req.stageId = stageId
	req.confirm = confirm

	self:sendMsg(req)
end

function HeartOfAoJiuClgAgent:handlePM_HeartOfAoJiuClgConfirmRes(status, msg)
	HeartOfAoJiuClgController.instance:handlePM_HeartOfAoJiuClgConfirmRes(status, msg)
end

function HeartOfAoJiuClgAgent:sendPM_HeartOfAoJiuClgResetReq(activityId)
	local req = HeartOfAoJiuClgExtension_pb.PM_HeartOfAoJiuClgResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HeartOfAoJiuClgAgent:handlePM_HeartOfAoJiuClgResetRes(status, msg)
	if status == 0 then
		HeartOfAoJiuClgController.instance:handlePM_HeartOfAoJiuClgResetRes(msg)
	end
end

function HeartOfAoJiuClgAgent:sendPM_HeartOfAoJiuClgGetRankInfoReq(activityId)
	local req = HeartOfAoJiuClgExtension_pb.PM_HeartOfAoJiuClgGetRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HeartOfAoJiuClgAgent:handlePM_HeartOfAoJiuClgGetRankInfoRes(status, msg)
	if status == 0 then
		HeartOfAoJiuClgController.instance:handlePM_HeartOfAoJiuClgGetRankInfoRes(msg)
	end
end

function HeartOfAoJiuClgAgent:handlePM_Notify_HeartOfAoJiuClgChallengeResult(status, msg)
	if status == 0 then
		HeartOfAoJiuClgController.instance:handlePM_Notify_HeartOfAoJiuClgChallengeResult(msg)
	end
end

function HeartOfAoJiuClgAgent:sendPM_HeartOfAoJiuClgGetRankInfoV0926Req(activityId)
	local req = HeartOfAoJiuClgExtension_pb.PM_HeartOfAoJiuClgGetRankInfoV0926Req()

	req.activityId = activityId

	self:sendMsg(req)
end

function HeartOfAoJiuClgAgent:handlePM_HeartOfAoJiuClgGetRankInfoV0926Res(status, msg)
	if status == 0 then
		HeartOfAoJiuClgModel.instance:setRankMsg(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HeartOfAojiuRep0926Rank)
	end
end

HeartOfAoJiuClgAgent.instance = HeartOfAoJiuClgAgent.New()

return HeartOfAoJiuClgAgent
