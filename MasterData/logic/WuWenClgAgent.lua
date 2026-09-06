-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/agent/WuWenClgAgent.lua

module("logic.extensions.wuwenclg.agent.WuWenClgAgent", package.seeall)

local WuWenClgAgent = class("WuWenClgAgent", BaseAgent)

function WuWenClgAgent:sendPM_WuWenClgGetInfoReq(activityId)
	local req = WuWenClgExtension_pb.PM_WuWenClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WuWenClgAgent:handlePM_WuWenClgGetInfoRes(status, msg)
	if status == 0 then
		WuWenChallengeController.instance:handlePM_WuWenClgGetInfoRes(msg)
	end
end

function WuWenClgAgent:sendPM_WuWenClgFightReq(activityId, stageId, form, buffIdUsed)
	local req = WuWenClgExtension_pb.PM_WuWenClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	for i, v in ipairs(buffIdUsed) do
		req.buffIdUsed:append(v)
	end

	self:sendMsg(req)
end

function WuWenClgAgent:handlePM_WuWenClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function WuWenClgAgent:handlePM_WuWenClgNotifyFightResultRes(status, msg)
	if status == 0 then
		WuWenChallengeController.instance:handlePM_WuWenClgNotifyFightResultRes(msg)
	end
end

function WuWenClgAgent:sendPM_WuWenClgFightConfirmReq(activityId, confirmNum, save)
	local req = WuWenClgExtension_pb.PM_WuWenClgFightConfirmReq()

	req.activityId = activityId
	req.confirmNum = confirmNum
	req.save = save

	self:sendMsg(req)
end

function WuWenClgAgent:handlePM_WuWenClgFightConfirmRes(status, msg)
	if status == 0 then
		WuWenChallengeController.instance:handlePM_WuWenClgFightConfirmRes(msg)
	end
end

function WuWenClgAgent:sendPM_WuWenClgResetPhaseReq(activityId)
	local req = WuWenClgExtension_pb.PM_WuWenClgResetPhaseReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WuWenClgAgent:handlePM_WuWenClgResetPhaseRes(status, msg)
	if status == 0 then
		WuWenChallengeController:handlePM_WuWenClgResetPhaseRes(msg)
	end
end

WuWenClgAgent.instance = WuWenClgAgent.New()

return WuWenClgAgent
