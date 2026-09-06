-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roseclg/agent/RoseClgAgent.lua

module("logic.extensions.roseclg.agent.RoseClgAgent", package.seeall)

local RoseClgAgent = class("RoseClgAgent", BaseAgent)

function RoseClgAgent:sendPM_RoseClgGetInfoReq(activityId)
	local req = RoseClgExtension_pb.PM_RoseClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function RoseClgAgent:handlePM_RoseClgGetInfoRes(status, msg)
	if status == 0 then
		RoseclgModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RoseClgGetInfoRes)
	end
end

function RoseClgAgent:sendPM_RoseClgChallengeReq(activityId, teamIndex, form)
	local req = RoseClgExtension_pb.PM_RoseClgChallengeReq()

	req.activityId = activityId
	req.teamIndex = teamIndex

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function RoseClgAgent:handlePM_RoseClgChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.RoseClgChallengeRes)
	end
end

function RoseClgAgent:handlePM_NotifyRoseClgChallengeEndRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local curFightStageId = msg.curFightStageId

		RoseclgModel.instance:onClgRes(msg)

		local stageCfgs = RoseclgConfig.instance:getStageCfgs(activityId)

		UIJumper.instance:pushOneStack(ViewName.RoseclgmainView, nil, activityId)

		if curFightStageId < #stageCfgs then
			UIJumper.instance:pushOneStack(ViewName.RoseclgstageView, nil, activityId)
		end

		GlobalDispatcher:dispatch(GlobalNotify.NotifyRoseClgChallengeEndRes)
	end
end

function RoseClgAgent:sendPM_RoseClgResetReq(activityId)
	local req = RoseClgExtension_pb.PM_RoseClgResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function RoseClgAgent:handlePM_RoseClgResetRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId

		RoseclgModel.instance:onClgReset(activityId)
		GlobalDispatcher:dispatch(GlobalNotify.RoseClgResetRes)
	end
end

RoseClgAgent.instance = RoseClgAgent.New()

return RoseClgAgent
