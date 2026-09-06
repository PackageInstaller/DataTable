-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/qualifier/PTQualifierMainView.lua

module("logic.extensions.peaktournament.view.qualifier.PTQualifierMainView", package.seeall)

local PTQualifierMainView = class("PTQualifierMainView", ViewComponent)

function PTQualifierMainView:buildUI()
	PTQualifierMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/txtTitle/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._imgLevel = goutil.findChild(self.mainGO, "seasonInfo/imgLevel")
	self._txtLevel = goutil.findChildTextComponent(self.mainGO, "seasonInfo/txtLevel")
	self._txtSeason = goutil.findChildTextComponent(self.mainGO, "seasonInfo/txtSeason")
	self._txtDivision = goutil.findChildTextComponent(self.mainGO, "seasonInfo/txtSeason/txtDivision")
	self._txtRankScore = goutil.findChildTextComponent(self.mainGO, "seasonInfo/txtRankScore")
	self._countNum = goutil.findChild(self.mainGO, "countNum")
	self._txtCountNum = goutil.findChildTextComponent(self.mainGO, "countNum/txtCountNum/txt")
	self._txtStreakNum = goutil.findChildTextComponent(self.mainGO, "challengeInfo/txtStreakNum")
	self._btnReport = goutil.findChild(self.mainGO, "btnCol/btnReport")
	self._btnReportRed = goutil.findChild(self.mainGO, "btnCol/btnReport/redPoint")
	self._btnForm = goutil.findChild(self.mainGO, "btnCol/btnForm")
	self._btnFormRed = goutil.findChild(self.mainGO, "btnCol/btnForm/redPoint")
	self._btnExchange = goutil.findChild(self.mainGO, "btnCol/btnExchange")
	self._btnExchangeRed = goutil.findChild(self.mainGO, "btnCol/btnExchange/redPoint")
	self._btnRank = goutil.findChild(self.mainGO, "btnCol/btnRank")
	self._btnRankRed = goutil.findChild(self.mainGO, "btnCol/btnRank/redPoint")
	self._btnReward = goutil.findChild(self.mainGO, "btnCol/btnReward")
	self._btnRewardRed = goutil.findChild(self.mainGO, "btnCol/btnReward/redPoint")
	self._btnBless = goutil.findChild(self.mainGO, "btnCol/btnBless")
	self._btnBanPet = goutil.findChild(self.mainGO, "btnCol/btnBanPet")
	self._roleCol = goutil.findChild(self.mainGO, "roleCol")
	self._modelCam = goutil.findChild(self.mainGO, "modelCam")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
end

function PTQualifierMainView:bindEvents()
	PTQualifierMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._imgLevel, self._onClickImgLevel, self)
	GameUtil.addClickHandler(self._btnReport, self._onClickBtnReport, self)
	GameUtil.addClickHandler(self._btnForm, self._onClickBtnForm, self)
	GameUtil.addClickHandler(self._btnExchange, self._onClickBtnExchange, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickBtnReward, self)
	GameUtil.addClickHandler(self._btnBless, self._onClickBtnBless, self)
	GameUtil.addClickHandler(self._btnBanPet, self._onCLickBtnBanPet, self)
end

function PTQualifierMainView:unbindEvents()
	PTQualifierMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._imgLevel)
	GameUtil.rmClickHandler(self._btnReport)
	GameUtil.rmClickHandler(self._btnForm)
	GameUtil.rmClickHandler(self._btnExchange)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnReward)
	GameUtil.rmClickHandler(self._btnBless)
	GameUtil.rmClickHandler(self._btnBanPet)
end

function PTQualifierMainView:onEnter()
	PTQualifierMainView.super.onEnter(self)

	self._activityId = PeakTournamentController.instance:getCurActivityId()

	if self._activityId == 0 then
		FloatWordMgr.instance:show("缺失活动id")

		return
	end

	self:_setAvatarCameraEnv(true)
	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentGetQualifierInfoRes, self._onUpdate, self)
	PeakTournamentController.instance:sendPM_PeakTournamentGetQualifierInfoReq(self._activityId)
end

function PTQualifierMainView:onExit()
	PTQualifierMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentGetQualifierInfoRes, self._onUpdate, self)
	self:_clearAvatarPool()
	self:_setAvatarCameraEnv(false)

	if self._roleCellList and self._roleCellList[2] then
		RedPointController.instance:unregRedPoint(self._roleCellList[2]._redPoint)
	end

	RedPointController.instance:unregRedPoint(self._btnRewardRed)
end

function PTQualifierMainView:destroyUI()
	PTQualifierMainView.super.destroyUI(self)
end

