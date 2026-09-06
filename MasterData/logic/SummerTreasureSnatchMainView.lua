-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/view/SummerTreasureSnatchMainView.lua

module("logic.extensions.summertreasuresnatch.view.SummerTreasureSnatchMainView", package.seeall)

local SummerTreasureSnatchMainView = class("SummerTreasureSnatchMainView", ViewComponent)

function SummerTreasureSnatchMainView:ctor()
	SummerTreasureSnatchMainView.super.ctor(self)
end

function SummerTreasureSnatchMainView:buildUI()
	SummerTreasureSnatchMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._con = self:getGo("con")
	self._btnTip = self:getBtn("leftTop/txtTitle/btnTip")
	self._rightTeamProgress = self:getGo("rightTeamProgress")
	self._leftTeamProgress = self:getGo("leftTeamProgress")
	self._txtTeamLeftHurt = self:getTxt("leftTeamProgress/txt")
	self._txtTeamRightHurt = self:getTxt("rightTeamProgress/txt")
	self._curTeamLeft = self:getGo("leftTeam/curTeam")
	self._curTeamRight = self:getGo("rightTeam/curTeam")
	self._txtLeftTeam = self:getTxt("leftTeam/txtLeftTeam")
	self._txtRightTeam = self:getTxt("rightTeam/txtRightTeam")
	self._txtRadio = self:getTxt("radio/txtRadio")
	self._txtMaxHurt = self:getTxt("boss/txtMaxHurt")
	self._txtTotalHurt = self:getTxt("boss/txtTotalHurt")
	self._btnPractice = self:getBtn("boss/btnPractice")
	self._btnBossLeft = self:getBtn("boss/btnLeft")
	self._btnBossRight = self:getBtn("boss/btnRight")
	self._btnFightBoss = self:getBtn("btnFightBoss")
	self._txtFightBossNum = self:getTxt("btnFightBoss/txtFightBossNum")
	self._btnMatch = self:getBtn("btnMatch")
	self._txtMatch = self:getTxt("btnMatch/txtMatch")
	self._showCamp = self:getGo("showCamp")
	self._imgTeamChange = self:getGo("showCamp/imgTeam"):GetComponent(ComponentType.UIImageSpriteChange)
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._redPoint1 = self:getGo("jumpBtnCol/btnJump1/redPoint")
	self._btnRank = self:getGo("btnRank")
	self._btnShop = self:getGo("btnShop")
	self._btnFormation = self:getGo("btnFormation")
	self._btnBuyFightBoss = self:getGo("btnFightBoss/btnBuyFightBoss")
	self._btnBossShow = self:getGo("btnBossShow")
	self._coin1 = self:getGo("coin1")
	self._coin2 = self:getGo("coin2")
	self._icon1 = self:getGo("coin1/icon")
	self._txtNum1 = self:getTxt("coin1/txtNum")
	self._icon2 = self:getGo("coin2/icon")
	self._txtNum2 = self:getTxt("coin2/txtNum")
end

function SummerTreasureSnatchMainView:bindEvents()
	SummerTreasureSnatchMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._showCamp, self._onClickShowCamp, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnPractice, self._onClickPractice, self)
	GameUtil.addClickHandler(self._btnBossLeft, self._onClickBossLeft, self)
	GameUtil.addClickHandler(self._btnBossRight, self._onClickBossRight, self)
	GameUtil.addClickHandler(self._btnFightBoss, self._onClickFightBoss, self)
	GameUtil.addClickHandler(self._btnMatch, self._onClickMatch, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnFormation, self._popFormation, self)
	GameUtil.addClickHandler(self._btnBuyFightBoss, self._onClickBuyFightBoss, self)
	GameUtil.addClickHandler(self._btnBossShow, self._onClickBtnBossShow, self)
	GameUtil.addClickHandler(self._icon1, GameUtil.handler(self._onClickBtnCoin, self, 1))
	GameUtil.addClickHandler(self._icon2, GameUtil.handler(self._onClickBtnCoin, self, 2))
end

function SummerTreasureSnatchMainView:unbindEvents()
	SummerTreasureSnatchMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._showCamp)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPractice)
	GameUtil.rmClickHandler(self._btnBossLeft)
	GameUtil.rmClickHandler(self._btnBossRight)
	GameUtil.rmClickHandler(self._btnFightBoss)
	GameUtil.rmClickHandler(self._btnMatch)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnFormation)
	GameUtil.rmClickHandler(self._btnBuyFightBoss)
	GameUtil.rmClickHandler(self._btnBossShow)
	GameUtil.rmClickHandler(self._icon1)
	GameUtil.rmClickHandler(self._icon2)
