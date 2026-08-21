-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/control/AirWorkShopController.lua

module("logic.extensions.airworkshop.control.AirWorkShopController", package.seeall)

local M = class("AirWorkShopController", BaseController)

M.SystemOpenKey = GameEnum.SystemEnum.PvpFightActivity

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
	self:setEvent(true)
end

function M:onReset()
	self:_timerCtrlChallengeNum(false)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_RODEO_INFO_CHANGE, self._handleOnRodeoInfoChange, self)
		GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN_INIT, self._handleOnSystemOpenInit, self)
		GlobalDispatcher:addEventListener(EventType.GM_REPLY, self._handleOnGmReply, self)
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_VIEW_CLOSE, self._handleOnGainItemViewClose, self)
		GlobalDispatcher:addEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self._handleOnImportantInstantPush, self)
	else
		GlobalDispatcher:removeEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_RODEO_INFO_CHANGE, self._handleOnRodeoInfoChange, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN_INIT, self._handleOnSystemOpenInit, self)
		GlobalDispatcher:removeEventListener(StringUtil.toUniqueKey(EventType.ON_SYSTEM_OPEN, GameEnum.SystemEnum.PvpFightActivity), self._handleOnSystemOpen, self)
		GlobalDispatcher:removeEventListener(EventType.GM_REPLY, self._handleOnGmReply, self)
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_VIEW_CLOSE, self._handleOnGainItemViewClose, self)
		GlobalDispatcher:removeEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self._handleOnImportantInstantPush, self)
	end
end

function M:_handleOnSystemOpenInit(e)
	local isOpen = AirWorkShopUtil.isSystemOpen(false)

	if isOpen then
		self:_handleOnSystemOpen(nil)
	else
		GlobalDispatcher:removeEventListener(StringUtil.toUniqueKey(EventType.ON_SYSTEM_OPEN, GameEnum.SystemEnum.PvpFightActivity), self._handleOnSystemOpen, self)
		GlobalDispatcher:addEventListener(StringUtil.toUniqueKey(EventType.ON_SYSTEM_OPEN, GameEnum.SystemEnum.PvpFightActivity), self._handleOnSystemOpen, self)
	end
end

function M:_handleOnSystemOpen(e)
	local isOpen = AirWorkShopUtil.isSystemOpen(false)

	if isOpen then
		AirWorkShopAtkAgent.instance:sendRodeoInfoRequest()
		AirWorkShopAtkAgent.instance:sendFreeEndlessInfoRequest()
	end
end

function M:_handleOnGmReply(e, lastTableData)
	if lastTableData.cmd == GameEnum.GMCmdEnum.AirSetWeek then
		AirWorkShopAtkAgent.instance:sendRodeoInfoRequest()
	end
end

function M:_handleOnGainItemViewClose(e, itemDataLst)
	local trophyItems = {}

	for _, itemData in ipairs(itemDataLst or {}) do
		if itemData then
			local type = itemData:getType()

			if type == GameEnum.ItemTypeEnum.AirSeasonCup or type == GameEnum.ItemTypeEnum.AirAchievementCup then
				table.insert(trophyItems, itemData)
			end
		end
	end

	if #trophyItems > 0 then
		ToolTipsMgr.showTopToastAirWorkTrophyNotice(trophyItems, 1.2)
	end
end

function M:_handleOnImportantInstantPush(e, key)
	AirWorkShopDefAgent.instance:sendGetAirInfoRequest()
	AirWorkShopAtkAgent.instance:sendRodeoInfoRequest()
end

function M:getBattleRecordLst()
	local needRequestFromServer = false
	local recordLst = AirWorkShopRecordModel.instance:getRecordLst()
	local dataDirty = AirWorkShopRecordModel.instance:getDataDirty()

	if dataDirty or #recordLst == 0 then
		needRequestFromServer = true
	end

	if needRequestFromServer then
		AirWorkShopAtkAgent.instance:sendPlayRecordRequest()
	else
		GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_QUALIFYING_RECORD_CHANGE)
	end
end

