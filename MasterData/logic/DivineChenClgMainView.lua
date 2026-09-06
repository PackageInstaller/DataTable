-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinechenclg/view/DivineChenClgMainView.lua

module("logic.extensions.divinechenclg.view.DivineChenClgMainView", package.seeall)

local DivineChenClgMainView = class("DivineChenClgMainView", ViewComponent)

function DivineChenClgMainView:ctor()
	DivineChenClgMainView.super.ctor(self)
end

function DivineChenClgMainView:unbindEvents()
	DivineChenClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._btnExtreme)
	GameUtil.rmClickHandler(self._btnNormal)
end

function DivineChenClgMainView:bindEvents()
	DivineChenClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "junpStr1"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "junpStr2"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "junpStr3"))
	GameUtil.addClickHandler(self._btnExtreme, self._onClickBtnExtreme, self)
	GameUtil.addClickHandler(self._btnNormal, self._onClickBtnNormal, self)
end

function DivineChenClgMainView:buildUI()
	DivineChenClgMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTimeRoot = self:getGo("txtOpenTime")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._jumpBtnCol_btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._jumpBtnCol_btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._jumpBtnCol_btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._jumpBtnCol_btnJump1_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._jumpBtnCol_btnJump2_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._jumpBtnCol_btnJump3_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._passExtreme = self:getGo("extreme/pass")
	self._btnExtreme = self:getGo("extreme/btn")
	self._bubble = self:getGo("extreme/bubble")
	self._showConBubble = self:getGo("extreme/bubble/showCon")
	self._txtBubble = self:getTxt("extreme/bubble/txt")
	self._passBubble = self:getGo("extreme/bubble/pass")
	self._normal = self:getGo("normal")
	self._btnNormal = self:getGo("normal/btn")
	self._passNormal = self:getGo("normal/pass")
	self._redPointNormal = self:getGo("normal/btn/redPoint")
	self._txtOpenTimeNor = self:getTxt("normal/openTime/txt")
	self._openTimeNor = self:getGo("normal/openTime")
	self._txtOpenTimeExt = self:getTxt("extreme/openTime/txt")
	self._openTimeExt = self:getGo("extreme/openTime")
end

function DivineChenClgMainView:onExit()
	DivineChenClgMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._showConBubble)
	RedPointController.instance:unregRedPoint(self._redPointNormal)
end

function DivineChenClgMainView:onEnter()
	DivineChenClgMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_updateUIByCfg()

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_initAoqiGodUI()
	self.addGEvent(self, GlobalNotify.DivineChenClgGetExtremeInfoRes, self._updateUIByExtremeInfo, self)
	self.addGEvent(self, GlobalNotify.DivineChenClgGetNormalInfoRes, self._updateUIByNormalInfo, self)
	DivineChenClgController.instance:getExtremeInfo(self._activityId)

	if not self._isAoqiGodProcessType then
		DivineChenClgController.instance:getNormalInfo(self._activityId)
	end

	RedPointController.instance:regRedPoint(self._redPointNormal, self._actCfg.redPointId)
end

function DivineChenClgMainView:_updateUIByCfg()
	self._actCfg = DivineChenClgConfig.instance:getActCfg(self._activityId)
	self._normalPrizeCfgs = DivineChenClgConfig.instance:getNormalPrizeCfgs(self._activityId)
	self._extremeStageCfgs = DivineChenClgConfig.instance:getExtremeStageCfgs(self._activityId)
	self._lastNorPrizeCfg = self._normalPrizeCfgs[#self._normalPrizeCfgs]
	self._curSkinId = self._actCfg.skinId

	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curSkinId)

	self._curRaceId = petSkinCfg and petSkinCfg.raceId

	MaterialMgr.setCell(MatType.Rare, self._curSkinId, self._pointRare)

	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._txtPetNameInInfo.text = petSkinCfg and petSkinCfg.name
	self._txtBubble.text = self._actCfg.showPrizeDesc

	MaterialMgr.setCellByCfg(self._actCfg.showPrize, self._showConBubble)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, nil, nil, true, nil, nil)

	local dateOpen = GameUtil.string2date(self._actCfg.openTime)
	local dateEnd = GameUtil.string2date(self._actCfg.endTime)
	local dateExtremeOpen = GameUtil.string2date(self._actCfg.extremeOpenTime)
	local dateExtremeEnd = GameUtil.string2date(self._actCfg.extremeEndTime)

	if not self._isAoqiGodProcessType then
		self._txtOpenTimeNor.text = string.format("%s.%s-%s.%s开启", dateOpen.month, dateOpen.day, dateEnd.month, dateEnd.day)
		self._txtOpenTimeExt.text = string.format("%s.%s-%s.%s开启", dateExtremeOpen.month, dateExtremeOpen.day, dateExtremeEnd.month, dateExtremeEnd.day)

		GameUtil.SetGray(self._btnExtreme, not GameUtil.checkIsInTimePeriod(self._actCfg.extremeOpenTime, self._actCfg.extremeEndTime))
		GameUtil.SetGray(self._btnNormal, not GameUtil.checkIsInTimePeriod(self._actCfg.openTime, self._actCfg.endTime))
	end
