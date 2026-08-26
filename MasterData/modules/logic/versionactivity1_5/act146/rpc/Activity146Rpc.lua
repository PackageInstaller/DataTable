-- chunkname: @modules/logic/versionactivity1_5/act146/rpc/Activity146Rpc.lua

module("modules.logic.versionactivity1_5.act146.rpc.Activity146Rpc", package.seeall)

local Activity146Rpc = class("Activity146Rpc", BaseRpc)

function Activity146Rpc:sendGetAct146InfosRequest(actId)
	local req = Activity146Module_pb.GetAct146InfosRequest()

	req.activityId = actId

	self:sendMsg(req)
end

function Activity146Rpc:onReceiveGetAct146InfosReply(resultCode, msg)
	if resultCode == 0 then
		Activity146Model.instance:setActivityInfo(msg.act146Episodes)
		Activity146Controller.instance:onActModelUpdate()
	end
end

function Activity146Rpc:sendFinishAct146EpisodeRequest(actId, episodeId)
	local req = Activity146Module_pb.FinishAct146EpisodeRequest()

	req.activityId = actId
	req.episodeId = episodeId

	self:sendMsg(req)
end

function Activity146Rpc:onReceiveFinishAct146EpisodeReply(resultCode, msg)
	if resultCode == 0 then
		Activity146Model.instance:setActivityInfo(msg.updateAct146Episodes)
		Activity146Controller.instance:onActModelUpdate()
	end
end

function Activity146Rpc:sendAct146EpisodeBonusRequest(actId, episodeId)
	local req = Activity146Module_pb.Act146EpisodeBonusRequest()

	req.activityId = actId
	req.episodeId = episodeId

	self:sendMsg(req)
end

function Activity146Rpc:onReceiveAct146EpisodeBonusReply(resultCode, msg)
	if resultCode == 0 then
		Activity146Model.instance:setActivityInfo(msg.updateAct146Episodes)
		Activity146Controller.instance:onActModelUpdate()
	end
end

Activity146Rpc.instance = Activity146Rpc.New()

return Activity146Rpc
