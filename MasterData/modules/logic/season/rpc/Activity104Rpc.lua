-- chunkname: @modules/logic/season/rpc/Activity104Rpc.lua

module("modules.logic.season.rpc.Activity104Rpc", package.seeall)

local Activity104Rpc = class("Activity104Rpc", BaseRpc)

function Activity104Rpc:sendGet104InfosRequest(activityId, callback, callbackObj)
	local req = Activity104Module_pb.Get104InfosRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity104Rpc:onReceiveGet104InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity104Model.instance:setActivity104Info(msg)
	Activity104EquipController.instance:checkHeroGroupCardExist(msg.activityId)
	Activity104Controller.instance:dispatchEvent(Activity104Event.GetAct104Info)
end

function Activity104Rpc:sendBeforeStartAct104BattleRequest(activityId, layer, episodeId, callback, callbackObj)
	local req = Activity104Module_pb.BeforeStartAct104BattleRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.layer = layer

	return self:sendMsg(req, callback, callbackObj)
end

function Activity104Rpc:onReceiveBeforeStartAct104BattleReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity104Controller.instance:dispatchEvent(Activity104Event.StartAct104BattleReply, msg)
end

function Activity104Rpc:sendStartAct104BattleRequest(dungeonParam, activityId, layer, episodeId, callback, callbackObj)
	local req = Activity104Module_pb.StartAct104BattleRequest()

	self:setStartDungeonReq(req.startDungeonRequest, dungeonParam)

	req.activityId = activityId
	req.episodeId = episodeId
	req.layer = layer or 0

	return self:sendMsg(req, callback, callbackObj)
end

function Activity104Rpc:setStartDungeonReq(req, dungeonParam)
	if not dungeonParam.endAdventure then
		DungeonModel.instance:SetSendChapterEpisodeId(dungeonParam.chapterId, dungeonParam.episodeId)
	end

	req.chapterId = dungeonParam.chapterId
	req.episodeId = dungeonParam.episodeId

	if dungeonParam.isRestart then
		req.isRestart = dungeonParam.isRestart
	end

	local fightParam = dungeonParam.fightParam

	if fightParam then
		if HeroGroupBalanceHelper.getIsBalanceMode() then
			req.isBalance = true
		end

		fightParam:setReqFightGroup(req)

		local episode_config = fightParam:getCurEpisodeConfig()

		if episode_config and not Activity104Model.instance:isSeasonEpisodeType(episode_config.type) then
			for i = #req.fightGroup.activity104Equips, 1, -1 do
				table.remove(req.fightGroup.activity104Equips, i)
			end
		end
	end

	req.multiplication = dungeonParam.multiplication or 1

	if dungeonParam.useRecord == true then
		req.useRecord = dungeonParam.useRecord
	end

	VersionActivityDungeonBaseController.instance:resetIsFirstPassEpisode(dungeonParam.episodeId)
end

function Activity104Rpc:onReceiveStartAct104BattleReply(resultCode, msg)
	DungeonRpc.instance:onReceiveStartDungeonReply(resultCode, msg.startDungeonReply)
end

function Activity104Rpc:onReceiveAct104BattleFinishPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity104Model.instance:updateActivity104Info(msg)
	Activity104Controller.instance:dispatchEvent(Activity104Event.GetAct104BattleFinish)
end

function Activity104Rpc:onReceiveActivity104ItemChangePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity104Model.instance:updateItemChange(msg)
	Activity104Controller.instance:dispatchEvent(Activity104Event.GetAct104ItemChange)
end

function Activity104Rpc:sendRefreshRetailRequest(activityId, callback, callbackObj)
	local req = Activity104Module_pb.RefreshRetailRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity104Rpc:onReceiveRefreshRetailReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity104Model.instance:replaceAct104Retails(msg)
	Activity104Controller.instance:dispatchEvent(Activity104Event.RefreshRetail)
end

function Activity104Rpc:sendOptionalActivity104EquipRequest(activityId, optionEquipId, equipId, callback, callbackObj)
	local req = Activity104Module_pb.OptionalActivity104EquipRequest()

	req.activityId = activityId
	req.optionalEquipUid = optionEquipId
	req.equipId = equipId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity104Rpc:onReceiveOptionalActivity104EquipReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity104Controller.instance:dispatchEvent(Activity104Event.OptionalEquip)
end

function Activity104Rpc:sendChangeFightGroupRequest(activityId, heroGroupSnapshotSubId, callback, callbackObj)
	local req = Activity104Module_pb.ChangeFightGroupRequest()

	req.activityId = activityId
	req.heroGroupSnapshotSubId = heroGroupSnapshotSubId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity104Rpc:onReceiveChangeFightGroupReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity104Model.instance:setSeasonCurSnapshotSubId(msg.activityId, msg.heroGroupSnapshotSubId)
	Activity104Controller.instance:dispatchEvent(Activity104Event.SwitchSnapshotSubId)
end

function Activity104Rpc:sendComposeActivity104EquipRequest(activityId, equipIdUids)
	local req = Activity104Module_pb.ComposeActivity104EquipRequest()

	req.activityId = activityId

	for i, uid in ipairs(equipIdUids) do
		req.equipIdUids:append(uid)
	end

	return self:sendMsg(req)
end

function Activity104Rpc:onReceiveComposeActivity104EquipReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity104EquipController.instance:checkHeroGroupCardExist(msg.activityId)
	Activity104EquipComposeController.instance:dispatchEvent(Activity104Event.OnComposeSuccess, msg.activityId)
end

function Activity104Rpc:sendGetUnlockActivity104EquipIdsRequest(activityId)
	local req = Activity104Module_pb.GetUnlockActivity104EquipIdsRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function Activity104Rpc:onReceiveGetUnlockActivity104EquipIdsReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity104Model.instance:onReceiveGetUnlockActivity104EquipIdsReply(msg)
end

function Activity104Rpc:sendMarkActivity104StoryRequest(activityId)
	local req = Activity104Module_pb.MarkActivity104StoryRequest()

	req.activityId = activityId

	Activity104Model.instance:markActivityStory(activityId)

	return self:sendMsg(req)
end

function Activity104Rpc:onReceiveMarkActivity104StoryReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity104Model.instance:markActivityStory(msg.activityId)
end

function Activity104Rpc:sendMarkEpisodeAfterStoryRequest(activityId, layer)
	local req = Activity104Module_pb.MarkEpisodeAfterStoryRequest()

	req.activityId = activityId
	req.layer = layer

	return self:sendMsg(req)
end

function Activity104Rpc:onReceiveMarkEpisodeAfterStoryReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity104Model.instance:markEpisodeAfterStory(msg.activityId, msg.layer)
end

function Activity104Rpc:sendMarkPopSummaryRequest(activityId)
	local req = Activity104Module_pb.MarkPopSummaryRequest()

	req.activityId = activityId

	return self:sendMsg(req)
end

function Activity104Rpc:onReceiveMarkPopSummaryReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity104Model.instance:MarkPopSummary(msg.activityId)
end

Activity104Rpc.instance = Activity104Rpc.New()

return Activity104Rpc
