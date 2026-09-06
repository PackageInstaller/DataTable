-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdMatchHallView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdMatchHallView", package.seeall)

local YouthArenaThirdMatchHallView = class("YouthArenaThirdMatchHallView", ViewComponent)
local TITLE_STATE = {
	[YouthArenaThirdEnum.MatchStepId.Qualifier] = 0,
	[YouthArenaThirdEnum.MatchStepId.ScoreMatch] = 1,
	[YouthArenaThirdEnum.MatchStepId.Fun] = 2
}
local CHALLENGE_CD = 5

function YouthArenaThirdMatchHallView:ctor()
	YouthArenaThirdMatchHallView.super.ctor(self)
end

function YouthArenaThirdMatchHallView:buildUI()
	YouthArenaThirdMatchHallView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/txtTitle/btnTip")
	self._battleMode1 = self:getGo("battleMode1")
	self._battleMode2 = self:getGo("battleMode2")
	self._tagBattleMode1 = self:getGo("battleMode1/tagSelect")
	self._tagBattleMode2 = self:getGo("battleMode2/tagSelect")
	self._txtScheduleTime1 = self:getTxt("infoTop/scheduleTime1/txt")
	self._scheduleTime2Root = self:getGo("infoTop/scheduleTime2")
	self._txtScheduleTime2 = self:getTxt("infoTop/scheduleTime2/txt")
	self._imgTitleChange = self:getGo("imgTitle"):GetComponent("UIImageSpriteChange")
	self._tagModeTips = self:getGo("infoTop/tagModeTips")
	self._btnTog = self:getGo("infoTop/togSwitch/btnTog")
	self._markTog = self:getGo("infoTop/togSwitch/btnTog/mark")
	self._modelCam = self:getGo("modelCam")
	self._myRolePoint = self:getGo("modelCam/rolePoint_1")
	self._enemyRolePoint = self:getGo("modelCam/rolePoint_2")
	self._txtMyName = self:getTxt("myRole/infoCom/txtName")
	self._txtMyPower = self:getTxt("myRole/infoCom/txtPower")
	self._headMyRole = self:getGo("myRole/head")
	self._enemyRoot = self:getGo("enemyRole/root")
	self._txtEnemyName = self:getTxt("enemyRole/root/infoCom/txtName")
	self._txtEnemyPower = self:getTxt("enemyRole/root/infoCom/txtPower")
	self._headEnemyRole = self:getGo("enemyRole/root/head")
	self._prizeTimesRoot = self:getGo("enemyRole/root/times/prizeTimes")
	self._txtPrizeTimes = self:getTxt("enemyRole/root/times/prizeTimes/txt")
	self._enemyMatchTimeRoot = self:getGo("enemyRole/root/times/matchTime")
	self._txtEnemyMatchTime = self:getTxt("enemyRole/root/times/matchTime/txt")
	self._btnFight = self:getGo("enemyRole/root/btnFight")
	self._matchingRoot = self:getGo("enemyRole/matching")
	self._btnMatch = self:getGo("enemyRole/matching/btnMatch")
	self._leftTimesRoot = self:getGo("enemyRole/matching/leftTimes")
	self._txtLeftTimes = self:getTxt("enemyRole/matching/leftTimes/txt")
	self._matchTimeRoot = self:getGo("enemyRole/matching/matchTime")
	self._txtMatchTime = self:getTxt("enemyRole/matching/matchTime/txt")
	self._btnRank = self:getGo("btnJumps/btnRank")
	self._btnDefense = self:getGo("btnJumps/btnFmt")
	self._btnReport = self:getGo("btnJumps/btnReport")
	self._btnBuff = self:getGo("btnJumps/btnBuff")
	self._btnScoreRule = self:getGo("btnJumps/btnScoreRule")
	self._playerInfo1Root = self:getGo("playerInfo1")
	self._txtMyRank1 = self:getTxt("playerInfo1/txtMyRank")
	self._txtMyScore1 = self:getTxt("playerInfo1/txtMyScore")
	self._itemWinPrize1 = self:getGo("playerInfo1/item1")
	self._itemFailPrize1 = self:getGo("playerInfo1/item2")
	self._txtZoneName1 = self:getTxt("playerInfo1/txtZoneName")
	self._playerInfo2Root = self:getGo("playerInfo2")
	self._txtMyRank2 = self:getTxt("playerInfo2/txtMyRank")
	self._txtMyScore2 = self:getTxt("playerInfo2/txtMyScore")
	self._txtZoneName2 = self:getTxt("playerInfo2/txtZoneName")
	self._playerInfo2HeadRoot = self:getGo("playerInfo2/headRoot")
	self._playerInfo3Root = self:getGo("playerInfo3")
	self._itemWinPrize3 = self:getGo("playerInfo3/item1")
	self._itemFailPrize3 = self:getGo("playerInfo3/item2")
