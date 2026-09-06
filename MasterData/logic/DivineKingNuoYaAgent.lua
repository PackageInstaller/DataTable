-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingnuoya/agent/DivineKingNuoYaAgent.lua

module("logic.extensions.divinekingnuoya.agent.DivineKingNuoYaAgent", package.seeall)

local DivineKingNuoYaAgent = class("DivineKingNuoYaAgent", BaseAgent)

function DivineKingNuoYaAgent:sendPM_DivineKingNoahClgGetInfoReq(activityId)
	local req = DivineKingNoahClgExtension_pb.PM_DivineKingNoahClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineKingNuoYaAgent:handlePM_DivineKingNoahClgGetInfoRes(status, msg)
	if status == 0 then
		DivineKingNuoYaController.instance:handlePM_DivineKingNoahClgGetInfoRes(msg)
	end
end

function DivineKingNuoYaAgent:sendPM_DivineKingNoahClgSetBanItemsReq(activityId, banItemPosIds)
	local req = DivineKingNoahClgExtension_pb.PM_DivineKingNoahClgSetBanItemsReq()

	req.activityId = activityId

	for i, id in ipairs(banItemPosIds) do
		req.banItemPosIds:append(id)
	end

	self:sendMsg(req)
end

function DivineKingNuoYaAgent:handlePM_DivineKingNoahClgSetBanItemsRes(status, msg)
	if status == 0 then
		DivineKingNuoYaController.instance:handlePM_DivineKingNoahClgSetBanItemsRes(msg)
	end
end

function DivineKingNuoYaAgent:sendPM_DivineKingNoahClgFightReq(activityId, stageId, form)
	local req = DivineKingNoahClgExtension_pb.PM_DivineKingNoahClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineKingNuoYaAgent:handlePM_DivineKingNoahClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineKingNuoYaAgent:handlePM_DivineKingNoahClgNotifyFightRes(status, msg)
	if status == 0 then
		DivineKingNuoYaController.instance:handlePM_DivineKingNoahClgNotifyFightRes(msg)
	end
end

DivineKingNuoYaAgent.instance = DivineKingNuoYaAgent.New()

return DivineKingNuoYaAgent