function M:getMapStatistics(mapId)
	local needRequestFromServer = false
	local mapData = AirWorkShopStatisticsModel.instance:getMapData(mapId)
	local dataDirty = AirWorkShopStatisticsModel.instance:getDataDirty(mapId)

	if dataDirty or not mapData then
		needRequestFromServer = true
	end

	if needRequestFromServer then
		AirWorkShopDefAgent.instance:sendGetAirMapStatisticsRequest(mapId)
	else
		GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_BATTLE_STATISTICS_REPLY, mapId)
	end
end

function M:onGetAirInfoReply(airInfoNO)
	AirWorkShopModel.instance:updateAirInfo(airInfoNO)
	GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_AIR_INFO_CHANGE)
end

function M:onRodeoMatchReply(lstLevelNO)
	local infoMo = AirWorkShopChallengeModel.instance:getPlayerInfoMo()

	infoMo:updateCurLevelLst(lstLevelNO)

	local count = lstLevelNO and #lstLevelNO or 0

	if count > 0 then
		for index, LevelNO in ipairs(lstLevelNO) do
			printWarn(string.format("[%s] mapId[%s] 评分[%s] 通过率[%s]", index, LevelNO.mapId, LevelNO.point, LevelNO.passRate))
		end
	else
		printError("空气工坊-竞技模式-匹配关卡-返回关卡数量为0")
	end

	local status = 0

	GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_RODEO_MATCH_REPLY, status, lstLevelNO)
end

function M:onLikedMap(mapId, liked)
	AirWorkShopRecordModel.instance:setMapIdLiked(mapId, liked)
	GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_LIKED_MAP, mapId, liked)
end

function M:onWeekSettlePush(msg)
	local lv = msg.lv

	printWarn("<color=#C2C2C2>赛季推送</color>", lv)
end

function M:onChallengeNumChange(msg)
	local challengeNum = msg.challengeNum or 0
	local recoveryTime = msg.recoveryTime or 0

	printWarn("<color=#C2C2C2>挑战次数推送</color>", challengeNum, recoveryTime)

	local infoMo = AirWorkShopChallengeModel.instance:getPlayerInfoMo()

	if infoMo then
		infoMo:setUseChallengeNum(challengeNum)
		infoMo:setLastChallengeNumRecoverTime(recoveryTime)
	end

	GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_RODEO_INFO_CHANGE)
	GlobalDispatcher:dispatchEvent(EventType.ITEM_MODEL_CHANGED_ANY)
end

function M:onBattleSettlePush(msg)
	local info = {}

	info.isWin = msg.isWin
	info.airPlayType = msg.type

	if msg.battle then
		info.battle = {
			roundCount = msg.battle.roundCount,
			killCount = msg.battle.killCount,
			teamCount = msg.battle.teamCount
		}
	end

	if msg.level then
		info.level = {
			mapId = msg.level.mapId,
			userName = msg.level.userName,
			likeNum = msg.level.likeNum,
			commentNum = msg.level.commentNum,
			liked = msg.level.liked,
			commented = msg.level.commented,
			passRate = msg.level.passRate,
			sceneId = msg.level.sceneId,
			cover = msg.level.cover,
			tags = {}
		}

		for _, tag in ipairs(msg.level.tags or {}) do
			table.insert(info.level.tags, tag)
		end
	end

	if msg.rodeo then
		info.rodeo = {
			round = msg.rodeo.round,
			curScore = msg.rodeo.curScore,
			addScore = msg.rodeo.addScore,
			totalScore = msg.rodeo.totalScore,
			maxScore = msg.rodeo.maxScore
		}
	end

	if Astral.OSDef.isEditor then
		TableUtil.dump(info)
	end

	GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_ON_BATTLE_SETTLE_PUSH, info)
end

function M:onRodeoSettlePush(msg)
	local info = {
		round = msg.round,
		score = msg.score,
		maxScore = msg.maxScore
	}

	if Astral.OSDef.isEditor then
		TableUtil.dump(info)
	end

	GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_QUALIFYING_SETTLE_PUSH, info)
end

function M:_handleOnRodeoInfoChange(e)
	local reachMax = AirWorkShopChallengeModel.instance:getIsChallengeNumMax()

	if not reachMax then
		self:_timerChallengeNum()
	end

	self:_timerCtrlChallengeNum(not reachMax)
end

