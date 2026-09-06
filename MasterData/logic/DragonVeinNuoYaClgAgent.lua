-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonveinnuoyaclg/agent/DragonVeinNuoYaClgAgent.lua

module("logic.extensions.dragonveinnuoyaclg.agent.DragonVeinNuoYaClgAgent", package.seeall)

local DragonVeinNuoYaClgAgent = class("DragonVeinNuoYaClgAgent", BaseAgent)

function DragonVeinNuoYaClgAgent:sendPM_DragonVeinNuoYaClgGetInfoReq(activityId)
	local req = DragonVeinNuoYaClgExtension_pb.PM_DragonVeinNuoYaClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DragonVeinNuoYaClgAgent:handlePM_DragonVeinNuoYaClgGetInfoRes(status, msg)
	if status == 0 then
		DragonVeinNuoYaClgController.instance:handlePM_DragonVeinNuoYaClgGetInfoRes(msg)
	end
end

function DragonVeinNuoYaClgAgent:sendPM_DragonVeinNuoYaClgDigReq(activityId, gridId)
	local req = DragonVeinNuoYaClgExtension_pb.PM_DragonVeinNuoYaClgDigReq()

	req.activityId = activityId
	req.gridId = gridId

	self:sendMsg(req)
end

function DragonVeinNuoYaClgAgent:handlePM_DragonVeinNuoYaClgDigRes(status, msg)
	if status == 0 then
		DragonVeinNuoYaClgController.instance:handlePM_DragonVeinNuoYaClgDigRes(msg)
	end
end

function DragonVeinNuoYaClgAgent:sendPM_DragonVeinNuoYaClgFightReq(activityId, gridId, form)
	local req = DragonVeinNuoYaClgExtension_pb.PM_DragonVeinNuoYaClgFightReq()

	req.activityId = activityId
	req.gridId = gridId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DragonVeinNuoYaClgAgent:handlePM_DragonVeinNuoYaClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DragonVeinNuoYaClgAgent:handlePM_DragonVeinNuoYaClgNotifyFightResultRes(status, msg)
	if status == 0 then
		DragonVeinNuoYaClgController.instance:handlePM_DragonVeinNuoYaClgNotifyFightResultRes(msg)
	end
end

function DragonVeinNuoYaClgAgent:sendPM_DragonVeinNuoYaClgGainBoxReq(activityId, gridId)
	local req = DragonVeinNuoYaClgExtension_pb.PM_DragonVeinNuoYaClgGainBoxReq()

	req.activityId = activityId
	req.gridId = gridId

	self:sendMsg(req)
end

function DragonVeinNuoYaClgAgent:handlePM_DragonVeinNuoYaClgGainBoxRes(status, msg)
	if status == 0 then
		DragonVeinNuoYaClgController.instance:handlePM_DragonVeinNuoYaClgGainBoxRes(msg)
	end
end

function DragonVeinNuoYaClgAgent:sendPM_DragonVeinNuoYaClgJump2NextStageReq(activityId)
	local req = DragonVeinNuoYaClgExtension_pb.PM_DragonVeinNuoYaClgJump2NextStageReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DragonVeinNuoYaClgAgent:handlePM_DragonVeinNuoYaClgJump2NextStageRes(status, msg)
	if status == 0 then
		DragonVeinNuoYaClgController.instance:handlePM_DragonVeinNuoYaClgJump2NextStageRes(msg)
	end
end

DragonVeinNuoYaClgAgent.instance = DragonVeinNuoYaClgAgent.New()

return DragonVeinNuoYaClgAgent
