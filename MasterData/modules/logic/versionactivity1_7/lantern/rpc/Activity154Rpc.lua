-- chunkname: @modules/logic/versionactivity1_7/lantern/rpc/Activity154Rpc.lua

module("modules.logic.versionactivity1_7.lantern.rpc.Activity154Rpc", package.seeall)

local Activity154Rpc = class("Activity154Rpc", BaseRpc)

function Activity154Rpc:sendGet154InfosRequest(activityId, callback, callbackObj)
	local req = Activity154Module_pb.Get154InfosRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity154Rpc:onReceiveGet154InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	LanternFestivalModel.instance:setActivity154Infos(msg)
	LanternFestivalController.instance:dispatchEvent(LanternFestivalEvent.InfosRefresh)
end

function Activity154Rpc:sendAnswer154PuzzleRequest(activityId, puzzleId, optionId, callback, callbackObj)
	local req = Activity154Module_pb.Answer154PuzzleRequest()

	req.activityId = activityId
	req.puzzleId = puzzleId
	req.optionId = optionId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity154Rpc:onReceiveAnswer154PuzzleReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	LanternFestivalModel.instance:updatePuzzleInfo(msg.info)
	LanternFestivalModel.instance:setCurPuzzleId(0)
	LanternFestivalController.instance:dispatchEvent(LanternFestivalEvent.PuzzleRewardGet)
end

Activity154Rpc.instance = Activity154Rpc.New()

return Activity154Rpc