end

function YouthArenaThirdMatchHallView:bindEvents()
	YouthArenaThirdMatchHallView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnTog, self._onClickSystemAttr, self)
	GameUtil.addClickHandler(self._btnMatch, self._onClickBtnMatch, self)
	GameUtil.addClickHandler(self._btnFight, self._onClickBtnFight, self)
	GameUtil.addClickHandler(self._btnDefense, self._onClickBtnDefense, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnReport, self._onClickBtnReport, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
	GameUtil.addClickHandler(self._btnScoreRule, self._onClickBtnScoreRule, self)
	GameUtil.addClickHandler(self._battleMode1, GameUtil.handler(self._onClickBattleMode, self, YouthArenaThirdEnum.BattleMode.One))
	GameUtil.addClickHandler(self._battleMode2, GameUtil.handler(self._onClickBattleMode, self, YouthArenaThirdEnum.BattleMode.Three))
end

function YouthArenaThirdMatchHallView:unbindEvents()
	YouthArenaThirdMatchHallView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTog)
	GameUtil.rmClickHandler(self._btnMatch)
	GameUtil.rmClickHandler(self._btnFight)
	GameUtil.rmClickHandler(self._btnDefense)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnReport)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnScoreRule)
	GameUtil.rmClickHandler(self._battleMode1)
	GameUtil.rmClickHandler(self._battleMode2)
end

function YouthArenaThirdMatchHallView:onEnter()
	YouthArenaThirdMatchHallView.super.onEnter(self)
	self:_setAvatarCameraEnv(true)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetQualifierInfoRes, self._handleQualifierInfo, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3QualifierGetNewOpponentRes, self._handleGetNewOpponent, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3NotifyStepChangeRes, self._handleStepChange, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._stepId = checknumber(params[2])
	self._mode = checknumber(params[3])

	if self._mode <= 0 then
		self._mode = YouthArenaThirdEnum.BattleMode.One
	end

	self._autoMatchRequested = false
	self._dailyScoreTipShown = false
	self._actData = YouthArenaThirdConfig.instance:getActivityData(self._activityId)
	self._matchCfg = YouthArenaThirdConfig.instance:getMatchData(self._activityId, self._stepId)
	self._isFun = self._stepId == YouthArenaThirdEnum.MatchStepId.Fun
	self._isScoreMatch = self._stepId == YouthArenaThirdEnum.MatchStepId.ScoreMatch

	if self._isScoreMatch then
		self._txtMyRank = self._txtMyRank2 or self._txtMyRank1
	end

	if self._isScoreMatch then
		self._txtMyScore = self._txtMyScore2 or self._txtMyScore1
	end

	if self._isScoreMatch then
		self._txtZoneName = self._txtZoneName2 or self._txtZoneName1
	end

	self:_refreshStaticInfo()
	self:_refreshPlayerInfo()
	self:_refreshProtocolInfo()
	self:_tryShowDailyScoreTip()
	self:_sendQualifierInfoReq()
	settimer(1, self._refreshChallengeButtonState, self, true)
end

