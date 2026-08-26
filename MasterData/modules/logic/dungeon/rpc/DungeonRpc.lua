-- chunkname: @modules/logic/dungeon/rpc/DungeonRpc.lua

module("modules.logic.dungeon.rpc.DungeonRpc", package.seeall)

local DungeonRpc = class("DungeonRpc", BaseRpc)

function DungeonRpc:sendGetDungeonRequest(callback, callbackObj)
	local req = DungeonModule_pb.GetDungeonRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function DungeonRpc:onReceiveGetDungeonReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mapIds = msg.mapIds
	local elements = msg.elements
	local rewardPointInfo = msg.rewardPointInfo
	local equipSpChapters = msg.equipSpChapters
	local chapterTypeNums = msg.chapterTypeNums
	local finishElements = msg.finishElements

	DungeonMapModel.instance:addFinishedElements(finishElements)
	DungeonMapModel.instance:updateMapIds(mapIds)
	DungeonMapModel.instance:addElements(elements)
	DungeonMapModel.instance:initRewardPointInfo(rewardPointInfo)
	DungeonMapModel.instance:initEquipSpChapters(equipSpChapters)
	DungeonMapModel.instance:initMapPuzzleStatus(msg.finishPuzzles)
	DungeonModel.instance:setChapterTypeNums(chapterTypeNums)

	DungeonModel.instance.dungeonInfoCount = msg.dungeonInfoSize

	if msg.dungeonInfoSize <= 0 then
		DungeonModel.instance:initDungeonInfoList({})
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo)
	end
end

function DungeonRpc:onReceiveDungeonInfosPush(resultCode, msg)
	local dungeonInfoList = msg.dungeonInfos

	if #dungeonInfoList <= 0 then
		return
	end

	local isAll = DungeonModel.instance:initDungeonInfoList(dungeonInfoList)

	if isAll then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo)
	end
end

function DungeonRpc:onReceiveDungeonUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local dungeonInfo = msg.dungeonInfo
	local chapterTypeNums = msg.chapterTypeNums

	DungeonModel.instance:setChapterTypeNums(chapterTypeNums)

	if DungeonModel.instance.initAllDungeonInfo then
		DungeonController.instance:onStartLevelOrStoryChange()
	end

	DungeonModel.instance:updateDungeonInfo(dungeonInfo)
	DungeonController.instance:onEndLevelOrStoryChange()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, dungeonInfo)
end

function DungeonRpc:packStartDungeonRequest(req, chapterId, episodeId, fightParam, multiplication, endAdventure, useRecord, isRestart)
	req.chapterId = chapterId
	req.episodeId = episodeId

	if isRestart then
		req.isRestart = isRestart
	end

	if fightParam then
		if HeroGroupBalanceHelper.getIsBalanceMode() then
			req.isBalance = true
		end

		fightParam:setReqFightGroup(req)
		FightModel.instance:recordFightGroup(req.fightGroup)

		local episode_config = fightParam:getCurEpisodeConfig()

		if episode_config and not Activity104Model.instance:isSeasonEpisodeType(episode_config.type) and not Season123Controller.canUse123EquipEpisodeType(episode_config.type) then
			for i = #req.fightGroup.activity104Equips, 1, -1 do
				table.remove(req.fightGroup.activity104Equips, i)
			end
		end

		DungeonPackStartDungeonRequestHelper.packRequestCustomParams(req, episode_config)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnStartDungeonExtraParams, req, episode_config)
	end

	req.multiplication = multiplication or 1

	if useRecord == true then
		req.useRecord = useRecord
	end

	VersionActivityDungeonBaseController.instance:resetIsFirstPassEpisode(episodeId)
end

function DungeonRpc:sendStartDungeonRequest(chapterId, episodeId, fightParam, multiplication, endAdventure, useRecord, isRestart)
	if not endAdventure then
		DungeonModel.instance:SetSendChapterEpisodeId(chapterId, episodeId)
	end

	local req = DungeonModule_pb.StartDungeonRequest()

	self:packStartDungeonRequest(req, chapterId, episodeId, fightParam, multiplication, endAdventure, useRecord, isRestart)
	logNormal(string.format("aaaaaaaaaaaaaaaaaaa StartDungeonRequest chapter_%d episode_%d %s", chapterId or "nil", episodeId or "nil", debug.traceback("", 2)))
	self:sendMsg(req)
end

function DungeonRpc:onReceiveStartDungeonReply(resultCode, msg)
	local co = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if co and DungeonModel.isBattleEpisode(co) then
		DungeonFightController.instance:onReceiveStartDungeonReply(resultCode, msg)
	end
end

function DungeonRpc:sendEndDungeonRequest(isAbort, endType)
	endType = endType or DungeonEnum.EndType.None

	local req = DungeonModule_pb.EndDungeonRequest()

	req.isAbort = isAbort
	req.endType = endType

	self:sendMsg(req)
end

function DungeonRpc:onReceiveEndDungeonReply(resultCode, msg)
	DungeonFightController.instance:onReceiveEndDungeonReply(resultCode, msg)
	DungeonFightController.instance:dispatchEvent(DungeonEvent.OnEndDungeonReply, resultCode)