function PTQualifierMainView:_onSetUI()
	local taskPrizeRedId = PeakTournamentConfig.instance:getPtCommonValue("PT_RED_TASK_PRIZE")
	local rewardOnceRedId = PeakTournamentConfig.instance:getPtCommonValue("PT_RED_QUA_REWARD_ONCE")

	RedPointController.instance:regRedPoint(self._btnRewardRed, taskPrizeRedId, rewardOnceRedId)

	local startTime, endTime = PeakTournamentController.instance:getStartAndEndTimeStrAsPT(self._activityId, GameEnum.PeakTournamentStep.Qualifier)

	if self._txtOpenTime then
		self._txtOpenTime.text = GameUtil.getFormatTimeByStamp(GameUtil.string2time(startTime), GameUtil.string2time(endTime))
	end

	local goldBarList = PeakTournamentController.instance:getGoldBarList(self._activityId)

	if #goldBarList > 0 then
		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, goldBarList)
	end

	local isHave = PeakTournamentController.instance:isTheSeasonHaveBanPet(self._activityId, GameEnum.PeakTournamentStep.Qualifier)

	GameUtil.SetActive(self._btnBanPet, isHave)
end

function PTQualifierMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function PTQualifierMainView:_onUpdateData()
	self:_onUpdateRoleColData()
end

function PTQualifierMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateRoleColUI()
end

function PTQualifierMainView:_onUpdatePlaneUI()
	local rankScore = PeakTournamentModel.instance:getRankScoreAsQua()
	local levelData = PeakTournamentConfig.instance:getPtQuaLevelDataByScore(self._activityId, rankScore)

	if levelData then
		self._imgLevel:GetComponent(ComponentType.UIImageSpriteChange):SetState(levelData.quaLevelId - 1)

		self._txtLevel.text = levelData.levelName
	end

	local curSeason = PeakTournamentController.instance:getWhatSeason()

	self._txtSeason.text = string.format("第%s届", GameUtil.getChineseNumber(curSeason))
	self._txtDivision.text = RoleModel.instance:getAreaName()
	self._txtRankScore.text = string.format("我的积分：%s", rankScore)

	local remainDailyFightTimes = PeakTournamentController.instance:getRemainDailyFightTimesAsQua(self._activityId)

	self._txtCountNum.text = string.format("挑战次数：%s", remainDailyFightTimes)

	GameUtil.SetActive(self._countNum, remainDailyFightTimes > 0)

	local winStreak = PeakTournamentModel.instance:getWinStreakAsQua()

	self._txtStreakNum.text = string.format("<size=60>%s</size>连胜", winStreak)
end

function PTQualifierMainView:_onUpdateRoleColData()
	local myRoleInfo = {
		power = RoleModel.instance:getMaxPower(),
		userName = RoleModel.instance:getUserName(),
		gender = RoleModel.instance:getGender(),
		clothes = RoleModel.instance:getClothes(),
		rankScore = PeakTournamentModel.instance:getRankScoreAsQua(),
		areaId = RoleModel.instance:getAreaId()
	}
	local opInfo = PeakTournamentModel.instance:getOpPlayerInfoAsQua()
	local opRoleInfo = {
		power = opInfo.zdl,
		userName = opInfo.headInfo.userName,
		gender = opInfo.gender,
		clothes = opInfo.clothes,
		rankScore = opInfo.rankScore,
		areaId = opInfo.areaId
	}

	self._roleInfoList = {
		myRoleInfo,
		opRoleInfo
	}
end

function PTQualifierMainView:_onUpdateRoleColUI()
	if self._roleCellList == nil then
		self._roleCellList = {}

		for idx = 0, self._roleCol.transform.childCount - 1 do
			local cell = {}

			table.insert(self._roleCellList, cell)

			local mainGo = self._roleCol.transform:GetChild(idx)

			cell._mainGo = mainGo
			cell._txtPower = goutil.findChildTextComponent(mainGo, "info/txtPower")
			cell._imgLevel = goutil.findChild(mainGo, "info/imgLevel")
			cell._txtLevel = goutil.findChildTextComponent(mainGo, "info/txtLevel")
			cell._txtname = goutil.findChildTextComponent(mainGo, "info/txtname")
			cell._btnFight = goutil.findChild(mainGo, "btnFight")
			cell._tip = goutil.findChild(mainGo, "tip")
			cell._root = goutil.findChild(self._modelCam, "posList/pos_" .. idx + 1)
			cell._btnRole = goutil.findChild(mainGo, "btnRole")
			cell._redPoint = goutil.findChild(mainGo, "btnFight/redPoint")
		end
	end

	for roleIdx = 1, #self._roleCellList do
		local cell = self._roleCellList[roleIdx]
		local info = self._roleInfoList[roleIdx]

		if cell._txtPower and info.power then
			cell._txtPower.text = info.power
		end

		if info.rankScore then
			local levelData = PeakTournamentConfig.instance:getPtQuaLevelDataByScore(self._activityId, info.rankScore)

			if levelData then
				if cell._imgLevel then
					cell._imgLevel:GetComponent(ComponentType.UIImageSpriteChange):SetState(levelData.quaLevelId - 1)
				end

				if cell._txtLevel then
					cell._txtLevel.text = levelData.levelName
				end
			end
		end

		cell._txtname.text = PeakTournamentController.instance:getFormatUserName(info.userName, info.areaId)

		if info.gender and info.clothes then
			self:_showAvatar(cell._root, info.gender, info.clothes)
		end

		if roleIdx == 2 then
			GameUtil.SetActive(cell._btnFight, PeakTournamentController.instance:isCanStartChallengeAsQua(self._activityId))
			GameUtil.SetActive(cell._tip, not GameUtil.GetActive(cell._btnFight))
			GameUtil.SetActive(cell._btnRole, true)

			local remainDailyFightTimes = PeakTournamentController.instance:getRemainDailyFightTimesAsQua(self._activityId)

			GameUtil.SetActive(cell._redPoint, false)
			RedPointController.instance:unregRedPoint(cell._redPoint)

			if remainDailyFightTimes > 0 then
				RedPointController.instance:regRedPoint(cell._redPoint, 406)
			end
		else
			GameUtil.SetActive(cell._btnFight, false)
			GameUtil.SetActive(cell._tip, false)
			GameUtil.SetActive(cell._btnRole, false)
		end

		GameUtil.addClickHandler(cell._btnFight, self._onClickRoleCellBtnFight, self)
		GameUtil.addClickHandler(cell._btnRole, self._onClickRoleCellBtnRole, self)
		GameUtil.addClickHandler(cell._imgLevel, self._onClickImgLevel, self)
	end
