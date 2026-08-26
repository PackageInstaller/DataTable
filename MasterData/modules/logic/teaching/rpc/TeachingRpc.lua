-- chunkname: @modules/logic/teaching/rpc/TeachingRpc.lua

module("modules.logic.teaching.rpc.TeachingRpc", package.seeall)

local TeachingRpc = class("TeachingRpc", BaseRpc)

function TeachingRpc:sendGetTeachingInfo(callback, callobj)
	local req = TeachingModule_pb.TeachingGetInfoRequest()

	return self:sendMsg(req, callback, callobj)
end

function TeachingRpc:onReceiveTeachingGetInfoReply(resultCode, msg)
	if resultCode == 0 then
		TeachingModel.instance:updateTeachingMo(msg.teachingInfo)
	end
end

function TeachingRpc:sendTeachingGetBonusRequest(id, callback, callObj)
	local req = TeachingModule_pb.TeachingGetBonusRequest()

	table.insert(req.teachingIds, id)

	return self:sendMsg(req, callback, callObj)
end

function TeachingRpc:onReceiveTeachingGetBonusReply(resultCode, msg)
	if resultCode == 0 then
		TeachingModel.instance:updateTeachingMoByServer(msg.teachinges)
		TeachingController.instance:dispatchEvent(TeachingEvent.OnTeachingBonusUpdate)
	end
end

function TeachingRpc:onReceiveTeachingUpdateInfoPush(resultCode, msg)
	if resultCode == 0 then
		TeachingModel.instance:updateTeachingMo(msg.teachingInfo)
		TeachingController.instance:dispatchEvent(TeachingEvent.OnTeachingInfoUpdate)
	end
end

TeachingRpc.instance = TeachingRpc.New()

return TeachingRpc
