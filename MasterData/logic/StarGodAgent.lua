-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargod/agent/StarGodAgent.lua

module("logic.extensions.stargod.agent.StarGodAgent", package.seeall)

local StarGodAgent = class("StarGodAgent", BaseAgent)

function StarGodAgent:sendLoadStarGodReq()
	local req = StarGodExtension_pb.LoadStarGodReq()

	self:sendMsg(req)
end

function StarGodAgent:handleLoadStarGodRes(status, msg)
	if status == 0 then
		StarGodModel.instance:setStarGodMsgerInfo(msg)
		StarGodNotify.dispatch(StarGodNotify.OnMessengerStateChange)
		StarGodNotify.dispatch(StarGodNotify.OnStarGodInfoChange)
		StarGodNotify.dispatch(StarGodNotify.OnBagInfoChanged)
	end
end

function StarGodAgent:sendHuntUpStarGodReq(messengerId, changeSetId)
	local req = StarGodExtension_pb.HuntUpStarGodReq()

	req.messengerId = messengerId

	self:sendMsg(req)
end

function StarGodAgent:handleHuntUpStarGodRes(status, msg)
	if status == 0 then
		local stargodmessengerstate = msg.starGodMessengerState
		local newstargodid = msg.newStarGodId

		StarGodModel.instance:setMessengerState(stargodmessengerstate)
		StarGodNotify.dispatch(StarGodNotify.OnHuntUpStarGod, newstargodid, stargodmessengerstate)
	else
		StarGodNotify.dispatch(StarGodNotify.OnStatusInvalid)
	end
end

function StarGodAgent:sendPickUpAndFusionStarGodReq()
	local req = StarGodExtension_pb.PickUpAndFusionStarGodReq()

	self:sendMsg(req)
end

function StarGodAgent:handlePickUpAndFusionStarGodRes(status, msg)
	if status == 0 then
		if not msg.collectIds then
			if not msg.fusionIds then
				local fusionids = {}
				local godview = msg.godView
				local starGodList = StarGodModel.instance:getStoreStarGods()
				local t = {}

				for _, v in ipairs(starGodList) do
					table.insert(t, v.id)
				end

				StarGodModel.instance:collectStarGods(msg.collectIds)
				StarGodModel.instance:fusionStarGods(fusionids)
				StarGodModel.instance:setStarGodInfo(godview.id, godview)
				StarGodNotify.dispatch(StarGodNotify.OnPickUp, t, msg.collectIds, fusionids)
			end
		end
	else
		StarGodNotify.dispatch(StarGodNotify.OnStatusInvalid)
	end
end

local equipedStarGod

function StarGodAgent:sendEquipStarGodReq(petId, starGodId, slotId)
	local req = StarGodExtension_pb.EquipStarGodReq()

	req.petId = petId
	req.starGodId = starGodId
	req.slotId = slotId
	equipedStarGod = starGodId

	self:sendMsg(req)
end

function StarGodAgent:handleEquipStarGodRes(status, msg)
	if status == 0 then
		StarGodModel.instance:equipStarGod(equipedStarGod)

		equipedStarGod = nil

		StarGodNotify.dispatch(StarGodNotify.OnStarGodEquiped)
		StarGodNotify.dispatch(StarGodNotify.OnBagInfoChanged)
	end
end

function StarGodAgent:sendFreeStarGodFusionReq(masterStarGodId, slaveIds)
	local req = StarGodExtension_pb.FreeStarGodFusionReq()

	req.masterStarGodId = masterStarGodId

	for i, v in ipairs(slaveIds) do
		table.insert(req.slaveIds, v)
	end

	self:sendMsg(req)
end

function StarGodAgent:handleFreeStarGodFusionRes(status, msg)
	if status == 0 then
		local godview = msg.godView
		local slaveids = msg.slaveIds

		StarGodModel.instance:setStarGodInfo(godview.id, godview)
		StarGodModel.instance:fusionStarGods(slaveids)
		StarGodNotify.dispatch(StarGodNotify.OnBagInfoChanged)
		StarGodNotify.dispatch(StarGodNotify.OnClickLevelUp)
	end
end

function StarGodAgent:sendCollectStarGodOrNotReq(starGodId, isCollect)
	local req = StarGodExtension_pb.CollectStarGodOrNotReq()

	req.starGodId = starGodId
	req.isCollect = isCollect

	self:sendMsg(req)
end

function StarGodAgent:handleCollectStarGodOrNotRes(status, msg)
	if status == 0 then
		local stargodid = msg.starGodId
		local iscollect = msg.isCollect

		StarGodModel.instance:changeLockState(stargodid, iscollect)
		StarGodNotify.dispatch(StarGodNotify.OnBagInfoChanged)
	end
end

