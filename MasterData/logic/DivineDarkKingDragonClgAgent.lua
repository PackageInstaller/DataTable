-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedarkkingdragonclg/agent/DivineDarkKingDragonClgAgent.lua

module("logic.extensions.divinedarkkingdragonclg.agent.DivineDarkKingDragonClgAgent", package.seeall)

local DivineDarkKingDragonClgAgent = class("DivineDarkKingDragonClgAgent", BaseAgent)

function DivineDarkKingDragonClgAgent:sendPM_DivineDarkKingDragonClgInfoReq(activityId)
	local req = DivineDarkKingDragonClgExtension_pb.PM_DivineDarkKingDragonClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineDarkKingDragonClgAgent:handlePM_DivineDarkKingDragonClgInfoRes(status, msg)
	if status == 0 then
		DivineDarkKingDragonClgController.instance:handleGetInfo(msg)
	end
end

function DivineDarkKingDragonClgAgent:sendPM_DivineDarkKingDragonClgChallengeReq(activityId, phaseId, stageId, form_pb)
	local req = DivineDarkKingDragonClgExtension_pb.PM_DivineDarkKingDragonClgChallengeReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineDarkKingDragonClgAgent:handlePM_DivineDarkKingDragonClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineDarkKingDragonClgAgent:sendPM_DivineDarkKingDragonClgResetReq(activityId, phaseId)
	local req = DivineDarkKingDragonClgExtension_pb.PM_DivineDarkKingDragonClgResetReq()

	req.activityId = activityId
	req.phaseId = phaseId

	self:sendMsg(req)
end

function DivineDarkKingDragonClgAgent:handlePM_DivineDarkKingDragonClgResetRes(status, msg)
	if status == 0 then
		DivineDarkKingDragonClgController.instance:handleResetClg(msg)
	end
end

function DivineDarkKingDragonClgAgent:handlePM_NotifyDivineDarkKingDragonClgFinsihRes(status, msg)
	if status == 0 then
		DivineDarkKingDragonClgController.instance:handleNotifyClgFinish(msg)
	end
end

function DivineDarkKingDragonClgAgent:sendPM_DivineDarkKingDragonClgConfirmReq(activityId, phaseId, stageId, save)
	local req = DivineDarkKingDragonClgExtension_pb.PM_DivineDarkKingDragonClgConfirmReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId
	req.save = save

	self:sendMsg(req)
end

function DivineDarkKingDragonClgAgent:handlePM_DivineDarkKingDragonClgConfirmRes(status, msg)
	if status == 0 then
		DivineDarkKingDragonClgController.instance:handleConfirm(msg)
	end
end

DivineDarkKingDragonClgAgent.instance = DivineDarkKingDragonClgAgent.New()

return DivineDarkKingDragonClgAgent
