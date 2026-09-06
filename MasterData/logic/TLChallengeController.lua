-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/controller/TLChallengeController.lua

module("logic.extensions.timelimitedchallenge.controller.TLChallengeController", package.seeall)

local TLChallengeController = class("TLChallengeController", BaseController)

function TLChallengeController:ctor()
	TimedChallengeCircleFightAgent.instance:addHandler(TimedChallengeCircleFightAgent.PM_TimedChallengeCircleFightFinishRes, self._onCircleFightFinishRes, self)
	TimedChallengeAccumulateAgent.instance:addHandler(TimedChallengeAccumulateAgent.PM_TimedChallengeAccumulateFightFinishRes, self._onAccumulateFightFinishRes, self)
	TimedChallengeMiYaAgent.instance:addHandler(TimedChallengeMiYaAgent.PM_TimedChallengeMiYaEventFinishRes, self._onMiyaFightFinishRes, self)
end

function TLChallengeController:onInit()
	self:onReset()
end

function TLChallengeController:onReset()
	self._missionParams = nil
end

function TLChallengeController:getRuleDesc(challengeId)
	if challengeId == 12 then
		return lang("根据每轮累计总伤害给予对应的奖励")
	else
		return lang("击败敌阵所有精灵即可过关")
	end
end

function TLChallengeController:reqFight(challengeId, errHandler, errTarget)
	self._errHandler, self._errTarget = errHandler, errTarget

	if TimeLimitedConfig.instance:isCircleChallenge(challengeId) then
		TimedChallengeCircleFightAgent.instance:sendPM_TimedChallengeCircleFightReq(challengeId, function(msg)
			self:_onCircleFightRes(challengeId, msg)
		end, self, self._onErrorMsg)
	elseif challengeId == 2 then
		TimedChallengeAccumulateAgent.instance:sendPM_TimedChallengeAccumulateFightReq(challengeId, nil, self, self._onErrorMsg)
	elseif challengeId == 4 then
		TimedChallengeMiYaAgent.instance:sendPM_TimedChallengeMiYaProcessModeReq(3)
	else
		FloatWordMgr.instance:show("未知的限时挑战id = " .. challengeId)
	end
end

function TLChallengeController:_onCircleFightRes(challengeId)
	return
end

function TLChallengeController:_onErrorMsg(msg)
	GameUtil.callBack(self._errHandler, self._errTarget)
end

function TLChallengeController:reqResetChallenge(challengeId, handler, target)
	self._handler, self._target = handler, target

	TimedChallengeCircleFightAgent.instance:sendPM_TimedChallengeCircleResetChallengeReq(challengeId, function(msg)
		self:_onResetChallengeRes(challengeId, msg)
	end, self)
end

function TLChallengeController:_onResetChallengeRes(challengeId, msg)
	local fightInfo = TLChallengeModel.instance:getFightInfo(challengeId)
	local info = {}

	if fightInfo then
		fightInfo.curRound = 0
		fightInfo.hasChallengeCircle = fightInfo.hasChallengeCircle + 1
		info.totalDamage = fightInfo.totalDamage
		fightInfo.totalDamage = 0

		local everTotalMaxDamage = checknumber(msg.everTotalMaxDamage)

		if everTotalMaxDamage > 0 then
			fightInfo.everTotalMaxDamage = msg.everTotalMaxDamage
		end
	end

	info.changeSetId = msg.changeSetId
	info.challengeId = challengeId
	info.isCircleEnd = true
	info.singleDamage = nil
	info.singleDamgeTitle = ""
	info.totalDamageTitle = lang("本次挑战累积总伤害")
	info.title = lang("挑战结束")

	self:setBattleResultInfo(info)

	if challengeId == 3 then
		LonghuangGameModel.instance:setDodgeTime(0)
	end

	GameUtil.callBack(self._handler, self._target)
	GlobalDispatcher:dispatch(GlobalNotify.CircleChallengeReset)
end

