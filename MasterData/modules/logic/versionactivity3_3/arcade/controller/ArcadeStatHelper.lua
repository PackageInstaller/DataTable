-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/ArcadeStatHelper.lua

module("modules.logic.versionactivity3_3.arcade.controller.ArcadeStatHelper", package.seeall)

local ArcadeStatHelper = class("ArcadeStatHelper")

function ArcadeStatHelper:ctor()
	self.roomStartTime = 0
	self.roomBoomInitCount = 0
	self.roomRebornInitCount = 0
	self.roomRebornUseTimes = 0
	self.roomUseBoomTimes = 0
	self.roomUseUltimateTimes = 0
end

function ArcadeStatHelper:onEnterRoom()
	self.roomRebornUseTimes = 0
	self.roomUseBoomTimes = 0
	self.roomUseUltimateTimes = 0
	self.roomBoomInitCount = 0
	self.roomRebornInitCount = 0

	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if characterMO then
		self.roomBoomInitCount = characterMO:getResourceCount(ArcadeGameEnum.CharacterResource.Bomb) or 0
		self.roomRebornInitCount = characterMO:getResourceCount(ArcadeGameEnum.CharacterResource.RespawnTimes) or 0
	end

	self.roomStartTime = UnityEngine.Time.realtimeSinceStartup

	self:sendEnterRoom()
end

function ArcadeStatHelper:AddUseRebornTimes()
	self.roomRebornUseTimes = self.roomRebornUseTimes + 1
end

function ArcadeStatHelper:AddUseBoomTimes()
	self.roomUseBoomTimes = self.roomUseBoomTimes + 1
end

function ArcadeStatHelper:AddUseUltimateTimes()
	self.roomUseUltimateTimes = self.roomUseUltimateTimes + 1
end

function ArcadeStatHelper:buildArcadeGameBaseObj(cassetteCount, isWin, argsRoomId, serverInfo)
	local difficulty, characterId
	local areaIndex = 0
	local roomId
	local allPassRoomCount = 0
	local areaPassRoomCount = 0
	local killMonsterNum = 0
	local gainAllCoinNum = 0
	local propInfo = serverInfo and serverInfo.prop

	if propInfo then
		difficulty = propInfo.difficulty
		characterId = serverInfo.player and serverInfo.player.id
		areaIndex = propInfo.areaId
		roomId = propInfo.roomId
		allPassRoomCount = propInfo.clearedRoomNum
		areaPassRoomCount = propInfo.progress
		killMonsterNum = propInfo.maxKillMonsterNum
		gainAllCoinNum = propInfo.totalGainGoldNum
	else
		difficulty = ArcadeGameModel.instance:getDifficulty()

		local characterMO = ArcadeGameModel.instance:getCharacterMO()

		characterId = characterMO and characterMO:getId() or 0
		areaIndex = ArcadeGameModel.instance:getCurAreaIndex()
		roomId = argsRoomId or ArcadeGameModel.instance:getCurRoomId()
		allPassRoomCount = ArcadeGameModel.instance:getPassLevelCount()
		areaPassRoomCount = ArcadeGameModel.instance:getTransferNodeIndex()
		killMonsterNum = ArcadeGameModel.instance:getKillMonsterNum()
		gainAllCoinNum = ArcadeGameModel.instance:getAllCoinNum()
	end

	if isWin then
		areaPassRoomCount = areaPassRoomCount + 1
	end

	local gameBaseObj = {
		difficulty = difficulty,
		character = characterId,
		area = areaIndex,
		room = roomId,
		all_rooms = allPassRoomCount,
		area_rooms = areaPassRoomCount,
		finish_count = ArcadeOutSizeModel.instance:getFinishLevelCount(difficulty),
		max_kill = killMonsterNum,
		all_coin = gainAllCoinNum,
		max_score = cassetteCount or 0,
		total_score = ArcadeOutSizeModel.instance:getScore()
	}

	return {
		gameBaseObj
	}
end

function ArcadeStatHelper:buildRoomEndObj(selectedPortalId)
	local roomObj = {
		selected_room_trans = selectedPortalId,
		init_boom_count = self.roomBoomInitCount,
		init_reborn_count = self.roomRebornInitCount,
		use_time = UnityEngine.Time.realtimeSinceStartup - self.roomStartTime,
		use_boom_times = self.roomUseBoomTimes,
		use_ultimate_times = self.roomUseUltimateTimes,
		use_reborn_times = self.roomRebornUseTimes
	}

	return {
		roomObj
	}
