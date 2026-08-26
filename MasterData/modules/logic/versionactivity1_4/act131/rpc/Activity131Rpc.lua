-- chunkname: @modules/logic/versionactivity1_4/act131/rpc/Activity131Rpc.lua

module("modules.logic.versionactivity1_4.act131.rpc.Activity131Rpc", package.seeall)

local Activity131Rpc = class("Activity131Rpc", BaseRpc)

Activity131Rpc.instance = Activity131Rpc.New()

function Activity131Rpc:sendGet131InfosRequest(activityId, callback, callbackObj)
	local req = Activity131Module_pb.Get131InfosRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity131Rpc:onReceiveGet131InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity131Model.instance:setInfos(msg.infos)
	Activity131Controller.instance:dispatchEvent(Activity131Event.OnGetInfoSuccess)
end

function Activity131Rpc:sendAct131StoryRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity131Module_pb.Act131StoryRequest()

	req.activityId = activityId
	req.episodeId = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function Activity131Rpc:onReceiveAct131StoryReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity131Model.instance:updateProgress(msg.episodeId, msg.progress)
	Activity131Controller.instance:dispatchEvent(Activity131Event.OnStoryFinishedSuccess)
end

function Activity131Rpc:sendAct131GeneralRequest(activityId, episodeId, elementId, callback, callbackObj)
	local req = Activity131Module_pb.Act131GeneralRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.elementId = elementId

	self:sendMsg(req, callback, callbackObj)
end

function Activity131Rpc:onReceiveAct131GeneralReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.OnGeneralGameSuccess)
end

function Activity131Rpc:sendAct131DialogRequest(activityId, episodeId, elementId, option)
	local req = Activity131Module_pb.Act131DialogRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.elementId = elementId
	req.option = option

	self:sendMsg(req)
end

function Activity131Rpc:onReceiveAct131DialogReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.OnDialogMarkSuccess)
end

function Activity131Rpc:sendAct131DialogHistoryRequest(activityId, episodeId, elementId, historylist)
	local req = Activity131Module_pb.Act131DialogHistoryRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.elementId = elementId

	for _, v in ipairs(historylist) do
		table.insert(req.historylist, v)
	end

	self:sendMsg(req)
end

function Activity131Rpc:onReceiveAct131DialogHistoryReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.OnDialogHistorySuccess)
end

function Activity131Rpc:onReceiveAct131ElementsPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity131Model.instance:updateInfos(msg.act131Info)
	Activity131Model.instance:refreshLogDics()
	Activity131Controller.instance:dispatchEvent(Activity131Event.OnElementUpdate)
end

function Activity131Rpc:sendAct131RestartEpisodeRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity131Module_pb.Act131RestartEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function Activity131Rpc:onReceiveAct131RestartEpisodeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity131Model.instance:updateInfos(msg.infos)
	Activity131Controller.instance:dispatchEvent(Activity131Event.OnRestartEpisodeSuccess)
end

function Activity131Rpc:sendBeforeAct131BattleRequest(activityId, episodeId, elementId)
	local req = Activity131Module_pb.BeforeAct131BattleRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.elementId = elementId

	self:sendMsg(req)
end

function Activity131Rpc:onReceiveBeforeAct131BattleReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.OnBattleBeforeSucess, msg.elementId)
end

Activity131Rpc.instance = Activity131Rpc.New()

return Activity131Rpc