end

function PTQualifierMainView:_onClearRoleColUI()
	for _, cell in ipairs(self._roleCellList) do
		-- block empty
	end

	self._roleCellList = nil
end

function PTQualifierMainView:_onClickRoleCellBtnFight()
	local result, tips = PeakTournamentController.instance:getStartFightResultAndTipsAsQua(self._activityId)

	if not string.nilorempty(tips) then
		FloatWordMgr.instance:show(tips)
	end

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	PeakTournamentController.instance:enterBattleAsPT(self._activityId)
end

function PTQualifierMainView:_onClickRoleCellBtnRole()
	local playerInfo = PeakTournamentModel.instance:getOpPlayerInfoAsQua()
	local formList = {}

	for _, v in ipairs(playerInfo.forms) do
		formList[v.formId] = v
	end

	UIStateManager.instance:push(ViewName.PTLookOverFmtInQualifierView, self._activityId, formList)
end

function PTQualifierMainView:_showAvatar(parentGo, gender, clothes)
	local avatar = self:_getAvatar(parentGo)

	avatar:updateByMo(self:_getAvatarMo(gender, clothes))
	GameUtil.SetActive(parentGo, true)
end

function PTQualifierMainView:_hideAvatar(parentGo)
	GameUtil.SetActive(parentGo, false)
end

function PTQualifierMainView:_getAvatar(parentGo)
	if self._avatarPool == nil then
		self._avatarPool = {}
	end

	if self._avatarPool[parentGo] then
		return self._avatarPool[parentGo]
	end

	local avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	avatar.useType = AvatarUseType.Scene

	avatar:setParent(parentGo.transform)
	avatar:setLayer(SceneLayer.UI3D_Value)

	self._avatarPool[parentGo] = avatar

	return avatar
end

function PTQualifierMainView:_getAvatarMo(gender, clothes)
	return DressModel.instance:getAvatarMoByGrCosAndMount(gender, clothes, nil)
end

function PTQualifierMainView:_clearAvatarPool()
	if self._avatarPool then
		for _, avatar in pairs(self._avatarPool) do
			AvatarsMgrNew.instance:removeAvatar(avatar)
		end

		self._avatarPool = nil
	end
end

function PTQualifierMainView:_setAvatarCameraEnv(isOnEnter)
	if isOnEnter then
		goutil.addChildToParent(self._modelCam)
		LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	else
		goutil.addChildToParent(self._modelCam, self.mainGO)
		LightMgr.instance:setLightForNormalScene()
	end

	LightMgr.instance:setUseModelLight(isOnEnter)
	GlobalModel.instance:visibleSceneHUDs(not isOnEnter)
end

function PTQualifierMainView:_onClickBtnTip()
	local ruleKey = PeakTournamentConfig.instance:getPtCommonValue("PT_QUA_RULE") or ""

	TipsFacade.instance:openRulesView(ruleKey)
end

function PTQualifierMainView:_onClickBtnReport()
	UIStateManager.instance:push(ViewName.PTBattlefieldReportAsMyView)
end

function PTQualifierMainView:_onClickBtnForm()
	PeakTournamentController.instance:enterFormationAsPT(self._activityId, true)
end

function PTQualifierMainView:_onClickBtnExchange()
	local jumpToStr = PeakTournamentConfig.instance:getPtCommonValue("PT_JUMP_SHOP_KEY")

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function PTQualifierMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.PTQualifierRankView)
end

function PTQualifierMainView:_onClickBtnReward()
	UIStateManager.instance:push(ViewName.TabPTRewardDescriptionView)
end

function PTQualifierMainView:_onClickImgLevel()
	local ruleKey = PeakTournamentConfig.instance:getPtCommonValue("PT_QUA_RANK_RULE") or ""

	TipsFacade.instance:openRulesView(ruleKey)
end

function PTQualifierMainView:_onClickBtnBless()
	UIStateManager.instance:push(ViewName.BirthdaySportsWishesMainView)
end

function PTQualifierMainView:_onCLickBtnBanPet()
	UIStateManager.instance:push(ViewName.PTEliBanPetTipsView, self._activityId)
end

return PTQualifierMainView
