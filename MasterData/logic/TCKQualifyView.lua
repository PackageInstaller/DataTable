-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKQualifyView.lua

module("logic.extensions.teenchampionking.view.TCKQualifyView", package.seeall)

local TCKQualifyView = class("TCKQualifyView", ViewComponent)

function TCKQualifyView:ctor()
	TCKQualifyView.super.ctor(self)
end

function TCKQualifyView:unbindEvents()
	TCKQualifyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnAdjust)
	GameUtil.rmClickHandler(self._btnMatch)
	GameUtil.rmClickHandler(self._btnTog)
end

function TCKQualifyView:bindEvents()
	TCKQualifyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnMatch, self._onClickBtnMatch, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnAdjust, self._onClickBtnAdjust, self)
	GameUtil.addClickHandler(self._btnTog, self._onClickBtnTog, self)
end

function TCKQualifyView:buildUI()
	TCKQualifyView.super.buildUI(self)

	self._modelCam = self:getGo("modelCam")

	local rolePoint = self:getGo("modelCam/rolePoint")

	self._myAvatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	self._myAvatar:setParent(rolePoint.transform)
	self._myAvatar:setLayer(SceneLayer.UI3D_Value)

	self._btnRank = self:getGo("leftBottomBtns/btnRank")
	self._btnAdjust = self:getGo("leftBottomBtns/btnAdjust")
	self._scorePart = self:getGo("scorePart")
	self._txtZoneName = self:getTxt("scorePart/txtZoneName")
	self._txtMyRank = self:getTxt("scorePart/txtMyRank")
	self._txtMyScore = self:getTxt("scorePart/txtMyScore")
	self._headMyRole = self:getGo("myRole/head")
	self._txtNameShowMyRole = self:getTxt("myRole/infoCom/txtNameShow")
	self._txtPowerMyRole = self:getTxt("myRole/infoCom/txtPower")
	self._combos = self:getGo("combos")
	self._txtCombos = self:getTxt("combos/txt")
	self._btnMatch = self:getGo("match/btnMatch")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnAdjust = self:getGo("leftBottomBtns/btnAdjust")
	self._btnRank = self:getGo("leftBottomBtns/btnRank")
	self._imgTitleChange = self:getGo("mask/imgTitle"):GetComponent("UIImageSpriteChange")
	self._txtOpenTime = self:getTxt("mask/txtOpenTime")
	self._txtLeftTimes = self:getTxt("leftTimes/times/txt")
	self._tipFinish = self:getGo("leftTimes/tip")
	self._prizecom = self:getGo("prizecom")
	self._icon1Prize = self:getGo("prizecom/icon1")
	self._icon2Prize = self:getGo("prizecom/icon2")
	self._icon1Score = self:getGo("scorePart/prizecom/icon1")
	self._icon2Score = self:getGo("scorePart/prizecom/icon2")
	self._txtWintips = self:getTxt("wintips/tips/txt")
	self._wintips = self:getGo("wintips")
	self._tips = self:getGo("wintips/tips")
	self._addTips = self:getGo("wintips/addTips")
	self._btnTog = self:getGo("togSwitch/btnTog")
	self._markTog = self:getGo("togSwitch/btnTog/mark")
	self._txtMatchTime = self:getTxt("matchTime/txt")
end

function TCKQualifyView:onExit()
	TCKQualifyView.super.onExit(self)
	LightMgr.instance:setLightForNormalScene()
	goutil.addChildToParent(self._modelCam, self.mainGO)
	GlobalModel.instance:visibleSceneHUDs(true)
	HeadItemController.instance:resetHeadCell(self._headMyRole)
	MaterialMgr.instance:resetAll(self._icon1Prize)
	MaterialMgr.instance:resetAll(self._icon2Prize)
	MaterialMgr.instance:resetAll(self._icon1Score)
	MaterialMgr.instance:resetAll(self._icon2Score)
end