end

function SummerTreasureSnatchMainView:onEnter()
	SummerTreasureSnatchMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_SummerTreasureSnatchInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_SummerTreasureSnatchBuyItemRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_SummerTreasureSnatchPvpFightRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_SummerTreasureSnatchNotifyBossClgRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.OnMaterialItemChange, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 623001
	end

	self._actCfg = SummerTreasureSnatchConfig.instance:getActivityCfg(self._activityId) or {}
	self._totalWidth = GameUtil.getWidth(self._leftTeamProgress) + GameUtil.getWidth(self._rightTeamProgress)

	self:_initBossCfgs()

	local curWeek = SummerTreasureSnatchController.instance:getCurWeek(self._activityId)
	local isActivityEnd = self:_isActivityEnd()

	if isActivityEnd or curWeek > self._lastWeek then
		self:_onUpdate()
	else
		SummerTreasureSnatchController.instance:sendPM_SummerTreasureSnatchInfoReq(self._activityId)
	end

	self._hasEnterTime = 0
	self._updateDuration = 300
	self._enterTime = ServerTime.now()

	self:_tick()
	settimer(1, self._tick, self, true)
	RedPointController.instance:regRedPoint(self._redPoint1, 794)
end

function SummerTreasureSnatchMainView:onExit()
	SummerTreasureSnatchMainView.super.onExit(self)
	removetimer(self._tick, self)
	RoleObjectPool.instance:removeRole(self._role)
	RedPointController.instance:unregRedPoint(self._redPoint1)
end

function SummerTreasureSnatchMainView:_tick()
	self._hasEnterTime = self._hasEnterTime + 1
	self._curTime = self._enterTime + self._hasEnterTime

	self:_updateRadio()

	local curWeek = SummerTreasureSnatchController.instance:getCurWeek(self._activityId)
	local showWeek = math.min(curWeek, self._lastWeek)
	local isActivityEnd = self:_isActivityEnd()
	local canSendInfoReq = curWeek <= self._lastWeek and not isActivityEnd

	if self._week ~= showWeek then
		self:_initBossCfgs()

		if canSendInfoReq then
			SummerTreasureSnatchController.instance:sendPM_SummerTreasureSnatchInfoReq(self._activityId)
		end
	elseif canSendInfoReq and self._hasEnterTime % self._updateDuration == 0 then
		SummerTreasureSnatchController.instance:sendPM_SummerTreasureSnatchInfoReq(self._activityId)
	end
end

function SummerTreasureSnatchMainView:_updateRadio()
	local leftCamp = SummerTreasureSnatchModel.instance:getCampInfo(self._activityId, SummerTreasureSnatchController.TeamType.Left) or {}
	local rightCamp = SummerTreasureSnatchModel.instance:getCampInfo(self._activityId, SummerTreasureSnatchController.TeamType.Right) or {}
	local leftDamage = checknumber(leftCamp.damage)
	local rightDamage = checknumber(rightCamp.damage)
	local leftName = SummerTreasureSnatchConfig.instance:getCampName(self._activityId, SummerTreasureSnatchController.TeamType.Left)
	local rightName = SummerTreasureSnatchConfig.instance:getCampName(self._activityId, SummerTreasureSnatchController.TeamType.Right)
	local showRadioStr = ""

	showRadioStr = rightDamage < leftDamage and langPara("全服广播：%s暂时领先", leftName) or leftDamage < rightDamage and langPara("全服广播：%s暂时领先", rightName) or lang("全服广播：双方势均力敌")

	local needCountDown = self:_needShowCountDown()

	if needCountDown then
		local countDown = self:_getCountDown()

		showRadioStr = string.format("%s    %s", showRadioStr, countDown)
	end

	self._txtRadio.text = showRadioStr
end

function SummerTreasureSnatchMainView:_needShowCountDown()
	local curTime = self._curTime
	local weekEndTime = self:_getCurWeekEndTime()
	local leftTime = weekEndTime - curTime

	return leftTime > 0 and leftTime <= 3600
end

function SummerTreasureSnatchMainView:_getCountDown()
	if not self._curTime then
		local curTime = ServerTime.now()
		local weekEndTime = self:_getCurWeekEndTime()
		local leftTime = math.max(weekEndTime - curTime, 0)
		local timeStr = GameUtil.FormatTimeSymbol(leftTime)

		return langPara("距离结算：%s", timeStr)
	end
end