function YouthArenaThirdMatchHallView:onExit()
	YouthArenaThirdMatchHallView.super.onExit(self)
	removetimer(self._refreshChallengeButtonState, self)
	self:_setAvatarCameraEnv(false)
	HeadItemController.instance:resetHeadCell(self._headMyRole)
	HeadItemController.instance:resetHeadCell(self._headEnemyRole)
	HeadItemController.instance:resetHeadCell(self._playerInfo2HeadRoot)
	self:_clearMyRole()
	self:_clearEnemyRole()
end

function YouthArenaThirdMatchHallView:_setAvatarCameraEnv(isOnEnter)
	if isOnEnter then
		goutil.addChildToParent(self._modelCam)
		LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	else
		goutil.addChildToParent(self._modelCam, self.mainGO)
		LightMgr.instance:setLightForNormalScene()
	end

	GlobalModel.instance:visibleSceneHUDs(not isOnEnter)
end

function YouthArenaThirdMatchHallView:_refreshStaticInfo()
	self:_refreshBattleMode()
	goutil.setActive(self._btnRank, not self._isFun)
	goutil.setActive(self._btnScoreRule, not self._isFun)
	goutil.setActive(self._btnBuff, checknumber(self._matchCfg and self._matchCfg.buffPlanId) > 0)
	self:_refreshScheduleTime()

	local openHours = self:_formatOpenHours()
	local isShowOpenTime = not string.nilorempty(openHours)

	if isShowOpenTime then
		local openTimeText = string.format("开放时间：%s", openHours)

		self._txtEnemyMatchTime.text = openTimeText
		self._txtMatchTime.text = openTimeText
	end

	if self._imgTitleChange then
		self._imgTitleChange:SetState(TITLE_STATE[self._stepId] or 0)
	end

	goutil.setActive(self._tagModeTips, self._isFun)
	goutil.setActive(self._enemyMatchTimeRoot, isShowOpenTime)
	goutil.setActive(self._matchTimeRoot, isShowOpenTime)
	goutil.setActive(self._playerInfo1Root, not self._isScoreMatch and not self._isFun)
	goutil.setActive(self._playerInfo2Root, self._isScoreMatch)
	goutil.setActive(self._playerInfo3Root, self._isFun)
	self:_refreshPrizeItem()
end

function YouthArenaThirdMatchHallView:_refreshBattleMode()
	goutil.setActive(self._tagBattleMode1, self._mode == YouthArenaThirdEnum.BattleMode.One)
	goutil.setActive(self._tagBattleMode2, self._mode == YouthArenaThirdEnum.BattleMode.Three)
end

function YouthArenaThirdMatchHallView:_refreshPlayerInfo()
	HeadItemController.instance:setMyHeadCell(self._headMyRole)

	self._txtMyName.text = string.format("s%03d-%s", RoleModel.instance:getAreaId(), RoleModel.instance:getUserName())
	self._txtMyPower.text = tostring(RoleModel.instance:getMaxPower())

	if not self._isFun then
		self._txtZoneName.text = YouthArenaThirdController.instance:getCurZoneName(self._activityId)
	end

	if self._isScoreMatch then
		HeadItemController.instance:setHeadCellByInfo(self._playerInfo2HeadRoot, RoleModel.instance:getHeadInfo())
	end

	self:_updateMyRole()
end

function YouthArenaThirdMatchHallView:_refreshProtocolInfo()
	local subMo = YouthArenaThirdController.instance:getSubMo(self._activityId)
	local qualifierInfo = subMo:getQualifierInfo(self._stepId, self._mode)

	if qualifierInfo then
		if not qualifierInfo.rankScore then
			local rankScore = 0

			if qualifierInfo then
				if not qualifierInfo.rank then
					local rank = 0

					if qualifierInfo then
						if not qualifierInfo.dailyFightTimes then
							local dailyFightTimes = 0

							if self._actData then
								if not self._actData.dailyMatchPrizeTimes then
									local dailyMatchPrizeTimes = 0
									local leftTimes = math.max(dailyMatchPrizeTimes - checknumber(dailyFightTimes), 0)

									if not self._isFun then
										self._txtMyRank.text = string.format("我的排名：%s", self:_formatRank(rank))
										self._txtMyScore.text = string.format("我的积分：%s", rankScore)
									end

									self._txtLeftTimes.text = string.format("今日剩余奖励次数：%s", leftTimes)
									self._txtPrizeTimes.text = string.format("今日剩余奖励次数：%s", leftTimes)

									self:_refreshSystemAttrState()
									self:_refreshOpponentInfo(qualifierInfo and qualifierInfo.opponent)
									self:_refreshChallengeButtonState()
								end
							end
						end
					end
				end
			end
		end
	end