function TLChallengeController:_onCircleFightFinishRes(msg)
	local info = {}
	local fightInfo = TLChallengeModel.instance:getFightInfo(msg.challengeId)

	info.curRound = fightInfo.curRound + 1

	if not msg.isCircleEnd then
		fightInfo.curRound = fightInfo.curRound + 1
		fightInfo.totalDamage = msg.totalDamage
	end

	local challengeId = msg.challengeId

	info.totalDamage = msg.totalDamage
	info.changeSetId = msg.changeSetId
	info.challengeId = challengeId
	info.isCircleEnd = msg.isCircleEnd
	info.singleDamage = msg.singleDamage
	info.singleDamgeTitle = string.format(lang("第%s轮累积总伤害"), info.curRound)
	info.totalDamageTitle = info.isCircleEnd and lang("本次挑战累积总伤害") or lang("当前累积总伤害")
	info.title = info.isCircleEnd and lang("挑战结束") or lang("战斗结束")

	if not info.isCircleEnd then
		local circleCfg = TimeLimitedConfig.instance:getCircleFightCfg(challengeId)

		info.pushStack = circleCfg.detailViewName

		if challengeId == 3 then
			LonghuangGameModel.instance:setDodgeTime(0)
		end
	end

	local leftDamage = checknumber(fightInfo.maxProgress) - checknumber(info.totalDamage)

	if leftDamage > 0 and not info.isCircleEnd then
		local petCo = self:getChallengePetCo(msg.challengeId)

		info.tips = string.format(lang("还差<color=#EB4642FF>%s</color>伤害即可击败%s"), leftDamage, petCo.name)
	end

	info.showSuccess = leftDamage <= 0

	self:setBattleResultInfo(info)
end

function TLChallengeController:_onAccumulateFightFinishRes(msg)
	local info = {}

	info.totalDamage = msg.totalDamage
	info.changeSetId = msg.changeSetId
	info.challengeId = msg.challengeId
	info.singleDamage = msg.singleDamage
	info.singleDamgeTitle = lang("本次挑战总伤害")
	info.totalDamageTitle = lang("潘多拉挑战累积总伤害")
	info.title = lang("挑战结束")

	self:setBattleResultInfo(info)
end

function TLChallengeController:_onTianManKingFightFinish(msg)
	local info = {}

	info.totalDamage = msg.damage
	info.changeSetId = msg.changeSetId
	info.challengeId = 18
	info.singleDamage = msg.accDamage
	info.singleDamgeTitle = TianmanKingController.instance:getText("TEXT_29")
	info.totalDamageTitle = TianmanKingController.instance:getText("TEXT_30")
	info.title = TianmanKingController.instance:getText("TEXT_31")

	self:setBattleResultInfo(info)
end

function TLChallengeController:_onMiyaFightFinishRes(msg)
	local info = {}

	info.changeSetId = msg.changeSetId
	info.title = lang("对弈结束")
	info.challengeId = 4

	if msg.isPass then
		info.rewardTitle = "对弈成功，获得奖励："
	else
		info.subTitle = "对弈失败！"
		info.text = lang("miya_playchess_lose_tip")
	end

	self:setBattleResultInfo(info)
	MiyaGameController.instance:onFightFinishRes()

	local curDiff = MiyaGameModel.instance:getCurDifficulty()
	local curModeId = MiyaGameModel.instance:getCurModeId()

	if curModeId == GameEnum.MiyaModeType.FIND_DIFFERENCE then
		SurveyController.instance:reportBehavior(200383, curDiff, msg.isPass and 1 or 0)
	elseif curModeId == GameEnum.MiyaModeType.ANSWER_QUIZ then
		SurveyController.instance:reportBehavior(200384, curDiff, msg.isPass and 1 or 0)
	end
end

function TLChallengeController:setBattleResultInfo(info)
	info.items = MaterialController.instance:saveChangeSetToTemp(info.changeSetId)
	self._btlResultInfo = info
end

function TLChallengeController:getBattleResultInfo()
	return self._btlResultInfo
end

function TLChallengeController:getChallengePetCo(challengeId)
	local cfg = TimeLimitedConfig.instance:getCfgById(challengeId)

	return (CharacterConfig.instance:getPetCo(cfg.raceId))
end

