-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalfarm/agent/EternalFarmAgent.lua

module("logic.extensions.eternalfarm.agent.EternalFarmAgent", package.seeall)

local EternalFarmAgent = class("EternalFarmAgent", BaseAgent)

function EternalFarmAgent:sendPM_EternalFarmInfoReq(activityId)
	local req = EternalFarmExtension_pb.PM_EternalFarmInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EternalFarmAgent:handlePM_EternalFarmInfoRes(status, msg)
	if status == 0 then
		EternalFarmController.instance:handlePM_EternalFarmInfoRes(status, msg)
	end
end

function EternalFarmAgent:sendPM_EternalFarmSowReq(activityId, zoneId, indexId, cropId)
	local req = EternalFarmExtension_pb.PM_EternalFarmSowReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.indexId = indexId
	req.cropId = cropId

	self:sendMsg(req)
end

function EternalFarmAgent:handlePM_EternalFarmSowRes(status, msg)
	if status == 0 then
		EternalFarmController.instance:handlePM_EternalFarmSowRes(status, msg)
	end
end

function EternalFarmAgent:sendPM_EternalFarmHarvestReq(activityId, zoneIds)
	local req = EternalFarmExtension_pb.PM_EternalFarmHarvestReq()

	req.activityId = activityId

	for i, id in ipairs(zoneIds) do
		req.zoneId:append(id)
	end

	self:sendMsg(req)
end

function EternalFarmAgent:handlePM_EternalFarmHarvestRes(status, msg)
	if status == 0 then
		EternalFarmController.instance:handlePM_EternalFarmHarvestRes(status, msg)
	end
end

function EternalFarmAgent:sendPM_EternalFarmUseFertilizerReq(activityId, zoneId, indexId)
	local req = EternalFarmExtension_pb.PM_EternalFarmUseFertilizerReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.indexId = indexId

	self:sendMsg(req)
end

function EternalFarmAgent:handlePM_EternalFarmUseFertilizerRes(status, msg)
	if status == 0 then
		EternalFarmController.instance:handlePM_EternalFarmUseFertilizerRes(status, msg)
	end
end

function EternalFarmAgent:sendPM_EternalFarmGainTodayPrizeReq(activityId)
	local req = EternalFarmExtension_pb.PM_EternalFarmGainTodayPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EternalFarmAgent:handlePM_EternalFarmGainTodayPrizeRes(status, msg)
	if status == 0 then
		EternalFarmController.instance:handlePM_EternalFarmGainTodayPrizeRes(status, msg)
	end
end

function EternalFarmAgent:sendPM_EternalFarmShopReq(activityId, shopId, num)
	local req = EternalFarmExtension_pb.PM_EternalFarmShopReq()

	req.activityId = activityId
	req.shopId = shopId
	req.num = num

	self:sendMsg(req)
end

function EternalFarmAgent:handlePM_EternalFarmShopRes(status, msg)
	if status == 0 then
		EternalFarmController.instance:handlePM_EternalFarmShopRes(status, msg)
	end
end

function EternalFarmAgent:sendPM_EternalFarmGainPrizeReq(activityId, itemId, prizeId)
	local req = EternalFarmExtension_pb.PM_EternalFarmGainPrizeReq()

	req.activityId = activityId
	req.itemId = itemId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function EternalFarmAgent:handlePM_EternalFarmGainPrizeRes(status, msg)
	if status == 0 then
		EternalFarmController.instance:handlePM_EternalFarmGainPrizeRes(msg)
	end
end

function EternalFarmAgent:sendPM_EternalFarmOneKeySowReq(activityId, sowItems)
	local req = EternalFarmExtension_pb.PM_EternalFarmOneKeySowReq()

	req.activityId = activityId

	for i, item in ipairs(sowItems) do
		local oneKeySowItem = req.items:add()

		oneKeySowItem.zoneId = item.zoneId
		oneKeySowItem.indexId = item.indexId
		oneKeySowItem.cropId = item.cropId
	end

	self:sendMsg(req)
end

function EternalFarmAgent:handlePM_EternalFarmOneKeySowRes(status, msg)
	if status == 0 then
		EternalFarmController.instance:handlePM_EternalFarmOneKeySowRes(status, msg)
	end
end

function EternalFarmAgent:sendPM_EternalFarmOneKeySellReq(activityId, sellItems)
	local req = EternalFarmExtension_pb.PM_EternalFarmOneKeySellReq()

	req.activityId = activityId

	for i, sellItem in ipairs(sellItems) do
		local item = req.sellItems:add()

		item.shopId = sellItem.shopId
		item.num = sellItem.num
	end

	self:sendMsg(req)
end

function EternalFarmAgent:handlePM_EternalFarmOneKeySellRes(status, msg)
	if status == 0 then
		EternalFarmController.instance:handlePM_EternalFarmOneKeySellRes(status, msg)
	end
end

EternalFarmAgent.instance = EternalFarmAgent.New()

return EternalFarmAgent
