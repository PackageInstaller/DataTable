-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/agent/DivineZhongFeiClgAgent.lua

module("logic.extensions.divinezhongfeiclg.agent.DivineZhongFeiClgAgent", package.seeall)

local DivineZhongFeiClgAgent = class("DivineZhongFeiClgAgent", BaseAgent)

function DivineZhongFeiClgAgent:sendPM_DivineZhongFeiClgExtremeInfoReq(activityId)
	local req = DivineZhongFeiClgExtension_pb.PM_DivineZhongFeiClgExtremeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineZhongFeiClgAgent:handlePM_DivineZhongFeiClgExtremeInfoRes(status, msg)
	if status == 0 then
		DivineZhongFeiClgController.instance:handlePM_DivineZhongFeiClgExtremeInfoRes(msg)
	end
end

function DivineZhongFeiClgAgent:sendPM_DivineZhongFeiClgExtremeChallengeReq(activityId, stageId, form)
	local req = DivineZhongFeiClgExtension_pb.PM_DivineZhongFeiClgExtremeChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineZhongFeiClgAgent:handlePM_DivineZhongFeiClgExtremeChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineZhongFeiClgAgent:handlePM_NotifyDivineZhongFeiClgExtremeFinishRes(status, msg)
	if status == 0 then
		DivineZhongFeiClgController.instance:handlePM_NotifyDivineZhongFeiClgExtremeFinishRes(msg)
	end
end

function DivineZhongFeiClgAgent:sendPM_DivineZhongFeiClgExtremeConfirmReq(activityId, stageId, save)
	local req = DivineZhongFeiClgExtension_pb.PM_DivineZhongFeiClgExtremeConfirmReq()

	req.activityId = activityId
	req.stageId = stageId
	req.save = save

	self:sendMsg(req)
end

function DivineZhongFeiClgAgent:handlePM_DivineZhongFeiClgExtremeConfirmRes(status, msg)
	if status == 0 then
		DivineZhongFeiClgController.instance:handlePM_DivineZhongFeiClgExtremeConfirmRes(msg)
	end
end

function DivineZhongFeiClgAgent:sendPM_DivineZhongFeiClgExtremeResetReq(activityId)
	local req = DivineZhongFeiClgExtension_pb.PM_DivineZhongFeiClgExtremeResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineZhongFeiClgAgent:handlePM_DivineZhongFeiClgExtremeResetRes(status, msg)
	if status == 0 then
		DivineZhongFeiClgController.instance:handlePM_DivineZhongFeiClgExtremeResetRes(msg)
	end
end

function DivineZhongFeiClgAgent:sendPM_DivineZhongFeiClgNormalInfoReq(activityId)
	local req = DivineZhongFeiClgExtension_pb.PM_DivineZhongFeiClgNormalInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineZhongFeiClgAgent:handlePM_DivineZhongFeiClgNormalInfoRes(status, msg)
	if status == 0 then
		DivineZhongFeiClgController.instance:handlePM_DivineZhongFeiClgNormalInfoRes(msg)
	end
end

function DivineZhongFeiClgAgent:sendPM_DivineZhongFeiClgNormalChallengeReq(activityId, form)
	local req = DivineZhongFeiClgExtension_pb.PM_DivineZhongFeiClgNormalChallengeReq()

	req.activityId = activityId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineZhongFeiClgAgent:handlePM_DivineZhongFeiClgNormalChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineZhongFeiClgAgent:handlePM_NotifyDivineZhongFeiClgNormalFinishRes(status, msg)
	if status == 0 then
		DivineZhongFeiClgController.instance:handlePM_NotifyDivineZhongFeiClgNormalFinishRes(msg)
	end
end

function DivineZhongFeiClgAgent:sendPM_DivineZhongFeiClgNormalGainPrizeReq(activityId, prizeId)
	local req = DivineZhongFeiClgExtension_pb.PM_DivineZhongFeiClgNormalGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DivineZhongFeiClgAgent:handlePM_DivineZhongFeiClgNormalGainPrizeRes(status, msg)
	if status == 0 then
		DivineZhongFeiClgController.instance:handlePM_DivineZhongFeiClgNormalGainPrizeRes(msg)
	end
end

DivineZhongFeiClgAgent.instance = DivineZhongFeiClgAgent.New()

return DivineZhongFeiClgAgent
