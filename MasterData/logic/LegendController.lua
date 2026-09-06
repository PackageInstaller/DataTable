-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/controller/LegendController.lua

module("logic.extensions.legend.controller.LegendController", package.seeall)

local LegendController = class("LegendController", BaseController)

LegendController.BoxStateEnum = {
	CanGet = 1,
	Off = 0,
	Geted = 2
}
LegendController.MapDealType = {
	OnlyJump = 2,
	Original = 1
}

function LegendController:ctor()
	self._isEnterGame = false
end

function LegendController:onInit()
	GlobalDispatcher:addListener(LegendChallengeAgent.PM_ChallengeProcessInfoRes, self._onChallengeProcessInfoRes, self)
	GlobalDispatcher:addListener(LegendChallengeAgent.PM_LegendChallengeInfoRes, self._onLegendChallengeInfoRes, self)
	GlobalDispatcher:addListener(LegendChallengeAgent.PM_ChallengeRes, self._onChallengeRes, self)
	GlobalDispatcher:addListener(LegendChallengeAgent.PM_BuyIndependentTimesRes, self._onBuyIndependentTimesRes, self)
	GlobalDispatcher:addListener(LegendChallengeAgent.NotifyAfterChallengeRes, self._onNotifyAfterChallengeRes, self)
	GlobalDispatcher:addListener(LegendChallengeAgent.SweepsByTimesRes, self._onSweepsByTimesRes, self)
	GlobalDispatcher:addListener(LegendChallengeAgent.SweepAutoRes, self._onSweepAutoRes, self)
	GlobalDispatcher:addListener(LegendChallengeAgent.LegendChallengeTimesInfoRes, self._onLegendChallengeTimesInfoRes, self)
	LegendChallengeAgent.instance:setShowChangeSetFunc(GameUtil.handler(self.showChangeSet, self))
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
	GlobalDispatcher:addListener(LegendChallengeAgent.LegendChallengeTreasureInfoRes, self._onTreasureInfoRes, self)
	GlobalDispatcher:addListener(LegendChallengeAgent.LegendChallengeSetFormRes, self._onSupportSetFormRes, self)
	GlobalDispatcher:addListener(LegendChallengeAgent.LegendChallengeFormRes, self._onSupportGetFormRes, self)

	self._updateTime = LegendModel.instance:getUpdateTime()
end

function LegendController:onReset()
	self._isEnterGame = false

	removetimer(self._onSecond, self)
end

function LegendController:sendPM_ChallengeProcessInfoReq(handler, handlerObj, errHandler)
	LegendChallengeAgent.instance:sendPM_ChallengeProcessInfoReq(handler, handlerObj, errHandler)
end

function LegendController:sendPM_LegendChallengeInfoReq(challengeId, handler, handlerObj, errHandler)
	LegendChallengeAgent.instance:sendPM_LegendChallengeInfoReq(challengeId, handler, handlerObj, errHandler)
end

function LegendController:sendPM_ChallengeReq(challengeId, stageId, handler, handlerObj, errHandler)
	LegendChallengeAgent.instance:sendPM_ChallengeReq(challengeId, stageId, handler, handlerObj, errHandler)
end

function LegendController:sendPM_BuyChallengeTimesReq(handler, handlerObj, errHandler)
	LegendChallengeAgent.instance:sendPM_BuyChallengeTimesReq(handler, handlerObj, errHandler)
end

function LegendController:sendPM_BuyIndependentTimesReq(challengeId, handler, handlerObj, errHandler)
	LegendChallengeAgent.instance:sendPM_BuyIndependentTimesReq(challengeId, handler, handlerObj, errHandler)
end

function LegendController:sendSweepsByTimesReq(challengeId, stageId, times, handler, handlerObj, errHandler)
	LegendChallengeAgent.instance:sendSweepsByTimesReq(challengeId, stageId, times, handler, handlerObj, errHandler)
end

function LegendController:sendSweepAutoReq(challengeId, stageId, materialType, materialId, num, handler, handlerObj, errHandler)
	LegendChallengeAgent.instance:sendSweepAutoReq(challengeId, stageId, materialType, materialId, num, handler, handlerObj, errHandler)
end

function LegendController:sendLegendChallengeTreasureInfoReq()
	LegendChallengeAgent.instance:sendLegendChallengeTreasureInfoReq()
end

function LegendController:sendLegendChallengeGainTreasureReq(id)
	LegendChallengeAgent.instance:sendLegendChallengeGainTreasureReq(id, function()
		LegendModel.instance:updateGetedBox(id)
		GlobalDispatcher:dispatch(GlobalNotify.LegendChallengeGainTreasureRes, id)
	end)
end

