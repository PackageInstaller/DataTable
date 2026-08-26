-- chunkname: @modules/logic/versionactivity1_4/act130/rpc/Activity130Rpc.lua

module("modules.logic.versionactivity1_4.act130.rpc.Activity130Rpc", package.seeall)

local Activity130Rpc = class("Activity130Rpc", BaseRpc)

Activity130Rpc.instance = Activity130Rpc.New()

function Activity130Rpc:sendGet130InfosRequest(activityId, callback, callbackObj)
	local req = Activity130Module_pb.Get130InfosRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity130Rpc:onReceiveGet130InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity130Model.instance:setInfos(msg.infos)
	Activity130Controller.instance:dispatchEvent(Activity130Event.OnGetInfoSuccess)
end

function Activity130Rpc:sendAct130StoryRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity130Module_pb.Act130StoryRequest()

	req.activityId = activityId
	req.episodeId = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function Activity130Rpc:onReceiveAct130StoryReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity130Model.instance:updateProgress(msg.episodeId, msg.progress)
	Activity130Controller.instance:dispatchEvent(Activity130Event.OnStoryFinishedSuccess)
end

function Activity130Rpc:sendAct130GeneralRequest(activityId, episodeId, elementId, callback, callbackObj)
	local req = Activity130Module_pb.Act130GeneralRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.elementId = elementId

	self:sendMsg(req, callback, callbackObj)
end

function Activity130Rpc:onReceiveAct130GeneralReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity130Controller.instance:dispatchEvent(Activity130Event.OnGeneralGameSuccess)
end

function Activity130Rpc:sendAct130DialogRequest(activityId, episodeId, elementId, option)
	local req = Activity130Module_pb.Act130DialogRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.elementId = elementId
	req.option = option

	self:sendMsg(req)
end

function Activity130Rpc:onReceiveAct130DialogReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local elementId = msg.elementId

	Activity130Controller.instance:dispatchEvent(Activity130Event.OnDialogMarkSuccess, elementId)
end

function Activity130Rpc:sendAct130DialogHistoryRequest(activityId, episodeId, elementId, historylist)
	local req = Activity130Module_pb.Act130DialogHistoryRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.elementId = elementId

	for _, v in ipairs(historylist) do
		table.insert(req.historylist, v)
	end

	self:sendMsg(req)
end

function Activity130Rpc:onReceiveAct130DialogHistoryReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity130Controller.instance:dispatchEvent(Activity130Event.OnDialogHistorySuccess)
end

function Activity130Rpc:onReceiveAct130ElementsPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity130Model.instance:updateInfos(msg.act130Info)
	Activity130Controller.instance:dispatchEvent(Activity130Event.OnElementUpdate)
end

function Activity130Rpc:sendAct130RestartEpisodeRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity130Module_pb.Act130RestartEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function Activity130Rpc:onReceiveAct130RestartEpisodeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity130Model.instance:updateInfos(msg.infos)
	Activity130Controller.instance:dispatchEvent(Activity130Event.OnRestartEpisodeSuccess)
end

function Activity130Rpc:addGameChallengeNum(episodeId)
	local req = Activity130Module_pb.Act130StartGameRequest()

	req.activityId = VersionActivity1_4Enum.ActivityId.Role37
	req.episodeId = episodeId

	self:sendMsg(req)
end

function Activity130Rpc:onReceiveAct130StartGameReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity130Model.instance:updateChallengeNum(msg.episodeId, msg.startGameTimes)
end

Activity130Rpc.instance = Activity130Rpc.New()

return Activity130Rpc