end

function YouthArenaThirdMatchHallView:_refreshSystemAttrState()
	local isUse = YouthArenaThirdController.instance:getUseSystemProperty(self._activityId, self._stepId)

	goutil.setActive(self._markTog, isUse)
end

function YouthArenaThirdMatchHallView:_handleGetNewOpponent(activityId, stepId, mode)
	if not self:_isCurrentMatchParam(activityId, stepId, mode) then
		return
	end

	self._challengeCdEndTime = ServerTime.now() + CHALLENGE_CD

	self:_refreshProtocolInfo()
	FloatWordMgr.instance:show("匹配成功")
end

function YouthArenaThirdMatchHallView:_handleStepChange()
	FloatWordMgr.instance:show("赛事阶段已变化")
	self:close()
end

function YouthArenaThirdMatchHallView:_sendQualifierInfoReq()
	if checknumber(self._activityId) <= 0 or checknumber(self._stepId) <= 0 or checknumber(self._mode) <= 0 then
		return
	end

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3GetQualifierInfoReq(self._activityId, self._stepId, self._mode)
end

function YouthArenaThirdMatchHallView:_updateMyRole()
	local curCardInfo = RoleModel.instance.myCardInfo

	if not curCardInfo then
		if self._isReqingMyRoleInfo then
			return
		end

		self._isReqingMyRoleInfo = true

		PlayerAgent.instance:sendGetMyDisplayCardInfoReq(function(msg)
			self._isReqingMyRoleInfo = false

			RoleModel.instance:setMyCardInfo(msg)

			if self:isOpen() then
				self:_updateMyRole()
			end
		end, nil, function()
			self._isReqingMyRoleInfo = false
		end)

		return
	end

	local skId = DressModel.instance:getSkeIdByGender(RoleModel.instance:getGender())
	local mo = DressModel.instance:getAvatarPlayerMo(skId, (not curCardInfo.clothes or nil) and {}, 0)

	if not self._avatarMy then
		self._avatarMy = AvatarsMgrNew.instance:getAvatarByMo(mo)
		self._avatarMy.useType = AvatarUseType.Scene

		self._avatarMy:setParent(self._myRolePoint.transform)
		self._avatarMy:setLayer(Framework.LayerUtil.NameToLayer(SceneLayer.UI3D))
	end

	self._avatarMy:updateByMo(mo)
	self._avatarMy:setVisible(true)
end

function YouthArenaThirdMatchHallView:_clearMyRole()
	if self._avatarMy then
		AvatarsMgrNew.instance:removeAvatar(self._avatarMy)

		self._avatarMy = nil
	end
end

function YouthArenaThirdMatchHallView:_refreshOpponentInfo(opponent)
	local hasOpponent = not not (opponent and opponent.headInfo)

	goutil.setActive(self._enemyRoot, hasOpponent)
	goutil.setActive(self._matchingRoot, not hasOpponent)
	goutil.setActive(self._leftTimesRoot, not hasOpponent and self:_isShowPrizeTimes())
	goutil.setActive(self._prizeTimesRoot, hasOpponent and self:_isShowPrizeTimes())

	if not hasOpponent then
		HeadItemController.instance:resetHeadCell(self._headEnemyRole)
		self:_clearEnemyRole()

		return
	end

	local headInfo = opponent.headInfo
	local enemyUserId = checknumber(headInfo.userId)

	if self._avatarEnemy and self._enemyUserId ~= enemyUserId then
		self:_clearEnemyRole()
	end

	HeadItemController.instance:resetHeadCell(self._headEnemyRole)
	HeadItemController.instance:setHeadCellByInfo(self._headEnemyRole, headInfo, true)

	self._txtEnemyName.text = string.format("s%03d-%s", checknumber(headInfo.areaId), headInfo.userName or "")
	self._txtEnemyPower.text = tostring(checknumber(opponent.opPlayerZdl))
	self._enemyUserId = enemyUserId

	self:_updateEnemyRole(opponent)
