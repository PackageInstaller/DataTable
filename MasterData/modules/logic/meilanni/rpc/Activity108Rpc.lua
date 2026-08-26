-- chunkname: @modules/logic/meilanni/rpc/Activity108Rpc.lua

module("modules.logic.meilanni.rpc.Activity108Rpc", package.seeall)

local Activity108Rpc = class("Activity108Rpc", BaseRpc)

function Activity108Rpc:sendGet108InfosRequest(activityId, callback, callbackObj)
	local req = Activity108Module_pb.Get108InfosRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity108Rpc:onReceiveGet108InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local infos = msg.infos

	MeilanniModel.instance:updateMapList(infos)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.getInfo)
end

function Activity108Rpc:sendResetMapRequest(activityId, mapId, callback, callbackObj)
	local req = Activity108Module_pb.ResetMapRequest()

	req.activityId = activityId
	req.mapId = mapId

	self:sendMsg(req, callback, callbackObj)
end

function Activity108Rpc:onReceiveResetMapReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	MeilanniModel.instance:updateMapInfo(info)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.resetMap)
	MeilanniController.instance:statStart()
end

function Activity108Rpc:sendDialogEventSelectRequest(activityId, eventId, historylist, option)
	self._selectEventId = eventId

	local req = Activity108Module_pb.DialogEventSelectRequest()

	req.activityId = activityId
	req.eventId = eventId

	for i, v in ipairs(historylist) do
		table.insert(req.historylist, v)
	end

	req.option = option

	self:sendMsg(req)
end

function Activity108Rpc:onReceiveDialogEventSelectReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	if msg:HasField("mapInfo") then
		local mapInfo = MeilanniModel.instance:getMapInfo(msg.mapInfo.mapId)
		local oldRules = mapInfo:getExcludeRules()
		local oldThreat = mapInfo:getThreat()

		MeilanniModel.instance:updateMapExcludeRules(msg.mapInfo)

		local newRules = mapInfo:getExcludeRules()

		if #oldRules ~= #newRules then
			MeilanniController.instance:dispatchEvent(MeilanniEvent.updateExcludeRules, {
				oldRules,
				newRules,
				oldThreat
			})
		end
	end

	MeilanniModel.instance:updateEpisodeInfo(info)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.episodeInfoUpdate, self._selectEventId)
end

function Activity108Rpc:sendEnterFightEventRequest(activityId, eventId)
	local req = Activity108Module_pb.EnterFightEventRequest()

	req.activityId = activityId
	req.eventId = eventId

	self:sendMsg(req)
end

function Activity108Rpc:onReceiveEnterFightEventReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local eventId = msg.eventId

	MeilanniController.instance:enterFight(eventId)
end

function Activity108Rpc:sendEpisodeConfirmRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity108Module_pb.EpisodeConfirmRequest()

	req.activityId = activityId
	req.episodeId = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function Activity108Rpc:onReceiveEpisodeConfirmReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MeilanniController.instance:dispatchEvent(MeilanniEvent.episodeInfoUpdate)
end

function Activity108Rpc:sendGet108BonusRequest(activityId, id)
	local req = Activity108Module_pb.Get108BonusRequest()

	req.activityId = activityId
	req.id = id

	self:sendMsg(req)
end

function Activity108Rpc:onReceiveGet108BonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MeilanniController.instance:dispatchEvent(MeilanniEvent.bonusReply)
end

function Activity108Rpc:onReceiveEpisodeUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	MeilanniModel.instance:updateEpisodeInfo(info)
end

function Activity108Rpc:onReceiveInfoUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local infos = msg.infos

	MeilanniModel.instance:updateMapList(infos)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.getInfo)
end

Activity108Rpc.instance = Activity108Rpc.New()

return Activity108Rpc
