-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/agent/EternalCityAgent.lua

module("logic.extensions.eternalcity.agent.EternalCityAgent", package.seeall)

local EternalCityAgent = class("EternalCityAgent", BaseAgent)

function EternalCityAgent:sendPM_EternalCityInfoReq(activityId)
	local req = EternalCityExtension_pb.PM_EternalCityInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EternalCityAgent:handlePM_EternalCityInfoRes(status, msg)
	if status == 0 then
		EternalCityController.instance:handlePM_EternalCityInfoRes(msg)
	end
end

function EternalCityAgent:sendPM_EternalCityRecruitReq(activityId, poolId)
	local req = EternalCityExtension_pb.PM_EternalCityRecruitReq()

	req.activityId = activityId
	req.poolId = poolId

	self:sendMsg(req)
end

function EternalCityAgent:handlePM_EternalCityRecruitRes(status, msg)
	if status == 0 then
		EternalCityController.instance:handlePM_EternalCityRecruitRes(msg)
	end
end

function EternalCityAgent:sendPM_EternalCityRefreshPoolReq(activityId)
	local req = EternalCityExtension_pb.PM_EternalCityRefreshPoolReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EternalCityAgent:handlePM_EternalCityRefreshPoolRes(status, msg)
	if status == 0 then
		EternalCityController.instance:handlePM_EternalCityRefreshPoolRes(msg)
	end
end

function EternalCityAgent:sendPM_EternalCityStageClgReq(activityId, form_pb, stageId)
	local req = EternalCityExtension_pb.PM_EternalCityStageClgReq()

	req.activityId = activityId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	req.stageId = stageId

	self:sendMsg(req)
end

function EternalCityAgent:handlePM_EternalCityStageClgRes(status, msg)
	if status == 0 then
		EternalCityController.instance:handlePM_EternalCityStageClgRes(msg)
	end
end

function EternalCityAgent:sendPM_EternalCityBossClgReq(activityId, form_pb)
	local req = EternalCityExtension_pb.PM_EternalCityBossClgReq()

	req.activityId = activityId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function EternalCityAgent:handlePM_EternalCityBossClgRes(status, msg)
	if status == 0 then
		EternalCityController.instance:handlePM_EternalCityBossClgRes(msg)
	end
end

function EternalCityAgent:sendPM_EternalCityBuyBuildingReq(activityId, buildingId, num)
	local req = EternalCityExtension_pb.PM_EternalCityBuyBuildingReq()

	req.activityId = activityId
	req.buildingId = buildingId
	req.num = num

	self:sendMsg(req)
end

function EternalCityAgent:handlePM_EternalCityBuyBuildingRes(status, msg)
	if status == 0 then
		EternalCityController.instance:handlePM_EternalCityBuyBuildingRes(msg)
	end
end

function EternalCityAgent:sendPM_EternalCitySaleBuildingReq(activityId, buildingId, level, num)
	local req = EternalCityExtension_pb.PM_EternalCitySaleBuildingReq()

	req.activityId = activityId
	req.buildingId = buildingId
	req.level = level
	req.num = num

	self:sendMsg(req)
end

function EternalCityAgent:handlePM_EternalCitySaleBuildingRes(status, msg)
	if status == 0 then
		EternalCityController.instance:handlePM_EternalCitySaleBuildingRes(msg)
	end
end

