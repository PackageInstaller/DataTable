-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originxiuer/view/OriginXiuErMainView.lua

module("logic.extensions.originxiuer.view.OriginXiuErMainView", package.seeall)

local OriginXiuErMainView = class("OriginXiuErMainView", ViewComponent)

function OriginXiuErMainView:ctor()
	OriginXiuErMainView.super.ctor(self)
end

function OriginXiuErMainView:unbindEvents()
	OriginXiuErMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnBuff)
end

function OriginXiuErMainView:bindEvents()
	OriginXiuErMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onBtnIntroduceClg, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, 4))
	GameUtil.addClickHandler(self._btnChallenge, self._onBtnChallenge, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
end

function OriginXiuErMainView:buildUI()
	OriginXiuErMainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._con = self:getGo("con")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._btnChallenge = self:getGo("btnNorClg/btn")
	self._btnBuff = self:getBtn("btnBuff")
	self._buffText = self:getTxt("btnBuff/txtBuff")
	self._buffRed = self:getGo("btnBuff/redPoint")
end

function OriginXiuErMainView:onExit()
	OriginXiuErMainView.super.onExit(self)
end

function OriginXiuErMainView:onEnter()
	OriginXiuErMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SignInBuffGetInfo, self._updateBuffUI, self)
	self.addGEvent(self, GlobalNotify.SignInBuffUpgradeSignIn, self._updateBuffUI, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 537001
	end

	self._actCfg = OriginXiuErConfig.instance:getActCfg(self._activityId)

	self:_onSetUI()
	OriginXiuErController.instance:sendPM_OriginXiuErInfoReq(self._activityId)
	SignInBuffController.instance:getInfo(self._activityId)
end

function OriginXiuErMainView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	local skinId = self._actCfg.skinId
	local petName
	local petData = CharacterConfig.instance:getPetCo(skinId)

	if petData then
		self._txtPetNameInInfo.text = petData.name
	end

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end
end

function OriginXiuErMainView:_updateBuffUI()
	local info = SignInBuffModel.instance:getBaseInfo(self._activityId)

	if not info then
		return
	end

	local signInDays = info.signInDays
	local hasSignInToday = info.hasSignInToday
	local buffPlanId = SignInBuffConfig.instance:getBuffPlanId(self._activityId)
	local buffCfg = SignInBuffConfig.instance:getBuffCfgByDay(buffPlanId, signInDays)

	self._buffText.text = buffCfg == nil and "未获得加成" or buffCfg.des

	self._buffRed:SetActive(not hasSignInToday)
end

function OriginXiuErMainView:_onClickBtnJump(jumpIdx)
	local jumpStr = self._actCfg.jumpTo[jumpIdx]

	GotoMgr.gotoByString(jumpStr)
end

function OriginXiuErMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function OriginXiuErMainView:_onBtnSkillClg()
	local skinId = self._actCfg.skinId

	PetbookController.instance:previewBattle(skinId)
end

function OriginXiuErMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self._actCfg.skinId)
end

function OriginXiuErMainView:_onBtnChallenge()
	UIStateManager.instance:push(ViewName.OriginXiuErLevelView, self._activityId)
end

function OriginXiuErMainView:_onClickBuff()
	local info = SignInBuffModel.instance:getBaseInfo(self._activityId)

	if not info then
		return
	end

	local hasSignInToday = info.hasSignInToday

	if hasSignInToday then
		FloatWordMgr.instance:show("今日加成已生效")

		return
	end

	SignInBuffController.instance:upgradeSignInBuff(self._activityId)
end

return OriginXiuErMainView
