-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestQualifierView.lua

module("logic.extensions.martialcontest.view.MartialContestQualifierView", package.seeall)

local MartialContestQualifierView = class("MartialContestQualifierView", ViewComponent)

function MartialContestQualifierView:ctor()
	MartialContestQualifierView.super.ctor(self)
end

function MartialContestQualifierView:unbindEvents()
	MartialContestQualifierView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnForm)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnFight)
	GameUtil.rmClickHandler(self._btnMatch)
	GameUtil.rmClickHandler(self._btnEquip)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnReport)
	GameUtil.rmClickHandler(self._btnRoleInfo)
end

function MartialContestQualifierView:bindEvents()
	MartialContestQualifierView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnForm, self._onClickBtnForm, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnEquip, self._onClickBtnEquip, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickBtnPrize, self)
	GameUtil.addClickHandler(self._btnReport, self._onClickBtnReport, self)
	GameUtil.addClickHandler(self._btnRoleInfo, self._onClickEnemyInfo, self)
	GameUtil.addClickHandler(self._btnFight, self._onClickBtnFight, self)
	GameUtil.addClickHandler(self._btnMatch, self._onClickBtnMatch, self)
end

function MartialContestQualifierView:buildUI()
	MartialContestQualifierView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnForm = self:getGo("leftBottomBtns/btnForm")
	self._btnRank = self:getGo("leftBottomBtns/btnRank")
	self._btnEquip = self:getGo("leftBottomBtns/btnEquip")
	self._btnPrize = self:getGo("leftBottomBtns/btnPrize")
	self._btnReport = self:getGo("leftBottomBtns/btnReport")
	self._redPointEquip = self:getGo("leftBottomBtns/btnEquip/redPoint")
	self._btnFight = self:getGo("enemyRole/btnFight")
	self._btnMatch = self:getGo("match/btnMatch")
	self._combos = self:getGo("combos")
	self._txtCombo = self:getTxt("combos/txtCombo")
	self._score = self:getGo("score")
	self._txtScoreTips = self:getTxt("score/txtScoreTips")
	self._txtScore = self:getTxt("score/txtScore")
	self._modelCam = self:getGo("modelCam")

	local rolePointMy = self:getGo("modelCam/rolePointMy")
	local rolePointEnemy = self:getGo("modelCam/rolePointEnemy")

	self._txtNameShowMyRole = self:getTxt("myRole/infoCom/txtNameShow")
	self._txtPowerMyRole = self:getTxt("myRole/infoCom/txtPower")
	self._headMyRole = self:getGo("myRole/head")
	self._roleShowMy = self:getGo("myRole/role")
	self._avatarMy = nil
	self._avatarMy = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	self._avatarMy:setParent(rolePointMy.transform)
	self._avatarMy:setLayer(SceneLayer.UI3D_Value)

	self._txtLeftTimes = self:getTxt("leftTimes/txt")
	self._txtOpenTime = self:getTxt("txtOpenTime")
	self._tipsFunny = self:getGo("tips")
	self._enemyRole = self:getGo("enemyRole")
	self._txtNameShowEnemyRole = self:getTxt("enemyRole/infoCom/txtNameShow")
	self._txtPowerEnemyRole = self:getTxt("enemyRole/infoCom/txtPower")
	self._headEnemyRole = self:getGo("enemyRole/head")
	self._roleShowEnemy = self:getGo("enemyRole/role")
	self._avatarEnemy = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	self._avatarEnemy:setParent(rolePointEnemy.transform)
	self._avatarEnemy:setLayer(SceneLayer.UI3D_Value)

	self._btnRoleInfo = self:getGo("enemyRole/role/btnRoleInfo")
	self._tipFight = self:getGo("enemyRole/tip")
	self._scorePart = self:getGo("scorePart")
	self._txtZoneName = self:getTxt("scorePart/txtZoneName")
	self._txtMyRank = self:getTxt("scorePart/txtMyRank")
	self._txtMyScore = self:getTxt("scorePart/txtMyScore")
	self._match = self:getGo("match")
	self._imgTitleChange = self:getGo("imgTitle"):GetComponent("UIImageSpriteChange")
	self._winPrize1 = self:getGo("scorePart/winPrize")
	self._failPrize1 = self:getGo("scorePart/failPrize")
	self._prizePart = self:getGo("prizePart")
	self._winPrize2 = self:getGo("prizePart/winPrize")
	self._failPrize2 = self:getGo("prizePart/failPrize")
end

