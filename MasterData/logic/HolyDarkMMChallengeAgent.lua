-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydarkmm/agent/HolyDarkMMChallengeAgent.lua

module("logic.extensions.holydarkmm.agent.HolyDarkMMChallengeAgent", package.seeall)

local HolyDarkMMChallengeAgent = class("HolyDarkMMChallengeAgent", BaseAgent)

function HolyDarkMMChallengeAgent:sendPM_HolyDarkMMChallengeInfoReq(activityId)
	local req = HolyDarkMMChallengeExtension_pb.PM_HolyDarkMMChallengeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HolyDarkMMChallengeAgent:handlePM_HolyDarkMMChallengeInfoRes(status, msg)
	if status == 0 then
		HolyDarkMMController.instance:handlePM_HolyDarkMMChallengeInfoRes(status, msg)
	end
end

function HolyDarkMMChallengeAgent:sendPM_HolyDarkMMChallengeReq(activityId, stageId, form, formPlanId, angleId)
	local req = HolyDarkMMChallengeExtension_pb.PM_HolyDarkMMChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.formPlanId = formPlanId
	req.angleId = angleId

	self:sendMsg(req)
end

function HolyDarkMMChallengeAgent:handlePM_HolyDarkMMChallengeRes(status, msg)
	HolyDarkMMController.instance:handlePM_HolyDarkMMChallengeRes(status, msg)
end

function HolyDarkMMChallengeAgent:handlePM_NotifyHolyDarkMMChallengeEndRes(status, msg)
	if status == 0 then
		HolyDarkMMController.instance:handlePM_NotifyHolyDarkMMChallengeEndRes(status, msg)
	end
end

function HolyDarkMMChallengeAgent:sendPM_HolyDarkMMChallengeResetReq(activityId, stageId)
	local req = HolyDarkMMChallengeExtension_pb.PM_HolyDarkMMChallengeResetReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function HolyDarkMMChallengeAgent:handlePM_HolyDarkMMChallengeResetRes(status, msg)
	if status == 0 then
		HolyDarkMMController.instance:handlePM_HolyDarkMMChallengeResetRes(status, msg)
	end
end

HolyDarkMMChallengeAgent.instance = HolyDarkMMChallengeAgent.New()

return HolyDarkMMChallengeAgent