end

function DungeonRpc:onReceiveEndDungeonPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	FightResultModel.instance:onEndDungeonPush(msg)
	DungeonController.instance:onReceiveEndDungeonReply(resultCode, msg)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnEndDungeonPush, msg)
end

function DungeonRpc:sendMapElementRequest(elementId, dialogIds, cb, cbObj)
	local req = DungeonModule_pb.MapElementRequest()

	req.elementId = elementId

	if dialogIds then
		for _, dialogId in ipairs(dialogIds) do
			table.insert(req.dialogIds, tonumber(dialogId))
		end
	end

	self:sendMsg(req, cb, cbObj)
end

function DungeonRpc:sendMapElementWithRecordRequest(elementId, dialogIds, record, cb, cbObj)
	local req = DungeonModule_pb.MapElementRequest()

	req.elementId = elementId

	if record then
		req.record = record
	end

	if dialogIds then
		for _, dialogId in ipairs(dialogIds) do
			table.insert(req.dialogIds, tonumber(dialogId))
		end
	end

	self:sendMsg(req, cb, cbObj)
end

function DungeonRpc:onReceiveMapElementReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local elementId = msg.elementId

	DungeonModel.instance:startCheckUnlockChapter()
	DungeonMapModel.instance:addFinishedElement(elementId)
	DungeonMapModel.instance:removeElement(elementId)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnRemoveElement, elementId)

	local record = msg.record

	DungeonMapModel.instance:updateRecordInfo(elementId, record)

	local eleConfig = lua_chapter_map_element.configDict[elementId]

	DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateMapElementState, eleConfig.mapId)
end

function DungeonRpc:onReceiveChapterMapUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mapIds = msg.mapIds

	DungeonMapModel.instance:updateMapIds(mapIds)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnChapterMapUpdate)
end

function DungeonRpc:onReceiveChapterMapElementUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local elements = msg.elements

	DungeonMapModel.instance:setNewElements(elements)
	DungeonMapModel.instance:addElements(elements)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnAddElements, elements)

	for i, elementId in ipairs(elements) do
		local eleConfig = lua_chapter_map_element.configDict[elementId]

		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateMapElementState, eleConfig.mapId)
	end

	if DungeonMapModel.instance.playAfterStory then
		DungeonMapModel.instance.playAfterStory = nil

		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)
	end
end

function DungeonRpc:sendGetPointRewardRequest(idList)
	local req = DungeonModule_pb.GetPointRewardRequest()

	for i, v in ipairs(idList) do
		table.insert(req.id, v)
	end

	self:sendMsg(req)
end

function DungeonRpc:onReceiveGetPointRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local idList = msg.id

	DungeonMapModel.instance:addPointRewardIds(idList)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnGetPointReward)
end

function DungeonRpc:sendGetEpisodeHeroRecommendRequest(episodeId, callback, callbackObj)
	local req = DungeonModule_pb.GetEpisodeHeroRecommendRequest()

	req.episodeId = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function DungeonRpc:onReceiveGetEpisodeHeroRecommendReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function DungeonRpc:onReceiveEquipSpDungeonUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local isDelete = msg.isDelete
	local chapterId = msg.chapterId

	DungeonMapModel.instance:updateEquipSpChapter(chapterId, isDelete)

	if not isDelete then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.SpecialEquipOpenTip, ViewName.MessageBoxView, {
			messageBoxId = MessageBoxIdDefine.SpecialEquipOpenTip,
			msgBoxType = MsgBoxEnum.BoxType.Yes_No,
			yesCallback = function()
				local list = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

				DungeonModel.instance.curSendEpisodeId = list[1].id

				FightController.instance:dispatchEvent(FightEvent.OnResultViewClose)
				ViewMgr.instance:closeView(ViewName.FightSuccView)
			end
		})
	end
end

function DungeonRpc:onReceiveRewardPointUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local chapterId = msg.chapterId
	local value = msg.value

	DungeonMapModel.instance:updateRewardPoint(chapterId, value)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateRewardPoint)
end

function DungeonRpc:sendInstructionDungeonInfoRequest(callback, callbackObj)
	local req = DungeonModule_pb.InstructionDungeonInfoRequest()

	self:sendMsg(req, callback, callbackObj)
end

function DungeonRpc:onReceiveInstructionDungeonInfoReply(resultCode, msg)
	if resultCode == 0 then
		TeachNoteModel.instance:setTeachNoteInfo(msg)
		TeachNoteController.instance:dispatchEvent(TeachNoteEvent.GetServerTopicInfo)
	end
end

function DungeonRpc:sendInstructionDungeonOpenRequest(ids)
	local req = DungeonModule_pb.InstructionDungeonOpenRequest()

	for i, v in ipairs(ids) do
		table.insert(req.openId, v)
	end

	self:sendMsg(req)
end

