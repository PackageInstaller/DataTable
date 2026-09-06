-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/agent/MiracleNuoYaClgAgent.lua

module("logic.extensions.miraclenuoyaclg.agent.MiracleNuoYaClgAgent", package.seeall)

local MiracleNuoYaClgAgent = class("MiracleNuoYaClgAgent", BaseAgent)

function MiracleNuoYaClgAgent:ctor()
	return
end

function MiracleNuoYaClgAgent:setExtId(extId)
	MiracleNuoYaClgAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function MiracleNuoYaClgAgent:sendPM_MiracleNuoYaClgGetInfoReq(activityId)
	local req = MiracleNuoYaClgExtension_pb.PM_MiracleNuoYaClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MiracleNuoYaClgAgent:handlePM_MiracleNuoYaClgGetInfoRes(status, msg)
	if status == 0 then
		MiracleNuoyaController.instance:onGetInfo(msg)
	end
end

function MiracleNuoYaClgAgent:sendPM_MiracleNuoYaExtremeClgReq(activityId, blockId, form_pb)
	local req = MiracleNuoYaClgExtension_pb.PM_MiracleNuoYaExtremeClgReq()

	req.activityId = activityId
	req.blockId = blockId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function MiracleNuoYaClgAgent:handlePM_MiracleNuoYaExtremeClgRes(status, msg)
	if status == 0 then
		-- block empty
	else
		BattleFacade.instance:registerResultHandler(nil, nil)
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function MiracleNuoYaClgAgent:sendPM_MiracleNuoYaExtremeClgConfirmReq(activityId, confirmNum, save)
	local req = MiracleNuoYaClgExtension_pb.PM_MiracleNuoYaExtremeClgConfirmReq()

	req.activityId = activityId
	req.confirmNum = confirmNum
	req.save = save

	self:sendMsg(req)
end

function MiracleNuoYaClgAgent:handlePM_MiracleNuoYaExtremeClgConfirmRes(status, msg)
	MiracleNuoyaController.instance:onConfirmExtre(status, msg)
end

function MiracleNuoYaClgAgent:sendPM_MiracleNuoYaResetExtremeClgReq(activityId)
	local req = MiracleNuoYaClgExtension_pb.PM_MiracleNuoYaResetExtremeClgReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MiracleNuoYaClgAgent:handlePM_MiracleNuoYaResetExtremeClgRes(status, msg)
	if status == 0 then
		MiracleNuoyaController.instance:onResetExtre(msg)
	end
end

function MiracleNuoYaClgAgent:sendPM_MiracleNuoYaNormalClgReq(activityId, form_pb)
	local req = MiracleNuoYaClgExtension_pb.PM_MiracleNuoYaNormalClgReq()

	req.activityId = activityId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function MiracleNuoYaClgAgent:handlePM_MiracleNuoYaNormalClgRes(status, msg)
	if status == 0 then
		-- block empty
	else
		BattleFacade.instance:registerResultHandler(nil, nil)
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function MiracleNuoYaClgAgent:sendPM_MiracleNuoYaGainNormalClgProgressPrizeReq(activityId, dataBitId)
	local req = MiracleNuoYaClgExtension_pb.PM_MiracleNuoYaGainNormalClgProgressPrizeReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	self:sendMsg(req)
end

function MiracleNuoYaClgAgent:handlePM_MiracleNuoYaGainNormalClgProgressPrizeRes(status, msg)
	if status == 0 then
		MiracleNuoyaController.instance:onGetProgressPrize(msg)
	end
end

function MiracleNuoYaClgAgent:handlePM_MiracleNuoYaNotifyExtremeClgResultRes(status, msg)
	MiracleNuoyaModel.instance:updateExtFightEnd(msg)
end

function MiracleNuoYaClgAgent:handlePM_MiracleNuoYaNotifyNormalClgClgResultRes(status, msg)
	MiracleNuoyaModel.instance:updateNorFightEnd(msg)
end

MiracleNuoYaClgAgent.instance = MiracleNuoYaClgAgent.New()

return MiracleNuoYaClgAgent