function TCKQualifyView:onEnter()
	TCKQualifyView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_TCKStepChange, self._onStepChange, self)
	self.addGEvent(self, GlobalNotify.PM_TCKGetQualifierInfo, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_TCKUpdateRank, self._updateRankPart, self)
	self.addGEvent(self, GlobalNotify.PM_TCKSelectPets, self._updatePetList, self)

	local params = self:getOpenParam()

	self._activityId = params and checknumber(params[1]) or 501001
	self._enterStepId = params and checknumber(params[2]) or 1
	self._isEntertainment = self._enterStepId == TeenChampionKingController.EntertainmentStepId

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	self:_updateRankPart()
	TeenChampionKingController.instance:getGlobalInfo(self._activityId)
	TeenChampionKingController.instance:getQualifierInfo(self._activityId, self._enterStepId)

	if not self._isEntertainment and self._zoneCfg then
		TeenChampionKingController.instance:updateRankView(self._activityId, self._zoneCfg.zoneId, self._enterStepId)
	end
end

function TCKQualifyView:onEnterFinished()
	TCKQualifyView.super.onEnterFinished(self)

	local curCardInfo = RoleModel.instance.myCardInfo

	if not curCardInfo then
		PlayerAgent.instance:sendGetMyDisplayCardInfoReq(function(msg)
			self._isReqingRoleInfo = false

			RoleModel.instance:setMyCardInfo(msg)
			self:_updateMyRole()
		end, nil, function()
			self._isReqingRoleInfo = false
		end)
	else
		self:_updateMyRole()
	end
end

function TCKQualifyView:destroyUI()
	TCKQualifyView.super.destroyUI(self)

	if self._myAvatar then
		AvatarsMgrNew.instance:removeAvatar(self._myAvatar)

		self._myAvatar = nil
	end
end

function TCKQualifyView:_updateMyRole()
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	goutil.addChildToParent(self._modelCam)
	GlobalModel.instance:visibleSceneHUDs(false)

	local curCardInfo = RoleModel.instance.myCardInfo

	if not curCardInfo then
		return
	end

	local skId = DressModel.instance:getSkeIdByGender(RoleModel.instance:getGender())
	local mo = DressModel.instance:getAvatarPlayerMo(skId, (not curCardInfo.clothes or nil) and {}, 0)

	self._myAvatar:updateByMo(mo)
end

