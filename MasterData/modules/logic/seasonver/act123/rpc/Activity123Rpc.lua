-- chunkname: @modules/logic/seasonver/act123/rpc/Activity123Rpc.lua

module("modules.logic.seasonver.act123.rpc.Activity123Rpc", package.seeall)

local Activity123Rpc = class("Activity123Rpc", BaseRpc)

function Activity123Rpc:sendGet123InfosRequest(activityId, callback, callbackObj)
	local req = Activity123Module_pb.Get123InfosRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity123Rpc:onReceiveGet123InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Season123Model.instance:setActInfo(msg)
	Season123Controller.instance:dispatchEvent(Season123Event.GetActInfo, msg.activityId)
end

function Activity123Rpc:onReceiveAct123BattleFinishPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Season123Model.instance:updateActInfoBattle(msg)
	Season123Controller.instance:dispatchEvent(Season123Event.GetActInfoBattleFinish)
end

function Activity123Rpc:sendAct123EnterStageRequest(activityId, stage, heroUids, equipUids, callback, callbackObj)
	local req = Activity123Module_pb.Act123EnterStageRequest()

	req.activityId = activityId
	req.stage = stage

	for i = 1, #heroUids do
		req.heroUids:append(heroUids[i])
	end

	return self:sendMsg(req, callback, callbackObj)
end

function Activity123Rpc:onReceiveAct123EnterStageReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Season123EpisodeListController.instance:onReceiveEnterStage(msg.stage)
	Season123Controller.instance:dispatchEvent(Season123Event.EnterStageSuccess)
end

function Activity123Rpc:sendAct123ChangeFightGroupRequest(activityId, groupIndex, callback, callbackObj)
	local req = Activity123Module_pb.Act123ChangeFightGroupRequest()

	req.activityId = activityId
	req.heroGroupSnapshotSubId = groupIndex

	return self:sendMsg(req, callback, callbackObj)
end

function Activity123Rpc:onReceiveAct123ChangeFightGroupReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = Season123Model.instance:getActInfo(msg.activityId)

	if mo then
		mo.heroGroupSnapshotSubId = msg.heroGroupSnapshotSubId

		HeroGroupModel.instance:_setSingleGroup()
		Season123Controller.instance:dispatchEvent(Season123Event.HeroGroupIndexChanged, {
			actId = msg.activityId,
			groupIndex = msg.heroGroupSnapshotSubId
		})
	end
end

function Activity123Rpc:sendAct123EndStageRequest(activityId, stage, callback, callbackObj)
	local req = Activity123Module_pb.Act123EndStageRequest()

	req.activityId = activityId
	req.stage = stage

	return self:sendMsg(req, callback, callbackObj)
end

function Activity123Rpc:onReceiveAct123EndStageReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Season123Controller.instance:dispatchEvent(Season123Event.ResetStageFinished, msg.activityId)
end

function Activity123Rpc:onReceiveAct123ItemChangePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local curSeasonId = Season123Model.instance:getCurSeasonId()

	Season123Model.instance:updateItemMap(curSeasonId, msg.act123Items, msg.deleteItems)
	Season123Controller.instance:dispatchEvent(Season123Event.OnEquipItemChange)
end

function Activity123Rpc:sendStartAct123BattleRequest(activityId, layer, chapterId, episodeId, fightParam, multiplication, endAdventure, useRecord, isRestart, callback, callbackObj)
	local req = Activity123Module_pb.StartAct123BattleRequest()

	req.activityId = activityId
	req.layer = layer

	DungeonRpc.instance:packStartDungeonRequest(req.startDungeonRequest, chapterId, episodeId, fightParam, multiplication, endAdventure, useRecord, isRestart)
	Season123HeroGroupUtils.processFightGroupAssistHero(ModuleEnum.HeroGroupType.Season123, req.startDungeonRequest.fightGroup, useRecord)

	return self:sendMsg(req, callback, callbackObj)
end

function Activity123Rpc:onReceiveStartAct123BattleReply(resultCode, msg)
	if resultCode == 0 then
		local battleContext = Season123Model.instance:getBattleContext()

		if battleContext.actId == msg.activityId and (battleContext.layer == nil or battleContext.layer == msg.layer) then
			local co = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

			if co and DungeonModel.isBattleEpisode(co) then
				DungeonFightController.instance:onReceiveStartDungeonReply(resultCode, msg.startDungeonReply)
			end
		end

		if msg.updateAct123Stages and #msg.updateAct123Stages > 0 then
			local seasonMO = Season123Model.instance:getActInfo(msg.activityId)

			if seasonMO then
				seasonMO:updateStages(msg.updateAct123Stages)
				Season123Controller.instance:dispatchEvent(Season123Event.StageInfoChanged)
			end
		end
	else
		Season123Controller.instance:dispatchEvent(Season123Event.StartFightFailed)
	end
