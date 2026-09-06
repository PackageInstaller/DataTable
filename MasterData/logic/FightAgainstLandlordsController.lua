-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/controller/FightAgainstLandlordsController.lua

module("logic.extensions.landlords.controller.FightAgainstLandlordsController", package.seeall)

local FightAgainstLandlordsController = class("FightAgainstLandlordsController", BaseController)

function FightAgainstLandlordsController:ctor()
	return
end

function FightAgainstLandlordsController:onInit()
	self:onReset()
end

function FightAgainstLandlordsController:onReset()
	self._falCustomFmtMo = nil
end

function FightAgainstLandlordsController:sendPM_LandlordsPKInfoReq(activityId)
	LandlordsPKAgent.instance:sendPM_LandlordsPKInfoReq(activityId)
end

function FightAgainstLandlordsController:handlePM_LandlordsPKInfoRes(msg)
	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKInfoRes(msg)
	self:_updateScoreMatNum(msg.tokenScore)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKInfoRes)
end

function FightAgainstLandlordsController:sendPM_LandlordsPKGetDailySuppluGainReq(activityId)
	LandlordsPKAgent.instance:sendPM_LandlordsPKGetDailySuppluGainReq(activityId)
end

function FightAgainstLandlordsController:handlePM_LandlordsPKGetDailySuppluGainRes(msg)
	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKGetDailySuppluGainRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKGetDailySuppluGainRes)

	local baseData = FightAgainstLandlordsConfig.instance:getFalBaseData(self:getActivityId())
	local matType, matId, matNum = MaterialMgr.getMatParams(baseData.scoreItem)
	local prizeStr = string.format("%s:%s:%s", matType, matId, msg.addScore)

	self:popChangSetItemList({
		prizeStr
	})
end

function FightAgainstLandlordsController:sendPM_LandlordsPKGetOnlineTimeSupplyGainInfoReq(activityId)
	LandlordsPKAgent.instance:sendPM_LandlordsPKGetOnlineTimeSupplyGainInfoReq(activityId)
end

function FightAgainstLandlordsController:handlePM_LandlordsPKGetOnlineTimeSupplyGainInfoRes(msg)
	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKGetOnlineTimeSupplyGainInfoRes(msg)
	self:_updateScoreMatNum(msg.tokenScore)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKGetOnlineTimeSupplyGainInfoRes)
end

function FightAgainstLandlordsController:_updateScoreMatNum(num)
	local baseData = FightAgainstLandlordsConfig.instance:getFalBaseData(self:getActivityId())

	if baseData and not string.nilorempty(baseData.scoreItem) then
		local matType, matId, matNum = MaterialMgr.getMatParams(baseData.scoreItem)
		local matNum = checknumber(num)

		MaterialModel.instance:UpdateMaterial(matType, matId, matNum, false)
	end
end

function FightAgainstLandlordsController:sendPM_LandlordsPKGetOnlineTimeSupplyGainReq(activityId)
	LandlordsPKAgent.instance:sendPM_LandlordsPKGetOnlineTimeSupplyGainReq(activityId)
end

function FightAgainstLandlordsController:handlePM_LandlordsPKGetOnlineTimeSupplyGainRes(msg)
	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKGetOnlineTimeSupplyGainRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKGetOnlineTimeSupplyGainRes)

	local baseData = FightAgainstLandlordsConfig.instance:getFalBaseData(self:getActivityId())
	local matType, matId, matNum = MaterialMgr.getMatParams(baseData.scoreItem)
	local prizeStr = string.format("%s:%s:%s", matType, matId, msg.addScore)

	self:popChangSetItemList({
		prizeStr
	})
end

function FightAgainstLandlordsController:popChangSetItemList(prizeStrList)
	local itemlist = {}

	for _, prizeStr in ipairs(prizeStrList) do
		local matType, matId, matNum = MaterialMgr.getMatParams(prizeStr)
		local mo = MaterialModel.instance:createMo(matType, matId, matNum)

		table.insert(itemlist, mo)
	end

	if #itemlist > 0 then
		local clientChangeSetId = MaterialController.instance:getClientChangeSetId(true)

		MaterialController.instance:showChangeSetItemMo(itemlist, clientChangeSetId)
	end
end

function FightAgainstLandlordsController:sendPM_LandlordsPKRankViewReq(activityId)
	LandlordsPKAgent.instance:sendPM_LandlordsPKRankViewReq(activityId)
end

function FightAgainstLandlordsController:handlePM_LandlordsPKRankViewRes(msg)
	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKRankViewRes, msg)
