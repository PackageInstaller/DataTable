-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origineternaldragonclg/agent/OriginEternalDragonClgAgent.lua

module("logic.extensions.origineternaldragonclg.agent.OriginEternalDragonClgAgent", package.seeall)

local OriginEternalDragonClgAgent = class("OriginEternalDragonClgAgent", BaseAgent)

function OriginEternalDragonClgAgent:sendPM_OriginEternalDragonClgGetInfoReq(activityId)
	local req = OriginEternalDragonClgExtension_pb.PM_OriginEternalDragonClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginEternalDragonClgAgent:handlePM_OriginEternalDragonClgGetInfoRes(status, msg)
	if status == 0 then
		OriginEternalDragonClgController.instance:handlePM_OriginEternalDragonClgGetInfoRes(msg)
	end
end

function OriginEternalDragonClgAgent:sendPM_OriginEternalDragonClgFightReq(activityId, type, stageId, form)
	local req = OriginEternalDragonClgExtension_pb.PM_OriginEternalDragonClgFightReq()

	req.activityId = activityId
	req.type = type
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginEternalDragonClgAgent:handlePM_OriginEternalDragonClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginEternalDragonClgAgent:handlePM_OriginEternalDragonClgFightNotifyRes(status, msg)
	if status == 0 then
		OriginEternalDragonClgController.instance:handlePM_OriginEternalDragonClgFightNotifyRes(msg)
	end
end

function OriginEternalDragonClgAgent:sendPM_OriginEternalDragonClgUnlockComboReq(activityId, comboId)
	local req = OriginEternalDragonClgExtension_pb.PM_OriginEternalDragonClgUnlockComboReq()

	req.activityId = activityId
	req.comboId = comboId

	self:sendMsg(req)
end

function OriginEternalDragonClgAgent:handlePM_OriginEternalDragonClgUnlockComboRes(status, msg)
	if status == 0 then
		OriginEternalDragonClgController.instance:handlePM_OriginEternalDragonClgUnlockComboRes(msg)
	end
end

function OriginEternalDragonClgAgent:sendPM_OriginEternalDragonClgResetReq(activityId)
	local req = OriginEternalDragonClgExtension_pb.PM_OriginEternalDragonClgResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginEternalDragonClgAgent:handlePM_OriginEternalDragonClgResetRes(status, msg)
	if status == 0 then
		OriginEternalDragonClgController.instance:handlePM_OriginEternalDragonClgResetRes(msg)
	end
end

OriginEternalDragonClgAgent.instance = OriginEternalDragonClgAgent.New()

return OriginEternalDragonClgAgent