end

function DivineChenClgMainView:_initAoqiGodUI()
	local showNormalUI = not self._isAoqiGodProcessType

	GameUtil.SetActive(self._jumpBtnCol, showNormalUI)
	GameUtil.SetActive(self._txtOpenTimeRoot, showNormalUI)
	GameUtil.SetActive(self._bubble, showNormalUI)
end

function DivineChenClgMainView:_updateUIByExtremeInfo()
	self._isExtremePass = false

	local extremeInfo = DivineChenClgModel.instance:getExtremeInfoByActId(self._activityId)

	if extremeInfo then
		if not extremeInfo.passStages then
			local passStages = {}
			local passNum = #passStages

			self._isExtremePass = passNum >= #self._extremeStageCfgs
		end
	end

	goutil.setActive(self._passExtreme, self._isExtremePass)
	goutil.setActive(self._passBubble, self._isExtremePass)
end

function DivineChenClgMainView:_updateUIByNormalInfo()
	self._isNormalPass = false
	self._isAllGain = false

	local normalInfo = DivineChenClgModel.instance:getNormalInfoByActId(self._activityId)

	if normalInfo then
		local passNum = normalInfo.historyPassNum

		if not normalInfo.gainedPrizeIds then
			local gainPrizeNum = {}

			self._isNormalPass = passNum >= self._lastNorPrizeCfg.stageNum
			self._isAllGain = #gainPrizeNum >= #self._normalPrizeCfgs
		end
	end

	goutil.setActive(self._passNormal, self._isNormalPass)
end

function DivineChenClgMainView:_onClickBtnJump(key)
	local jumpToStr = self._actCfg[key]

	GotoMgr.gotoByString(jumpToStr)
end

function DivineChenClgMainView:_onClickBtnTip()
	local key = self._actCfg.ruleTip

	TipsFacade.instance:openRulesView(key)
end

function DivineChenClgMainView:_onClickBtnExtreme()
	if not GameUtil.checkIsInTimePeriod(self._actCfg.extremeOpenTime, self._actCfg.extremeEndTime) and not self._isAoqiGodProcessType then
		FloatWordMgr.instance:show("活动未开启")

		return
	end

	if self._isExtremePass then
		if self._isAoqiGodProcessType then
			AoqiGodController.instance:doHandleChallengeFinishReady(DivineChenClgController.instance:getActivityType(), self._activityId)
		end

		FloatWordMgr.instance:show("已通关")

		return
	end

	if not DivineChenClgController.instance:checkPassAoqiGodProcessResult(self._activityId) then
		return
	end

	UIStateManager.instance:push(ViewName.DivineChenClgExtremeView, self._activityId)
end

function DivineChenClgMainView:_onClickBtnNormal()
	if not GameUtil.checkIsInTimePeriod(self._actCfg.openTime, self._actCfg.endTime) and not self._isAoqiGodProcessType then
		FloatWordMgr.instance:show("活动未开启")

		return
	end

	if self._isNormalPass and self._isAllGain then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.DivineChenClgNormalView, self._activityId)
end

function DivineChenClgMainView:_onClickBtnSkill()
	if self._curRaceId ~= 0 then
		if self._curRaceId == self._curSkinId then
			PetbookController.instance:previewBattle(self._curRaceId)
		else
			PetbookController.instance:previewBattle(self._curRaceId, self._curSkinId)
		end
	end
end

function DivineChenClgMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self._curRaceId)
end

return DivineChenClgMainView
