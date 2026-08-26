-- chunkname: @modules/logic/versionactivity2_5/challenge/rpc/Activity183Rpc.lua

module("modules.logic.versionactivity2_5.challenge.rpc.Activity183Rpc", package.seeall)

local Activity183Rpc = class("Activity183Rpc", BaseRpc)

function Activity183Rpc:sendAct183GetInfoRequest(activityId, callback, callbackObj)
	local req = Activity183Module_pb.Act183GetInfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity183Rpc:onReceiveAct183GetInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Act183Model.instance:init(msg.activityId, msg.actInfo)
end

function Activity183Rpc:sendAct183ResetGroupRequest(activityId, groupId)
	local req = Activity183Module_pb.Act183ResetGroupRequest()

	req.activityId = activityId
	req.groupId = groupId

	return self:sendMsg(req)
end

function Activity183Rpc:onReceiveAct183ResetGroupReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local groupInfo = msg.group

	Act183Controller.instance:updateResetGroupEpisodeInfo(activityId, groupInfo)
end

function Activity183Rpc:sendAct183ResetEpisodeRequest(activityId, episodeId)
	local req = Activity183Module_pb.Act183ResetEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId

	return self:sendMsg(req)
end

function Activity183Rpc:onReceiveAct183ResetEpisodeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local groupInfo = msg.group

	Act183Controller.instance:updateResetEpisodeInfo(groupInfo)
end

function Activity183Rpc:sendAct183ChooseRepressRequest(activityId, episodeId, ruleIndex, heroIndex, callback, callbackObj)
	local req = Activity183Module_pb.Act183ChooseRepressRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.ruleIndex = ruleIndex
	req.heroIndex = heroIndex

	return self:sendMsg(req, callback, callbackObj)
end

function Activity183Rpc:onReceiveAct183ChooseRepressReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local episodeId = msg.episodeId
	local repressInfo = msg.repress

	Act183Controller.instance:updateChooseRepressInfo(episodeId, repressInfo)
end

function Activity183Rpc:sendAct183GetRecordRequest(activityId, callback, callbackObj)
	local req = Activity183Module_pb.Act183GetRecordRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity183Rpc:onReceiveAct183GetRecordReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local groupList = Act183Helper.rpcInfosToList(msg.groupList, Act183GroupEpisodeRecordMO, activityId)

	Act183ReportListModel.instance:init(activityId, groupList)
end

function Activity183Rpc:sendAct183ReplaceResultRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity183Module_pb.Act183ReplaceResultRequest()

	req.activityId = activityId
	req.episodeId = episodeId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity183Rpc:onReceiveAct183ReplaceResultReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local episodeNO = msg.episode
	local episodeId = episodeNO.episodeId
	local episodeMo = Act183Model.instance:getEpisodeMo(activityId, episodeId)

	if episodeMo then
		episodeMo:init(episodeNO)
	end
end

function Activity183Rpc:onReceiveAct183BadgeNumUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local badgeNum = msg.badgeNum
	local actInfo = Act183Model.instance:getActInfo()

	actInfo:updateBadgeNum(badgeNum)
	Act183Controller.instance:dispatchEvent(Act183Event.OnUpdateBadgeNum)
	Act183Controller.instance:dispatchEvent(Act183Event.RefreshMedalReddot)
end

function Activity183Rpc:onReceiveAct183BattleFinishPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local episodeMo = Act183EpisodeMO.New()

	episodeMo:init(msg.episode)

	local fightResultMo

	if msg:HasField("fightResult") then
		fightResultMo = Act183FightResultMO.New()

		fightResultMo:init(msg.fightResult)
	end

	local record

	if msg:HasField("record") then
		record = Act183GroupEpisodeRecordMO.New()

		record:init(msg.record)
	end

	local battleFinishedInfo = {
		activityId = activityId,
		episodeMo = episodeMo,
		groupFinished = msg.groupFinished,
		win = msg.win,
		record = record,
		reChallenge = msg.reChallenge,
		fightResultMo = fightResultMo,
		params = msg.params
	}

	Act183Model.instance:recordBattleFinishedInfo(battleFinishedInfo)
end

Activity183Rpc.instance = Activity183Rpc.New()

return Activity183Rpc
