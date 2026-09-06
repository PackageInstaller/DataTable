-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/DivineSaintKnightFireGod/view/DivinesaintknightfiregodmainView.lua

module("logic.extensions.DivineSaintKnightFireGod.view.DivinesaintknightfiregodmainView", package.seeall)

local DivinesaintknightfiregodmainView = class("DivinesaintknightfiregodmainView", ViewComponent)

function DivinesaintknightfiregodmainView:buildUI()
	DivinesaintknightfiregodmainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
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
	self._jumpBtnCol_btnJump4 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump4")
	self._btnClg = self:getBtn("btnClg")
	self._passGo = self:getGo("btnClg/passGo")
	self._btnBuff = self:getBtn("btnBuff")
	self._buffText = self:getTxt("btnBuff/txtBuff")
	self._buffRed = self:getGo("btnBuff/redPoint")
end

function DivinesaintknightfiregodmainView:bindEvents()
	DivinesaintknightfiregodmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStr1"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStr2"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStr3"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStr4"))
	self._btnClg:AddClickListener(self._onClickbtnClg, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
end

function DivinesaintknightfiregodmainView:unbindEvents()
	DivinesaintknightfiregodmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump4)
	self._btnClg:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnBuff)
end

function DivinesaintknightfiregodmainView:onEnter()
	DivinesaintknightfiregodmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineSaintKnightFireGodInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.SignInBuffGetInfo, self._updateBuffUI, self)
	self.addGEvent(self, GlobalNotify.SignInBuffUpgradeSignIn, self._updateBuffUI, self)
	self:_initActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开放")
		self:close()

		return
	end

	self._actCfg = DivineSaintKnightFireGodConfig.instance:getActCfg(self._activityId)
	self._buffActId = self._activityId == 480001 and 1 or self._activityId
	self._params = GameUtil.jsonToTable(self._actCfg.paramStr)

	self:_updateStaticUI()
	DivineSaintKnightFireGodAgent.instance:sendPM_DivineSaintKnightFireGodInfoReq(self._activityId)
	SignInBuffController.instance:getInfo(self._buffActId)
end

function DivinesaintknightfiregodmainView:onExit()
	DivinesaintknightfiregodmainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
end

function DivinesaintknightfiregodmainView:_updateStaticUI()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())
end

function DivinesaintknightfiregodmainView:_updateUI()
	local isAllPass = DivineSaintKnightFireGodController.instance:isClgPass(self._activityId)

	goutil.setActive(self._passGo, isAllPass)
end

function DivinesaintknightfiregodmainView:_onClickBtnSkill()
	local skinId = self:_getSkinId()

	PetbookController.instance:previewBattleWithSkinId(skinId)
end

function DivinesaintknightfiregodmainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivinesaintknightfiregodmainView:_onClickbtnClg()
	if DivineSaintKnightFireGodController.instance:isClgPass(self._activityId) then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.DivinesaintknightfiregodstageView, self._activityId)
end

function DivinesaintknightfiregodmainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function DivinesaintknightfiregodmainView:_getSkinId()
	return DivineSaintKnightFireGodConfig.instance:getSkinId(self._activityId)
end

function DivinesaintknightfiregodmainView:_onClickBtnJump(key)
	local jumpToStr = self._params[key]

	GotoMgr.gotoByString(jumpToStr)
end

function DivinesaintknightfiregodmainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("syshengqiyansen_rule")
end

function DivinesaintknightfiregodmainView:_initActivityId()
	self._activityType = GameEnum.ActivityType.DivineSaintKnightFireGod
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(self._activityType)
	end
end

function DivinesaintknightfiregodmainView:_onClickBuff()
	local info = SignInBuffModel.instance:getBaseInfo(self._buffActId)

	if not info then
		return
	end

	local hasSignInToday = info.hasSignInToday

	if hasSignInToday then
		FloatWordMgr.instance:show("今日加成已生效")

		return
	end

	SignInBuffController.instance:upgradeSignInBuff(self._buffActId)
end

function DivinesaintknightfiregodmainView:_updateBuffUI()
	local info = SignInBuffModel.instance:getBaseInfo(self._buffActId)

	if not info then
		return
	end

	local signInDays = info.signInDays
	local hasSignInToday = info.hasSignInToday
	local buffPlanId = SignInBuffConfig.instance:getBuffPlanId(self._buffActId)
	local buffCfg = SignInBuffConfig.instance:getBuffCfgByDay(buffPlanId, signInDays)

	self._buffText.text = buffCfg == nil and "未获得加成" or buffCfg.des

	self._buffRed:SetActive(not hasSignInToday)
end

return DivinesaintknightfiregodmainView
