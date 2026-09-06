-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingQualifyView.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingQualifyView", package.seeall)

local YoungChampionKingQualifyView = class("YoungChampionKingQualifyView", ViewComponent)

function YoungChampionKingQualifyView:ctor()
	YoungChampionKingQualifyView.super.ctor(self)
end

function YoungChampionKingQualifyView:unbindEvents()
	YoungChampionKingQualifyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnForm)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnFight)
	GameUtil.rmClickHandler(self._btnMatch)
end

function YoungChampionKingQualifyView:bindEvents()
	YoungChampionKingQualifyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnForm, self._onClickBtnForm, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnFight, self._onClickBtnFight, self)
	GameUtil.addClickHandler(self._btnMatch, self._onClickBtnMatch, self)
	self._photoEffMy:setFirstAddParent(self._myRoleLoadHandler, self)
	self._photoEffEnemy:setFirstAddParent(self._enemyRoleLoadHandler, self)
end

function YoungChampionKingQualifyView:buildUI()
	YoungChampionKingQualifyView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnForm = self:getGo("leftBottomBtns/btnForm")
	self._btnRank = self:getGo("leftBottomBtns/btnRank")
	self._btnFight = self:getGo("enemyRole/btnFight")
	self._btnMatch = self:getGo("match/btnMatch")
	self._combos = self:getGo("combos")
	self._txtCombos = self:getTxt("combos/txt")
	self._txtNameShowMyRole = self:getTxt("myRole/infoCom/txtNameShow")
	self._txtPowerMyRole = self:getTxt("myRole/infoCom/txtPower")
	self._headMyRole = self:getGo("myRole/head")
	self._roleShowMy = self:getGo("myRole/role")
	self._photoEffMy = AvatarPhotoShow.Get(self._roleShowMy)

	self._photoEffMy:setRawWidthAndHeight(1280, 720)
	self._photoEffMy:setCameraPosition(0, 1, -2)
	self._photoEffMy:setCamSize(2.2)

	self._avatarMy = nil
	self._txtLeftTimes = self:getTxt("leftTimes/txt")
	self._txtOpenTime = self:getTxt("txtOpenTime")
	self._tips = self:getGo("tips")
	self._txtTitle = self:getTxt("txtTitle")
	self._enemyRole = self:getGo("enemyRole")
	self._txtNameShowEnemyRole = self:getTxt("enemyRole/infoCom/txtNameShow")
	self._txtPowerEnemyRole = self:getTxt("enemyRole/infoCom/txtPower")
	self._headEnemyRole = self:getGo("enemyRole/head")
	self._roleShowEnemy = self:getGo("enemyRole/role")
	self._photoEffEnemy = AvatarPhotoShow.Get(self._roleShowEnemy)

	self._photoEffEnemy:setRawWidthAndHeight(1280, 720)
	self._photoEffEnemy:setCameraPosition(0, 1, -2)
	self._photoEffEnemy:setCamSize(2.2)

	self._avatarEnemy = nil
	self._tipFight = self:getGo("enemyRole/tip")
	self._scorePart = self:getGo("scorePart")
	self._txtZoneName = self:getTxt("scorePart/txtZoneName")
	self._txtMyRank = self:getTxt("scorePart/txtMyRank")
	self._txtMyScore = self:getTxt("scorePart/txtMyScore")
	self._match = self:getGo("match")
	self._imgTitleChange = self:getGo("imgTitle"):GetComponent("UIImageSpriteChange")
end

function YoungChampionKingQualifyView:onExit()
	YoungChampionKingQualifyView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._headMyRole)
	HeadItemController.instance:resetHeadCell(self._headEnemyRole)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self.close, self)
	self._photoEffMy:clear()
	self._photoEffEnemy:clear()

	self._avatarMy = nil
	self._avatarEnemy = nil
end

function YoungChampionKingQualifyView:onEnter()
	YoungChampionKingQualifyView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._enterStepId = checknumber(params[2])

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	self.addGEvent(self, GlobalNotify.PM_YCKStepChange, self._onStepChange, self)
	self.addGEvent(self, GlobalNotify.PM_YCKQualifierGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_YCKQualifierGetNewOpponentRes, self._updateOpponentPart, self)
	self.addGEvent(self, GlobalNotify.PM_YCKQualifierRankRes, self._updateRankPart, self)
	self:_dealEntertainmentPart()
	YoungChampionKingController.instance:sendPM_YCKGetDefenseForamtionReq()
	YoungChampionKingController.instance:sendPM_YCKGetQualifierInfoReq(self._activityId, self._enterStepId)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.close, self)

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

	if self._enterStepId == YoungChampionKingEnum.Qualify_Step_Id then
		self._imgTitleChange:SetState(0)
	elseif self._enterStepId == YoungChampionKingEnum.Score_Match_Step_Id then
		self._imgTitleChange:SetState(1)
	else
		self._imgTitleChange:SetState(2)
	end
