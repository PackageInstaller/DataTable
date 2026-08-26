-- chunkname: @modules/logic/activitywelfare/rpc/Activity160Rpc.lua

module("modules.logic.activitywelfare.rpc.Activity160Rpc", package.seeall)

local Activity160Rpc = class("Activity160Rpc", BaseRpc)

function Activity160Rpc:sendGetAct160InfoRequest(actId)
	local req = Activity160Module_pb.Act160GetInfoRequest()

	req.activityId = actId

	self:sendMsg(req)
end

function Activity160Rpc:onReceiveAct160GetInfoReply(resultCode, msg)
	if resultCode == 0 then
		Activity160Model.instance:setInfo(msg)
	end
end

function Activity160Rpc:onReceiveAct160UpdatePush(resultCode, msg)
	if resultCode == 0 then
		Activity160Model.instance:updateInfo(msg)
	end
end

function Activity160Rpc:sendGetAct160FinishMissionRequest(actId, id)
	local req = Activity160Module_pb.Act160FinishMissionRequest()

	req.activityId = actId
	req.id = id

	self:sendMsg(req)
end

function Activity160Rpc:onReceiveAct160FinishMissionReply(resultCode, msg)
	if resultCode == 0 then
		Activity160Model.instance:finishMissionReply(msg)
	end
end

Activity160Rpc.instance = Activity160Rpc.New()

return Activity160Rpc