end

function FightAgainstLandlordsController:sendPM_LandlordsPKGetBattleRecordReq(activityId)
	LandlordsPKAgent.instance:sendPM_LandlordsPKGetBattleRecordReq(activityId)
end

function FightAgainstLandlordsController:handlePM_LandlordsPKGetBattleRecordRes(msg)
	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKGetBattleRecordRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKGetBattleRecordRes)
end

function FightAgainstLandlordsController:sendPM_LandlordsPKShareSimpleRecordReq(activityId, battleId, chatChannel, receiveId)
	LandlordsPKAgent.instance:sendPM_LandlordsPKShareSimpleRecordReq(activityId, battleId, chatChannel, receiveId)
end

function FightAgainstLandlordsController:sendPM_LandlordsPKGetBattleVideoReq(battleIds)
	LandlordsPKAgent.instance:sendPM_LandlordsPKGetBattleVideoReq(battleIds)

	self._teamId = 0
end

function FightAgainstLandlordsController:handlePM_LandlordsPKGetBattleVideoRes(msg)
	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKGetBattleVideoRes(msg)
	BattleController.instance:viewUserFightMonsterBtlResultWithList(msg.battleResult)

	if self._teamId and self._teamId >= 0 then
		BattleModel.instance:setLeftTeamId(self._teamId)
	end

	self._teamId = nil

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKGetBattleVideoRes)
end

function FightAgainstLandlordsController:sendPM_LandlordsPKMatchReq(activityId, thresholdId)
	LandlordsPKAgent.instance:sendPM_LandlordsPKMatchReq(activityId, thresholdId)
end

function FightAgainstLandlordsController:handlePM_LandlordsPKMatchRes(status, msg)
	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKMatchRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKMatchRes, status, msg)
end

function FightAgainstLandlordsController:sendPM_LandlordsPKCancelMatchReq()
	LandlordsPKAgent.instance:sendPM_LandlordsPKCancelMatchReq()
end

function FightAgainstLandlordsController:handlePM_LandlordsPKCancelMatchRes(msg)
	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKCancelMatchRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKCancelMatchRes)
end

function FightAgainstLandlordsController:sendPM_LandlordsPKLandlordReq(ack)
	LandlordsPKAgent.instance:sendPM_LandlordsPKLandlordReq(ack)
end

function FightAgainstLandlordsController:handlePM_LandlordsPKLandlordRes(msg)
	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKLandlordRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKLandlordRes)
end

function FightAgainstLandlordsController:sendPM_LandlordsPKFormSetReq(form)
	LandlordsPKAgent.instance:sendPM_LandlordsPKFormSetReq(form)
end

function FightAgainstLandlordsController:handlePM_LandlordsPKFormSetRes(msg)
	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKFormSetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKFormSetRes)
end

function FightAgainstLandlordsController:sendPM_LandlordsPKChatReq(chatId)
	LandlordsPKAgent.instance:sendPM_LandlordsPKChatReq(chatId)
end

function FightAgainstLandlordsController:handlePM_LandlordsPKChatRes(msg)
	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKChatRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKChatRes)
end

function FightAgainstLandlordsController:handlePM_LandlordsPKNotifyDealCardRes(msg)
	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKNotifyDealCardRes(msg)

	local falGameMo = self:getFalGameMo()
	local userIdList = {}

	for _, info in ipairs(msg.cardsInfos) do
		table.insert(userIdList, info.headInfo.userId)
	end

	falGameMo:initPlayerMoPool(userIdList)

	local myUserId = self:getMyUserId()

	if table.indexof(userIdList, myUserId) == false then
		printError(string.format("userId列表没有我的( userId=%s, type=%s )", myUserId, type(myUserId)))

		for idx, userId in ipairs(userIdList) do
			printError(string.format("%s : userId=%s, type=%s", idx, userId, type(userId)))
		end
	end

	if #userIdList ~= 3 then
		printError("userId数量没有三个")
	end

	for _, info in ipairs(msg.cardsInfos) do
		falGameMo:setBagCreepsIds(info.headInfo.userId, info.cards)
		falGameMo:setHeadInfo(info.headInfo.userId, info.headInfo)
		falGameMo:setTokenScore(info.headInfo.userId, info.tokenScore)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKNotifyDealCardRes)
end

function FightAgainstLandlordsController:handlePM_LandlordsPKNotifyLandlordsAckRes(msg)
	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKNotifyLandlordsAckRes(msg)

	local falGameMo = self:getFalGameMo()

	falGameMo:setGrabNum(msg.grabNum)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKNotifyLandlordsAckRes, msg)
