-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/agent/DivineInvincibleClgAgent.lua

module("logic.extensions.divineinvincibleclg.agent.DivineInvincibleClgAgent", package.seeall)

local DivineInvincibleClgAgent = class("DivineInvincibleClgAgent", BaseAgent)

function DivineInvincibleClgAgent:sendPM_DivineInvincibleClgExtremeInfoReq(activityId)
	local req = DivineInvincibleClgExtension_pb.PM_DivineInvincibleClgExtremeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineInvincibleClgAgent:handlePM_DivineInvincibleClgExtremeInfoRes(status, msg)
	if status == 0 then
		DivineInvincibleController.instance:handlePM_DivineInvincibleClgExtremeInfoRes(msg)
	end
end

function DivineInvincibleClgAgent:sendPM_DivineInvincibleClgExtremeFightReq(activityId, stageId, form)
	local req = DivineInvincibleClgExtension_pb.PM_DivineInvincibleClgExtremeFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineInvincibleClgAgent:handlePM_DivineInvincibleClgExtremeFightRes(status, msg)
	if status == 0 then
		DivineInvincibleController.instance:handlePM_DivineInvincibleClgExtremeFightRes(msg)
	end
end

function DivineInvincibleClgAgent:sendPM_DivineInvincibleClgExtremeConfirmReq(activityId, posId)
	local req = DivineInvincibleClgExtension_pb.PM_DivineInvincibleClgExtremeConfirmReq()

	req.activityId = activityId

	if posId then
		for _, v in ipairs(posId) do
			req.posId:append(v)
		end
	end

	self:sendMsg(req)
end

function DivineInvincibleClgAgent:handlePM_DivineInvincibleClgExtremeConfirmRes(status, msg)
	DivineInvincibleController.instance:handlePM_DivineInvincibleClgExtremeConfirmRes(status, msg)
end

function DivineInvincibleClgAgent:sendPM_DivineInvincibleClgExtremeResetReq(activityId)
	local req = DivineInvincibleClgExtension_pb.PM_DivineInvincibleClgExtremeResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineInvincibleClgAgent:handlePM_DivineInvincibleClgExtremeResetRes(status, msg)
	if status == 0 then
		DivineInvincibleController.instance:handlePM_DivineInvincibleClgExtremeResetRes(msg)
	end
end

function DivineInvincibleClgAgent:sendPM_DivineInvincibleClgNormalInfoReq(activityId)
	local req = DivineInvincibleClgExtension_pb.PM_DivineInvincibleClgNormalInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineInvincibleClgAgent:handlePM_DivineInvincibleClgNormalInfoRes(status, msg)
	if status == 0 then
		DivineInvincibleController.instance:handlePM_DivineInvincibleClgNormalInfoRes(msg)
	end
end

function DivineInvincibleClgAgent:sendPM_DivineInvincibleClgNormalFightReq(activityId, indexId, form)
	local req = DivineInvincibleClgExtension_pb.PM_DivineInvincibleClgNormalFightReq()

	req.activityId = activityId
	req.indexId = indexId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineInvincibleClgAgent:handlePM_DivineInvincibleClgNormalFightRes(status, msg)
	if status == 0 then
		DivineInvincibleController.instance:handlePM_DivineInvincibleClgNormalFightRes(msg)
	end
end

function DivineInvincibleClgAgent:sendPM_DivineInvincibleClgNormalGainPrizeReq(activityId, prizeId)
	local req = DivineInvincibleClgExtension_pb.PM_DivineInvincibleClgNormalGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DivineInvincibleClgAgent:handlePM_DivineInvincibleClgNormalGainPrizeRes(status, msg)
	if status == 0 then
		DivineInvincibleController.instance:handlePM_DivineInvincibleClgNormalGainPrizeRes(msg)
	end
end

function DivineInvincibleClgAgent:handlePM_NotifyDivineInvincibleClgExtremeFightResultRes(status, msg)
	if status == 0 then
		DivineInvincibleController.instance:handlePM_NotifyDivineInvincibleClgExtremeFightResultRes(msg)
	end
end

function DivineInvincibleClgAgent:handlePM_NotifyDivineInvincibleClgNormalFightResultRes(status, msg)
	if status == 0 then
		DivineInvincibleController.instance:handlePM_NotifyDivineInvincibleClgNormalFightResultRes(msg)
	end
end

DivineInvincibleClgAgent.instance = DivineInvincibleClgAgent.New()

return DivineInvincibleClgAgent
