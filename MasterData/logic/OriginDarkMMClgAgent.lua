-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmmclg/agent/OriginDarkMMClgAgent.lua

module("logic.extensions.origindarkmmclg.agent.OriginDarkMMClgAgent", package.seeall)

local OriginDarkMMClgAgent = class("OriginDarkMMClgAgent", BaseAgent)

function OriginDarkMMClgAgent:sendPM_OriginDarkMMClgGetInfoReq(activityId)
	local req = OriginDarkMMClgExtension_pb.PM_OriginDarkMMClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginDarkMMClgAgent:handlePM_OriginDarkMMClgGetInfoRes(status, msg)
	if status == 0 then
		OriginDarkMMClgController.instance:handlePM_OriginDarkMMClgGetInfoRes(msg)
	end
end

function OriginDarkMMClgAgent:sendPM_OriginDarkMMClgChallengeReq(activityId, stageId, form, action)
	local req = OriginDarkMMClgExtension_pb.PM_OriginDarkMMClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())

	for _, v in ipairs(action) do
		local actionItem = req.action:add()

		actionItem.posId = v.stance
		actionItem.action = v.action
	end

	self:sendMsg(req)
end

function OriginDarkMMClgAgent:handlePM_OriginDarkMMClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginDarkMMClgAgent:sendPM_OriginDarkMMClgResetReq(activityId, stageId)
	local req = OriginDarkMMClgExtension_pb.PM_OriginDarkMMClgResetReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginDarkMMClgAgent:handlePM_OriginDarkMMClgResetRes(status, msg)
	if status == 0 then
		local activityid = msg.activityId
		local stageid = msg.stageId

		OriginDarkMMClgController.instance:handlePM_OriginDarkMMClgResetRes(activityid, stageid)
	end
end

function OriginDarkMMClgAgent:handlePM_Notify_OriginDarkMMClgChallengeResultRes(status, msg)
	if status == 0 then
		OriginDarkMMClgController.instance:handlePM_Notify_OriginDarkMMClgChallengeResultRes(msg)
	end
end

OriginDarkMMClgAgent.instance = OriginDarkMMClgAgent.New()

return OriginDarkMMClgAgent
