-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/agent/WuDiChallengeAgent.lua

module("logic.extensions.wudiclg.agent.WuDiChallengeAgent", package.seeall)

local WuDiChallengeAgent = class("WuDiChallengeAgent", BaseAgent)

function WuDiChallengeAgent:sendPM_WuDiClgGetInfoReq(activityId)
	local req = WuDiChallengeExtension_pb.PM_WuDiClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WuDiChallengeAgent:handlePM_WuDiClgGetInfoRes(status, msg)
	if status == 0 then
		WuDiClgController.instance:handlePM_WuDiClgGetInfoRes(msg)
	end
end

function WuDiChallengeAgent:sendPM_WuDiClgExtremeFightReq(activityId, stageId, form)
	local req = WuDiChallengeExtension_pb.PM_WuDiClgExtremeFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function WuDiChallengeAgent:handlePM_WuDiClgExtremeFightRes(status, msg)
	WuDiClgController.instance:handlePM_WuDiClgExtremeFightRes(status, msg)
end

function WuDiChallengeAgent:sendPM_WuDiClgExtremeFightConfirmReq(activityId, confirmNum, save)
	local req = WuDiChallengeExtension_pb.PM_WuDiClgExtremeFightConfirmReq()

	req.activityId = activityId
	req.confirmNum = confirmNum
	req.save = save

	self:sendMsg(req)
end

function WuDiChallengeAgent:handlePM_WuDiClgExtremeFightConfirmRes(status, msg)
	WuDiClgController.instance:handlePM_WuDiClgExtremeFightConfirmRes(status, msg)
end

function WuDiChallengeAgent:sendPM_WuDiClgResetExtremeClgReq(activityId)
	local req = WuDiChallengeExtension_pb.PM_WuDiClgResetExtremeClgReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WuDiChallengeAgent:handlePM_WuDiClgResetExtremeClgRes(status, msg)
	if status == 0 then
		WuDiClgController.instance:handlePM_WuDiClgResetExtremeClgRes(msg)
	end
end

function WuDiChallengeAgent:sendPM_WuDiClgGainExtremePrizeReq(activityId)
	local req = WuDiChallengeExtension_pb.PM_WuDiClgGainExtremePrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WuDiChallengeAgent:handlePM_WuDiClgGainExtremePrizeRes(status, msg)
	if status == 0 then
		WuDiClgController.instance:handlePM_WuDiClgGainExtremePrizeRes(msg)
	end
end

function WuDiChallengeAgent:sendPM_WuDiClgNormalFightReq(activityId, dataBitId, form)
	local req = WuDiChallengeExtension_pb.PM_WuDiClgNormalFightReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function WuDiChallengeAgent:handlePM_WuDiClgNormalFightRes(status, msg)
	WuDiClgController.instance:handlePM_WuDiClgNormalFightRes(status, msg)
end

function WuDiChallengeAgent:sendPM_WuDiClgGainNormalProgressPrizeReq(activityId, dataBitId)
	local req = WuDiChallengeExtension_pb.PM_WuDiClgGainNormalProgressPrizeReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	self:sendMsg(req)
end

function WuDiChallengeAgent:handlePM_WuDiClgGainNormalProgressPrizeRes(status, msg)
	if status == 0 then
		WuDiClgController.instance:handlePM_WuDiClgGainNormalProgressPrizeRes(msg)
	end
end

function WuDiChallengeAgent:handlePM_WuDiClgNotifyExtremeFightResultRes(status, msg)
	if status == 0 then
		WuDiClgController.instance:handlePM_WuDiClgNotifyExtremeFightResultRes(msg)
	end
end

function WuDiChallengeAgent:handlePM_WuDiClgNotifyNormalFightResultRes(status, msg)
	if status == 0 then
		WuDiClgController.instance:handlePM_WuDiClgNotifyNormalFightResultRes(msg)
	end
end

WuDiChallengeAgent.instance = WuDiChallengeAgent.New()

return WuDiChallengeAgent