end

function YoungChampionKingQualifyView:_dealEntertainmentPart()
	local isEntertainment = self._enterStepId == YoungChampionKingEnum.Entertainment_Step_Id

	if not isEntertainment then
		local zoneId = YoungChampionKingController.instance:getCurZoneId()

		YoungChampionKingController.instance:sendPM_YCKQualifierRankInfoReq(self._activityId, zoneId, self._enterStepId)
	end

	goutil.setActive(self._scorePart, not isEntertainment)
	goutil.setActive(self._tips, isEntertainment)
end

function YoungChampionKingQualifyView:_updateMyRole()
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
		self._photoEffMy:addShowAvatarEffect(self._avatarMy)
	end
end

function YoungChampionKingQualifyView:_updateUIByCfg()
	local baseCfg = YoungChampionKingConfig.instance:getQualifyBaseCfg(self._activityId, self._enterStepId)

	self._txtTitle.text = baseCfg.stepName
	self._txtZoneName.text = YoungChampionKingController.instance:getCurZoneName()

	if self._enterStepId == YoungChampionKingEnum.Score_Match_Step_Id then
		local startTime, endTime = YoungChampionKingController.instance:getStartTimeAndEndTimeByStepId(YoungChampionKingEnum.Score_Match_Step_Id)
		local startDate = GameUtil.time2date(startTime)
		local endDate = GameUtil.time2date(endTime)

		self._txtOpenTime.text = string.format("比赛时间：%02d.%02d %02d:%02d-%02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	else
		local startTime1, endTime1 = YoungChampionKingController.instance:getStartTimeAndEndTimeByStepId(YoungChampionKingEnum.Qualify_Step_Id)
		local startDate1 = GameUtil.time2date(startTime1)
		local endDate1 = GameUtil.time2date(endTime1)
		local startTime2, endTime2 = YoungChampionKingController.instance:getStartTimeAndEndTimeByStepId(YoungChampionKingEnum.Entertainment_Step_Id)
		local startDate2 = GameUtil.time2date(startTime2)
		local endDate2 = GameUtil.time2date(endTime2)

		self._txtOpenTime.text = string.format("比赛模式：%02d.%02d %02d:%02d-%02d.%02d %02d:%02d\n娱乐模式：%02d.%02d %02d:%02d-%02d.%02d %02d:%02d", startDate1.month, startDate1.day, startDate1.hour, startDate1.min, endDate1.month, endDate1.day, endDate1.hour, endDate1.min, startDate2.month, startDate2.day, startDate2.hour, startDate2.min, endDate2.month, endDate2.day, endDate2.hour, endDate2.min)
	end
end

function YoungChampionKingQualifyView:_updateUIByInfo()
	local qualifyInfo = YoungChampionKingModel.instance:getQualifierInfo(self._activityId, self._enterStepId)

	self._txtMyScore.text = string.format("我的积分:%s", qualifyInfo.rankScore)

	self:_updateOpponentPart()
	HeadItemController.instance:setMyHeadCell(self._headMyRole)

	self._txtNameShowMyRole.text = string.format("s%03d-%s", RoleModel.instance:getAreaId(), RoleModel.instance:getUserName())
	self._txtPowerMyRole.text = RoleModel.instance:getMaxPower()

	self:_updateMyRole()
	goutil.setActive(self._combos, qualifyInfo.winStreak > 0)

	self._txtCombos.text = string.format("<size=80>%s</size>连胜", qualifyInfo.winStreak)

	local leftTimes = YoungChampionKingController.instance:getCurLeftQualifierChanllegeTimes(self._enterStepId)

	self._txtLeftTimes.text = string.format("剩余匹配次数：%s", leftTimes)

	goutil.setActive(self._tipFight, false)
	goutil.setActive(self._btnFight, true)
end

function YoungChampionKingQualifyView:_onStepChange(newStepId)
	YoungChampionKingController.instance:sendPM_YCKGetQualifierInfoReq(self._activityId, self._enterStepId)

	local isEntertainment = self._enterStepId == YoungChampionKingEnum.Entertainment_Step_Id

	if not isEntertainment then
		local zoneId = YoungChampionKingController.instance:getCurZoneId()

		YoungChampionKingController.instance:sendPM_YCKQualifierRankInfoReq(self._activityId, zoneId, self._enterStepId)
	end
end

function YoungChampionKingQualifyView:_updateRankPart()
	local zoneId = YoungChampionKingController.instance:getCurZoneId()
	local rankInfo = YoungChampionKingModel.instance:getQualifierRankInfo(self._activityId, self._enterStepId, zoneId)

	self._txtMyRank.text = string.format("我的排名:%s", (rankInfo.myRank > 0 or nil) and (rankInfo.myRank or "未上榜"))
end

function YoungChampionKingQualifyView:_updateOpponentPart()
	local qualifyInfo = YoungChampionKingModel.instance:getQualifierInfo(self._activityId, self._enterStepId)
	local opponent = qualifyInfo.opponent

	if opponent then
		goutil.setActive(self._enemyRole, true)
		goutil.setActive(self._match, false)
		HeadItemController.instance:resetHeadCell(self._headEnemyRole)
		HeadItemController.instance:setHeadCellByInfo(self._headEnemyRole, opponent.headInfo)

		self._txtNameShowEnemyRole.text = string.format("s%03d-%s", opponent.areaId, opponent.headInfo.userName)
		self._txtPowerEnemyRole.text = opponent.zdl

		local skId = DressModel.instance:getSkeIdByGender(opponent.gender)
		local mo = DressModel.instance:getAvatarPlayerMo(skId, (not opponent.clothes or nil) and {}, 0)

		if self._avatarEnemy then
			self._avatarEnemy:updateByMo(mo)
		else
			self._avatarEnemy = AvatarsMgrNew.instance:getAvatarByMo(mo)
			self._avatarEnemy.useType = AvatarUseType.Scene

			GameUtil.SetActive(self._roleShowEnemy, false)
			self._photoEffEnemy:addShowAvatarEffect(self._avatarEnemy)
		end
	else
		goutil.setActive(self._match, true)
		goutil.setActive(self._enemyRole, false)
	end

	local leftTimes = YoungChampionKingController.instance:getCurLeftQualifierChanllegeTimes(self._enterStepId)

	self._txtLeftTimes.text = string.format("剩余匹配次数：%s", leftTimes)
end

function YoungChampionKingQualifyView:_onClickBtnForm()
	local fmtMo = YoungChampionKingModel.instance:getQualifierDefenseFmtMo()

	fmtMo:initParams(self._enterStepId)
	CustomFmtController.instance:showMissionFormationView(fmtMo)
end

function YoungChampionKingQualifyView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.YoungchampionkingrankView, self._activityId, self._enterStepId)
end