function EternalCityAgent:sendPM_EternalCityCraftBuildingReq(activityId, buildingId, craftLevel, oldPos, newPos)
	local req = EternalCityExtension_pb.PM_EternalCityCraftBuildingReq()

	req.activityId = activityId
	req.buildingId = buildingId
	req.craftLevel = craftLevel

	if oldPos then
		local oldPosition_pb = CommonStructDef_pb.PM_PairInt()

		oldPosition_pb.left = oldPos.x
		oldPosition_pb.right = oldPos.y

		req.oldPosition:ParseFromString(oldPosition_pb:SerializeToString())
	end

	if newPos then
		local newPosition_pb = CommonStructDef_pb.PM_PairInt()

		newPosition_pb.left = newPos.x
		newPosition_pb.right = newPos.y

		req.newPosition:ParseFromString(newPosition_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function EternalCityAgent:handlePM_EternalCityCraftBuildingRes(status, msg)
	EternalCityController.instance:handlePM_EternalCityCraftBuildingRes(status, msg)
end

function EternalCityAgent:sendPM_EternalCityPlaceBuildingReq(activityId, buildingId, level, x, y)
	local req = EternalCityExtension_pb.PM_EternalCityPlaceBuildingReq()

	req.activityId = activityId
	req.buildingId = buildingId
	req.level = level

	local position_pb = CommonStructDef_pb.PM_PairInt()

	position_pb.left = x
	position_pb.right = y

	req.position:ParseFromString(position_pb:SerializeToString())
	self:sendMsg(req)
end

function EternalCityAgent:handlePM_EternalCityPlaceBuildingRes(status, msg)
	EternalCityController.instance:handlePM_EternalCityPlaceBuildingRes(status, msg)
end

function EternalCityAgent:sendPM_EternalCityUnequipBuildingReq(activityId, buildingId, level, x, y)
	local req = EternalCityExtension_pb.PM_EternalCityUnequipBuildingReq()

	req.activityId = activityId
	req.buildingId = buildingId
	req.level = level

	local position_pb = CommonStructDef_pb.PM_PairInt()

	position_pb.left = x
	position_pb.right = y

	req.position:ParseFromString(position_pb:SerializeToString())
	self:sendMsg(req)
end

function EternalCityAgent:handlePM_EternalCityUnequipBuildingRes(status, msg)
	EternalCityController.instance:handlePM_EternalCityUnequipBuildingRes(status, msg)
end

function EternalCityAgent:sendPM_EternalCityMoveBuildingReq(activityId, buildingId, level, oldX, oldY, newX, newY)
	local req = EternalCityExtension_pb.PM_EternalCityMoveBuildingReq()

	req.activityId = activityId
	req.buildingId = buildingId
	req.level = level

	local oldPosition_pb = CommonStructDef_pb.PM_PairInt()

	oldPosition_pb.left = oldX
	oldPosition_pb.right = oldY

	req.oldPosition:ParseFromString(oldPosition_pb:SerializeToString())

	local newPosition_pb = CommonStructDef_pb.PM_PairInt()

	newPosition_pb.left = newX
	newPosition_pb.right = newY

	req.newPosition:ParseFromString(newPosition_pb:SerializeToString())
	self:sendMsg(req)
end

function EternalCityAgent:handlePM_EternalCityMoveBuildingRes(status, msg)
	EternalCityController.instance:handlePM_EternalCityMoveBuildingRes(status, msg)
end

function EternalCityAgent:sendPM_EternalCityOperaPetReq(activityId, buildingId, level, x, y, petIds)
	local req = EternalCityExtension_pb.PM_EternalCityOperaPetReq()

	req.activityId = activityId
	req.buildingId = buildingId
	req.level = level

	local position_pb = CommonStructDef_pb.PM_PairInt()

	position_pb.left = x
	position_pb.right = y

	req.position:ParseFromString(position_pb:SerializeToString())

	for _, petId in ipairs(petIds) do
		req.petId:append(petId)
	end

	self:sendMsg(req)
end

function EternalCityAgent:handlePM_EternalCityOperaPetRes(status, msg)
	if status == 0 then
		EternalCityController.instance:handlePM_EternalCityOperaPetRes(msg)
	end
end

function EternalCityAgent:sendPM_EternalCityGainProfitReq(activityId)
	local req = EternalCityExtension_pb.PM_EternalCityGainProfitReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EternalCityAgent:handlePM_EternalCityGainProfitRes(status, msg)
	if status == 0 then
		EternalCityController.instance:handlePM_EternalCityGainProfitRes(msg)
	end
end

function EternalCityAgent:sendPM_EternalCityRankViewReq(activityId)
	local req = EternalCityExtension_pb.PM_EternalCityRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EternalCityAgent:handlePM_EternalCityRankViewRes(status, msg)
	if status == 0 then
		EternalCityController.instance:handlePM_EternalCityRankViewRes(msg)
	end
end

function EternalCityAgent:sendPM_EternalCityOperaPoolReq(activityId, poolId, operaType)
	local req = EternalCityExtension_pb.PM_EternalCityOperaPoolReq()

	req.activityId = activityId
	req.poolId = poolId
	req.operaType = operaType

	self:sendMsg(req)
end

function EternalCityAgent:handlePM_EternalCityOperaPoolRes(status, msg)
	if status == 0 then
		EternalCityController.instance:handlePM_EternalCityOperaPoolRes(msg)
	end
end

function EternalCityAgent:handlePM_EternalCityNotifyStageClgRes(status, msg)
	if status == 0 then
		EternalCityController.instance:handlePM_EternalCityNotifyStageClgRes(msg)
	end
end

function EternalCityAgent:handlePM_EternalCityNotifyBossClgRes(status, msg)
	if status == 0 then
		EternalCityController.instance:handlePM_EternalCityNotifyBossClgRes(msg)
	end
end

function EternalCityAgent:handlePM_EternalCityNotifyProsperityChangeRes(status, msg)
	if status == 0 then
		EternalCityController.instance:handlePM_EternalCityNotifyProsperityChangeRes(msg)
	end
end

EternalCityAgent.instance = EternalCityAgent.New()

return EternalCityAgent
