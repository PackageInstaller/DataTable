-- chunkname: @modules/logic/pushbox/rpc/PushBoxRpc.lua

module("modules.logic.pushbox.rpc.PushBoxRpc", package.seeall)

local PushBoxRpc = class("PushBoxRpc", BaseRpc)

function PushBoxRpc:sendGet111InfosRequest(callback, callbackObj)
	local req = Activity111Module_pb.Get111InfosRequest()

	req.activityId = 11113

	self:sendMsg(req, callback, callbackObj)
end

function PushBoxRpc:onReceiveGet111InfosReply(resultCode, msg)
	if resultCode == 0 then
		PushBoxModel.instance:onReceiveGet111InfosReply(msg)
	end
end

function PushBoxRpc:sendFinishEpisodeRequest(activityId, episodeId, step, alarm)
	local req = Activity111Module_pb.FinishEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.step = step
	req.alarm = alarm

	local serverTime = ServerTime.now()

	for i = 1, 6 do
		serverTime = serverTime .. math.random(0, 9)
	end

	req.timestamp = serverTime
	req.sign = GameLuaMD5.sumhexa(string.format("%s#%s#%s#%s#%s#%s", activityId, episodeId, step, alarm, serverTime, LoginModel.instance.sessionId))

	self:sendMsg(req)
end

function PushBoxRpc:onReceiveFinishEpisodeReply(resultCode, msg)
	PushBoxModel.instance:onReceiveFinishEpisodeReply(resultCode, msg)
end

function PushBoxRpc:onReceiveAct111InfoPush(resultCode, msg)
	PushBoxModel.instance:onReceiveAct111InfoPush(msg)
end

function PushBoxRpc:onReceivePushBoxTaskPush(resultCode, msg)
	PushBoxModel.instance:onReceivePushBoxTaskPush(msg)
end

function PushBoxRpc:sendReceiveTaskRewardRequest(activityId, taskId)
	local req = Activity111Module_pb.ReceiveTaskRewardRequest()

	req.activityId = activityId or PushBoxModel.instance:getCurActivityID()
	req.taskId = taskId

	self:sendMsg(req)
end

function PushBoxRpc:onReceiveReceiveTaskRewardReply(resultCode, msg)
	if resultCode == 0 then
		PushBoxModel.instance:onReceiveReceiveTaskRewardReply(msg)
	end
end

setGlobal("Activity111Rpc", PushBoxRpc)

PushBoxRpc.instance = PushBoxRpc.New()

return PushBoxRpc
