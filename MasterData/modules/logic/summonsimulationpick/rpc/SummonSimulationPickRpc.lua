-- chunkname: @modules/logic/summonsimulationpick/rpc/SummonSimulationPickRpc.lua

module("modules.logic.summonsimulationpick.rpc.SummonSimulationPickRpc", package.seeall)

local SummonSimulationPickRpc = class("SummonSimulationPickRpc", BaseRpc)

function SummonSimulationPickRpc:getInfo(activityId, callBack, callBackObj)
	local req = Activity221Module_pb.Get221InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callBack, callBackObj)
end

function SummonSimulationPickRpc:onReceiveGet221InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	SummonSimulationPickModel.instance:setActInfo(info.activityId, info)
	SummonSimulationPickController.instance:dispatchEvent(SummonSimulationEvent.onGetSummonInfo, info.activityId)
end

function SummonSimulationPickRpc:summonSimulation(activityId, callBack, callBackObj)
	local req = Activity221Module_pb.Act221SummonRequest()

	req.activityId = activityId

	self:sendMsg(req, callBack, callBackObj)
end

function SummonSimulationPickRpc:onReceiveAct221SummonReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	SummonSimulationPickModel.instance:setActInfo(info.activityId, info)
	SummonSimulationPickController.instance:dispatchEvent(SummonSimulationEvent.onSummonSimulation, info.activityId)
end

function SummonSimulationPickRpc:selectResult(activityId, saveType, callBack, callBackObj)
	local req = Activity221Module_pb.Act221SelectRequest()

	req.activityId = activityId
	req.select = saveType

	self:sendMsg(req, callBack, callBackObj)
end

function SummonSimulationPickRpc:onReceiveAct221SelectReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	SummonSimulationPickModel.instance:setActInfo(info.activityId, info)
	SummonSimulationPickController.instance:dispatchEvent(SummonSimulationEvent.onSelectResult, info.activityId)
	CharacterModel.instance:setGainHeroViewShowState(false)
	CharacterModel.instance:setGainHeroViewNewShowState(false)
end

SummonSimulationPickRpc.instance = SummonSimulationPickRpc.New()

return SummonSimulationPickRpc