end

function YouthArenaThirdMatchHallView:_updateEnemyRole(opponent)
	local skId = DressModel.instance:getSkeIdByGender(opponent.gender)
	local mo = DressModel.instance:getAvatarPlayerMo(skId, (not opponent.clothes or nil) and {}, 0)

	if not self._avatarEnemy then
		self._avatarEnemy = AvatarsMgrNew.instance:getAvatarByMo(mo)
		self._avatarEnemy.useType = AvatarUseType.Scene

		self._avatarEnemy:setParent(self._enemyRolePoint.transform)
		self._avatarEnemy:setLayer(Framework.LayerUtil.NameToLayer(SceneLayer.UI3D))
	end

	self._avatarEnemy:updateByMo(mo)
	self._avatarEnemy:setVisible(true)
end

function YouthArenaThirdMatchHallView:_clearEnemyRole()
	if self._avatarEnemy then
		AvatarsMgrNew.instance:removeAvatar(self._avatarEnemy)

		self._avatarEnemy = nil
	end

	self._enemyUserId = nil
end

function YouthArenaThirdMatchHallView:_refreshPrizeItem()
	MaterialMgr.resetAll(self._itemWinPrize1)
	MaterialMgr.resetAll(self._itemFailPrize1)
	MaterialMgr.resetAll(self._itemWinPrize3)
	MaterialMgr.resetAll(self._itemFailPrize3)

	if self._isScoreMatch then
		return
	end

	if self._isFun then
		if not self._itemWinPrize3 then
			local itemWinPrize = self._itemWinPrize1

			if self._isFun then
				if not self._itemFailPrize3 then
					local itemFailPrize = self._itemFailPrize1

					self:_setPrizeItem(itemWinPrize, self._matchCfg and self._matchCfg.winPrize)
					self:_setPrizeItem(itemFailPrize, self._matchCfg and self._matchCfg.failPrize)
				end
			end
		end
	end
end

function YouthArenaThirdMatchHallView:_handleQualifierInfo(activityId, stepId, mode)
	if checknumber(activityId) ~= self._activityId or checknumber(stepId) ~= self._stepId then
		return
	end

	self:_tryShowDailyScoreTip()

	if checknumber(mode) ~= self._mode then
		return
	end

	self:_refreshProtocolInfo()
	self:_tryAutoMatch()
end

function YouthArenaThirdMatchHallView:_tryShowDailyScoreTip()
	if not self._isScoreMatch then
		return
	end

	local subMo = YouthArenaThirdController.instance:getSubMo(self._activityId)
	local shouldShow = subMo and subMo:consumeDailyScoreTip(self._stepId)

	if not shouldShow or self._dailyScoreTipShown then
		return
	end

	self._dailyScoreTipShown = true

	local dailyGainScore = checknumber(self._matchCfg and self._matchCfg.dailyGainScore)
	local content = string.format("今日%s积分已发放，请查收！", dailyGainScore)

	TipsFacade.instance:openTipWindowNoX("提示", content)
end

function YouthArenaThirdMatchHallView:_isCurrentMatchParam(activityId, stepId, mode)
	return checknumber(activityId) == self._activityId and checknumber(stepId) == self._stepId and checknumber(mode) == self._mode
end

