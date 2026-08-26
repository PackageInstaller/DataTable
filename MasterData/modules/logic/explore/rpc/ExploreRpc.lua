-- chunkname: @modules/logic/explore/rpc/ExploreRpc.lua

module("modules.logic.explore.rpc.ExploreRpc", package.seeall)

local ExploreRpc = class("ExploreRpc", BaseRpc)

ExploreRpc.instance = ExploreRpc.New()

function ExploreRpc:sendChangeMapRequest(mapId)
	local req = ExploreModule_pb.ChangeMapRequest()

	req.mapId = mapId

	self:sendMsg(req)
end

function ExploreRpc:onReceiveChangeMapReply(resultCode, msg)
	if resultCode == 0 then
		if msg.exploreInfo.exploreMap.isFirstEnter then
			ExploreModel.instance.isFirstEnterMap = ExploreEnum.EnterMode.First or ExploreEnum.EnterMode.Normal
		end

		ExploreSimpleModel.instance:setNowMapId(msg.exploreInfo.exploreMap.mapId)
		ExploreModel.instance:updateExploreInfo(msg.exploreInfo)
		ExploreController.instance:enterExploreMap(msg.exploreInfo.exploreMap.mapId)
	end
end

function ExploreRpc:sendGetExploreInfoRequest()
	local req = ExploreModule_pb.GetExploreInfoRequest()

	self:sendMsg(req)
end

function ExploreRpc:onReceiveGetExploreInfoReply(resultCode, msg)
	if resultCode == 0 then
		ExploreModel.instance:updateExploreInfo(msg.exploreInfo)
		ExploreController.instance:enterExploreMap(ExploreModel.instance:getMapId())
	end
end

function ExploreRpc:sendGetExploreSimpleInfoRequest(callback, callObj)
	local req = ExploreModule_pb.GetExploreSimpleInfoRequest()

	return self:sendMsg(req, callback, callObj)
end

function ExploreRpc:onReceiveGetExploreSimpleInfoReply(resultCode, msg)
	if resultCode == 0 then
		ExploreSimpleModel.instance:onGetInfo(msg)
	end
end

function ExploreRpc:sendExploreMoveRequest(posx, posy, interactId, callback, callbackObj)
	local req = ExploreModule_pb.ExploreMoveRequest()

	req.posx = posx
	req.posy = posy

	if interactId then
		req.interactId = interactId
	end

	return self:sendMsg(req, callback, callbackObj)
end

function ExploreRpc:onReceiveExploreMoveReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	else
		ExploreStepController.instance:forceAsyncPos()
	end
end

function ExploreRpc:sendExploreInteractSetStatusRequest(type, id, status, callback, callbackObj)
	local req = ExploreModule_pb.ExploreInteractSetStatusRequest()

	req.type = type
	req.id = id
	req.status = status

	return self:sendMsg(req, callback, callbackObj)
end

function ExploreRpc:onReceiveExploreInteractSetStatusReply(resultCode, msg)
	if resultCode == 0 then
		ExploreModel.instance:updateInteractStatus(msg.mapId, msg.id, msg.status)
	end
end

function ExploreRpc:sendExploreInteractRequest(id, step, params, callback, callbackObj)
	local req = ExploreModule_pb.ExploreInteractRequest()

	req.id = id

	if not string.nilorempty(params) then
		req.params = params
	end

	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.BeginInteract)

	return self:sendMsg(req, callback, callbackObj)
end

function ExploreRpc:onReceiveExploreInteractReply(resultCode, msg)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.BeginInteract)
	ExploreController.instance:dispatchEvent(ExploreEvent.UnitInteractEnd)

	if resultCode == 0 then
		-- block empty
	end
end

function ExploreRpc:onReceiveStartExplorePush(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function ExploreRpc:sendExploreItemInteractRequest(id, params, callback, callbackObj)
	local req = ExploreModule_pb.ExploreItemInteractRequest()

	req.id = id
	req.params = params

	return self:sendMsg(req, callback, callbackObj)
end

function ExploreRpc:onReceiveExploreItemInteractReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function ExploreRpc:sendExploreUseItemRequest(id, posx, posy, interactId, callback, callbackObj)
	local req = ExploreModule_pb.ExploreUseItemRequest()

	req.uid = id
	req.posx = posx
	req.posy = posy

	if interactId then
		req.interactId = interactId
	end

	return self:sendMsg(req, callback, callbackObj)
end

function ExploreRpc:onReceiveExploreUseItemReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function ExploreRpc:onReceiveExploreItemChangePush(resultCode, msg)
	if resultCode == 0 then
		ExploreBackpackModel.instance:updateItems(msg.exploreItems)
	end
end

function ExploreRpc:onReceiveExploreStepPush(resultCode, msg)
	if resultCode == 0 then
		ExploreStepController.instance:onExploreStepPush(msg)
	end
end

function ExploreRpc:sendResetExploreRequest()
	local req = ExploreModule_pb.ResetExploreRequest()

	ExploreController.instance:getMap():getHero():stopMoving(true)

	local stepData = {
		stepType = ExploreEnum.StepType.ResetBegin
	}

	ExploreStepController.instance:insertClientStep(stepData, 1)
	ExploreStepController.instance:startStep()
	self:sendMsg(req)
end

function ExploreRpc:onReceiveResetExploreReply(resultCode, msg)
	local stepData = {
		stepType = ExploreEnum.StepType.ResetEnd
	}

	ExploreStepController.instance:insertClientStep(stepData)
	ExploreStepController.instance:startStep()
end

return ExploreRpc