function StarGodAgent:sendAutoStarGodFusionReq(isRed)
	local req = StarGodExtension_pb.AutoStarGodFusionReq()

	req.isRed = isRed

	self:sendMsg(req)
end

function StarGodAgent:handleAutoStarGodFusionRes(status, msg)
	if status == 0 then
		local godview = msg.godView
		local slaveids = msg.slaveIds

		StarGodModel.instance:setStarGodInfo(godview.id, godview)
		StarGodModel.instance:fusionStarGods(slaveids)
		StarGodNotify.dispatch(StarGodNotify.OnBagInfoChanged)
	end
end

function StarGodAgent:sendExpandCapacityReq()
	local req = StarGodExtension_pb.ExpandCapacityReq()

	self:sendMsg(req)
end

function StarGodAgent:handleExpandCapacityRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function StarGodAgent:sendPetStarGodLickUpFreeStarGodReq(petId, slotId, starGodIds)
	local req = StarGodExtension_pb.PetStarGodLickUpFreeStarGodReq()

	req.petId = petId
	req.slotId = slotId

	print(petId, slotId)

	for i, v in ipairs(starGodIds) do
		table.insert(req.starGodIds, v)
	end

	self:sendMsg(req)
end

function StarGodAgent:handlePetStarGodLickUpFreeStarGodRes(status, msg)
	if status == 0 then
		local slaveids = msg.slaveIds

		StarGodModel.instance:fusionStarGods(slaveids)
		StarGodNotify.dispatch(StarGodNotify.OnBagInfoChanged)
		StarGodNotify.dispatch(StarGodNotify.OnClickLevelUp)
	end
end

local replacedStarGod

function StarGodAgent:sendFreeStarGodLickUpPetStarGodReq(petId, starGodId, slotId)
	local req = StarGodExtension_pb.FreeStarGodLickUpPetStarGodReq()

	req.petId = petId
	req.starGodId = starGodId
	req.slotId = slotId
	replacedStarGod = starGodId

	self:sendMsg(req)
end

function StarGodAgent:handleFreeStarGodLickUpPetStarGodRes(status, msg)
	if status == 0 then
		StarGodModel.instance:equipStarGod(replacedStarGod)

		replacedStarGod = nil

		StarGodNotify.dispatch(StarGodNotify.OnStarGodEquiped)
		StarGodNotify.dispatch(StarGodNotify.OnBagInfoChanged)
	end
end

function StarGodAgent:sendOneKeyHuntUpStarGodReq(changeSetId)
	local req = StarGodExtension_pb.OneKeyHuntUpStarGodReq()

	self:sendMsg(req)
end

function StarGodAgent:handleOneKeyHuntUpStarGodRes(status, msg)
	if status == 0 then
		local opList = msg.opList

		if #opList > 0 then
			StarGodModel.instance:setMessengerState(opList[#opList].starGodMessengerState)
			StarGodNotify.dispatch(StarGodNotify.OnOneKeyHuntUp, opList)
		end
	else
		StarGodNotify.dispatch(StarGodNotify.OnStatusInvalid)
	end
end

function StarGodAgent:sendSetAutoCombineStarGodStateReq(isAuto)
	local req = StarGodExtension_pb.SetAutoCombineStarGodStateReq()

	req.isAuto = isAuto

	self:sendMsg(req)
end

function StarGodAgent:handleSetAutoCombineStarGodStateRes(status, msg)
	if status == 0 then
		StarGodModel.instance:setAutoCombine(msg.isAuto)
		StarGodNotify.dispatch(StarGodNotify.OnAutoCombine)
	end
end

function StarGodAgent:sendOneKeyUncollectStarGodReq()
	local req = StarGodExtension_pb.OneKeyUncollectStarGodReq()

	self:sendMsg(req)
end

function StarGodAgent:handleOneKeyUncollectStarGodRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function StarGodAgent:sendSaveAutoFusionStateReq(isRed, state)
	local req = StarGodExtension_pb.SaveAutoFusionStateReq()

	req.isRed = isRed
	req.state = state

	self:sendMsg(req)
end

function StarGodAgent:handleSaveAutoFusionStateRes(status, msg)
	if status == 0 then
		local isred = msg.isRed
		local state = msg.state

		StarGodModel.instance:setAutoCombineState(isred, state)
		StarGodNotify.dispatch(StarGodNotify.OnChangeOneKeySuc, isred)
	end
end

function StarGodAgent:handleStarGodsChangedRes(status, msg)
	if status == 0 then
		local stargodchanged = msg.starGodChanged

		self:_handleStarGodChange(stargodchanged)
	end
end

function StarGodAgent:_handleStarGodChange(stargodchanged)
	for i, v in ipairs(stargodchanged) do
		StarGodFacade.instance:getStarGod(v.id, v)
	end
end

StarGodAgent.instance = StarGodAgent.New()

return StarGodAgent