end

function FightAgainstLandlordsController:handlePM_LandlordsPKNotifyLandlordsCofirmRes(msg)
	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKNotifyLandlordsCofirmRes(msg)

	local falGameMo = self:getFalGameMo()

	falGameMo:setBuffIds(msg.landlordsPlayerId, msg.landlordsBuffs, GameEnum.FalIdentity.Landlord)
	falGameMo:setGrabNum(msg.grabNum)

	local allLandCards = TableUtil.toList(falGameMo:getBagCreepsIdsAsUser(msg.landlordsPlayerId))

	TableUtil.AddTable(allLandCards, msg.landlordsCards)
	falGameMo:setBagCreepsIds(msg.landlordsPlayerId, allLandCards)

	local userIdList = falGameMo:getPlayerUserIdList()

	for _, userId in ipairs(userIdList) do
		falGameMo:setIdentity(userId, (userId == msg.landlordsPlayerId or nil) and GameEnum.FalIdentity.Landlord)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKNotifyLandlordsCofirmRes, msg)
end

function FightAgainstLandlordsController:handlePM_LandlordsPKNotifyLandlordsFormSetRes(msg)
	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKNotifyLandlordsFormSetRes(msg)

	local falGameMo = self:getFalGameMo()

	falGameMo:setWaitSecondInFight(msg.waitSecond)
	falGameMo:setRoundId(falGameMo:getRoundId() + 1)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKNotifyLandlordsFormSetRes)
end

function FightAgainstLandlordsController:handlePM_LandlordsPKNotifyLandlordsFormShowRes(msg)
	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKNotifyLandlordsFormShowRes(msg)

	local falGameMo = self:getFalGameMo()

	falGameMo:setSimpleForm(msg.civilianForm, GameEnum.FalIdentity.Farmer)
	falGameMo:setSimpleForm(msg.landlordForm, GameEnum.FalIdentity.Landlord)
	BattleFacade.instance:registerResultHandler(self._handlerBattleEndAsLand, self)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKNotifyLandlordsFormShowRes)
end

function FightAgainstLandlordsController:_handlerBattleEndAsLand()
	BattleFacade.instance:registerResultHandler(nil, nil)
	UIStateManager.instance:push(ViewName.FalGameResultView, true)

	return true
end

function FightAgainstLandlordsController:handlePM_LandlordsPKNotifyBattleResultRes(msg)
	FightAgainstLandlordsModel.instance:handlePM_LandlordsPKNotifyBattleResultRes(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKNotifyBattleResultRes, msg)
end

function FightAgainstLandlordsController:handlePM_LandlordsPKNotifyMatchingOverTimeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKNotifyMatchingOverTimeRes)
end

function FightAgainstLandlordsController:handlePM_LandlordsPKNotifyMatchFailRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKNotifyMatchFailRes)
end

function FightAgainstLandlordsController:handlePM_LandlordsPKNotifyChatRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_LandlordsPKNotifyChatRes, msg)
end

function FightAgainstLandlordsController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function FightAgainstLandlordsController:getActivityType()
	return GameEnum.ActivityType.LANDLORDS_PK
end

function FightAgainstLandlordsController:getMyUserId()
	return tostring(RoleModel.instance:getUserId())
end

function FightAgainstLandlordsController:getLeftPlayNum()
	local totalPlayNum = FightAgainstLandlordsConfig.instance:getFalCommonValue("DAILY_TIMES")
	local playNum = FightAgainstLandlordsModel.instance:getPlayNum()

	return Mathf.Max(totalPlayNum - playNum, 0)
end

function FightAgainstLandlordsController:getScoreMatNum(activityId)
	local matNum = 0
	local baseData = FightAgainstLandlordsConfig.instance:getFalBaseData(activityId)

	if baseData and not string.nilorempty(baseData.scoreItem) then
		local matType, matId = MaterialMgr.getMatParams(baseData.scoreItem)

		matNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
	end

	return matNum
end

