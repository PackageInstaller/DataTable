-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zdlverify/agent/ZdlVerifyAgent.lua

module("logic.extensions.zdlverify.agent.ZdlVerifyAgent", package.seeall)

local ZdlVerifyAgent = class("ZdlVerifyAgent", BaseAgent)

function ZdlVerifyAgent:sendPM_ZdlVerifyInfoReq(activityId)
	local req = ZdlVerifyExtension_pb.PM_ZdlVerifyInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ZdlVerifyAgent:handlePM_ZdlVerifyInfoRes(status, msg)
	if status == 0 then
		ZdlVerifyController.instance:handlePM_ZdlVerifyInfoRes(msg)
	end
end

function ZdlVerifyAgent:sendPM_ZdlVerifyVerifyRaceReq(activityId, verifyId, petId)
	local req = ZdlVerifyExtension_pb.PM_ZdlVerifyVerifyRaceReq()

	req.activityId = activityId
	req.verifyId = verifyId
	req.petId = petId

	self:sendMsg(req)
end

function ZdlVerifyAgent:handlePM_ZdlVerifyVerifyRaceRes(status, msg)
	if status == 0 then
		ZdlVerifyController.instance:handlePM_ZdlVerifyVerifyRaceRes(msg)
	end
end

function ZdlVerifyAgent:sendPM_ZdlVerifyGainProgressReq(activityId, progressId)
	local req = ZdlVerifyExtension_pb.PM_ZdlVerifyGainProgressReq()

	req.activityId = activityId
	req.progressId = progressId

	self:sendMsg(req)
end

function ZdlVerifyAgent:handlePM_ZdlVerifyGainProgressRes(status, msg)
	if status == 0 then
		ZdlVerifyController.instance:handlePM_ZdlVerifyGainProgressRes(msg)
	end
end

ZdlVerifyAgent.instance = ZdlVerifyAgent.New()

return ZdlVerifyAgent
