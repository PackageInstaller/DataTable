-- chunkname: @modules/logic/versionactivity1_8/dungeon/rpc/Activity157Rpc.lua

module("modules.logic.versionactivity1_8.dungeon.rpc.Activity157Rpc", package.seeall)

local Activity157Rpc = class("Activity157Rpc", BaseRpc)

function Activity157Rpc:sendGet157InfoRequest(activityId, cb, cbObj)
	local req = Activity157Module_pb.Get157InfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, cb, cbObj)
end

function Activity157Rpc:onReceiveGet157InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity157Model.instance:setActivityInfo(msg)
end

function Activity157Rpc:sendAct157UnlockComponentRequest(activityId, componentId, cb, cbObj)
	local req = Activity157Module_pb.Act157UnlockComponentRequest()

	req.activityId = activityId
	req.componentId = componentId

	return self:sendMsg(req, cb, cbObj)
end

function Activity157Rpc:onReceiveAct157UnlockComponentReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity157Model.instance:setComponentUnlock(msg.componentId)

	local productionNum = msg.productionInfo.productionMaterial.quantity
	local nextRecoverTime = msg.productionInfo.nextRecoverTime

	Activity157Model.instance:setProductionInfo(productionNum, nextRecoverTime)
	Activity157Model.instance:setSideMissionUnlockTime(msg.sideMissionUnlockTime)
end

function Activity157Rpc:sendAct157AcceptProductionRequest(activityId, cb, cbObj)
	local req = Activity157Module_pb.Act157AcceptProductionRequest()

	req.activityId = activityId

	return self:sendMsg(req, cb, cbObj)
end

function Activity157Rpc:onReceiveAct157AcceptProductionReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local productionNum = msg.productionInfo.productionMaterial.quantity
	local nextRecoverTime = msg.productionInfo.nextRecoverTime

	Activity157Model.instance:setProductionInfo(productionNum, nextRecoverTime)
	GameFacade.showToast(ToastEnum.V1a8Activity157GetFactoryProductionSuccess)
end

function Activity157Rpc:sendAct157CompoundRequest(activityId, compoundTimes, cb, cbObj)
	local req = Activity157Module_pb.Act157CompoundRequest()

	req.activityId = activityId
	req.compoundTimes = compoundTimes

	return self:sendMsg(req, cb, cbObj)
end

function Activity157Rpc:onReceiveAct157CompoundReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function Activity157Rpc:sendAct157GainMilestoneRewardRequest(activityId, componentId, cb, cbObj)
	local req = Activity157Module_pb.Act157GainMilestoneRewardRequest()

	req.activityId = activityId
	req.componentId = componentId

	return self:sendMsg(req, cb, cbObj)
end

function Activity157Rpc:onReceiveAct157GainMilestoneRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local buildingData = {
		materilType = msg.info.buildingData.materilType,
		materilId = msg.info.buildingData.materilId,
		quantity = msg.info.buildingData.quantity,
		roomBuildingLevel = msg.info.buildingLevel
	}
	local totalDataList = {
		buildingData
	}

	if msg.dataList then
		for _, materialData in ipairs(msg.dataList) do
			if materialData.materilType ~= MaterialEnum.MaterialType.Building then
				totalDataList[#totalDataList + 1] = materialData
			end
		end
	end

	local co = MaterialRpc.receiveMaterial({
		dataList = totalDataList
	})

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157OnGetComponentReward, co)
	Activity157Model.instance:setHasGotRewardComponentByList(msg.componentIds)
end

function Activity157Rpc:onReceiveProductionInfoChangePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local productionNum = msg.productionInfo.productionMaterial.quantity
	local nextRecoverTime = msg.productionInfo.nextRecoverTime

	Activity157Model.instance:setProductionInfo(productionNum, nextRecoverTime)
end

Activity157Rpc.instance = Activity157Rpc.New()

return Activity157Rpc