function TCKQualifyView:_updateUIByCfg()
	self._actCfg = TeenChampionKingConfig.instance:getActCfg(self._activityId)
	self._baseCfg = TeenChampionKingConfig.instance:getQualifyCfg(self._activityId, self._enterStepId)
	self._zoneCfg = TeenChampionKingController.instance:getZoneCfgByActId(self._activityId)
	self._openTimeStr = TeenChampionKingConfig.instance:getCommonValue("MATCH_OPEN_TIME")
	self._rankScoreCfgs = TeenChampionKingConfig.instance:getQualiflerRankScoreCfgs(self._baseCfg.rankScorePlanId)

	local timeStrs = string.split(self._openTimeStr, "-")

	self._startTimeStr = timeStrs[1] or ""
	self._endTimeStr = timeStrs[2] or ""
	self._txtZoneName.text = self._zoneCfg.name
	self._txtMatchTime.text = string.format("匹配时间：%s", self._openTimeStr)

	MaterialMgr.setCellByCfg(self._actCfg.winPrize, self._icon1Prize)
	MaterialMgr.setCellByCfg(self._actCfg.failPrize, self._icon2Prize)
	MaterialMgr.setCellByCfg(self._actCfg.winPrize, self._icon1Score)
	MaterialMgr.setCellByCfg(self._actCfg.failPrize, self._icon2Score)

	if self._enterStepId == TeenChampionKingController.PRELIMINARY then
		self._imgTitleChange:SetState(0)
	elseif self._enterStepId == TeenChampionKingController.POINTS_RACE then
		self._imgTitleChange:SetState(1)
	else
		self._imgTitleChange:SetState(2)
	end

	goutil.setActive(self._tips, not self._isEntertainment)
	goutil.setActive(self._addTips, self._isEntertainment)
	goutil.setActive(self._scorePart, not self._isEntertainment)
	goutil.setActive(self._prizecom, self._isEntertainment)

	if self._enterStepId == TeenChampionKingController.POINTS_RACE then
		local startTime, endTime = TeenChampionKingController.instance:getStartTimeAndEndTimeByStepId(self._activityId, self._enterStepId)
		local startDate = GameUtil.time2date(startTime)
		local endDate = GameUtil.time2date(endTime)

		self._txtOpenTime.text = string.format("比赛时间：%02d.%02d %02d:%02d-%02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	else
		local startTime1, endTime1 = TeenChampionKingController.instance:getStartTimeAndEndTimeByStepId(self._activityId, 1)
		local startDate1 = GameUtil.time2date(startTime1)
		local endDate1 = GameUtil.time2date(endTime1)
		local startTime2, endTime2 = TeenChampionKingController.instance:getStartTimeAndEndTimeByStepId(self._activityId, TeenChampionKingController.EntertainmentStepId)
		local startDate2 = GameUtil.time2date(startTime2)
		local endDate2 = GameUtil.time2date(endTime2)

		self._txtOpenTime.text = string.format("比赛模式：%02d.%02d %02d:%02d-%02d.%02d %02d:%02d\n娱乐模式：%02d.%02d %02d:%02d-%02d.%02d %02d:%02d", startDate1.month, startDate1.day, startDate1.hour, startDate1.min, endDate1.month, endDate1.day, endDate1.hour, endDate1.min, startDate2.month, startDate2.day, startDate2.hour, startDate2.min, endDate2.month, endDate2.day, endDate2.hour, endDate2.min)
	end
end

function TCKQualifyView:_updateUIByInfo()
	local qualifyInfo = TeenChampionKingModel.instance:getQualifierInfo(self._activityId, self._enterStepId)

	self._leftTimes = 0
	self._rankScore = 0
	self._winStreak = 0

	if qualifyInfo then
		self._winStreak = qualifyInfo.winStreak
		self._winStreak = Mathf.Max(self._winStreak, 0)
		self._leftTimes = self._actCfg.dailyFightTimes - checknumber(qualifyInfo.dailyPrizeTimes)
		self._rankScore = qualifyInfo.rankScore
	else
		self._txtCombos.text = ""
	end

	self._txtCombos.text = string.format("<size=100>%s</size>连胜", self._winStreak)
	self._txtWintips.text = self:_getAddScoreByWinStreak(self._winStreak + 1)

	self:_updatePetList()
	goutil.setActive(self._tipFinish, self._leftTimes <= 0)

	self._txtLeftTimes.text = string.format("剩余奖励次数：%s", self._leftTimes)
	self._txtMyScore.text = string.format("我的积分:%s", self._rankScore)
	self._txtNameShowMyRole.text = string.format("s%03d-%s", RoleModel.instance:getAreaId(), RoleModel.instance:getUserName())
	self._txtPowerMyRole.text = RoleModel.instance:getMaxPower()
end

function TCKQualifyView:_getAddScoreByWinStreak(winStreak)
	if not self._rankScoreCfgs then
		return 0
	end

	local score = 0

	for _, cfg in ipairs(self._rankScoreCfgs) do
		score = cfg.addRankScore

		if winStreak <= cfg.winStreak then
			break
		end
	end

	return score
end

function TCKQualifyView:_updatePetList()
	self._selectPets = {}
	self._isUseSysProperty = false

	local globalInfo = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)

	if globalInfo then
		self._selectPets = globalInfo.selectPetIds or {}
		self._isUseSysProperty = globalInfo.useSysProperty
	end

	goutil.setActive(self._markTog, self._isUseSysProperty)
end