function TLChallengeController.getActLimitTimeDesc(challengeId)
	local challengeCfg = TimeLimitedConfig.instance:getCfgById(challengeId)

	if challengeCfg.openTimeType == 4 then
		local startTimestamp, endTimestamp = GameUtil.getStartAndEndInWeek(ServerTime.now())

		if endTimestamp >= GameUtil.string2time(GameUtil.ForeverActTimeString) then
			timeShowTxt = "活动时间：常驻"
		else
			local startDate = GameUtil.time2date(startTimestamp)
			local endDate = GameUtil.time2date(endTimestamp)

			timeShowTxt = string.format("活动时间：%02d.%02d %d:%02d - %02d.%02d %d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
		end

		return timeShowTxt
	end

	local startTime = GameUtil.string2time(challengeCfg.absoluteOpenDay)
	local endTime = GameUtil.string2time(challengeCfg.absoluteEndDay)

	return "活动时间：" .. (endTime < GameUtil.ForeverActTimeStringStamp and GameUtil.getTimeTxt(startTime, endTime, GameEnum.TimeTxt.M_D_H) or "常驻")
end

function TLChallengeController:getStartAndEndTimeStampByCId(challengeId)
	local cfg = TimeLimitedConfig.instance:getCfgById(challengeId)

	return self:getStartAndEndTime(cfg)
end

function TLChallengeController:getStartAndEndTime(cfg)
	if cfg.openTimeType == 1 then
		local openTimestamp = RoleModel.instance:getAreaOpenTimeSec()

		return GameUtil.getTimestampOnStartAndEnd(openTimestamp, cfg.relativeOpenDay, cfg.relativeEndDay)
	elseif cfg.openTimeType == 2 then
		return GameUtil.string2time(cfg.absoluteOpenDay), GameUtil.string2time(cfg.absoluteEndDay)
	elseif cfg.openTimeType == 4 then
		return GameUtil.string2time(cfg.absoluteOpenDay), GameUtil.string2time(cfg.absoluteEndDay)
	end

	return nil, nil
end

function TLChallengeController:isInOpenTime(challengeId, isTip)
	local cfg = TimeLimitedConfig.instance:getCfgById(challengeId)
	local isOpen = self:isInOpenTimeByCfg(cfg)

	if not isOpen and isTip then
		local funcCfg = FuncOpenConfig.instance:getFunctionOpenById(cfg.openFuncId)

		if funcCfg and not string.nilorempty(funcCfg.lockedTips) then
			FloatWordMgr.instance:show(funcCfg.lockedTips)
		end
	end

	return isOpen
end

function TLChallengeController:isInOpenTimeByCfg(cfg)
	if cfg == nil then
		return false
	end

	local isOpen = true

	isOpen = cfg.openTimeType == 1 and GameUtil.isInOpenDaysByOpenDay(cfg.relativeOpenDay, cfg.relativeEndDay) or cfg.openTimeType == 2 and GameUtil.checkIsInTimePeriod(cfg.absoluteOpenDay, cfg.absoluteEndDay) or cfg.openTimeType == 3 and true or cfg.openTimeType == 4 and true or isOpen

	return isOpen
end

function TLChallengeController:getLeftTimeFormat(challengeId)
	local cfg = TimeLimitedConfig.instance:getCfgById(challengeId)

	return self:_getLeftTimeFormat(cfg)
end

function TLChallengeController:_getLeftTimeFormat(cfg)
	local startTime, endTime = self:getStartAndEndTime(cfg)

	if startTime == nil then
		return "00:00:00"
	end

	local leftTime = endTime - ServerTime.now()

	return GameUtil.FormatTimeSymbol(leftTime)
end

function TLChallengeController:getExchangeLeftTimeFormated(exchangeId)
	local cfg = TimeLimitedConfig.instance:getExchangeOpenCfg(exchangeId)

	if cfg then
		return self:_getLeftTimeFormat(cfg)
	else
		return ""
	end
end

function TLChallengeController:reqDoExchange(challengeId, exchangeId, times)
	self._cacheChallengeId = challengeId

	TimedChallengeAgent.instance:sendPM_TimedChallengeDoExchangeReq(challengeId, exchangeId, times, self._onDoExchangeRes, self)
end

function TLChallengeController:_onDoExchangeRes(msg)
	TLChallengeModel.instance:doExchange(self._cacheChallengeId, msg)
	MaterialFacade.instance:popAndShowChangeSetItems(msg.changeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.TimedChallengeDoExchange, msg.exchangeId)

	if self._cacheChallengeId == 4 and msg.exchangeId == 10 then
		-- block empty
	end
end

function TLChallengeController:_openMiyaGiftView()
	print("_openMiyaGiftView")
	UIStateManager.instance:popByName(ViewName.TLCExchangeView)
	UIStateManager.instance:push(ViewName.MiyaGiftView)
	GlobalDispatcher:removeListener(GlobalNotify.ItemGetViewDoClosed, self._openMiyaGiftView, self)
end

function TLChallengeController:startChallenge(challengeId)
	local fightInfo = TLChallengeModel.instance:getFightInfo(challengeId)

	self._cacheInfo = {}
	self._cacheInfo.challengeId = challengeId

	if fightInfo then
		self._cacheInfo.maxProgress = fightInfo.maxProgress
		self._cacheInfo.totalDamage = fightInfo.totalDamage
		self._cacheInfo.lastDamage = fightInfo.lastDamage
	end
end

function TLChallengeController:getCurChallengeCacheInfo()
	return self._cacheInfo
end

function TLChallengeController:getRandomBuff(handler, handlerTarget)
	self._randomHandler = handler
	self._randomTarget = handlerTarget
	challengeId = 2

	local info = TLChallengeModel.instance:getFightInfo(challengeId)

	if info == nil then
		return
	end

	local buffId = info.validBuffId
	local cfg = TimeLimitedConfig.instance:getBuffCfgById(buffId)
	local fightCfg = TimeLimitedConfig.instance:getAccumulateFightCfg(challengeId)

	if cfg and cfg.grade == TimeLimitedConfig.instance:getMaxBuffLv() then
		FloatWordMgr.instance:show("当前已经是最优的效果，无需重抽")

		return
	end

	local fightCfg = TimeLimitedConfig.instance:getAccumulateFightCfg(challengeId)
	local matType, matId, matNum = unpack(string.splitToNumber(fightCfg.reGainBuffCost, ":"))
	local matCfg = MaterialMgr.getMatCfg(matType, matId)
	local isMatEnough = matNum <= MaterialModel.instance:getMaterialsNumber(matType, matId)

	if checknumber(buffId) > 0 then
		local params = {}

		params.title = lang("重新开盒")

		local matStr = TipsFacade.instance:getContentMatStr(string.format("%s:%s", matType, matId), 40, -10, true)

		params.text = string.format("你确定要消耗%s%s，重开潘多拉之盒吗？\n必定开出比当前更优的效果。", matNum, matStr)

		function params.okHandler()
			if not isMatEnough then
				FloatWordMgr.instance:show(matCfg.name .. "不足")
			else
				self:_reqRandomBuff()
			end
		end

		params.buffCfg = cfg
		params.showCancel = true
		params.challengeId = challengeId

		UIStateManager.instance:push(ViewName.ResetBuffView, params)
	else
		self:_reqRandomBuff()
	end
end

function TLChallengeController:_reqRandomBuff()
	TimedChallengeAccumulateAgent.instance:sendPM_TimedChallengeAccumulateRandomBuffReq(2, self._onRandomBuffRes, self)
end

function TLChallengeController:_onRandomBuffRes(msg)
	local info = TLChallengeModel.instance:getFightInfo(challengeId)

	info.validBuffId = msg.buffId

	local params = {}

	params.title = lang("潘多拉之盒")
	params.text = lang("开启潘多拉之盒，获得了如下战斗效果")
	params.buffId = msg.buffId
	params.okText = "知道了"
	params.okHandler = self._randomHandler
	params.okTarget = self._randomTarget

	UIStateManager.instance:push(ViewName.PopupBuffView, params)
end

function TLChallengeController:getMatParams(matStr)
	local matType, matId, matNum = unpack(string.splitToNumber(matStr, ":"))
	local matCfg = matType == MatType.Diamond_Consume and MaterialMgr.getMatCfg(MatType.Diamond, 1) or MaterialMgr.getMatCfg(matType, matId)
	local isMatEnough = MaterialMgr.getMatEnough(matStr)
	local graphicStr = matNum .. TipsFacade.instance:getContentMatStr(string.format("%s:%s", matType, matId), 40, -10, true)

	return graphicStr, isMatEnough, matCfg.name .. "不足"
end

function TLChallengeController:openTLCTip(title, text, okText, okHandler, okTarget, challengeId, showCancel, bgSpriteName)
	local params = {}

	params.title = title or "提示"
	params.okText = okText or "确定"
	params.text = text or ""
	params.okHandler = okHandler
	params.okTarget = okTarget
	params.showCancel = showCancel
	params.imgState = challengeId - 1
	params.bgSpriteName = bgSpriteName

	UIStateManager.instance:push(ViewName.PanduolaTipView, params)
end

function TLChallengeController:openChallengeView(challengeId)
	local cfg = TimeLimitedConfig.instance:getCfgById(challengeId)
	local funcId = cfg.openFuncId
	local funcCfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)
	local lockedTips = string.split(funcCfg.lockedTips, "\r\n")

	if not self:isInOpenTimeByCfg(cfg) then
		FloatWordMgr.instance:show(lockedTips[2])
	elseif not FuncOpenModel.instance:getFuncIsOpen(funcId) then
		FloatWordMgr.instance:show(lockedTips[1])
	else
		UIStateManager.instance:push(funcCfg.view)
	end
end

function TLChallengeController:openMissionView(challengeId, monsterCfg, creepCfg, showPower, showStrategy, showBossHp)
	if showBossHp == nil then
		showBossHp = true
	end

	local params = {
		challengeId = challengeId,
		monsterCfg = monsterCfg,
		creepCfg = creepCfg,
		showPower = showPower,
		showStrategy = showStrategy,
		showBossHp = showBossHp
	}

	self:setMissionParams(params)
	UIStateManager.instance:push(ViewName.TLCMissionView)
end

function TLChallengeController:setMissionParams(params)
	self._missionParams = params
end

function TLChallengeController:getMissionParams()
	return self._missionParams
end

function TLChallengeController:isShowBossHp()
	if self._missionParams then
		return self._missionParams.showBossHp
	end
end

TLChallengeController.instance = TLChallengeController.New()

return TLChallengeController