function YouthArenaThirdMatchHallView:_tryAutoMatch()
	if self._autoMatchRequested or not self:_isAutoMatchAllowed() then
		return
	end

	local subMo = YouthArenaThirdController.instance:getSubMo(self._activityId)
	local qualifierInfo = subMo and subMo:getQualifierInfo(self._stepId, self._mode)

	if not qualifierInfo or qualifierInfo.opponent then
		return
	end

	self._autoMatchRequested = true

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3QualifierGetNewOpponentReq(self._activityId, self._stepId, self._mode)
end

function YouthArenaThirdMatchHallView:_isAutoMatchAllowed()
	if checknumber(self._activityId) <= 0 or not self._matchCfg then
		return false
	end

	if self._mode ~= YouthArenaThirdEnum.BattleMode.One and self._mode ~= YouthArenaThirdEnum.BattleMode.Three then
		return false
	end

	if not self:_isCurrentMatchStageOpen() or not self:_isPlayerQualified() then
		return false
	end

	if not YouthArenaThirdController.instance:checkMatchFightAvailable(self._activityId, self._stepId, false) then
		return false
	end

	return YouthArenaThirdController.instance:checkMatchDailyTimeAvailable(self._activityId, self._stepId, false)
end

function YouthArenaThirdMatchHallView:_isCurrentMatchStageOpen()
	local startStepId, endStepId

	if self._stepId == YouthArenaThirdEnum.MatchStepId.Qualifier then
		startStepId = YouthArenaThirdEnum.TimeStepId.QualifierStart
		endStepId = YouthArenaThirdEnum.TimeStepId.ScoreMatchStart
	elseif self._stepId == YouthArenaThirdEnum.MatchStepId.ScoreMatch then
		startStepId = YouthArenaThirdEnum.TimeStepId.ScoreMatchStart
		endStepId = YouthArenaThirdEnum.TimeStepId.KnockoutStart
	elseif self._stepId == YouthArenaThirdEnum.MatchStepId.Fun then
		startStepId = YouthArenaThirdEnum.TimeStepId.ScoreMatchStart
	else
		return false
	end

	local startCfg = YouthArenaThirdConfig.instance:getStepData(self._activityId, startStepId)
	local startStamp = startCfg and GameUtil.string2time(startCfg.startTime) or 0
	local now = ServerTime.now()

	if startStamp <= 0 or now < startStamp then
		return false
	end

	if checknumber(endStepId) > 0 then
		local endCfg = YouthArenaThirdConfig.instance:getStepData(self._activityId, endStepId)
		local endStamp = endCfg and GameUtil.string2time(endCfg.startTime) or 0

		return endStamp > 0 and now < endStamp
	end

	local activityEndTime = self:_getActivityEndTime()

	if string.nilorempty(activityEndTime) then
		return false
	end

	local activityEndStamp = GameUtil.string2time(activityEndTime)

	return activityEndStamp > 0 and now < activityEndStamp
end

function YouthArenaThirdMatchHallView:_isPlayerQualified()
	if self._stepId ~= YouthArenaThirdEnum.MatchStepId.ScoreMatch then
		return true
	end

	local roundTypeMap = {
		[YouthArenaThirdEnum.RoundType.ScoreMatch] = true
	}
	local firstStepId = YouthArenaThirdController.instance:getFirstStepIdByRoundTypeMap(self._activityId, roundTypeMap)
	local firstStepCfg = YouthArenaThirdConfig.instance:getStepData(self._activityId, firstStepId)
	local minRoundId = checknumber(firstStepCfg and firstStepCfg.roundId)
	local subMo = YouthArenaThirdController.instance:getSubMo(self._activityId)
	local playerRoundId = checknumber(subMo and subMo:getPlayerRoundId())

	return minRoundId > 0 and minRoundId <= playerRoundId
end

function YouthArenaThirdMatchHallView:_refreshChallengeButtonState()
	local canMatch = YouthArenaThirdController.instance:checkMatchFightAvailable(self._activityId, self._stepId, false) and YouthArenaThirdController.instance:checkMatchDailyTimeAvailable(self._activityId, self._stepId, false)
	local canFight = canMatch and ServerTime.now() >= checknumber(self._challengeCdEndTime) and YouthArenaThirdController.instance:checkScoreMatchChallengeAvailable(self._activityId, self._stepId, self._mode, false)

	GameUtil.SetGray(self._btnMatch, not canMatch)
	GameUtil.SetGray(self._btnFight, not canFight)
