-- chunkname: @modules/logic/sp02/operationactivity/rpc/AtomicOperationActivityRpc.lua

module("modules.logic.sp02.operationactivity.rpc.AtomicOperationActivityRpc", package.seeall)

local AtomicOperationActivityRpc = class("AtomicOperationActivityRpc", BaseRpc)

function AtomicOperationActivityRpc:sendGetAct235InfoRequest(activityId, callback, callbackObj)
	local req = Activity235Module_pb.GetAct235InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function AtomicOperationActivityRpc:onReceiveGetAct235InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = AtomicOperationActivityModel.instance:getCurGameId()
	local info = msg.info

	AtomicOperationActivityModel.instance:updateSingleInfo(activityId, info)
end

function AtomicOperationActivityRpc:sendActivePreparationRequest(activityId, preparationId, callback, callbackObj)
	local req = Activity235Module_pb.ActivePreparationRequest()

	req.activityId = activityId
	req.preparationId = preparationId

	self:sendMsg(req, callback, callbackObj)
end

function AtomicOperationActivityRpc:onReceiveActivePreparationReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info
	local activityId = AtomicOperationActivityModel.instance:getCurGameId()

	AtomicOperationActivityModel.instance:updateSingleInfo(activityId, info)
end

function AtomicOperationActivityRpc:sendFinishMiniGameRequest(activityId, countList, callback, callbackObj)
	local req = Activity235Module_pb.FinishMiniGameRequest()

	req.activityId = activityId

	for _, info in ipairs(countList) do
		local infoNo = Activity235Module_pb.Act235TypeCount()

		infoNo.type = info[1]
		infoNo.count = info[2]

		table.insert(req.countList, infoNo)
	end

	self:sendMsg(req, callback, callbackObj)
end

function AtomicOperationActivityRpc:onReceiveFinishMiniGameReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info
	local activityId = AtomicOperationActivityModel.instance:getCurGameId()

	AtomicOperationActivityModel.instance:updateSingleInfo(activityId, info)
end

AtomicOperationActivityRpc.instance = AtomicOperationActivityRpc.New()

return AtomicOperationActivityRpc
