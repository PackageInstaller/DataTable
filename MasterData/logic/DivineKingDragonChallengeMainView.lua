-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingdragonchallenge/view/DivineKingDragonChallengeMainView.lua

module("logic.extensions.divinekingdragonchallenge.view.DivineKingDragonChallengeMainView", package.seeall)

local DivineKingDragonChallengeMainView = class("DivineKingDragonChallengeMainView", ViewComponent)

function DivineKingDragonChallengeMainView:buildUI()
	DivineKingDragonChallengeMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._openTimeGo = goutil.findChild(self.mainGO, "txtOpenTime")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._jumpBtnCol_btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._jumpBtnCol_btnJump1_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._jumpBtnCol_btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._jumpBtnCol_btnJump2_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._jumpBtnCol_btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._jumpBtnCol_btnJump3_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._clgBtnCol = goutil.findChild(self.mainGO, "clgBtnCol")
	self._clgBtnCol_btnClg1 = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1")
	self._clgBtnCol_btnClg1_btn = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn")
	self._clgBtnCol_btnClg1_redPoint = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn/redPoint")
	self._clgBtnCol_btnClg1_bubble_itemcell = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble/itemcell")
	self._clgBtnCol_btnClg1_bubble_txt = goutil.findChildTextComponent(self.mainGO, "clgBtnCol/btnClg1/bubble/txt")
end

function DivineKingDragonChallengeMainView:bindEvents()
	DivineKingDragonChallengeMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._clgBtnCol_btnClg1_btn, self._onClickBtnClg1, self)
end

function DivineKingDragonChallengeMainView:unbindEvents()
	DivineKingDragonChallengeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._clgBtnCol_btnClg1_btn)
end

function DivineKingDragonChallengeMainView:onEnter()
	DivineKingDragonChallengeMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = DivineKingDragonChallengeController.instance:getActivityId()
	end

	self._activityType = DivineKingDragonChallengeController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local isInTime = DivineKingDragonChallengeController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = DivineKingDragonChallengeConfig.instance:getDkdActData(self._activityId)

	self:_onSetUI()
	DivineKingDragonChallengeController.instance:sendPM_DivineKingDragonGetInfoReq(self._activityId)
end

function DivineKingDragonChallengeMainView:onExit()
	DivineKingDragonChallengeMainView.super.onExit(self)
	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._clgBtnCol_btnClg1_bubble_itemcell)
	RedPointController.instance:unregRedPoint(self._jumpBtnCol_btnJump1_redPoint)
	RedPointController.instance:unregRedPoint(self._jumpBtnCol_btnJump2_redPoint)
	RedPointController.instance:unregRedPoint(self._jumpBtnCol_btnJump3_redPoint)
	RedPointController.instance:unregRedPoint(self._clgBtnCol_btnClg1_redPoint)
end

function DivineKingDragonChallengeMainView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	end

	local redId = DivineKingDragonChallengeConfig.instance:getDkdCommonValue(self._activityId, "jumpRedIdOne")

	if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
		RedPointController.instance:regRedPoint(self._jumpBtnCol_btnJump1_redPoint, redId)
	end

	local redId = DivineKingDragonChallengeConfig.instance:getDkdCommonValue(self._activityId, "jumpRedIdTwo")

	if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
		RedPointController.instance:regRedPoint(self._jumpBtnCol_btnJump2_redPoint, redId)
	end

	local redId = DivineKingDragonChallengeConfig.instance:getDkdCommonValue(self._activityId, "jumpRedIdThree")

	if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
		RedPointController.instance:regRedPoint(self._jumpBtnCol_btnJump3_redPoint, redId)
	end

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())

	GameUtil.SetActive(self._jumpBtnCol, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._openTimeGo, not self._isAoqiGodProcessType)
end

function DivineKingDragonChallengeMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DivineKingDragonChallengeMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivineKingDragonChallengeMainView:_getRaceId()
	return DivineKingDragonChallengeController.instance:getRaceId(self._activityId)
end

function DivineKingDragonChallengeMainView:_getSkinId()
	return DivineKingDragonChallengeController.instance:getSkinId(self._activityId)
end

function DivineKingDragonChallengeMainView:_onClickBtnJump(key)
	local jumpToStr = DivineKingDragonChallengeConfig.instance:getDkdCommonValue(self._activityId, key)

	GotoMgr.gotoByString(jumpToStr)
end

function DivineKingDragonChallengeMainView:_onClickBtnClg1()
	if self._isAoqiGodProcessType then
		local pass = DivineKingDragonChallengeController.instance:hasPassChallenge(self._activityId)

		if pass then
			AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.DragonVeinNuoYaClg, self._activityId)
		end
	end

	UIStateManager.instance:push(ViewName.DivineKingDragonChallengeStageView, self._activityId)
end

function DivineKingDragonChallengeMainView:_onClickBtnTip()
	local key = DivineKingDragonChallengeConfig.instance:getDkdCommonValue(self._activityId, "GODKINGDRAGONCHALLENGE_RULE_MAIN_KEY", false)

	TipsFacade.instance:openRulesView(key)
end

return DivineKingDragonChallengeMainView