function LegendController:sendLegendChallengeTimesInfoReqAll()
	local challengeIds = {}
	local cfgs = LegendConfig.instance:getLegendChallengeCfgs()

	for i, v in ipairs(cfgs) do
		table.insert(challengeIds, v.challengeId)
	end

	LegendChallengeAgent.instance:sendLegendChallengeTimesInfoReq(challengeIds)
end

function LegendController:sendSupportSetFormReq(challengeId, stageId, simpleForm_pb)
	LegendChallengeAgent.instance:sendLegendChallengeSetFormReq(challengeId, stageId, simpleForm_pb)
end

function LegendController:sendSupportGetFormReq(challengeId, stageId)
	LegendChallengeAgent.instance:sendLegendChallengeFormReq(challengeId, stageId)
end

function LegendController:loadLegendChallengeInfo()
	LegendController.instance:sendPM_ChallengeProcessInfoReq()
end

function LegendController:_onChallengeProcessInfoRes(status, msg)
	if status == 0 then
		LegendModel.instance:onChallengeProcessInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.LegendChallengeProcessInfoRes, msg)
	end
end

function LegendController:_onLegendChallengeInfoRes(status, msg)
	if status == 0 then
		LegendModel.instance:onLegendChallengeInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.LegendChallengeInfoRes, msg)
	end
end

function LegendController:_onChallengeRes(status, msg)
	if status == 0 then
		LegendModel.instance:onChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.LegendChallengeRes, msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function LegendController:_onBuyIndependentTimesRes(status, msg)
	if status == 0 then
		LegendModel.instance:onBuyIndependentTimesRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.LegendChallengeBuyIndependentTimesRes, msg)
	end
end

function LegendController:_onNotifyAfterChallengeRes(status, msg)
	if status == 0 then
		LegendModel.instance:onNotifyAfterChallengeRes(msg)

		local challengeId, stageId = LegendModel.instance:getOpenChallengeIdAndStageId()

		GlobalDispatcher:dispatch(GlobalNotify.LegendChallengeNotifyAfterChallengeRes, msg)

		if msg.isWin then
			local isStagePass = LegendConfig.instance:isLastStageById(challengeId, stageId)

			printInfo("test _onNotifyAfterChallengeRes", msg.isWin, LegendConfig.instance:isLastStageById(challengeId, stageId))

			if msg.isWin then
				LegendController.instance:sendPM_LegendChallengeInfoReq(challengeId)
				self:_openPassShowView(challengeId)
			end
		end
	end
end

function LegendController:_openPassShowView(challengeId)
	printInfo("test _openPassShowView1", challengeId)

	local cfg = LegendConfig.instance:getLegendChallengeCfg(challengeId)

	if cfg then
		local param = {}

		param.raceId = cfg.raceId
		param.desc = cfg.passDesc

		UIJumper.instance:removeTopState(ViewName.Legend)
		printInfo("test _openPassShowView2", challengeId, cfg.raceId, cfg.passDesc)
		UIJumper.instance:pushOneStack(ViewName.PassShowView, true, param)
	end
end

function LegendController:_onSweepsByTimesRes(status, msg)
	if status == 0 then
		LegendModel.instance:onSweepsByTimesRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.LegendChallengeSweepsByTimesRes, msg)
	end
end

function LegendController:_onSweepAutoRes(status, msg)
	if status == 0 then
		LegendModel.instance:onSweepAutoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.LegendChallengeSweepAutoRes, msg)
	end
end

function LegendController:_onLegendChallengeTimesInfoRes(status, msg)
	if status == 0 then
		LegendModel.instance:onLegendChallengeTimesInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.LegendChallengeTimesInfoRes, msg)
	end
end

function LegendController:_onTreasureInfoRes(status, msg)
	if status == 0 then
		LegendModel.instance:onTreasureInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.LegendChallengeTreasureInfoRes, msg)
	end
end

function LegendController:_onSupportSetFormRes(status, msg)
	if status == 0 then
		LegendModel.instance:setSupportFormRes(msg.challengeId, msg.stageId, msg.simpleForm)
		GlobalDispatcher:dispatch(GlobalNotify.LegendSupportSetForm)
		GlobalDispatcher:dispatch(GlobalNotify.FormationRefresh)
	end
end

function LegendController:_onSupportGetFormRes(status, msg)
	if status == 0 then
		LegendModel.instance:setSupportFormRes(msg.challengeId, msg.stageId, msg.simpleForm)
		GlobalDispatcher:dispatch(GlobalNotify.LegendSupportGetForm)
	end
end

function LegendController:showChangeSet(changeSetId, msgName)
	if msgName == "handleNotifyAfterChallengeRes" then
		BattleSettlementModel.instance:setChangeSetId(changeSetId)
	else
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
	end
end

function LegendController:_onStartEnterGame()
	self._isEnterGame = true

	settimer(2, self._onSecond, self)