function SummerTreasureSnatchMainView:_getCurWeekEndTime()
	local activityType = ActivityDefineController.instance:getActTypeByActId(self._activityId)
	local startTime = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, self._activityId)

	return startTime + self._week * 7 * 24 * 60 * 60 - 18000
end

function SummerTreasureSnatchMainView:_initBossCfgs()
	local bossCfgs = SummerTreasureSnatchConfig.instance:getBossCfgs(self._activityId) or {}
	local curWeek = SummerTreasureSnatchController.instance:getCurWeek(self._activityId)

	self._lastWeek = #bossCfgs
	self._week = math.min(curWeek, self._lastWeek)
	self._bossCfgs = bossCfgs[self._week] or {}
	self._curBossIdx = SummerTreasureSnatchController.instance:getBossIdx()
	self._curBossCfg = self._bossCfgs[self._curBossIdx] or {}

	self:_onChangePlayRole()
end

function SummerTreasureSnatchMainView:_tryPopCamp()
	local isActivityEnd = self:_isActivityEnd()
	local needShowCamp = self:_needShowCamp()
	local needShow = not isActivityEnd and needShowCamp

	GameUtil.SetActive(self._showCamp, needShow)
end

function SummerTreasureSnatchMainView:_needShowCamp()
	local key = string.format("SummerTreasureSnatchMainView_%s", self._activityId)
	local lastRecordWeek = checknumber(GameUtil.getUserData(key))

	return self._week ~= lastRecordWeek
end

function SummerTreasureSnatchMainView:_onUpdate()
	self:_updateUI()
	self:_tryPopCamp()
end

function SummerTreasureSnatchMainView:_updateUI()
	self._info = SummerTreasureSnatchModel.instance:getInfo(self._activityId) or {}
	self._curBoosInfo = SummerTreasureSnatchModel.instance:getBossInfo(self._activityId, self:_getCurBossId())

	local leftCamp = SummerTreasureSnatchModel.instance:getCampInfo(self._activityId, SummerTreasureSnatchController.TeamType.Left) or {}
	local rightCamp = SummerTreasureSnatchModel.instance:getCampInfo(self._activityId, SummerTreasureSnatchController.TeamType.Right) or {}
	local leftDamage = checknumber(leftCamp.damage)
	local rightDamage = checknumber(rightCamp.damage)
	local totalDamage = leftDamage + rightDamage

	self._myCamp = checknumber(self._info.myCamp)

	local curCampCfg = SummerTreasureSnatchConfig.instance:getCampCfgByCampId(self._activityId, self._myCamp)

	if curCampCfg then
		if not curCampCfg.name then
			local leftName = SummerTreasureSnatchConfig.instance:getCampName(self._activityId, SummerTreasureSnatchController.TeamType.Left)
			local rightName = SummerTreasureSnatchConfig.instance:getCampName(self._activityId, SummerTreasureSnatchController.TeamType.Right)
			local leftWinRate = SummerTreasureSnatchModel.instance:getCampWinRate(self._activityId, SummerTreasureSnatchController.TeamType.Left)
			local rightWinRate = SummerTreasureSnatchModel.instance:getCampWinRate(self._activityId, SummerTreasureSnatchController.TeamType.Right)
			local bossTotalDamage = self._curBoosInfo and checknumber(self._curBoosInfo.totalDamage) or 0
			local bossSingleMaxDamage = self._curBoosInfo and checknumber(self._curBoosInfo.singleMaxDamage) or 0
			local leftShowHurt = langPara("%s", MmUtil.formatNumber(leftDamage, MmUtil.Units_EN, 3))
			local rightShowHurt = langPara("%s", MmUtil.formatNumber(rightDamage, MmUtil.Units_EN, 3))
			local bossSingleMaxDamageShowHurt = langPara("%s", MmUtil.formatNumber(bossSingleMaxDamage, MmUtil.Units_EN))
			local bossTotalDamageShowHurt = langPara("%s", MmUtil.formatNumber(bossTotalDamage, MmUtil.Units_EN))
			local matType1, matId1, _ = MaterialMgr.getMatParams(self._actCfg.scoreMatStr)
			local matType2, matId2, _ = MaterialMgr.getMatParams(self._actCfg.actShopMatStr)
			local curHasMatNum = MaterialModel.instance:getMaterialsNumber(matType2, matId2)
			local leftWidth = self._totalWidth / 2
			local rightWidth = self._totalWidth / 2

			if totalDamage > 0 then
				leftWidth = self._totalWidth * (leftDamage / totalDamage)
				rightWidth = self._totalWidth * (rightDamage / totalDamage)
			end

			GameUtil.setWidth(self._leftTeamProgress, leftWidth)
			GameUtil.setWidth(self._rightTeamProgress, rightWidth)

			self._txtTeamLeftHurt.text = langPara("%s：%s", leftName, leftShowHurt)
			self._txtTeamRightHurt.text = langPara("%s：%s", rightName, rightShowHurt)
			self._txtLeftTeam.text = langPara("每周匹配胜率:%s%%", leftWinRate)
			self._txtRightTeam.text = langPara("每周匹配胜率:%s%%", rightWinRate)
			self._txtMaxHurt.text = langPara("单次最高伤害：     %s", bossSingleMaxDamageShowHurt)
			self._txtTotalHurt.text = langPara("累计造成的伤害： %s", bossTotalDamageShowHurt)
			self._txtFightBossNum.text = langPara("门票：%s", SummerTreasureSnatchController.instance:getRemainBossTimes(self._activityId))
			self._txtMatch.text = langPara("次数：%s", SummerTreasureSnatchController.instance:getRemainPvpTimes(self._activityId))

			if self._myCamp > 0 then
				self._imgTeamChange:SetState(self._myCamp - 1)
			end

			GameUtil.SetActive(self._curTeamLeft, self._myCamp == SummerTreasureSnatchController.TeamType.Left)
			GameUtil.SetActive(self._curTeamRight, self._myCamp == SummerTreasureSnatchController.TeamType.Right)
			MaterialMgr.setIcon(self._icon1, matType1, matId1, nil, nil)
			MaterialMgr.setIcon(self._icon2, matType2, matId2, nil, nil)

			self._txtNum1.text = checknumber(self._info.score)
			self._txtNum2.text = curHasMatNum
		end
	end
