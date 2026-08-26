-- chunkname: @modules/logic/versionactivity2_5/act187/rpc/Activity187Rpc.lua

module("modules.logic.versionactivity2_5.act187.rpc.Activity187Rpc", package.seeall)

local Activity187Rpc = class("Activity187Rpc", BaseRpc)

function Activity187Rpc:sendGet187InfoRequest(actId, cb, cbObj)
	local req = Activity187Module_pb.Get187InfoRequest()

	req.activityId = actId

	self:sendMsg(req, cb, cbObj)
end

function Activity187Rpc:onReceiveGet187InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local checkResult = Activity187Model.instance:checkActId(msg.activityId)

	if not checkResult then
		return
	end

	Activity187Model.instance:setAct187Info(msg)
	Activity187Controller.instance:dispatchEvent(Activity187Event.GetAct187Info)
end

function Activity187Rpc:sendAct187FinishGameRequest(actId, cb, cbObj)
	local req = Activity187Module_pb.Act187FinishGameRequest()

	req.activityId = actId

	self:sendMsg(req, cb, cbObj)
end

function Activity187Rpc:onReceiveAct187FinishGameReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local checkResult = Activity187Model.instance:checkActId(msg.activityId)

	if not checkResult then
		return
	end

	Activity187Model.instance:setRemainPaintingCount(msg.haveGameCount)
	Activity187Model.instance:setFinishPaintingIndex(msg.finishGameCount)
	Activity187Model.instance:setPaintingRewardList(msg.finishGameCount, msg.randomBonusList)
	Activity187Controller.instance:dispatchEvent(Activity187Event.FinishPainting, msg.finishGameCount)
end

function Activity187Rpc:sendAct187AcceptRewardRequest(actId, cb, cbObj)
	local req = Activity187Module_pb.Act187AcceptRewardRequest()

	req.activityId = actId

	self:sendMsg(req, cb, cbObj)
end

function Activity187Rpc:onReceiveAct187AcceptRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local checkResult = Activity187Model.instance:checkActId(msg.activityId)

	if not checkResult then
		return
	end

	local materialDataMOList = MaterialRpc.receiveMaterial({
		dataList = msg.fixBonusList
	})

	Activity187Controller.instance:dispatchEvent(Activity187Event.GetAccrueReward, materialDataMOList)
	Activity187Model.instance:setAccrueRewardIndex(msg.acceptRewardGameCount)
	Activity187Controller.instance:dispatchEvent(Activity187Event.RefreshAccrueReward)
end

Activity187Rpc.instance = Activity187Rpc.New()

return Activity187Rpc