end

function LegendController:_onSecond()
	if self._isEnterGame and not BattleController.instance:isBattling() then
		self:_setNpcOpenState()
	end
end

function LegendController:_setNpcOpenState()
	local cfgs = LegendConfig.instance:getLegendChallengeCfgs()

	if not cfgs then
		return
	end

	local id = 0

	for i, v in ipairs(cfgs) do
		if not string.nilorempty(v.startTime) and not string.nilorempty(v.endTime) then
			if v.__chId then
				id = v.__chId
			else
				id = checknumber(string.split(v.jumpTo, "#")[2])
				v.__chId = id
			end

			if GameUtil.checkIsInTimePeriod(v.startTime, v.endTime) then
				local isUnlock = UnlockModel.instance:isFunctionUnlock(v.challengeId)

				if isUnlock then
					SceneNpcsMgr.instance:createNpc(id)
				else
					SceneNpcsMgr.instance:removeNpc(id)
				end
			else
				SceneNpcsMgr.instance:removeNpc(id)
			end
		end
	end
end

function LegendController:_getCostDiamondNum(buyType, challengeId)
	local cfg = LegendConfig.instance:getLegendBuyTimesPriceCfg(buyType, challengeId, buyType == 1 and LegendModel.instance:getPublicBuyTimes() + 1 or LegendModel.instance:getIndependentBuyTimes(challengeId) + 1)

	if cfg then
		local params = string.split(cfg.price, ":")

		if params[3] then
			return checknumber(params[3])
		end
	end

	return 0
end

function LegendController:sendSweepsByTimesReq(challengeId, stageId, times, handler, handlerObj, errHandler)
	LegendChallengeAgent.instance:sendSweepsByTimesReq(challengeId, stageId, times, handler, handlerObj, errHandler)
end

function LegendController:sendSweepAutoReq(challengeId, stageId, materialType, materialId, num, handler, handlerObj, errHandler)
	LegendChallengeAgent.instance:sendSweepAutoReq(challengeId, stageId, materialType, materialId, num, handler, handlerObj, errHandler)
end

function LegendController:openRaidersView(challengeId, stageId, targetPosition)
	local cfgStage = LegendConfig.instance:getLegendChallengeStageCfg(challengeId, stageId)

	if not cfgStage then
		return
	end

	local param = {}

	param.challengeId = challengeId
	param.stageId = stageId
	param.txtCfg = cfgStage

	local cfgChallenge = LegendConfig.instance:getLegendChallengeCfg(challengeId)

	if cfgChallenge then
		param.challengeName = cfgChallenge.challengeName
	end

	self:openRaidersViewByParam(param, targetPosition)
end

function LegendController:openRaidersViewByParam(param, targetPosition)
	local cfgStage = param.txtCfg

	if cfgStage then
		local uiFlyParam = UIFlyTweenParam.New()

		uiFlyParam.endPosition = targetPosition

		local isSmallView = string.nilorempty(cfgStage.raidersText1) and string.nilorempty(cfgStage.raidersText2)

		if isSmallView then
			UIStateManager.instance:open(ViewName.RaidersSmallView, param, uiFlyParam)
		else
			UIStateManager.instance:open(ViewName.RaidersBigView, param, uiFlyParam)
		end
	end
end

function LegendController:openXiongmaoView()
	UIStateManager.instance:clear()
	ChallengeFacade.instance:startChallange(LegendModel.OldXiongMaoId)
end

function LegendController:openQiannaowanView()
	UIStateManager.instance:clear()
	ChallengeFacade.instance:startChallange(LegendModel.OldQianNiaoWanId)
end