end

function SummerTreasureSnatchMainView:_getCurBossId()
	local bossCfg = self._bossCfgs[self._curBossIdx]

	return (bossCfg or nil) and (bossCfg.bossId or 0)
end

function SummerTreasureSnatchMainView:_isActivityEnd()
	local endTime = GameUtil.string2time(self._actCfg.endTime)

	return endTime <= ServerTime.now()
end

function SummerTreasureSnatchMainView:_checkActivityEnd()
	local isEnd = self:_isActivityEnd()

	if isEnd then
		FloatWordMgr.instance:show(lang("该活动已结束，仅可查看商店与任务"))
	end

	return isEnd
end

function SummerTreasureSnatchMainView:_checkWeeklySettlement()
	local curTime = ServerTime.now()
	local weekEndTime = self:_getCurWeekEndTime()
	local settlementEndTime = weekEndTime + 18000
	local isSettlement = weekEndTime <= curTime and curTime < settlementEndTime

	if isSettlement then
		FloatWordMgr.instance:show(lang("结算中，请5:00后再试"))
	end

	return isSettlement
end

function SummerTreasureSnatchMainView:_onClickTip()
	local ruleKey = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(ruleKey)
end

function SummerTreasureSnatchMainView:_onClickPractice()
	if self:_checkActivityEnd() then
		return
	end

	if self:_checkWeeklySettlement() then
		return
	end

	local hasPreset = SummerTreasureSnatchModel.instance:hasPreSetFormation(self._activityId)

	if not hasPreset then
		FloatWordMgr.instance:show(lang("尚未完成布置守阵，请至少布置一个守阵后再来吧！"))
		self:_popFormation()

		return
	end

	SummerTreasureSnatchController.instance:enterBossBattleClg(self._activityId, self:_getCurBossId(), true)
end

function SummerTreasureSnatchMainView:_onClickBossLeft()
	local bossCount = #self._bossCfgs

	if bossCount <= 0 then
		return
	end

	self._curBossIdx = self._curBossIdx - 1

	if self._curBossIdx < 1 then
		self._curBossIdx = bossCount
	end

	self._curBossCfg = self._bossCfgs[self._curBossIdx] or {}

	self:_onChangePlayRole()
	self:_updateUI()
end

function SummerTreasureSnatchMainView:_onClickBossRight()
	local bossCount = #self._bossCfgs

	if bossCount <= 0 then
		return
	end

	self._curBossIdx = self._curBossIdx + 1

	if bossCount < self._curBossIdx then
		self._curBossIdx = 1
	end

	self._curBossCfg = self._bossCfgs[self._curBossIdx] or {}

	self:_onChangePlayRole()
	self:_updateUI()
end