function FightAgainstLandlordsController:getTryMathResult(activityId, gameId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isEnoughTimesInMatch(activityId) then
		result = GameEnum.ResultCode.NotEnoughTimes
		tips = "游戏次数不足"
	elseif not self:isEnoughScoreInMatch(activityId, gameId) then
		result = GameEnum.ResultCode.NotEnoughNum
		tips = "不满足最低入场要求"
	end

	return result, tips
end

function FightAgainstLandlordsController:isEnoughTimesInMatch(activityId)
	local times = FightAgainstLandlordsController.instance:getLeftPlayNum()

	return times > 0
end

function FightAgainstLandlordsController:isEnoughScoreInMatch(activityId, gameId)
	local myScore = self:getScoreMatNum(activityId)
	local gameData = FightAgainstLandlordsConfig.instance:getFalGameData(activityId, gameId)

	return myScore >= gameData.minScoreLimit
end

function FightAgainstLandlordsController:enterSupplyMgr(activityId)
	if self._falSupplyMgr == nil then
		self._falSupplyMgr = FalSupplyMgr.New()
	end

	self._falSupplyMgr:enter(activityId)

	return self._falSupplyMgr
end

function FightAgainstLandlordsController:exitSupplyMgr()
	self._falSupplyMgr:exit()

	return nil
end

function FightAgainstLandlordsController:initFalGameMo(activityId, gameId)
	if self._falGameMo == nil then
		self._falGameMo = FalGameMo.New()
	end

	self._falGameMo:init(activityId, gameId)

	return self._falGameMo
end

function FightAgainstLandlordsController:getFalGameMo()
	if self._falGameMo then
		return self._falGameMo
	else
		printError("未进入FalGame,无法获取对应数据模块")
	end
end

function FightAgainstLandlordsController:enterBattleAsFal(activityId)
	self._falCustomFmtMo = self._falCustomFmtMo or FALstFmtMo.New()

	self._falCustomFmtMo:initParams(activityId)
	CustomFmtController.instance:showMissionFormationView(self._falCustomFmtMo)
end

function FightAgainstLandlordsController:isCpPet(activityId, petId, petIdList)
	local cpId, petIdAsCp = self:getPetIdAsCp(activityId, petId, petIdList)

	return petIdAsCp > 0
end

function FightAgainstLandlordsController:getPetIdAsCp(activityId, petId, petIdList)
	local cpId = 0
	local petIdAsCp = 0
	local cfg = FightAgainstLandlordsConfig.instance:getFalCpCfg(activityId)

	for _, data in ipairs(cfg) do
		local isFitAsSame = false
		local isFitAsCp = true

		for _, creepsId in ipairs(data.creepsIds) do
			if petId == creepsId then
				isFitAsSame = true
			else
				isFitAsCp = isFitAsCp and table.indexof(petIdList, creepsId)
			end
		end

		if isFitAsSame and isFitAsCp then
			if data.creepsIds[1] == petId then
				petIdAsCp = data.creepsIds[2]
			elseif data.creepsIds[2] == petId then
				petIdAsCp = data.creepsIds[1]
			end

			cpId = data.cpId

			break
		end
	end

	return cpId, petIdAsCp
end

function FightAgainstLandlordsController:getCpIdListOfAnd(activityId, petIdList)
	local cpIdList = {}
	local cfg = FightAgainstLandlordsConfig.instance:getFalCpCfg(activityId)

	for _, data in ipairs(cfg) do
		if table.indexof(petIdList, data.creepsIds[1]) and table.indexof(petIdList, data.creepsIds[2]) then
			table.insert(cpIdList, data.cpId)
		end
	end

	return cpIdList
end

function FightAgainstLandlordsController:getCpIdListOfOr(activityId, petIdList)
	local cpIdList = {}
	local cfg = FightAgainstLandlordsConfig.instance:getFalCpCfg(activityId)

	for _, data in ipairs(cfg) do
		if table.indexof(petIdList, data.creepsIds[1]) or table.indexof(petIdList, data.creepsIds[2]) then
			table.insert(cpIdList, data.cpId)
		end
	end

	return cpIdList
end

function FightAgainstLandlordsController:getColorByCpId(activityId, cpId)
	local data = FightAgainstLandlordsConfig.instance:getFalCpData(activityId, cpId)

	if data == nil then
		print(string.format("test-> data is nil, activityId=%s, cpId=%s ", activityId, cpId))
	end

	return Framework.ColorUtil.ParseColor((data and not string.nilorempty(data.color) or nil) and data.color)
end

function FightAgainstLandlordsController:isFitTheChat(chatId, curChatScence, curIdentity)
	local data = FightAgainstLandlordsConfig.instance:getFalChatData(chatId)

	return (data.chatScence == curChatScence or nil) and (data.identity == 0 and true or data.identity == curIdentity and true or data.chatChannel == 1)
end

FightAgainstLandlordsController.instance = FightAgainstLandlordsController.New()

return FightAgainstLandlordsController
