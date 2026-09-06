-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingshikongllongzun/view/DivineKingShiKongLongZunMainView.lua

module("logic.extensions.divinekingshikongllongzun.view.DivineKingShiKongLongZunMainView", package.seeall)

local DivineKingShiKongLongZunMainView = class("DivineKingShiKongLongZunMainView", ViewComponent)

function DivineKingShiKongLongZunMainView:ctor()
	DivineKingShiKongLongZunMainView.super.ctor(self)
end

function DivineKingShiKongLongZunMainView:unbindEvents()
	DivineKingShiKongLongZunMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function DivineKingShiKongLongZunMainView:bindEvents()
	DivineKingShiKongLongZunMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnInfo, self._onBtnIntroduceClg, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, 4))
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
end

function DivineKingShiKongLongZunMainView:buildUI()
	DivineKingShiKongLongZunMainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._con = self:getGo("con")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._btnChallenge = self:getGo("btnNorClg/btn")
	self._firstPass = self:getGo("btnNorClg/firstPass")
end

function DivineKingShiKongLongZunMainView:onExit()
	DivineKingShiKongLongZunMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
end

function DivineKingShiKongLongZunMainView:onEnter()
	DivineKingShiKongLongZunMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineKingSpaceDragonInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_DivineKingSpaceDragonResetFloorRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 521001
	end

	self._actCfg = DivineKingShiKongLongZunConfig.instance:getActCfg(self._activityId)

	self:_onSetUI()
	DivineKingShiKongLongZunController.instance:sendPM_DivineKingSpaceDragonInfoReq(self._activityId)
end

function DivineKingShiKongLongZunMainView:_onSetUI()
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

function DivineKingShiKongLongZunMainView:_onUpdate()
	self._info = DivineKingShiKongLongZunModel.instance:getInfo(self._activityId)

	local isFirstPass = DivineKingShiKongLongZunModel.instance:hasFirstPass(self._activityId)

	GameUtil.SetActive(self._firstPass, isFirstPass)
end

function DivineKingShiKongLongZunMainView:_onClickBtnChallenge()
	UIStateManager.instance:push(ViewName.DivineKingShiKongLongZunChallengeView, self._activityId)
end

function DivineKingShiKongLongZunMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DivineKingShiKongLongZunMainView:_onBtnSkillClg()
	local skinId = self._actCfg.skinId

	PetbookController.instance:previewBattle(skinId)
end

function DivineKingShiKongLongZunMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self._actCfg.skinId)
end

function DivineKingShiKongLongZunMainView:_onClickBtnJump(jumpIdx)
	if jumpIdx == 4 then
		UltimateTrialController.instance:gotoFirstPassRankView(self._activityId)
	else
		local jumpStr = string.format("jumpTo%d", jumpIdx)
		local btnStr = self._actCfg[jumpStr]

		GotoMgr.gotoByString(btnStr)
	end
end

return DivineKingShiKongLongZunMainView
