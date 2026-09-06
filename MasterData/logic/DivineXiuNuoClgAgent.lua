-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiunuo/agent/DivineXiuNuoClgAgent.lua

module("logic.extensions.divinexiunuoclg.agent.DivineXiuNuoClgAgent", package.seeall)

local DivineXiuNuoClgAgent = class("DivineXiuNuoClgAgent", BaseAgent)

function DivineXiuNuoClgAgent:sendPM_DivineXiuNuoClgGetInfoReq(activityId)
	local req = DivineXiuNuoClgExtension_pb.PM_DivineXiuNuoClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineXiuNuoClgAgent:handlePM_DivineXiuNuoClgGetInfoRes(status, msg)
	if status == 0 then
		DivineXiuNuoController.instance:onGetInfo(msg)
	end
end

function DivineXiuNuoClgAgent:sendPM_DivineXiuNuoClgFightReq(activityId, stageId, form_pb)
	local req = DivineXiuNuoClgExtension_pb.PM_DivineXiuNuoClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineXiuNuoClgAgent:handlePM_DivineXiuNuoClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	else
		BattleFacade.instance:registerResultHandler(nil, nil)
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineXiuNuoClgAgent:handlePM_DivineXiuNuoClgNotifyFightResultRes(status, msg)
	if status == 0 then
		DivineXiuNuoController.instance:handleFightRes(msg)
	end
end

function DivineXiuNuoClgAgent:sendPM_DivineXiuNuoClgResetStageReq(activityId, stageId)
	local req = DivineXiuNuoClgExtension_pb.PM_DivineXiuNuoClgResetStageReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function DivineXiuNuoClgAgent:handlePM_DivineXiuNuoClgResetStageRes(status, msg)
	if status == 0 then
		DivineXiuNuoController.instance:onResetStage(msg)
	end
end

DivineXiuNuoClgAgent.instance = DivineXiuNuoClgAgent.New()

return DivineXiuNuoClgAgent