function DungeonRpc:onReceiveInstructionDungeonOpenReply(resultCode, msg)
	if resultCode == 0 then
		TeachNoteController.instance:dispatchEvent(TeachNoteEvent.GetServerSetOpenSuccess)
	end
end

function DungeonRpc:onReceiveInstructionDungeonInfoPush(resultCode, msg)
	if resultCode == 0 then
		TeachNoteModel.instance:setTeachNoteInfo(msg)
		TeachNoteController.instance:dispatchEvent(TeachNoteEvent.GetServerTopicInfo)
	end
end

function DungeonRpc:sendInstructionDungeonRewardRequest(topicId)
	local req = DungeonModule_pb.InstructionDungeonRewardRequest()

	req.topicId = topicId

	self:sendMsg(req)
end

function DungeonRpc:onReceiveInstructionDungeonRewardReply(resultCode, msg)
	if resultCode == 0 then
		TeachNoteController.instance:dispatchEvent(TeachNoteEvent.GetServerTopicReward)
	end
end

function DungeonRpc:sendInstructionDungeonFinalRewardRequest()
	local req = DungeonModule_pb.InstructionDungeonFinalRewardRequest()

	self:sendMsg(req)
end

function DungeonRpc:onReceiveInstructionDungeonFinalRewardReply(resultCode, msg)
	if resultCode == 0 then
		TeachNoteController.instance:dispatchEvent(TeachNoteEvent.GetServerTeachNoteFinalReward)
	end
end

function DungeonRpc:sendCoverDungeonRecordRequest(isCover)
	local req = DungeonModule_pb.CoverDungeonRecordRequest()

	req.isCover = isCover

	self:sendMsg(req)
end

function DungeonRpc:onReceiveCoverDungeonRecordReply(resultCode, msg)
	if resultCode == 0 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnCoverDungeonRecordReply, msg.isCover)
	end
end

function DungeonRpc:sendPuzzleFinishRequest(elementId)
	local req = DungeonModule_pb.PuzzleFinishRequest()

	req.elementId = elementId

	self:sendMsg(req)
end

function DungeonRpc:onReceivePuzzleFinishReply(resultCode, msg)
	if resultCode == 0 then
		DungeonMapModel.instance:setPuzzleStatus(msg.elementId)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnPuzzleFinish, msg.elementId)
	end
end

function DungeonRpc:sendRefreshAssistRequest(assistType, callback, callbackObj, ext)
	local req = DungeonModule_pb.RefreshAssistRequest()

	req.assistType = assistType
	req.ext = ext or ""

	return self:sendMsg(req, callback, callbackObj)
end

function DungeonRpc:onReceiveRefreshAssistReply(resultCode, msg)
	if resultCode == 0 then
		DungeonAssistModel.instance:setAssistHeroCareersByServerData(msg.assistType, msg.assistHeroCareers)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnRefreshAssistReply, msg)
	end
end

function DungeonRpc:sendGetMainDramaRewardRequest()
	local req = DungeonModule_pb.GetMainDramaRewardRequest()

	self:sendMsg(req)
end

function DungeonRpc:onReceiveGetMainDramaRewardReply(resultCode, msg)
	if resultCode == 0 then
		local dataList = {}

		for _, bonu in ipairs(msg.bonus) do
			local materialData = MaterialDataMO.New()

			materialData:initValue(bonu.materilType, bonu.materilId, bonu.quantity)
			table.insert(dataList, materialData)
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, dataList)
		DungeonModel.instance:setCanGetDramaReward(false)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnDramaRewardStatusChange)
	end
end

function DungeonRpc:onReceiveMainDramaRewardInfo(resultCode, msg)
	if resultCode == 0 then
		DungeonModel.instance:setCanGetDramaReward(true)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnDramaRewardStatusChange)
	end
end

function DungeonRpc:sendSavePuzzleProgressRequest(elementId, progressStr)
	local req = DungeonModule_pb.SavePuzzleProgressRequest()

	req.elementId = elementId
	req.progress = progressStr

	self:sendMsg(req)
end

function DungeonRpc:onReceiveSavePuzzleProgressReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function DungeonRpc:sendGetPuzzleProgressRequest(elementId, callback, callbackObj)
	local req = DungeonModule_pb.GetPuzzleProgressRequest()

	req.elementId = elementId

	self:sendMsg(req, callback, callbackObj)
end

function DungeonRpc:onReceiveGetPuzzleProgressReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local elementId = msg.elementId
	local progress = msg.progress

	PuzzleMazeDrawController.instance:onGetPuzzleDrawProgress(elementId, progress)
end

function DungeonRpc:sendGetMapElementRecordRequest(elementIds)
	local req = DungeonModule_pb.GetMapElementRecordRequest()

	for i, v in ipairs(elementIds) do
		table.insert(req.elementIds, v)
	end

	self:sendMsg(req)
end

function DungeonRpc:onReceiveGetMapElementRecordReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local recordInfos = msg.recordInfos

	DungeonMapModel.instance:updateRecordInfos(recordInfos)
end

DungeonRpc.instance = DungeonRpc.New()

return DungeonRpc