end

function Activity123Rpc:sendComposeAct123EquipRequest(activityId, equipId, callback, callbackObj)
	local req = Activity123Module_pb.ComposeAct123EquipRequest()

	req.activityId = activityId
	req.equipId = equipId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity123Rpc:onReceiveComposeAct123EquipReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Season123EquipBookModel.instance:refreshBackpack()
	Season123DecomposeModel.instance:initDatas(msg.activityId)
	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnItemChange)
end

function Activity123Rpc:sendDecomposeAct123EquipRequest(activityId, equipUids, callback, callbackObj)
	local req = Activity123Module_pb.DecomposeAct123EquipRequest()

	req.activityId = activityId

	for i, v in pairs(equipUids) do
		table.insert(req.equipUids, v)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function Activity123Rpc:onReceiveDecomposeAct123EquipReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Season123DecomposeModel.instance:removeHasDecomposeItems(msg.equipUids)
	Season123EquipController.instance:checkHeroGroupCardExist(msg.activityId)
	Season123EquipBookModel.instance:removeDecomposeEquipItem(msg.equipUids)
	Season123DecomposeModel.instance:initDatas(msg.activityId)
	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnItemChange)
	Season123EquipBookController.instance:dispatchEvent(Season123Event.CloseBatchDecomposeEffect)
end

function Activity123Rpc:sendAct123OpenCardBagRequest(activityId, itemId, callback, callbackObj)
	local req = Activity123Module_pb.Act123OpenCardBagRequest()

	req.activityId = activityId
	req.itemId = itemId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity123Rpc:onReceiveAct123OpenCardBagReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Season123CardPackageModel.instance:initData(msg.activityId)
	Season123CardPackageModel.instance:setCardItemList(msg.act123EquipIds)
	Season123Controller.instance:dispatchEvent(Season123Event.OnCardPackageOpen)
end

function Activity123Rpc:sendAct123ResetOtherStageRequest(actId, stage, callback, callbackObj)
	local req = Activity123Module_pb.Act123ResetOtherStageRequest()

	req.activityId = actId
	req.enterStage = stage

	return self:sendMsg(req, callback, callbackObj)
end

function Activity123Rpc:onReceiveAct123ResetOtherStageReply(resultCode, msg)
	if resultCode == 0 and msg.updateAct123Stages and #msg.updateAct123Stages > 0 then
		local seasonMO = Season123Model.instance:getActInfo(msg.activityId)

		if seasonMO then
			seasonMO:updateStages(msg.updateAct123Stages)
			Season123Controller.instance:dispatchEvent(Season123Event.StageInfoChanged)
		end
	end
end

function Activity123Rpc:sendAct123ResetHighLayerRequest(actId, stage, layer, callback, callbackObj)
	local req = Activity123Module_pb.Act123ResetHighLayerRequest()

	req.activityId = actId
	req.stage = stage
	req.layer = layer

	return self:sendMsg(req, callback, callbackObj)
end

function Activity123Rpc:onReceiveAct123ResetHighLayerReply(resultCode, msg)
	if resultCode == 0 and msg.updateAct123Stages and #msg.updateAct123Stages > 0 then
		local seasonMO = Season123Model.instance:getActInfo(msg.activityId)

		if seasonMO then
			seasonMO.stage = msg.stage

			seasonMO:updateStages(msg.updateAct123Stages)
			Season123Controller.instance:dispatchEvent(Season123Event.StageInfoChanged)
		end
	end
end

function Activity123Rpc:sendGetUnlockAct123EquipIdsRequest(actId, callback, callbackObj)
	local req = Activity123Module_pb.GetUnlockAct123EquipIdsRequest()

	req.activityId = actId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity123Rpc:onReceiveGetUnlockAct123EquipIdsReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Season123Model.instance:setUnlockAct123EquipIds(msg)
end

function Activity123Rpc:sendGetAct123StageRecordRequest(actId, stage, cb, cbObj)
	local req = Activity123Module_pb.GetAct123StageRecordRequest()

	req.activityId = actId
	req.stage = stage

	return self:sendMsg(req, cb, cbObj)
end

function Activity123Rpc:onReceiveGetAct123StageRecordReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Season123RecordModel.instance:setSeason123ServerRecordData(msg)
end

function Activity123Rpc:sendAct123ReceiveStageBonusRequest(actId, stage, callback, callbackObj)
	local req = Activity123Module_pb.Act123ReceiveStageBonusRequest()

	req.activityId = actId
	req.stage = stage

	return self:sendMsg(req, callback, callbackObj)
end

function Activity123Rpc:onReceiveAct123ReceiveStageBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Season123Model.instance:setGetStageBonus(msg)
	Season123Controller.instance:dispatchEvent(Season123Event.StageRewardGet)
end

Activity123Rpc.instance = Activity123Rpc.New()

return Activity123Rpc
