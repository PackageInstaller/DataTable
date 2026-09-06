-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianchallenge/view/TunTianChallengeMainView.lua

module("logic.extensions.tuntianchallenge.view.TunTianChallengeMainView", package.seeall)

local TunTianChallengeMainView = class("TunTianChallengeMainView", ViewComponent)

function TunTianChallengeMainView:buildUI()
	TunTianChallengeMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txt")
	self._jumpButton = goutil.findChild(self.mainGO, "jumpButton")
	self._btnCultivate = goutil.findChild(self.mainGO, "jumpButton/btnCultivate")
	self._redBtnCultivate = goutil.findChild(self.mainGO, "jumpButton/btnCultivate/redPoint")
	self._btnRank = goutil.findChild(self.mainGO, "jumpButton/btnRank")
	self._redBtnRank = goutil.findChild(self.mainGO, "jumpButton/btnRank/redPoint")
	self._btnLottery = goutil.findChild(self.mainGO, "jumpButton/btnLottery")
	self._redBtnLottery = goutil.findChild(self.mainGO, "jumpButton/btnLottery/redPoint")
	self._challengeButtom = goutil.findChild(self.mainGO, "challengeButtom")
	self._btnChallenge1 = goutil.findChild(self.mainGO, "challengeButtom/btnChallenge1/btn")
	self._redBtnChallenge1 = goutil.findChild(self.mainGO, "challengeButtom/btnChallenge1/btn/redPoint")
	self._txtBtnChallenge1 = goutil.findChildTextComponent(self.mainGO, "challengeButtom/btnChallenge1/desc/txt")
	self._btnChallenge2 = goutil.findChild(self.mainGO, "challengeButtom/btnChallenge2/btn")
	self._redBtnChallenge2 = goutil.findChild(self.mainGO, "challengeButtom/btnChallenge2/btn/redPoint")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._con = goutil.findChild(self.mainGO, "con")
end

function TunTianChallengeMainView:bindEvents()
	TunTianChallengeMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnCultivate, GameUtil.handler(self._onClickBtnJump, self, "TUNTIAN_JUMP_PET_CULTIVATE"))
	GameUtil.addClickHandler(self._btnRank, GameUtil.handler(self._onClickBtnJump, self, "TUNTIAN_JUMP_PET_TOP_RANK"))
	GameUtil.addClickHandler(self._btnLottery, GameUtil.handler(self._onClickBtnJump, self, "TUNTIAN_JUMP_SHOP_KEY"))
	GameUtil.addClickHandler(self._btnChallenge1, self._onClickBtnChallenge1, self)
	GameUtil.addClickHandler(self._btnChallenge2, self._onClickBtnChallenge2, self)
end

function TunTianChallengeMainView:unbindEvents()
	TunTianChallengeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnCultivate)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnChallenge1)
	GameUtil.rmClickHandler(self._btnChallenge2)
end

function TunTianChallengeMainView:onEnter()
	TunTianChallengeMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = TunTianChallengeController.instance:getActivityId()
	end

	self._activityType = TunTianChallengeController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local isInTime = TunTianChallengeController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.TunTianClgGetInfoRes, self._onUpdate, self)
	TunTianChallengeController.instance:sendPM_TunTianClgGetInfoReq(self._activityId)
end

function TunTianChallengeMainView:onExit()
	TunTianChallengeMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TunTianClgGetInfoRes, self._onUpdate, self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	if self._bgEff then
		UIEffectManager.instance:stopEffect(self._bgEff)

		self._bgEff = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	RedPointController.instance:unregRedPoint(self._redBtnRank)
	RedPointController.instance:unregRedPoint(self._redBtnChallenge1)
	RedPointController.instance:unregRedPoint(self._redBtnChallenge2)
end

function TunTianChallengeMainView:_onSetUI()
	GameUtil.SetActive(self._jumpButton, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._btnChallenge1, not self._isAoqiGodProcessType)

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())

	local startStamp, endStamp = 0, 0

	if self._activityId > 0 then
		startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	local redIdRank = TunTianChallengeConfig.instance:getTtClientCommonValue(self._activityId, "TUNTIAN_PET_TOP_RANK_RED", false)

	RedPointController.instance:regRedPoint(self._redBtnRank, redIdRank)

	if self._redBtnChallenge1 then
		local redId = RedPointModel.ID_TUNTIAN_CHALLENGE_NORMAL

		RedPointController.instance:regRedPoint(self._redBtnChallenge1, redId)
	end

	if self._redBtnChallenge2 then
		local redId = RedPointModel.ID_TUNTIAN_CHALLENGE_EXTREME

		RedPointController.instance:regRedPoint(self._redBtnChallenge2, redId)
	end

	local effParent = self.mainGO
	local pathName = TunTianChallengeConfig.instance:getTtClientCommonValue(self._activityId, "TUNTIAN_MAIN_VIEW_BG_EFF", false)

	UIEffectManager.instance:stopEffect(self._bgEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._bgEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function TunTianChallengeMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TunTianChallengeMainView:_onUpdateData()
	return
end

function TunTianChallengeMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
end

function TunTianChallengeMainView:_onUpdatePlaneUI()
	return
end

function TunTianChallengeMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function TunTianChallengeMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function TunTianChallengeMainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function TunTianChallengeMainView:_getSkinId()
	return TunTianChallengeConfig.instance:getTtClientCommonValue(self._activityId, "TUNTIAN_PET_SKINID", true)
end

function TunTianChallengeMainView:_onClickBtnJump(key)
	if self._isAoqiGodProcessType then
		return
	end

	local jumpToStr = TunTianChallengeConfig.instance:getTtClientCommonValue(self._activityId, key)

	GotoMgr.gotoByString(jumpToStr)
end

function TunTianChallengeMainView:_onClickBtnChallenge1()
	if self._isAoqiGodProcessType then
		return
	end

	UIStateManager.instance:push(ViewName.TunTianChallengeNormalView, self._activityId)
end

function TunTianChallengeMainView:_onClickBtnChallenge2()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	UIStateManager.instance:push(ViewName.TunTianChallengeExtremeView, self._activityId)
end

function TunTianChallengeMainView:_onClickBtnTip()
	local key = TunTianChallengeConfig.instance:getTtClientCommonValue(self._activityId, "TUNTIAN_MAIN_RULE_KEY", false)

	TipsFacade.instance:openRulesView(key)
end

return TunTianChallengeMainView
