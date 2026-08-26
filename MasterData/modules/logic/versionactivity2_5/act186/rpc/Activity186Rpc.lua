-- chunkname: @modules/logic/versionactivity2_5/act186/rpc/Activity186Rpc.lua

module("modules.logic.versionactivity2_5.act186.rpc.Activity186Rpc", package.seeall)

local Activity186Rpc = class("Activity186Rpc", BaseRpc)

function Activity186Rpc:sendGetAct186InfoRequest(activityId, callback, callbackObj)
	local req = Activity186Module_pb.GetAct186InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity186Rpc:onReceiveGetAct186InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity186Model.instance:setActInfo(msg)
	Activity186Controller.instance:dispatchEvent(Activity186Event.UpdateInfo)
	Activity186Controller.instance:dispatchEvent(Activity186Event.RefreshRed)
end

function Activity186Rpc:sendFinishAct186TaskRequest(activityId, taskId)
	local req = Activity186Module_pb.FinishAct186TaskRequest()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req)
end

function Activity186Rpc:onReceiveFinishAct186TaskReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity186Model.instance:onFinishAct186Task(msg)
	Activity186Controller.instance:dispatchEvent(Activity186Event.FinishTask, msg)
end

function Activity186Rpc:sendFinishAllAct186TaskRequest(activityId)
	local req = Activity186Module_pb.FinishAllAct186TaskRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function Activity186Rpc:onReceiveFinishAllAct186TaskReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity186Model.instance:onFinishAllAct186Task(msg)
	Activity186Controller.instance:dispatchEvent(Activity186Event.FinishAllTask, msg)
end

function Activity186Rpc:sendGetAct186MilestoneRewardRequest(activityId)
	local req = Activity186Module_pb.GetAct186MilestoneRewardRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function Activity186Rpc:onReceiveGetAct186MilestoneRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity186Model.instance:onGetAct186MilestoneReward(msg)
	Activity186Controller.instance:dispatchEvent(Activity186Event.GetMilestoneReward)
end

function Activity186Rpc:sendGetAct186DailyCollectionRequest(activityId)
	local req = Activity186Module_pb.GetAct186DailyCollectionRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function Activity186Rpc:onReceiveGetAct186DailyCollectionReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity186Model.instance:onGetAct186DailyCollection(msg)
	Activity186Controller.instance:dispatchEvent(Activity186Event.GetDailyCollection)
end

function Activity186Rpc:onReceiveAct186TaskPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity186Model.instance:onAct186TaskPush(msg)
	Activity186Controller.instance:dispatchEvent(Activity186Event.UpdateTask)
end

function Activity186Rpc:onReceiveAct186LikePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity186Model.instance:onAct186LikePush(msg)
end

function Activity186Rpc:sendFinishAct186ATypeGameRequest(activityId, gameId, rewardId)
	local req = Activity186Module_pb.FinishAct186ATypeGameRequest()

	req.activityId = activityId
	req.gameId = gameId
	req.rewardId = rewardId

	self:sendMsg(req)
end

function Activity186Rpc:onReceiveFinishAct186ATypeGameReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity186Model.instance:onFinishAct186Game(msg)
	Activity186Controller.instance:dispatchEvent(Activity186Event.FinishGame)
end

function Activity186Rpc:sendAct186BTypeGamePlayRequest(activityId, gameId)
	local req = Activity186Module_pb.Act186BTypeGamePlayRequest()

	req.activityId = activityId
	req.gameId = gameId

	self:sendMsg(req)
end

function Activity186Rpc:onReceiveAct186BTypeGamePlayReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity186Model.instance:onBTypeGamePlay(msg)
	Activity186Controller.instance:dispatchEvent(Activity186Event.PlayGame)
end

function Activity186Rpc:sendFinishAct186BTypeGameRequest(activityId, gameId)
	local req = Activity186Module_pb.FinishAct186BTypeGameRequest()

	req.activityId = activityId
	req.gameId = gameId

	self:sendMsg(req)
end

function Activity186Rpc:onReceiveFinishAct186BTypeGameReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity186Model.instance:onFinishAct186Game(msg)
	Activity186Controller.instance:dispatchEvent(Activity186Event.FinishGame)
end

function Activity186Rpc:sendGetAct186OnceBonusRequest(activityId)
	local req = Activity186Module_pb.GetAct186OnceBonusRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function Activity186Rpc:onReceiveGetAct186OnceBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity186Model.instance:onGetOnceBonusReply(msg)
	Activity186Controller.instance:dispatchEvent(Activity186Event.GetOnceBonus)
end

Activity186Rpc.instance = Activity186Rpc.New()

return Activity186Rpc
