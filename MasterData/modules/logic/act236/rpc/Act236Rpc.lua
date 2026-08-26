-- chunkname: @modules/logic/act236/rpc/Act236Rpc.lua

module("modules.logic.act236.rpc.Act236Rpc", package.seeall)

local Act236Rpc = class("Act236Rpc", BaseRpc)

function Act236Rpc:sendGetAct236InfoRequest(activityId, callback, callbackObj)
	local req = Activity236Module_pb.GetAct236InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Act236Rpc:onReceiveGetAct236InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	Act236Model.instance:updateInfo(info)
end

function Act236Rpc:sendAct236GetAutoGainRewardRequest(activityId, rewardIds, callback, callbackObj)
	local req = Activity236Module_pb.Act236GetAutoGainRewardRequest()

	req.activityId = activityId

	if rewardIds and next(rewardIds) then
		tabletool.clear(req.rewardIds)

		for _, id in ipairs(rewardIds) do
			table.insert(req.rewardIds, id)
		end
	end

	self:sendMsg(req, callback, callbackObj)
end

function Act236Rpc:onReceiveAct236GetAutoGainRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local gainRewardIds = msg.gainRewardIds

	Act236Model.instance:onAutoGainReward(activityId, gainRewardIds)
end

function Act236Rpc:onReceiveAct236UpdateInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	Act236Model.instance:updateInfo(info)
end

Act236Rpc.instance = Act236Rpc.New()

return Act236Rpc