end

function YouthArenaThirdMatchHallView:_setPrizeItem(item, cfgStr)
	MaterialMgr.resetAll(item)

	if string.nilorempty(cfgStr) then
		return
	end

	MaterialMgr.setCellByCfg(cfgStr, item)
end

function YouthArenaThirdMatchHallView:_isShowPrizeTimes()
	return self._stepId ~= YouthArenaThirdEnum.MatchStepId.ScoreMatch
end

function YouthArenaThirdMatchHallView:_refreshScheduleTime()
	local isScoreMatch = self._stepId == YouthArenaThirdEnum.MatchStepId.ScoreMatch

	if isScoreMatch then
		self._txtScheduleTime1.text = self:_formatScheduleTime("积分赛", YouthArenaThirdEnum.TimeStepId.ScoreMatchStart, YouthArenaThirdEnum.TimeStepId.KnockoutStart)
	else
		self._txtScheduleTime1.text = self:_formatScheduleTime("预选赛", YouthArenaThirdEnum.TimeStepId.QualifierStart, YouthArenaThirdEnum.TimeStepId.ScoreMatchStart)
		self._txtScheduleTime2.text = self:_formatScheduleTime("娱乐赛", YouthArenaThirdEnum.TimeStepId.ScoreMatchStart, nil)
	end

	goutil.setActive(self._scheduleTime2Root, not isScoreMatch)
end

function YouthArenaThirdMatchHallView:_formatScheduleTime(name, startStepId, endStepId)
	local startCfg = YouthArenaThirdConfig.instance:getStepData(self._activityId, startStepId)
	local endCfg = checknumber(endStepId) > 0 and YouthArenaThirdConfig.instance:getStepData(self._activityId, endStepId) or nil

	if endCfg then
		if not endCfg.startTime then
			local endTime = self:_getActivityEndTime()

			return string.format("%s：%s - %s", name, self:_formatTimeStr(startCfg and startCfg.startTime), self:_formatTimeStr(endTime))
		end
	end
end

function YouthArenaThirdMatchHallView:_getActivityEndTime()
	local actDefineCfg = ActivityDefineConfig.instance:getCfgByActivitYId(self._activityId)

	return actDefineCfg and actDefineCfg.endTime
end

function YouthArenaThirdMatchHallView:_formatOpenHours()
	if self._matchCfg then
		if not self._matchCfg.closedTimeRange then
			local closedTimeRange = ""

			if string.nilorempty(closedTimeRange) then
				return nil
			end

			local arr = string.split(closedTimeRange, "-")
			local closeStart = arr[1]
			local closeEnd = arr[2]

			if string.nilorempty(closeStart) or string.nilorempty(closeEnd) then
				return nil
			end

			local prefix = self:_getSecondInDay(closeStart) <= self:_getSecondInDay(closeEnd) and "次日" or ""

			return string.format("%s-%s%s", self:_formatHourMinute(closeEnd), prefix, self:_formatHourMinute(closeStart))
		end
	end
end

function YouthArenaThirdMatchHallView:_formatTimeStr(timeStr)
	if string.nilorempty(timeStr) then
		return ""
	end

	local date = GameUtil.time2date(GameUtil.string2time(timeStr))

	return string.format("%02d.%02d %02d:%02d", date.month, date.day, date.hour, date.min)
end

function YouthArenaThirdMatchHallView:_formatHourMinute(timeStr)
	local arr = string.split(timeStr, ":")

	return string.format("%02d:%02d", checknumber(arr[1]), checknumber(arr[2]))
end

function YouthArenaThirdMatchHallView:_getSecondInDay(timeStr)
	local arr = string.split(timeStr, ":")

	return checknumber(arr[1]) * 3600 + checknumber(arr[2]) * 60 + checknumber(arr[3])
