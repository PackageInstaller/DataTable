-- chunkname: @modules/logic/versionactivity2_8/molideer/rpc/MoLiDeErRpc.lua

module("modules.logic.versionactivity2_8.molideer.rpc.MoLiDeErRpc", package.seeall)

local MoLiDeErRpc = class("MoLiDeErRpc", BaseRpc)

function MoLiDeErRpc:sendAct194GetInfosRequest(activityId, callback, callbackObj)
	local req = Activity194Module_pb.Act194GetInfosRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function MoLiDeErRpc:onReceiveAct194GetInfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MoLiDeErModel.instance:onGetActInfo(msg)
end

function MoLiDeErRpc:sendAct194EnterEpisodeRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity194Module_pb.Act194EnterEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function MoLiDeErRpc:onReceiveAct194EnterEpisodeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local episodeInfo = msg.episodeInfo

	MoLiDeErGameModel.instance:setEpisodeInfo(activityId, episodeInfo)
end

function MoLiDeErRpc:sendAct194FinishStoryEpisodeRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity194Module_pb.Act194FinishStoryEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function MoLiDeErRpc:onReceiveAct194FinishStoryEpisodeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local episodeId = msg.episodeId

	MoLiDeErController.instance:episodeFinish(activityId, episodeId)
end

function MoLiDeErRpc:sendAct194GetEpisodeInfoRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity194Module_pb.Act194GetEpisodeInfoRequest()

	req.activityId = activityId
	req.episodeId = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function MoLiDeErRpc:onReceiveAct194GetEpisodeInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local episodeInfo = msg.episodeInfo

	MoLiDeErGameModel.instance:setEpisodeInfo(activityId, episodeInfo)
end

function MoLiDeErRpc:sendAct194SendTeamExploreRequest(activityId, episodeId, eventId, teamId, optionId, callback, callbackObj)
	local req = Activity194Module_pb.Act194SendTeamExploreRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.eventId = eventId
	req.teamId = teamId
	req.optionId = optionId

	self:sendMsg(req, callback, callbackObj)
end

function MoLiDeErRpc:onReceiveAct194SendTeamExploreReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MoLiDeErGameController.instance:onDispatchTeam(msg)
end

function MoLiDeErRpc:sendAct194UseItemRequest(activityId, episodeId, itemId, callback, callbackObj)
	local req = Activity194Module_pb.Act194UseItemRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.itemId = itemId

	self:sendMsg(req, callback, callbackObj)
end

function MoLiDeErRpc:onReceiveAct194UseItemReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MoLiDeErGameController.instance:onUseItem(msg)
end

function MoLiDeErRpc:sendAct194NextRoundRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity194Module_pb.Act194NextRoundRequest()

	req.activityId = activityId
	req.episodeId = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function MoLiDeErRpc:onReceiveAct194NextRoundReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function MoLiDeErRpc:sendAct194WithdrawTeamRequest(activityId, episodeId, teamId, callback, callbackObj)
	local req = Activity194Module_pb.Act194WithdrawTeamRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.teamId = teamId

	self:sendMsg(req, callback, callbackObj)
end

function MoLiDeErRpc:onReceiveAct194WithdrawTeamReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local teamId = msg.teamId

	MoLiDeErGameController.instance:onWithdrawReply(teamId)
end

function MoLiDeErRpc:sendAct194ResetEpisodeRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity194Module_pb.Act194ResetEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function MoLiDeErRpc:onReceiveAct194ResetEpisodeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function MoLiDeErRpc:sendAct194SkipEpisodeRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity194Module_pb.Act194SkipEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function MoLiDeErRpc:onReceiveAct194SkipEpisodeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local episodeId = msg.episodeId

	MoLiDeErGameController.instance:onReceiveSkipGame(activityId, episodeId)
end

function MoLiDeErRpc:onReceiveAct194EpisodeRecordsPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local episodeRecords = msg.episodeRecords

	MoLiDeErController.instance:onReceiveEpisodeInfo(activityId, episodeRecords)
end

function MoLiDeErRpc:onReceiveAct194EpisodeInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MoLiDeErGameController.instance:onEpisodeInfoPush(msg)
end

function MoLiDeErRpc:onReceiveAct194NewEventInfosPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function MoLiDeErRpc:onReceiveAct194EpisodeFinishPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

MoLiDeErRpc.instance = MoLiDeErRpc.New()

return MoLiDeErRpc
