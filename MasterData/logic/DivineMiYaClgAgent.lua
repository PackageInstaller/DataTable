-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiyaclg/agent/DivineMiYaClgAgent.lua

module("logic.extensions.divinemiyaclg.agent.DivineMiYaClgAgent", package.seeall)

local DivineMiYaClgAgent = class("DivineMiYaClgAgent", BaseAgent)

function DivineMiYaClgAgent:sendPM_DivineMiYaClgGetInfoReq(activityId)
	local req = DivineMiYaClgExtension_pb.PM_DivineMiYaClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineMiYaClgAgent:handlePM_DivineMiYaClgGetInfoRes(status, msg)
	if status == 0 then
		DivineMiyaClgController.instance:handlePM_DivineMiYaClgGetInfoRes(msg)
	end
end

function DivineMiYaClgAgent:sendPM_DivineMiYaClgFightReq(activityId, form)
	local req = DivineMiYaClgExtension_pb.PM_DivineMiYaClgFightReq()

	req.activityId = activityId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineMiYaClgAgent:handlePM_DivineMiYaClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineMiYaClgAgent:handlePM_DivineMiYaClgNotifyFightResultRes(status, msg)
	if status == 0 then
		DivineMiyaClgController.instance:handlePM_DivineMiYaClgNotifyFightResultRes(msg)
	end
end

function DivineMiYaClgAgent:sendPM_DivineMiYaClgSwitchStageReq(activityId, targetStageId)
	local req = DivineMiYaClgExtension_pb.PM_DivineMiYaClgSwitchStageReq()

	req.activityId = activityId
	req.targetStageId = targetStageId

	self:sendMsg(req)
end

function DivineMiYaClgAgent:handlePM_DivineMiYaClgSwitchStageRes(status, msg)
	if status == 0 then
		DivineMiyaClgController.instance:handlePM_DivineMiYaClgSwitchStageRes(msg)
	end
end

function DivineMiYaClgAgent:sendPM_DivineMiYaClgReset2StageReq(activityId, targetStageId)
	local req = DivineMiYaClgExtension_pb.PM_DivineMiYaClgReset2StageReq()

	req.activityId = activityId
	req.targetStageId = targetStageId

	self:sendMsg(req)
end

function DivineMiYaClgAgent:handlePM_DivineMiYaClgReset2StageRes(status, msg)
	if status == 0 then
		DivineMiyaClgController.instance:handlePM_DivineMiYaClgReset2StageRes(msg)
	end
end

function DivineMiYaClgAgent:sendPM_DivineMiYaClgGainProgressPrizeReq(activityId, dataBitId)
	local req = DivineMiYaClgExtension_pb.PM_DivineMiYaClgGainProgressPrizeReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	self:sendMsg(req)
end

function DivineMiYaClgAgent:handlePM_DivineMiYaClgGainProgressPrizeRes(status, msg)
	if status == 0 then
		DivineMiyaClgController.instance:handlePM_DivineMiYaClgGainProgressPrizeRes(msg)
	end
end

DivineMiYaClgAgent.instance = DivineMiYaClgAgent.New()

return DivineMiYaClgAgent