function LegendController:openSweepByChallengeId(challengeId)
	local cfgList = LegendConfig.instance:getLegendChallengeStageCfgList(challengeId)

	if cfgList and #cfgList > 0 then
		MopupModel.instance:clickLegenSweep(challengeId, cfgList[#cfgList].stageId)
	end
end

function LegendController:isChallengeUnlock(unlockId)
	if unlockId > 0 then
		return FuncOpenModel.instance:getFuncIsOpen(unlockId)
	else
		return true
	end
end

function LegendController:dealWithLegend(challengeId)
	local cfg = LegendConfig.instance:getLegendChallengeCfg(checknumber(challengeId))

	if not cfg then
		printInfo("test 精灵挑战配置不存在 challengeId =", challengeId)

		return true
	end

	if cfg.flag == LegendModel.XiongMaoGame then
		if not ChallengeModel.instance:isXiongMaoGamePass() then
			self:openXiongmaoView()

			return true
		end
	elseif cfg.flag == LegendModel.QianNiaoWanGame and not ChallengeModel.instance:isQianNiaoWanGamePass() then
		self:openQiannaowanView()

		return true
	end

	local isUnlock = self:isChallengeUnlock(cfg.unlockId)
	local isPass = LegendModel.instance:isChallengePass(cfg.challengeId)

	if isUnlock and isPass then
		self:openSweepByChallengeId(cfg.challengeId)

		return true
	end

	return false
end

function LegendController:isFuncUnlock(unlockId)
	if unlockId > 0 then
		return FuncOpenModel.instance:getFuncIsOpen(unlockId)
	else
		return true
	end
end

function LegendController:_isEnteredLegendView(challengeId)
	return GameUtil.getUserData(LegendConst.isClickChallengeFirst .. challengeId)
end

function LegendController:setEnteredLegendView(challengeId)
	GameUtil.saveUserData(LegendConst.isClickChallengeFirst .. challengeId, true)
end

function LegendController:getBoxState(treasureId, condition)
	local isGeted = LegendModel.instance:isTreasureBoxGeted(treasureId)

	if isGeted then
		return LegendController.BoxStateEnum.Geted
	elseif self:_isMatchCondition(condition) then
		return LegendController.BoxStateEnum.CanGet
	else
		return LegendController.BoxStateEnum.Off
	end
end

function LegendController:_isMatchCondition(condition)
	if string.nilorempty(condition) then
		return false
	end

	local list = string.split(condition, ",")
	local isMatch = true

	for i, v in ipairs(list) do
		if not string.nilorempty(v) then
			local str = string.split(v, "_")
			local challengeId = checknumber(str[1])
			local stageId = checknumber(str[2])

			isMatch = isMatch and LegendModel.instance:isStagePass(challengeId, stageId)
		end
	end

	return isMatch
end

function LegendController:isActiveRedPoint()
	local cfgPets = LegendConfig.instance:getLegendChallengeCfgs()

	for i, v in ipairs(cfgPets) do
		if self:isShowRedByChallengeId(v) then
			return true
		end
	end

	local cfgBoxs = LegendConfig.instance:getTreasureCfgs()

	for i, v in ipairs(cfgBoxs) do
		if LegendController.instance:getBoxState(v.treasureId, v.condition) == LegendController.BoxStateEnum.CanGet then
			return true
		end
	end

	return false
end

function LegendController:isShowRedByChallengeId(cfgLegendChallenge)
	local isUnlock = self:isFuncUnlock(cfgLegendChallenge.unlockId)
	local isPass = LegendModel.instance:isChallengePass(cfgLegendChallenge.challengeId)
	local isEnter = self:_isEnteredLegendView(cfgLegendChallenge.challengeId)

	if isUnlock and not isPass and not isEnter then
		return true
	end

	return false
end

function LegendController:raceIdToHeroSkillId(raceId)
	return 400000 + raceId
end

function LegendController:getCurLegendMapId()
	local dataKey = "Legend_Switch_Cur_Map_ID"
	local dataValue = checknumber(GameUtil.getUserData(dataKey))

	if dataValue <= 0 then
		dataValue = self:getRecommendMapId()

		self:setCurLegendMapId(dataValue)
	end

	return dataValue
end

function LegendController:setCurLegendMapId(mapId)
	local dataKey = "Legend_Switch_Cur_Map_ID"
	local dataValue = checknumber(mapId)
	local cfgs = LegendConfig.instance:getMapListCfgs()

	dataValue = MathUtil.clamp(dataValue, 1, #cfgs)

	GameUtil.saveUserData(dataKey, mapId)
	GlobalDispatcher:dispatch(GlobalNotify.LegendSwitchMap, dataValue)
end

function LegendController:getRecommendMapId()
	local mapId = 1
	local funcId = LegendController.instance:getSwitchOpenFuncId()
	local isLock = not FuncOpenModel.instance:getFuncIsOpen(funcId)

	if isLock then
		mapId = 1
	else
		local mapCfgs = LegendConfig.instance:getMapListCfgs()
		local zdl = RoleModel.instance:getMaxPower()

		for id, cfg in ipairs(mapCfgs) do
			if id ~= 1 and zdl > cfg.zdlRecommend then
				local petCfgs = LegendConfig.instance:getMapDetailCfg(cfg.mapId)

				for challengeId, challengeCfg in ipairs(petCfgs) do
					if not BagModel.instance:isExistRaceId(challengeCfg.raceId) then
						mapId = cfg.mapId

						return cfg.mapId
					end
				end
			end
		end
	end

	return mapId
end

function LegendController:getCurMapDealType()
	local curMapId = self:getCurLegendMapId()
	local cfg = LegendConfig.instance:getMapListCfg(curMapId)

	return cfg and cfg.dealType
end

function LegendController:getSwitchOpenFuncId()
	return 1144
end

LegendController.instance = LegendController.New()

return LegendController