function YoungChampionKingQualifyView:_onClickBtnFight()
	local canFight, resultCode, tips = YoungChampionKingController.instance:getIsAbleEnterQualifyFight(self._enterStepId)

	if resultCode < 0 then
		TipsFacade.instance:openCommonTips(tips)

		return
	end

	local fmtMo = YoungChampionKingModel.instance:getQualifierFmtMo()

	fmtMo:initParams(self._enterStepId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function YoungChampionKingQualifyView:_onClickBtnMatch()
	local curForm = YoungChampionKingModel.instance:getQualifierFormInfo()
	local isEmpty = true

	for i, v in ipairs(curForm.pos) do
		if v > 0 then
			isEmpty = false

			break
		end
	end

	if isEmpty then
		FloatWordMgr.instance:show("请先布置守阵")

		return
	end

	local qualifyInfo = YoungChampionKingModel.instance:getQualifierInfo(self._activityId, self._enterStepId)
	local opponent = qualifyInfo.opponent
	local leftTimes = YoungChampionKingController.instance:getCurLeftQualifierChanllegeTimes(self._enterStepId)

	if leftTimes <= 0 then
		FloatWordMgr.instance:show("今日匹配次数已耗尽，明天再来吧")

		return
	end

	if not opponent then
		UIStateManager.instance:push(ViewName.YoungChampionKingMatchView, self._activityId, self._enterStepId)
	end
end

function YoungChampionKingQualifyView:_myRoleLoadHandler()
	GameUtil.SetActive(self._roleShowMy, true)
end

function YoungChampionKingQualifyView:_enemyRoleLoadHandler()
	GameUtil.SetActive(self._roleShowEnemy, true)
end

return YoungChampionKingQualifyView