function SummerTreasureSnatchMainView:_onClickFightBoss()
	if self:_checkActivityEnd() then
		return
	end

	if self:_checkWeeklySettlement() then
		return
	end

	local remainBossTimes = SummerTreasureSnatchController.instance:getRemainBossTimes(self._activityId, self:_getCurBossId())

	if remainBossTimes <= 0 then
		FloatWordMgr.instance:show(lang("Boss挑战次数不足"))

		return
	end

	local hasPreset = SummerTreasureSnatchModel.instance:hasPreSetFormation(self._activityId)

	if not hasPreset then
		FloatWordMgr.instance:show(lang("尚未完成布置守阵，请至少布置一个守阵后再来吧！"))
		self:_popFormation()

		return
	end

	SummerTreasureSnatchController.instance:setBossIdx(self._curBossIdx)
	SummerTreasureSnatchController.instance:enterBossBattleClg(self._activityId, self:_getCurBossId(), false)
end

function SummerTreasureSnatchMainView:_onClickMatch()
	if self:_checkActivityEnd() then
		return
	end

	if self:_checkWeeklySettlement() then
		return
	end

	if SummerTreasureSnatchController.instance:getRemainPvpTimes(self._activityId) <= 0 then
		FloatWordMgr.instance:show(lang("匹配次数不足"))

		return
	end

	local hasPreset = SummerTreasureSnatchModel.instance:hasPreSetFormation(self._activityId)

	if not hasPreset then
		FloatWordMgr.instance:show(lang("尚未完成布置守阵，请至少布置一个守阵后再来吧！"))
		self:_popFormation()

		return
	end

	SummerTreasureSnatchController.instance:enterPvpBattleClg(self._activityId)
end

function SummerTreasureSnatchMainView:_onClickBtnJump(jumpIdx)
	if self._actCfg.jumpTo then
		GotoMgr.gotoByString(self._actCfg.jumpTo)
	end
end

function SummerTreasureSnatchMainView:_onClickShowCamp()
	local key = string.format("SummerTreasureSnatchMainView_%s", self._activityId)

	GameUtil.saveUserData(key, self._week)
	GameUtil.SetActive(self._showCamp, false)

	local hasPreset = SummerTreasureSnatchModel.instance:hasPreSetFormation(self._activityId)

	if not hasPreset then
		self:_popFormation()
	end
end

function SummerTreasureSnatchMainView:_onChangePlayRole()
	local skinId = self._curBossCfg.skinId
	local posNScaleArr = self._curBossCfg.posNScale

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	GameUtil.setAnchoredPos(self._con, checknumber(posNScaleArr[1]), checknumber(posNScaleArr[2]))
	GameUtil.setLocalScale(self._con, checknumber(posNScaleArr[3]), checknumber(posNScaleArr[3]), checknumber(posNScaleArr[3]))
end

function SummerTreasureSnatchMainView:_popFormation()
	if self:_checkActivityEnd() then
		return
	end

	if self:_checkWeeklySettlement() then
		return
	end

	local defendFmtMo = SummerTreasureSnatchModel.instance:getDefendFmtMo(self._activityId)

	defendFmtMo:updateCfg(self._activityId)
	UIStateManager.instance:push(ViewName.SummerTreasureSnatchCustomFormationView, defendFmtMo)
end

function SummerTreasureSnatchMainView:_onClickBtnShop()
	UIStateManager.instance:push(ViewName.SummerTreasureSnatchShopView, self._activityId)
end

function SummerTreasureSnatchMainView:_onClickRank()
	if self:_checkActivityEnd() then
		return
	end

	if self:_checkWeeklySettlement() then
		return
	end

	UIStateManager.instance:push(ViewName.SummerTreasureSnatchRankTabFrameView, self._activityId)
end

function SummerTreasureSnatchMainView:_onClickBuyFightBoss()
	UIStateManager.instance:push(ViewName.SummerTreasureSnatchShopView, self._activityId)
end

function SummerTreasureSnatchMainView:_onClickBtnBossShow()
	UIStateManager.instance:push(ViewName.SummerTreasureSnatchBossShowView, self._activityId)
end

function SummerTreasureSnatchMainView:_onClickBtnCoin(coinIdx)
	if coinIdx == 1 then
		local matType, matId, _ = MaterialMgr.getMatParams(self._actCfg.scoreMatStr)

		CommonTipsMgr.instance:openMaterialTips(self._coin1, matType, matId)
	else
		local matType, matId, _ = MaterialMgr.getMatParams(self._actCfg.actShopMatStr)

		CommonTipsMgr.instance:openMaterialTips(self._coin2, matType, matId)
	end
end

return SummerTreasureSnatchMainView