end

function ArcadeStatHelper:buildArcadeTalentInfo()
	local arcadeTalentInfo = {}
	local talentMOList = ArcadeHeroModel.instance:getTalentMoList()

	for _, talentMO in ipairs(talentMOList) do
		local talentId = talentMO.id
		local talentLevel = talentMO:getLevel()
		local talentObj = {
			id = talentId,
			level = talentLevel
		}

		table.insert(arcadeTalentInfo, talentObj)
	end

	return arcadeTalentInfo
end

function ArcadeStatHelper:sendStartGame()
	StatController.instance:track(StatEnum.EventName.ArcadeOperation, {
		[StatEnum.EventProperties.OperationType] = "arcade_enter",
		[StatEnum.EventProperties.ArcadeTalentInfo] = self:buildArcadeTalentInfo(),
		[StatEnum.EventProperties.ArcadeGameBaseObj] = self:buildArcadeGameBaseObj()
	})
end

local SettleTypeName = {
	[ArcadeGameEnum.SettleType.Abandon] = "abandon",
	[ArcadeGameEnum.SettleType.Win] = "win",
	[ArcadeGameEnum.SettleType.Fail] = "fail"
}

function ArcadeStatHelper:sendEndGame(settleType, cassetteCount, serverInfo)
	local isWin = settleType == ArcadeGameEnum.SettleType.Win

	StatController.instance:track(StatEnum.EventName.ArcadeOperation, {
		[StatEnum.EventProperties.OperationType] = "arcade_end",
		[StatEnum.EventProperties.Result] = SettleTypeName[settleType],
		[StatEnum.EventProperties.ArcadeTalentInfo] = self:buildArcadeTalentInfo(),
		[StatEnum.EventProperties.ArcadeGameBaseObj] = self:buildArcadeGameBaseObj(cassetteCount, isWin, nil, serverInfo)
	})
end

function ArcadeStatHelper:sendNextArea()
	StatController.instance:track(StatEnum.EventName.ArcadeOperation, {
		[StatEnum.EventProperties.OperationType] = "area_pass",
		[StatEnum.EventProperties.ArcadeTalentInfo] = self:buildArcadeTalentInfo(),
		[StatEnum.EventProperties.ArcadeGameBaseObj] = self:buildArcadeGameBaseObj()
	})
end

function ArcadeStatHelper:sendExitRoom(exitRoomId, portalIdList, selectedPortalId)
	if not portalIdList or not selectedPortalId then
		return
	end

	StatController.instance:track(StatEnum.EventName.ArcadeOperation, {
		[StatEnum.EventProperties.OperationType] = "room_end",
		[StatEnum.EventProperties.ArcadeRoomEndObj] = self:buildRoomEndObj(selectedPortalId),
		[StatEnum.EventProperties.ArcadeRoomTransList] = portalIdList,
		[StatEnum.EventProperties.ArcadeTalentInfo] = self:buildArcadeTalentInfo(),
		[StatEnum.EventProperties.ArcadeGameBaseObj] = self:buildArcadeGameBaseObj(nil, nil, exitRoomId)
	})
end

function ArcadeStatHelper:sendEnterRoom()
	StatController.instance:track(StatEnum.EventName.ArcadeOperation, {
		[StatEnum.EventProperties.OperationType] = "room_enter",
		[StatEnum.EventProperties.ArcadeTalentInfo] = self:buildArcadeTalentInfo(),
		[StatEnum.EventProperties.ArcadeGameBaseObj] = self:buildArcadeGameBaseObj()
	})
end

function ArcadeStatHelper:sendBuyGoods(collectionList, buyCollectionId)
	if not collectionList or not buyCollectionId then
		return
	end

	StatController.instance:track(StatEnum.EventName.ArcadeBuy, {
		[StatEnum.EventProperties.ArcadeGameBaseObj] = self:buildArcadeGameBaseObj(),
		[StatEnum.EventProperties.ArcadeRewardList] = collectionList,
		[StatEnum.EventProperties.OptionId] = buyCollectionId
	})
end

function ArcadeStatHelper:sendTalentUpgrade(talentId, newLevel)
	StatController.instance:track(StatEnum.EventName.ArcadeTalentUpgrade, {
		[StatEnum.EventProperties.ArcadeTalentId] = talentId,
		[StatEnum.EventProperties.ArcadeTalentLevel] = newLevel
	})
end

ArcadeStatHelper.instance = ArcadeStatHelper.New()

return ArcadeStatHelper
