-- chunkname: @modules/logic/commandstation/rpc/CommandStationRpc.lua

module("modules.logic.commandstation.rpc.CommandStationRpc", package.seeall)

local CommandStationRpc = class("CommandStationRpc", BaseRpc)

function CommandStationRpc:sendGetCommandPostInfoRequest(callback, callobj)
	local req = CommandPostModule_pb.GetCommandPostInfoRequest()

	return self:sendMsg(req, callback, callobj)
end

function CommandStationRpc:onReceiveGetCommandPostInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local eventList = msg.eventList
	local tasks = msg.tasks
	local catchTasks = msg.catchTasks
	local gainBonus = msg.gainBonus
	local paper = msg.paper
	local catchNum = msg.catchNum
	local characterState = msg.characterState

	CommandStationModel.instance:updateCharacterStateList(characterState)
	CommandStationModel.instance:updateEventList(eventList)

	CommandStationModel.instance.paper = paper
	CommandStationModel.instance.catchNum = catchNum
	CommandStationModel.instance.gainBonus = {
		unpack(gainBonus)
	}

	CommandStationTaskListModel.instance:initServerData(tasks, catchTasks)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.OnGetCommandPostInfo)
end

function CommandStationRpc:sendFinishCommandPostEventRequest(id, callback, callobj)
	local req = CommandPostModule_pb.FinishCommandPostEventRequest()

	req.id = id

	self:sendMsg(req, callback, callobj)
end

function CommandStationRpc:onReceiveFinishCommandPostEventReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local id = msg.id

	CommandStationController.instance:dispatchEvent(CommandStationEvent.BeforeEventFinish, id)
	CommandStationModel.instance:setEventFinish(id)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.EventReadChange, id)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.AfterEventFinish, id)
end

function CommandStationRpc:sendCommandPostDispatchRequest(eventId, heroIds, callback, callobj)
	local req = CommandPostModule_pb.CommandPostDispatchRequest()

	req.eventId = eventId

	for i, v in ipairs(heroIds) do
		table.insert(req.heroIds, v)
	end

	self:sendMsg(req, callback, callobj)
end

function CommandStationRpc:onReceiveCommandPostDispatchReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local event = msg.event

	CommandStationModel.instance:updateEventInfo(event)
end

function CommandStationRpc:sendCommandPostBonusAllRequest()
	local req = CommandPostModule_pb.CommandPostBonusAllRequest()

	self:sendMsg(req)
end

function CommandStationRpc:onReceiveCommandPostBonusAllReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local bonusId = msg.bonusId

	for i, v in ipairs(bonusId) do
		table.insert(CommandStationModel.instance.gainBonus, v)
	end

	CommandStationController.instance:dispatchEvent(CommandStationEvent.OnBonusUpdate)
end

function CommandStationRpc:sendCommandPostPaperRequest()
	local req = CommandPostModule_pb.CommandPostPaperRequest()

	self:sendMsg(req)
end

function CommandStationRpc:onReceiveCommandPostPaperReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CommandStationModel.instance.paper = msg.paper

	CommandStationController.instance:dispatchEvent(CommandStationEvent.OnPaperUpdate)
end

function CommandStationRpc:sendCommandPostEventReadRequest(id)
	local req = CommandPostModule_pb.CommandPostEventReadRequest()

	req.id = id

	self:sendMsg(req)
end

function CommandStationRpc:onReceiveCommandPostEventReadReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local id = msg.id
	local isReadFinishEvent = CommandStationConfig.instance:isReadFinishEvent(id)

	if isReadFinishEvent then
		CommandStationController.instance:dispatchEvent(CommandStationEvent.BeforeEventFinish, id)
	end

	CommandStationModel.instance:setEventRead(id)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.EventReadChange, id)

	if isReadFinishEvent then
		CommandStationController.instance:dispatchEvent(CommandStationEvent.AfterEventFinish, id)
	end
end

function CommandStationRpc:sendCommandPostCharacterReadRequest(id)
	local req = CommandPostModule_pb.CommandPostCharacterReadRequest()

	req.id = id

	self:sendMsg(req)
end

function CommandStationRpc:onReceiveCommandPostCharacterReadReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local id = msg.id

	CommandStationModel.instance:updateCharacterState(id)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.UpdateCharacterState, id)

	local refreshlist = {
		[RedDotEnum.DotNode.CommandStationRelationShipBoard] = true
	}

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, refreshlist)
end

CommandStationRpc.instance = CommandStationRpc.New()

return CommandStationRpc