function M:_timerCtrlChallengeNum(startTimer)
	GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKSECOND, self._timerChallengeNum, self)

	if startTimer then
		GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKSECOND, self._timerChallengeNum, self)
	end
end

function M:_timerChallengeNum()
	local nowTime = ServerTime.now()
	local reachMax = AirWorkShopChallengeModel.instance:getIsChallengeNumMax()
	local totalTime = AirWorkShopConfig.instance:getChallengeNumRecoveryTime()
	local recoveryTime = AirWorkShopChallengeModel.instance:getLastChallengeNumRecoverTime()
	local passTime = nowTime - recoveryTime

	if totalTime < passTime then
		local mod = passTime % totalTime

		passTime = mod
	end

	local leftTime = totalTime - passTime
	local hintTxt = ""

	if not reachMax then
		hintTxt = string.format(lang("tip_air_challenge_recover_hint"), TextFormatter.formatClockTime(leftTime))
	end

	local code = CommEnum.CurrencyCodeEnum.AirStudioChallengeNum

	GlobalDispatcher:dispatchEvent(MoneyEventType.MONEY_ITEM_HINT_CHANGE, code, hintTxt)
end

function M:showRodeoChallengeNumExchangeTips()
	if AirWorkShopUtil.getInRodeoCalculateTime(nil, true) then
		return
	end

	if AirWorkShopUtil.getCanRodeoSettle() then
		FloatWordMgr.instance:show(lang("tip_air_rodeo_in_calculate"))

		return
	end

	if AirWorkShopChallengeModel.instance:getIsChallengeNumMax() then
		ToolTipsMgr.showCharacterTopToast(lang("tip_air_challengenum_exchange_fail_by_full"), CommEnum.CharacterTopToastIcon.Info, 1)

		return
	end

	local itemId = AirWorkShopConfig.instance:getAtkConst("PropsExchange").numValue
	local txtContent = lang("tip_air_challengenum_exchange_hint")
	local moneyShowType = CommEnum.MoneyShowType.AirStudioChallengeShowType

	ToolTipsMgr.showCommonUsePropSingleTips(itemId, 1, txtContent, moneyShowType, self._clickExchangeChallengeNumByProps, self, self._onTimerChallengeNum, self)
end

function M:_onTimerChallengeNum()
	local show = false
	local txtTitle, txtContent
	local nowTime = ServerTime.now()
	local reachMax = AirWorkShopChallengeModel.instance:getIsChallengeNumMax()
	local totalTime = AirWorkShopConfig.instance:getChallengeNumRecoveryTime()
	local recoveryTime = AirWorkShopChallengeModel.instance:getLastChallengeNumRecoverTime()
	local passTime = nowTime - recoveryTime

	if totalTime < passTime then
		local mod = passTime % totalTime

		passTime = mod
	end

	local leftTime = totalTime - passTime

	if not reachMax then
		show = true
		txtContent = TextFormatter.formatClockTime(leftTime)
	end

	return show, txtTitle, txtContent
end

function M:_clickExchangeChallengeNumByProps()
	if AirWorkShopUtil.getInRodeoCalculateTime(nil, true) then
		return
	end

	if AirWorkShopUtil.getCanRodeoSettle() then
		FloatWordMgr.instance:show(lang("tip_air_rodeo_in_calculate"))

		return
	end

	if AirWorkShopChallengeModel.instance:getIsChallengeNumMax() then
		ToolTipsMgr.showCharacterTopToast(lang("tip_air_challengenum_exchange_fail_by_full"), CommEnum.CharacterTopToastIcon.Info, 1)

		return
	end

	local costCount = 1
	local leftItemId = AirWorkShopConfig.instance:getAtkConst("PropsExchange").numValue

	if not ItemUtil.isItemEnough(leftItemId, costCount) then
		ToolTipsMgr.showCharacterTopToast(lang("tip_lack_of_material"), CommEnum.CharacterTopToastIcon.Info, 1)

		return
	end

	AirWorkShopAtkAgent.instance:sendExchangeRequest(true)
end

function M:_refreshRedDot(e, info)
	if info.parentKey == GameEnum.RedPointEnum.AirMapNews then
		AirWorkShopDefAgent.instance:sendGetAllAirMapNewsReq()
	end
end

M.instance = M.New()

return M