end

function YouthArenaThirdMatchHallView:_onClickBattleMode(mode)
	mode = checknumber(mode)

	if mode == self._mode or mode ~= YouthArenaThirdEnum.BattleMode.One and mode ~= YouthArenaThirdEnum.BattleMode.Three then
		return
	end

	self:_clearEnemyRole()

	self._mode = mode
	self._autoMatchRequested = false

	self:_refreshBattleMode()
	self:_refreshProtocolInfo()
	self:_sendQualifierInfoReq()
end

function YouthArenaThirdMatchHallView:_onClickBtnMatch()
	if not YouthArenaThirdController.instance:checkMatchFightAvailable(self._activityId, self._stepId, true) or not YouthArenaThirdController.instance:checkMatchDailyTimeAvailable(self._activityId, self._stepId, true) then
		return
	end

	self._autoMatchRequested = true

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3QualifierGetNewOpponentReq(self._activityId, self._stepId, self._mode)
end

function YouthArenaThirdMatchHallView:_onClickBtnFight()
	if ServerTime.now() < checknumber(self._challengeCdEndTime) then
		return
	end

	YouthArenaThirdController.instance:openMatchAttackFormationView(self._activityId, self._stepId, self._mode)
end

function YouthArenaThirdMatchHallView:_onClickTip()
	if self._actData then
		if string.nilorempty(self._actData) then
			return
		end

		TipsFacade.instance:openRulesView(self._actData)
	end
end

function YouthArenaThirdMatchHallView:_onClickBtnScoreRule()
	local roundData = YouthArenaThirdConfig.instance:getRoundData(self._activityId, self._stepId)
	local roundId = checknumber(roundData and roundData.roundId)

	if roundId <= 0 then
		return
	end

	UIStateManager.instance:push(ViewName.YouthArenaThirdScoreRuleTipsView, self._activityId, roundId, self._mode)
end

function YouthArenaThirdMatchHallView:_onClickSystemAttr()
	local isUse = YouthArenaThirdController.instance:getUseSystemProperty(self._activityId, self._stepId)

	local function setUse(value)
		YouthArenaThirdController.instance:setUseSystemProperty(self._activityId, self._stepId, value)
		self:_refreshSystemAttrState()
	end

	if isUse then
		setUse(false)

		return
	end

	TipsFacade.instance:openPopupWindow("提示", "勾选后，在挑战时，己方全体精灵将使用系统属性", function()
		setUse(true)
	end, nil, "确定", "取消")
end

function YouthArenaThirdMatchHallView:_onClickBtnDefense()
	local subMo = YouthArenaThirdController.instance:getSubMo(self._activityId)
	local stepId = checknumber(subMo and subMo:getCurStepId())

	YouthArenaThirdController.instance:openDefenseFormationView(self._activityId, self._isFun, self._mode, stepId)
end

function YouthArenaThirdMatchHallView:_onClickBtnRank()
	if self._isFun then
		FloatWordMgr.instance:show("娱乐赛无排行榜")

		return
	end

	YouthArenaThirdController.instance:openRankView(self._activityId, self._stepId, YouthArenaThirdEnum.RankType.PlayerScore)
end

function YouthArenaThirdMatchHallView:_onClickBtnReport()
	UIStateManager.instance:push(ViewName.YouthArenaThirdQualifierReportView, self._activityId, self._isFun, self._mode, self._stepId)
end

function YouthArenaThirdMatchHallView:_onClickBtnBuff()
	if self._matchCfg then
		if checknumber(self._matchCfg) <= 0 then
			return
		end

		UIStateManager.instance:push(ViewName.YouthArenaThirdBuffView, self._matchCfg)
	end
end

function YouthArenaThirdMatchHallView:_formatRank(rank)
	if self._isFun then
		return "无"
	end

	rank = checknumber(rank)

	return rank > 0 and tostring(rank) or "未上榜"
end

return YouthArenaThirdMatchHallView