function MartialContestQualifierView:onExit()
	MartialContestQualifierView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._headMyRole)
	HeadItemController.instance:resetHeadCell(self._headEnemyRole)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self.close, self)
	LightMgr.instance:setLightForNormalScene()
	goutil.addChildToParent(self._modelCam, self.mainGO)
	GlobalModel.instance:visibleSceneHUDs(true)
end

function MartialContestQualifierView:destroyUI()
	TCKQualifyView.super.destroyUI(self)

	if self._avatarMy then
		AvatarsMgrNew.instance:removeAvatar(self._avatarMy)

		self._avatarMy = nil
	end

	if self._avatarEnemy then
		AvatarsMgrNew.instance:removeAvatar(self._avatarEnemy)

		self._avatarEnemy = nil
	end
end

function MartialContestQualifierView:onEnter()
	MartialContestQualifierView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MCGetInfoRes, self._PM_MCGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.MCFinalsGetFormationRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.MCGetDefenseForamtionRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_MCQualifierGetNewOpponentRes, self._updateOpponentPart, self)
	self.addGEvent(self, GlobalNotify.MCQualifierRankInfoRes, self._onMCQualifierRankInfoRes, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.close, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._enterStepId = checknumber(params[2])

	self:_initView()
	self:_dealEntertainmentPart()
	MartialContestAgent.instance:sendPM_MCGetQualifierInfoReq(self._activityId, self._enterStepId)

	if self._enterStepId == MartialContestEnum.Qualify_Step_Id or self._enterStepId == MartialContestEnum.Entertainment_Step_Id then
		MartialContestAgent.instance:sendPM_MCGetDefenseForamtionReq(self._activityId)
	elseif self._enterStepId == MartialContestEnum.Score_Match_Step_Id then
		MartialContestAgent.instance:sendPM_MCFinalsGetFormationReq(self._activityId)
	end

	if self._enterStepId == MartialContestEnum.Qualify_Step_Id or self._enterStepId == MartialContestEnum.Score_Match_Step_Id then
		local zoneId = MartialContestController.instance:getCurZoneId(self._activityId)

		MartialContestAgent.instance:sendPM_MCQualifierRankInfoReq(self._activityId, zoneId, self._enterStepId)
	end

	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	goutil.addChildToParent(self._modelCam)
	GlobalModel.instance:visibleSceneHUDs(false)
end

function MartialContestQualifierView:onEnterFinished()
	MartialContestQualifierView.super.onEnterFinished(self)

	local curCardInfo = RoleModel.instance.myCardInfo

	if not curCardInfo then
		PlayerAgent.instance:sendGetMyDisplayCardInfoReq(function(msg)
			self._isReqingRoleInfo = false

			RoleModel.instance:setMyCardInfo(msg)
			self:_updateMyRole()
		end, nil, function()
			self._isReqingRoleInfo = false
		end)
	end
end

function MartialContestQualifierView:_initView()
	self._txtZoneName.text = self._enterStepId == MartialContestEnum.Qualify_Step_Id and MartialContestController.instance:getCurZoneName(self._activityId) or lang("全服")

	if self._enterStepId == MartialContestEnum.Qualify_Step_Id or self._enterStepId == MartialContestEnum.Score_Match_Step_Id then
		local baseCfg = MartialContestConfig.instance:getStepCfg(self._activityId, self._enterStepId)
		local startTime = baseCfg.startTime
		local actDefineCfg = ActivityDefineConfig.instance:getCfgByActivitYId(self._activityId)
		local nextStepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, self._enterStepId + 1)
		local startDate = GameUtil.string2date(startTime)
		local endDate = GameUtil.string2date((nextStepCfg or nil) and nextStepCfg.startTime)

		self._txtOpenTime.text = langPara("比赛时间：%02d.%02d %02d:%02d-%02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	else
		local actDefineCfg = ActivityDefineConfig.instance:getCfgByActivitYId(self._activityId)
		local endTime = actDefineCfg.endTime
		local baseCfg = MartialContestConfig.instance:getStepCfg(self._activityId, 2)
		local startTime = baseCfg.startTime
		local startDate = GameUtil.string2date(startTime)
		local endDate = GameUtil.string2date(endTime)

		self._txtOpenTime.text = langPara("比赛时间：%02d.%02d %02d:%02d-%02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end

	if self._enterStepId == MartialContestEnum.Qualify_Step_Id then
		self._imgTitleChange:SetState(0)
	elseif self._enterStepId == MartialContestEnum.Score_Match_Step_Id then
		self._imgTitleChange:SetState(1)
	else
		self._imgTitleChange:SetState(2)
	end

	local qualifierCfg = MartialContestConfig.instance:getQualifierCfg(self._activityId, self._enterStepId)

	self._txtScoreTips.text = qualifierCfg.quaActiveScoreDesc

	local winPrizeArr = string.split(qualifierCfg.winPrize, "#")
	local failPrizeArr = string.split(qualifierCfg.failPrize, "#")

	MaterialMgr.setCellByCfg(winPrizeArr[1], self._winPrize1)
	MaterialMgr.setCellByCfg(failPrizeArr[1], self._failPrize1)
	MaterialMgr.setCellByCfg(winPrizeArr[1], self._winPrize2)
	MaterialMgr.setCellByCfg(failPrizeArr[1], self._failPrize2)
end

function MartialContestQualifierView:_dealEntertainmentPart()
	local isEntertainment = self._enterStepId == MartialContestEnum.Entertainment_Step_Id

	if not isEntertainment then
		local zoneId = MartialContestController.instance:getCurZoneId()
	end

	goutil.setActive(self._scorePart, not isEntertainment)
	goutil.setActive(self._tipsFunny, isEntertainment)
	GameUtil.SetActive(self._btnRank, not isEntertainment)
	GameUtil.SetActive(self._btnPrize, not isEntertainment)
	GameUtil.SetActive(self._score, not isEntertainment)
	GameUtil.SetActive(self._prizePart, isEntertainment)
end

function MartialContestQualifierView:_updateMyRole()
	local curCardInfo = RoleModel.instance.myCardInfo

	if not curCardInfo then
		return
	end

	local skId = DressModel.instance:getSkeIdByGender(RoleModel.instance:getGender())
	local mo = DressModel.instance:getAvatarPlayerMo(skId, (not curCardInfo.clothes or nil) and {}, 0)

	if self._avatarMy then
		self._avatarMy:updateByMo(mo)
	else
		self._avatarMy = AvatarsMgrNew.instance:getAvatarByMo(mo)
		self._avatarMy.useType = AvatarUseType.Scene

		GameUtil.SetActive(self._roleShowMy, false)
	end
end

function MartialContestQualifierView:_refreshView()
	local curStepId = MartialContestModel.instance:getCurStepId(self._activityId)
	local qualifyInfo = MartialContestModel.instance:getQualifierInfo(self._activityId, self._enterStepId)

	qualifyInfo = qualifyInfo and GameUtil.pbToTable(qualifyInfo) or {}
	self._txtMyScore.text = langPara("<color=#b1dbfc>我的积分：</color>%s", qualifyInfo.rankScore)

	self:_updateOpponentPart()
	HeadItemController.instance:setMyHeadCell(self._headMyRole)

	self._txtNameShowMyRole.text = string.format("s%03d-%s", RoleModel.instance:getAreaId(), RoleModel.instance:getUserName())
	self._txtPowerMyRole.text = RoleModel.instance:getMaxPower()

	self:_updateMyRole()

	self._txtCombo.text = math.max(checknumber(qualifyInfo.winStreak), 0)

	local leftTimes = MartialContestController.instance:getCurLeftQualifierChanllegeTimes(self._activityId, self._enterStepId)

	self._txtLeftTimes.text = langPara("今日剩余奖励次数：%d", leftTimes)

	goutil.setActive(self._tipFight, false)
	goutil.setActive(self._btnFight, true)

	local qualifierCfg = MartialContestConfig.instance:getQualifierCfg(self._activityId, self._enterStepId)
	local rankScoreCfgs = MartialContestConfig.instance:getQualifierRankScoreCfg(qualifierCfg.rankScorePlanId)
	local rankScore = 0

	for i, v in ipairs(rankScoreCfgs) do
		if qualifyInfo.winStreak >= v.winStreak then
			rankScore = v.addRankScore
		end
	end

	self._txtScore.text = langPara("%d", rankScore)

	GameUtil.SetActive(self._redPointEquip, MartialContestController.instance:isCanUpgradeEquip(self._activityId))
end

function MartialContestQualifierView:_updateRankPart()
	local zoneId = YoungChampionKingController.instance:getCurZoneId()
	local rankInfo = YoungChampionKingModel.instance:getQualifierRankInfo(self._activityId, self._enterStepId, zoneId)

	self._txtMyRank.text = langPara("<color=#b1dbfc>我的排名：</color>%s", (rankInfo.myRank > 0 or nil) and (rankInfo.myRank or "未上榜"))
end

function MartialContestQualifierView:_updateOpponentPart()
	local qualifyInfo = MartialContestModel.instance:getQualifierInfo(self._activityId, self._enterStepId)

	qualifyInfo = qualifyInfo and GameUtil.pbToTable(qualifyInfo)

	local opponent = qualifyInfo and qualifyInfo.opponent

	if opponent then
		goutil.setActive(self._enemyRole, true)
		goutil.setActive(self._match, false)
		HeadItemController.instance:resetHeadCell(self._headEnemyRole)
		HeadItemController.instance:setHeadCellByInfo(self._headEnemyRole, opponent.headInfo, true)

		self._txtNameShowEnemyRole.text = string.format("s%03d-%s", opponent.areaId, opponent.headInfo.userName)
		self._txtPowerEnemyRole.text = opponent.everMaxZdl

		local skId = DressModel.instance:getSkeIdByGender(opponent.gender)
		local mo = DressModel.instance:getAvatarPlayerMo(skId, (not opponent.clothes or nil) and {}, 0)

		if self._avatarEnemy then
			self._avatarEnemy:updateByMo(mo)
		else
			self._avatarEnemy = AvatarsMgrNew.instance:getAvatarByMo(mo)
			self._avatarEnemy.useType = AvatarUseType.Scene

			GameUtil.SetActive(self._roleShowEnemy, false)
		end
	else
		goutil.setActive(self._match, true)
		goutil.setActive(self._enemyRole, false)
	end
end

function MartialContestQualifierView:_isEmptyDefenceFormation()
	local isEmpty = true

	if self._enterStepId == MartialContestEnum.Qualify_Step_Id or self._enterStepId == MartialContestEnum.Entertainment_Step_Id then
		local formationInfo = MartialContestModel.instance:getDefenseForamtion(self._activityId)
		local curForm = formationInfo and formationInfo.simpleForm.simpleForm

		if curForm then
			for i, v in ipairs(curForm.pos) do
				if v > 0 then
					isEmpty = false

					break
				end
			end
		end
	elseif self._enterStepId == MartialContestEnum.Score_Match_Step_Id then
		local formationInfo = MartialContestModel.instance:getFinalFormation(self._activityId)

		if formationInfo.forms then
			for i, v in ipairs(formationInfo.forms) do
				local curForm = v.simpleForm

				if curForm then
					for j, id in ipairs(curForm.pos) do
						if id > 0 then
							isEmpty = false

							break
						end
					end
				end
			end
		end
	end

	return isEmpty
end

function MartialContestQualifierView:_onClickBtnForm()
	if self._enterStepId == MartialContestEnum.Qualify_Step_Id or self._enterStepId == MartialContestEnum.Entertainment_Step_Id then
		local fmtMo = MartialContestModel.instance:getQualifierDefenseFmtMo()

		fmtMo:initParams(self._activityId, self._enterStepId, self.roundId)
		CustomFmtController.instance:showMissionFormationView(fmtMo)
	elseif self._enterStepId == MartialContestEnum.Score_Match_Step_Id then
		local fmtMo = MartialContestModel.instance:getScoreDefenseFmtMo()

		fmtMo:initParams(self._activityId, self._enterStepId, self.roundId)
		CustomFmtController.instance:showMissionFormationView(fmtMo)
	end
end

function MartialContestQualifierView:_onClickBtnRank()
	if self._enterStepId == MartialContestEnum.Qualify_Step_Id then
		UIStateManager.instance:push(ViewName.MartialcontestfinalrankView, self._activityId, 2)
	else
		UIStateManager.instance:push(ViewName.MartialcontestfinalrankView, self._activityId, 6)
	end
end

function MartialContestQualifierView:_onClickBtnReport()
	if self._enterStepId == MartialContestEnum.Qualify_Step_Id or self._enterStepId == MartialContestEnum.Entertainment_Step_Id then
		UIStateManager.instance:push(ViewName.MartialContestQualifyReportView, self._activityId, self._enterStepId)
	elseif self._enterStepId == MartialContestEnum.Score_Match_Step_Id then
		UIStateManager.instance:push(ViewName.MartialContestScoreReportView, self._activityId, self._enterStepId)
	end
end

function MartialContestQualifierView:_onClickBtnPrize()
	UIStateManager.instance:push(ViewName.MartialContestRewardView, self._activityId, self._enterStepId)
end

function MartialContestQualifierView:_onClickBtnEquip()
	UIStateManager.instance:push(ViewName.MartialContestEquipView, self._activityId)
end

function MartialContestQualifierView:_onClickBtnFight()
	local isEmpty = self:_isEmptyDefenceFormation()

	if isEmpty then
		FloatWordMgr.instance:show("请先布置守阵")

		return
	end

	local canFight, resultCode, tips = MartialContestController.instance:getIsAbleEnterQualifyFight(self._activityId, self._enterStepId)

	if resultCode < 0 then
		TipsFacade.instance:openCommonTips(tips)

		return
	end

	local leftTimes = MartialContestController.instance:getCurLeftQualifierChanllegeTimes(self._activityId, self._enterStepId)

	if leftTimes <= 0 then
		local key = string.format("%s_%s", self._viewPresentor.viewName, self._activityId)

		TipsFacade.instance:openPopupWindowWithTogByDayKey(lang("tip"), lang("今日奖励次数已用完，继续挑战将不再获得奖励，连胜场数会继续统计"), function()
			self:_enterFigint()
		end, function()
			return
		end, key)
	else
		self:_enterFigint()
	end
end

function MartialContestQualifierView:_enterFigint()
	if self._enterStepId == MartialContestEnum.Qualify_Step_Id or self._enterStepId == MartialContestEnum.Entertainment_Step_Id then
		local fmtMo = MartialContestModel.instance:getQualifierFmtMo()

		fmtMo:initParams(self._activityId, self._enterStepId)
		CustomFmtController.instance:showMissionView(fmtMo)
	elseif self._enterStepId == MartialContestEnum.Score_Match_Step_Id then
		local fmtMo = MartialContestModel.instance:getScoreFmtMo()

		fmtMo:initParams(self._activityId, self._enterStepId)
		CustomFmtController.instance:showMissionView(fmtMo)
	end
end

function MartialContestQualifierView:_onClickBtnMatch()
	local isEmpty = self:_isEmptyDefenceFormation()

	if isEmpty then
		FloatWordMgr.instance:show("请先布置守阵")

		return
	end

	local qualifyInfo = MartialContestModel.instance:getQualifierInfo(self._activityId, self._enterStepId)

	qualifyInfo = qualifyInfo and GameUtil.pbToTable(qualifyInfo)

	local opponent = qualifyInfo.opponent
	local leftTimes = MartialContestController.instance:getCurLeftQualifierChanllegeTimes(self._activityId, self._enterStepId)

	if not opponent then
		if leftTimes <= 0 then
			local key = string.format("%s_%s", self._viewPresentor.viewName, self._activityId)

			TipsFacade.instance:openPopupWindowWithTogByDayKey(lang("tip"), lang("今日奖励次数已用完，继续挑战将不再获得奖励，连胜场数会继续统计"), function()
				UIStateManager.instance:push(ViewName.MartialContestQualifyMatchView, self._activityId, self._enterStepId)
			end, function()
				return
			end, key)
		else
			UIStateManager.instance:push(ViewName.MartialContestQualifyMatchView, self._activityId, self._enterStepId)
		end
	end
end

function MartialContestQualifierView:_myRoleLoadHandler()
	GameUtil.SetActive(self._roleShowMy, true)
end

function MartialContestQualifierView:_enemyRoleLoadHandler()
	GameUtil.SetActive(self._roleShowEnemy, true)
end

function MartialContestQualifierView:_PM_MCGetInfoRes()
	self:_refreshView()

	local qualifyInfo = MartialContestModel.instance:getQualifierInfo(self._activityId, self._enterStepId)

	qualifyInfo = qualifyInfo and GameUtil.pbToTable(qualifyInfo)

	local opponent = qualifyInfo and qualifyInfo.opponent

	if not opponent then
		MartialContestAgent.instance:sendPM_MCQualifierGetNewOpponentReq(self._activityId, self._enterStepId)
	end
end

function MartialContestQualifierView:_onClickEnemyInfo()
	local qualifyInfo = MartialContestModel.instance:getQualifierInfo(self._activityId, self._enterStepId)

	qualifyInfo = qualifyInfo and GameUtil.pbToTable(qualifyInfo)

	local opponent = qualifyInfo and qualifyInfo.opponent

	if opponent and checknumber(opponent.headInfo.userId) > 0 then
		FriendController.instance:showInfoView(checknumber(opponent.headInfo.userId), self._btnInfo)
	end
end

function MartialContestQualifierView:_onClickTip()
	TipsFacade.instance:openRulesView("martial_contest_clg_rule")
end

function MartialContestQualifierView:_onMCQualifierRankInfoRes(msg)
	self._txtMyRank.text = string.format("<color=#b1dbfc>我的排名：</color>%s", (msg.myRank > 0 or nil) and (msg.myRank or "未上榜"))
end

return MartialContestQualifierView