function TCKQualifyView:_updateRankPart()
	if self._zoneCfg then
		local zoneId = self._zoneCfg.zoneId
		local rankInfo = TeenChampionKingModel.instance:getRankInfo(self._activityId, self._enterStepId, zoneId)

		if rankInfo then
			self._txtMyRank.text = string.format("我的排名:%s", (rankInfo.myRank > 0 or nil) and (rankInfo.myRank or "未上榜"))
		end
	end
end

function TCKQualifyView:_onStepChange(newStepId)
	if not self._isEntertainment and self._enterStepId ~= newStepId then
		FloatWordMgr.instance:show("阶段变化")
		self:close()
	end
end

function TCKQualifyView:_onClickBtnRank()
	if self._isEntertainment then
		UIStateManager.instance:push(ViewName.TCKRankMainView)
	else
		UIStateManager.instance:push(ViewName.TCKRankMainView, self._enterStepId)
	end
end

function TCKQualifyView:_getNeedTogTips()
	local key = string.format("%s_%s", self._viewPresentor.viewName, self._activityId)

	return checknumber(GameUtil.getUserDayData(key)) <= 0
end

function TCKQualifyView:_onClickBtnAdjust()
	UIStateManager.instance:push(ViewName.TCKPetSelectView, self._activityId)
end

function TCKQualifyView:_onClickBtnTog()
	local isNeedTips = TeenChampionKingController.instance:checkTogSystem(self._activityId)

	if isNeedTips and not self._isUseSysProperty then
		local title = "提示"
		local text = "勾选后，在挑战时，己方全体精灵将使用系统属性"
		local togText = "今日不再提示"

		TipsFacade.instance:openPopupWindowNoCancelWithTog(title, text, function()
			TeenChampionKingController.instance:selectPets(self._activityId, self._selectPets, not self._isUseSysProperty)
		end, function()
			TeenChampionKingController.instance:saveTogSystem(self._activityId)
		end, "确定", togText)
	else
		TeenChampionKingController.instance:selectPets(self._activityId, self._selectPets, not self._isUseSysProperty)
	end
end

function TCKQualifyView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	if self._enterStepId == TeenChampionKingController.PRELIMINARY then
		key = self._actCfg.ruleKey1
	elseif self._enterStepId == TeenChampionKingController.POINTS_RACE then
		key = self._actCfg.ruleKey2
	elseif self._enterStepId == TeenChampionKingController.EntertainmentStepId then
		key = self._actCfg.ruleKey1
	end

	TipsFacade.instance:openRulesView(key)
end

function TCKQualifyView:_onClickBtnMatch()
	if self._enterStepId ~= TeenChampionKingController.EntertainmentStepId and TeenChampionKingController.instance:checkAdjustPets(self._activityId) then
		FloatWordMgr.instance:show("请先调整精灵")
		self:_onClickBtnAdjust()

		return
	end

	if #self._selectPets <= 0 then
		FloatWordMgr.instance:show("请先选择备战精灵")
		self:_onClickBtnAdjust()

		return
	end

	if not GameUtil.checkIsInTimePeriod(self._startTimeStr, self._endTimeStr, true) then
		FloatWordMgr.instance:show(string.format("每日匹配时间：%s", self._openTimeStr))

		return
	end

	if self._leftTimes <= 0 and self:_getNeedTogTips() then
		local title = "提示"
		local text = "今日奖励次数已用完，继续挑战将不再获得奖励和积分，连胜场数不会继续统计"
		local togText = "今日不再提示"

		TipsFacade.instance:openPopupWindowNoCancelWithTog(title, text, function()
			UIStateManager.instance:push(ViewName.TCKMatchView, self._activityId, self._enterStepId)
		end, function()
			local key = string.format("%s_%s", self._viewPresentor.viewName, self._activityId)

			GameUtil.saveUserDayData(key, 1)
		end, "确定", togText)

		return
	end

	UIStateManager.instance:push(ViewName.TCKMatchView, self._activityId, self._enterStepId)
end

return TCKQualifyView
