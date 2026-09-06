-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/agent/NuoYaSisterClgAgent.lua

module("logic.extensions.nuoyasisterclg.agent.NuoYaSisterClgAgent", package.seeall)

local NuoYaSisterClgAgent = class("NuoYaSisterClgAgent", BaseAgent)

function NuoYaSisterClgAgent:sendPM_NuoYaSisterExtremeClgInfoReq(activityId)
	local req = NuoYaSisterClgExtension_pb.PM_NuoYaSisterExtremeClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function NuoYaSisterClgAgent:handlePM_NuoYaSisterExtremeClgInfoRes(status, msg)
	if status == 0 then
		NuoYaSisterClgController.instance:handlePM_NuoYaSisterExtremeClgInfoRes(msg)
	end
end

function NuoYaSisterClgAgent:sendPM_NuoYaSisterExtremeClgSeletPetReq(activityId, selects)
	local req = NuoYaSisterClgExtension_pb.PM_NuoYaSisterExtremeClgSeletPetReq()

	req.activityId = activityId

	for i, v1 in ipairs(selects) do
		local select = req.selects:add()

		select:ParseFromString(v1:SerializeToString())
	end

	self:sendMsg(req)
end

function NuoYaSisterClgAgent:handlePM_NuoYaSisterExtremeClgSeletPetRes(status, msg)
	if status == 0 then
		NuoYaSisterClgController.instance:handlePM_NuoYaSisterExtremeClgSeletPetRes(msg)
	end
end

function NuoYaSisterClgAgent:sendPM_NuoYaSisterExtremeClgReq(activityId, stageId, typeId, simpleForm)
	local req = NuoYaSisterClgExtension_pb.PM_NuoYaSisterExtremeClgReq()

	req.activityId = activityId
	req.stageId = stageId
	req.typeId = typeId

	if simpleForm ~= nil then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function NuoYaSisterClgAgent:handlePM_NuoYaSisterExtremeClgRes(status, msg)
	if status == 0 then
		NuoYaSisterClgController.instance:handlePM_NuoYaSisterExtremeClgRes(msg)
	end
end

function NuoYaSisterClgAgent:sendPM_NuoYaSisterExtremeClgResetReq(activityId)
	local req = NuoYaSisterClgExtension_pb.PM_NuoYaSisterExtremeClgResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function NuoYaSisterClgAgent:handlePM_NuoYaSisterExtremeClgResetRes(status, msg)
	if status == 0 then
		NuoYaSisterClgController.instance:handlePM_NuoYaSisterExtremeClgResetRes(msg)
	end
end

function NuoYaSisterClgAgent:sendPM_NuoYaSisterCommonClgInfoReq(activityId)
	local req = NuoYaSisterClgExtension_pb.PM_NuoYaSisterCommonClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function NuoYaSisterClgAgent:handlePM_NuoYaSisterCommonClgInfoRes(status, msg)
	if status == 0 then
		NuoYaSisterClgController.instance:handlePM_NuoYaSisterCommonClgInfoRes(msg)
	end
end

function NuoYaSisterClgAgent:sendPM_NuoYaSisterCommonClgReq(activityId, bossId, simpleForm)
	local req = NuoYaSisterClgExtension_pb.PM_NuoYaSisterCommonClgReq()

	req.activityId = activityId
	req.bossId = bossId

	if simpleForm ~= nil then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function NuoYaSisterClgAgent:handlePM_NuoYaSisterCommonClgRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function NuoYaSisterClgAgent:handlePM_NotifyNuoYaSisterCommonClgFinishRes(status, msg)
	if status == 0 then
		NuoYaSisterClgController.instance:handlePM_NotifyNuoYaSisterCommonClgFinishRes(msg)
	end
end

function NuoYaSisterClgAgent:sendPM_NuoYaSisterCommonClgGainPrizeReq(activityId, prizeId)
	local req = NuoYaSisterClgExtension_pb.PM_NuoYaSisterCommonClgGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function NuoYaSisterClgAgent:handlePM_NuoYaSisterCommonClgGainPrizeRes(status, msg)
	if status == 0 then
		NuoYaSisterClgController.instance:handlePM_NuoYaSisterCommonClgGainPrizeRes(msg)
	end
end

function NuoYaSisterClgAgent:handlePM_NotifyNuoYaSisterExtremeClgFinishRes(status, msg)
	if status == 0 then
		NuoYaSisterClgController.instance:handlePM_NotifyNuoYaSisterExtremeClgFinishRes(msg)
	end
end

function NuoYaSisterClgAgent:sendPM_NuoYaSisterExtremeClgResultConfirmReq(activityId, stageId, typeId, confirm)
	local req = NuoYaSisterClgExtension_pb.PM_NuoYaSisterExtremeClgResultConfirmReq()

	req.activityId = activityId
	req.stageId = stageId
	req.typeId = typeId
	req.confirm = confirm

	self:sendMsg(req)
end

function NuoYaSisterClgAgent:handlePM_NuoYaSisterExtremeClgResultConfirmRes(status, msg)
	NuoYaSisterClgController.instance:handlePM_NuoYaSisterExtremeClgResultConfirmRes(status, msg)
end

NuoYaSisterClgAgent.instance = NuoYaSisterClgAgent.New()

return NuoYaSisterClgAgent
