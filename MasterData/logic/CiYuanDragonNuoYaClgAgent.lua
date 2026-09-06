-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanlonghuangnuoya/agent/CiYuanDragonNuoYaClgAgent.lua

module("logic.extensions.ciyuandragonnuoyaclg.agent.CiYuanDragonNuoYaClgAgent", package.seeall)

local CiYuanDragonNuoYaClgAgent = class("CiYuanDragonNuoYaClgAgent", BaseAgent)

function CiYuanDragonNuoYaClgAgent:sendPM_CiYuanDragonNuoYaClgGetInfoReq(activityId)
	local req = CiYuanDragonNuoYaClgExtension_pb.PM_CiYuanDragonNuoYaClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CiYuanDragonNuoYaClgAgent:handlePM_CiYuanDragonNuoYaClgGetInfoRes(status, msg)
	if status == 0 then
		CiyuanlonghuangnuoyaController.instance:onGetInfo(msg)
	end
end

function CiYuanDragonNuoYaClgAgent:sendPM_CiYuanDragonNuoYaClgFightReq(activityId, stageId, form_pb)
	local req = CiYuanDragonNuoYaClgExtension_pb.PM_CiYuanDragonNuoYaClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function CiYuanDragonNuoYaClgAgent:handlePM_CiYuanDragonNuoYaClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function CiYuanDragonNuoYaClgAgent:sendPM_CiYuanDragonNuoYaClgConfirmReq(activityId, confirmNum, save)
	local req = CiYuanDragonNuoYaClgExtension_pb.PM_CiYuanDragonNuoYaClgConfirmReq()

	req.activityId = activityId
	req.confirmNum = confirmNum
	req.save = save

	self:sendMsg(req)
end

function CiYuanDragonNuoYaClgAgent:handlePM_CiYuanDragonNuoYaClgConfirmRes(status, msg)
	if status == 0 then
		CiyuanlonghuangnuoyaController.instance:onConfirm(msg)
	end
end

function CiYuanDragonNuoYaClgAgent:sendPM_CiYuanDragonNuoYaClgResetStageReq(activityId, stageId)
	local req = CiYuanDragonNuoYaClgExtension_pb.PM_CiYuanDragonNuoYaClgResetStageReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function CiYuanDragonNuoYaClgAgent:handlePM_CiYuanDragonNuoYaClgResetStageRes(status, msg)
	if status == 0 then
		CiyuanlonghuangnuoyaController.instance:onResetStage(msg)
	end
end

function CiYuanDragonNuoYaClgAgent:handlePM_CiYuanDragonNuoYaClgNotifyFightResultRes(status, msg)
	if status == 0 then
		-- block empty
	end

	CiyuanlonghuangnuoyaController.instance:handleFightRes(msg)
end

CiYuanDragonNuoYaClgAgent.instance = CiYuanDragonNuoYaClgAgent.New()

return CiYuanDragonNuoYaClgAgent
