-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/agent/DivineWeiLeiTaClgAgent.lua

module("logic.extensions.divineweileitaclg.agent.DivineWeiLeiTaClgAgent", package.seeall)

local DivineWeiLeiTaClgAgent = class("DivineWeiLeiTaClgAgent", BaseAgent)

function DivineWeiLeiTaClgAgent:sendPM_DivineWeiLeiTaClgNormalInfoReq(activityId)
	local req = DivineWeiLeiTaClgExtension_pb.PM_DivineWeiLeiTaClgNormalInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineWeiLeiTaClgAgent:handlePM_DivineWeiLeiTaClgNormalInfoRes(status, msg)
	if status == 0 then
		DivineWeiLeiTaClgController.instance:handlePM_DivineWeiLeiTaClgNormalInfoRes(msg)
	end
end

function DivineWeiLeiTaClgAgent:sendPM_DivineWeiLeiTaClgNormalChallengeReq(activityId, form)
	local req = DivineWeiLeiTaClgExtension_pb.PM_DivineWeiLeiTaClgNormalChallengeReq()

	req.activityId = activityId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineWeiLeiTaClgAgent:handlePM_DivineWeiLeiTaClgNormalChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineWeiLeiTaClgAgent:sendPM_DivineWeiLeiTaClgGainPrizeReq(activityId, prizeId)
	local req = DivineWeiLeiTaClgExtension_pb.PM_DivineWeiLeiTaClgGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DivineWeiLeiTaClgAgent:handlePM_DivineWeiLeiTaClgGainPrizeRes(status, msg)
	if status == 0 then
		DivineWeiLeiTaClgController.instance:handlePM_DivineWeiLeiTaClgGainPrizeRes(msg)
	end
end

function DivineWeiLeiTaClgAgent:sendPM_DivineWeiLeiTaClgExtremeInfoReq(activityId)
	local req = DivineWeiLeiTaClgExtension_pb.PM_DivineWeiLeiTaClgExtremeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineWeiLeiTaClgAgent:handlePM_DivineWeiLeiTaClgExtremeInfoRes(status, msg)
	if status == 0 then
		DivineWeiLeiTaClgController.instance:handlePM_DivineWeiLeiTaClgExtremeInfoRes(msg)
	end
end

function DivineWeiLeiTaClgAgent:sendPM_DivineWeiLeiTaClgExtremeChallengeReq(activityId, stageId, form)
	local req = DivineWeiLeiTaClgExtension_pb.PM_DivineWeiLeiTaClgExtremeChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineWeiLeiTaClgAgent:handlePM_DivineWeiLeiTaClgExtremeChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineWeiLeiTaClgAgent:sendPM_DivineWeiLeiTaClgExtremeConfirmReq(activityId, save)
	local req = DivineWeiLeiTaClgExtension_pb.PM_DivineWeiLeiTaClgExtremeConfirmReq()

	req.activityId = activityId
	req.save = save

	self:sendMsg(req)
end

function DivineWeiLeiTaClgAgent:handlePM_DivineWeiLeiTaClgExtremeConfirmRes(status, msg)
	if status == 0 then
		DivineWeiLeiTaClgController.instance:handlePM_DivineWeiLeiTaClgExtremeConfirmRes(msg)
	end
end

function DivineWeiLeiTaClgAgent:sendPM_DivineWeiLeiTaClgExtremeResetReq(activityId)
	local req = DivineWeiLeiTaClgExtension_pb.PM_DivineWeiLeiTaClgExtremeResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineWeiLeiTaClgAgent:handlePM_DivineWeiLeiTaClgExtremeResetRes(status, msg)
	if status == 0 then
		DivineWeiLeiTaClgController.instance:handlePM_DivineWeiLeiTaClgExtremeResetRes(msg)
	end
end

function DivineWeiLeiTaClgAgent:handlePM_NotifyDivineWeiLeiTaNormalClgFinishRes(status, msg)
	if status == 0 then
		DivineWeiLeiTaClgController.instance:handlePM_NotifyDivineWeiLeiTaNormalClgFinishRes(msg)
	end
end

function DivineWeiLeiTaClgAgent:handlePM_NotifyDivineWeiLeiTaExtremeClgFinishRes(status, msg)
	if status == 0 then
		DivineWeiLeiTaClgController.instance:handlePM_NotifyDivineWeiLeiTaExtremeClgFinishRes(msg)
	end
end

DivineWeiLeiTaClgAgent.instance = DivineWeiLeiTaClgAgent.New()

return DivineWeiLeiTaClgAgent
