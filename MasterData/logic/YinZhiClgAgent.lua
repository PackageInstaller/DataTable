-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yinzhiclg/agent/YinZhiClgAgent.lua

module("logic.extensions.yinzhiclg.agent.YinZhiClgAgent", package.seeall)

local YinZhiClgAgent = class("YinZhiClgAgent", BaseAgent)

function YinZhiClgAgent:sendPM_YinZhiClgInfoReq(activityId)
	local req = YinZhiClgExtension_pb.PM_YinZhiClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function YinZhiClgAgent:handlePM_YinZhiClgInfoRes(status, msg)
	if status == 0 then
		YinZhiClgController.instance:handleGetInfo(msg)
	end
end

function YinZhiClgAgent:sendPM_YinZhiClgResetReq(activityId)
	local req = YinZhiClgExtension_pb.PM_YinZhiClgResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function YinZhiClgAgent:handlePM_YinZhiClgResetRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function YinZhiClgAgent:sendPM_YinZhiClgChallengeReq(activityId, phaseId, stageId, form_pb)
	local req = YinZhiClgExtension_pb.PM_YinZhiClgChallengeReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function YinZhiClgAgent:handlePM_YinZhiClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function YinZhiClgAgent:sendPM_YinZhiClgConfirmReq(activityId, save)
	local req = YinZhiClgExtension_pb.PM_YinZhiClgConfirmReq()

	req.activityId = activityId
	req.save = save

	self:sendMsg(req)
end

function YinZhiClgAgent:handlePM_YinZhiClgConfirmRes(status, msg)
	if status == 0 then
		YinZhiClgController.instance:handleConfirmResult(msg)
	end
end

function YinZhiClgAgent:handlePM_NotifyYinZhiClgChallengeFinshRes(status, msg)
	if status == 0 then
		YinZhiClgController.instance:handleNotifyClgFinish(msg)
	end
end

YinZhiClgAgent.instance = YinZhiClgAgent.New()

return YinZhiClgAgent
