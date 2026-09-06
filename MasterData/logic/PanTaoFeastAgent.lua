-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/agent/PanTaoFeastAgent.lua

module("logic.extensions.pantaofeast.agent.PanTaoFeastAgent", package.seeall)

local PanTaoFeastAgent = class("PanTaoFeastAgent", BaseAgent)

function PanTaoFeastAgent:sendPM_PanTaoFeastGetInfoReq(activityId)
	local req = PanTaoFeastExtension_pb.PM_PanTaoFeastGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PanTaoFeastAgent:handlePM_PanTaoFeastGetInfoRes(status, msg)
	if status == 0 then
		PanTaoFeastController.instance:handlePM_PanTaoFeastGetInfoRes(msg)
	end
end

function PanTaoFeastAgent:sendPM_PanTaoFeastMoveElementsReq(activityId, changedGridElements_pb_Ary)
	local req = PanTaoFeastExtension_pb.PM_PanTaoFeastMoveElementsReq()

	req.activityId = activityId

	if changedGridElements_pb_Ary ~= nil then
		for i, v1 in ipairs(changedGridElements_pb_Ary) do
			local changedGridElements = req.changedGridElements:add()

			changedGridElements:ParseFromString(v1:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function PanTaoFeastAgent:handlePM_PanTaoFeastMoveElementsRes(status, msg)
	if status == 0 then
		PanTaoFeastController.instance:handlePM_PanTaoFeastMoveElementsRes(msg)
	end
end

function PanTaoFeastAgent:sendPM_PanTaoFeastProduceElementReq(activityId, toolGridId, changedGridElements_pb_Ary)
	local req = PanTaoFeastExtension_pb.PM_PanTaoFeastProduceElementReq()

	req.activityId = activityId
	req.toolGridId = toolGridId

	if changedGridElements_pb_Ary ~= nil then
		for i, v2 in ipairs(changedGridElements_pb_Ary) do
			local changedGridElements = req.changedGridElements:add()

			changedGridElements:ParseFromString(v2:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function PanTaoFeastAgent:handlePM_PanTaoFeastProduceElementRes(status, msg)
	if status == 0 then
		PanTaoFeastController.instance:handlePM_PanTaoFeastProduceElementRes(msg)
	end
end

function PanTaoFeastAgent:sendPM_PanTaoFeastMoveToStoreReq(activityId, fromGridId, targetStashId, changedGridElements_pb_Ary)
	local req = PanTaoFeastExtension_pb.PM_PanTaoFeastMoveToStoreReq()

	req.activityId = activityId
	req.fromGridId = fromGridId
	req.targetStashId = targetStashId

	if changedGridElements_pb_Ary ~= nil then
		for i, v3 in ipairs(changedGridElements_pb_Ary) do
			local changedGridElements = req.changedGridElements:add()

			changedGridElements:ParseFromString(v3:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function PanTaoFeastAgent:handlePM_PanTaoFeastMoveToStoreRes(status, msg)
	if status == 0 then
		PanTaoFeastController.instance:handlePM_PanTaoFeastMoveToStoreRes(msg)
	end
end

function PanTaoFeastAgent:sendPM_PanTaoFeastMergeElementsReq(activityId, beMergedGridId, mainGridId, changedGridElements_pb_Ary)
	local req = PanTaoFeastExtension_pb.PM_PanTaoFeastMergeElementsReq()

	req.activityId = activityId
	req.beMergedGridId = beMergedGridId
	req.mainGridId = mainGridId

	if changedGridElements_pb_Ary ~= nil then
		for i, v4 in ipairs(changedGridElements_pb_Ary) do
			local changedGridElements = req.changedGridElements:add()

			changedGridElements:ParseFromString(v4:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function PanTaoFeastAgent:handlePM_PanTaoFeastMergeElementsRes(status, msg)
	if status == 0 then
		PanTaoFeastController.instance:handlePM_PanTaoFeastMergeElementsRes(msg)
	end
end

function PanTaoFeastAgent:sendPM_PanTaoFeastAutoMergeReq(activityId, changedGridElements_pb_Ary)
	local req = PanTaoFeastExtension_pb.PM_PanTaoFeastAutoMergeReq()

	req.activityId = activityId

	if changedGridElements_pb_Ary ~= nil then
		for i, v5 in ipairs(changedGridElements_pb_Ary) do
			local changedGridElements = req.changedGridElements:add()

			changedGridElements:ParseFromString(v5:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function PanTaoFeastAgent:handlePM_PanTaoFeastAutoMergeRes(status, msg)
	if status == 0 then
		PanTaoFeastController.instance:handlePM_PanTaoFeastAutoMergeRes(msg)
	end
end

function PanTaoFeastAgent:sendPM_PanTaoFeastUseEnergyPackReq(activityId, gridId, changedGridElements_pb_Ary)
	local req = PanTaoFeastExtension_pb.PM_PanTaoFeastUseEnergyPackReq()

	req.activityId = activityId
	req.gridId = gridId

	if changedGridElements_pb_Ary ~= nil then
		for i, v6 in ipairs(changedGridElements_pb_Ary) do
			local changedGridElements = req.changedGridElements:add()

			changedGridElements:ParseFromString(v6:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function PanTaoFeastAgent:handlePM_PanTaoFeastUseEnergyPackRes(status, msg)
	if status == 0 then
		PanTaoFeastController.instance:handlePM_PanTaoFeastUseEnergyPackRes(msg)
	end
end

function PanTaoFeastAgent:sendPM_PanTaoFeastCookDishReq(activityId, cookToolId, changedGridElements_pb_Ary)
	local req = PanTaoFeastExtension_pb.PM_PanTaoFeastCookDishReq()

	req.activityId = activityId
	req.cookToolId = cookToolId

	if changedGridElements_pb_Ary ~= nil then
		for i, v7 in ipairs(changedGridElements_pb_Ary) do
			local changedGridElements = req.changedGridElements:add()

			changedGridElements:ParseFromString(v7:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function PanTaoFeastAgent:handlePM_PanTaoFeastCookDishRes(status, msg)
	if status == 0 then
		PanTaoFeastController.instance:handlePM_PanTaoFeastCookDishRes(msg)
	end
end

function PanTaoFeastAgent:sendPM_PanTaoFeastStashToGridReq(activityId, stashId, elementId, changedGridElements_pb_Ary)
	local req = PanTaoFeastExtension_pb.PM_PanTaoFeastStashToGridReq()

	req.activityId = activityId
	req.stashId = stashId
	req.elementId = elementId

	if changedGridElements_pb_Ary ~= nil then
		for i, v8 in ipairs(changedGridElements_pb_Ary) do
			local changedGridElements = req.changedGridElements:add()

			changedGridElements:ParseFromString(v8:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function PanTaoFeastAgent:handlePM_PanTaoFeastStashToGridRes(status, msg)
	if status == 0 then
		PanTaoFeastController.instance:handlePM_PanTaoFeastStashToGridRes(msg)
	end
end

function PanTaoFeastAgent:sendPM_PanTaoFeastDeleteGridElementReq(activityId, gridId, changedGridElements_pb_Ary)
	local req = PanTaoFeastExtension_pb.PM_PanTaoFeastDeleteGridElementReq()

	req.activityId = activityId
	req.gridId = gridId

	if changedGridElements_pb_Ary ~= nil then
		for i, v9 in ipairs(changedGridElements_pb_Ary) do
			local changedGridElements = req.changedGridElements:add()

			changedGridElements:ParseFromString(v9:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function PanTaoFeastAgent:handlePM_PanTaoFeastDeleteGridElementRes(status, msg)
	if status == 0 then
		PanTaoFeastController.instance:handlePM_PanTaoFeastDeleteGridElementRes(msg)
	end
end

function PanTaoFeastAgent:sendPM_PanTaoFeastSubmitOrderReq(activityId, orderId, costGridIds_i32_Ary, changedGridElements_pb_Ary)
	local req = PanTaoFeastExtension_pb.PM_PanTaoFeastSubmitOrderReq()

	req.activityId = activityId
	req.orderId = orderId

	for i, v10 in ipairs(costGridIds_i32_Ary) do
		req.costGridIds:append(v10)
	end

	if changedGridElements_pb_Ary ~= nil then
		for i, v11 in ipairs(changedGridElements_pb_Ary) do
			local changedGridElements = req.changedGridElements:add()

			changedGridElements:ParseFromString(v11:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function PanTaoFeastAgent:handlePM_PanTaoFeastSubmitOrderRes(status, msg)
	if status == 0 then
		PanTaoFeastController.instance:handlePM_PanTaoFeastSubmitOrderRes(msg)
	end
end

function PanTaoFeastAgent:sendPM_PanTaoFeastGainRoundPrizeReq(activityId, roundPrizeId, changedGridElements_pb_Ary)
	local req = PanTaoFeastExtension_pb.PM_PanTaoFeastGainRoundPrizeReq()

	req.activityId = activityId
	req.roundPrizeId = roundPrizeId

	if changedGridElements_pb_Ary ~= nil then
		for i, v12 in ipairs(changedGridElements_pb_Ary) do
			local changedGridElements = req.changedGridElements:add()

			changedGridElements:ParseFromString(v12:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function PanTaoFeastAgent:handlePM_PanTaoFeastGainRoundPrizeRes(status, msg)
	if status == 0 then
		PanTaoFeastController.instance:handlePM_PanTaoFeastGainRoundPrizeRes(msg)
	end
end

function PanTaoFeastAgent:sendPM_PanTaoFeastRepairBuildingReq(activityId, buildingId)
	local req = PanTaoFeastExtension_pb.PM_PanTaoFeastRepairBuildingReq()

	req.activityId = activityId
	req.buildingId = buildingId

	self:sendMsg(req)
end

function PanTaoFeastAgent:handlePM_PanTaoFeastRepairBuildingRes(status, msg)
	if status == 0 then
		PanTaoFeastController.instance:handlePM_PanTaoFeastRepairBuildingRes(msg)
	end
end

function PanTaoFeastAgent:sendPM_PanTaoFeastGainBookPrizeReq(activityId, changedGridElements_pb_Ary)
	local req = PanTaoFeastExtension_pb.PM_PanTaoFeastGainBookPrizeReq()

	req.activityId = activityId

	if changedGridElements_pb_Ary ~= nil then
		for i, v13 in ipairs(changedGridElements_pb_Ary) do
			local changedGridElements = req.changedGridElements:add()

			changedGridElements:ParseFromString(v13:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function PanTaoFeastAgent:handlePM_PanTaoFeastGainBookPrizeRes(status, msg)
	if status == 0 then
		PanTaoFeastController.instance:handlePM_PanTaoFeastGainBookPrizeRes(msg)
	end
end

function PanTaoFeastAgent:sendPM_PanTaoFeastGainDailyGiftReq(activityId, changedGridElements_pb_Ary)
	local req = PanTaoFeastExtension_pb.PM_PanTaoFeastGainDailyGiftReq()

	req.activityId = activityId

	if changedGridElements_pb_Ary ~= nil then
		for i, v14 in ipairs(changedGridElements_pb_Ary) do
			local changedGridElements = req.changedGridElements:add()

			changedGridElements:ParseFromString(v14:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function PanTaoFeastAgent:handlePM_PanTaoFeastGainDailyGiftRes(status, msg)
	if status == 0 then
		PanTaoFeastController.instance:handlePM_PanTaoFeastGainDailyGiftRes(msg)
	end
end

function PanTaoFeastAgent:sendPM_PanTaoFeastGetRankInfoReq(activityId)
	local req = PanTaoFeastExtension_pb.PM_PanTaoFeastGetRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PanTaoFeastAgent:handlePM_PanTaoFeastGetRankInfoRes(status, msg)
	if status == 0 then
		PanTaoFeastController.instance:handlePM_PanTaoFeastGetRankInfoRes(msg)
	end
end

function PanTaoFeastAgent:handlePM_PanTaoFeastNotifyChangeRes(status, msg)
	if status == 0 then
		PanTaoFeastController.instance:handlePM_PanTaoFeastNotifyChangeRes(msg)
	end
end

PanTaoFeastAgent.instance = PanTaoFeastAgent.New()

return PanTaoFeastAgent
