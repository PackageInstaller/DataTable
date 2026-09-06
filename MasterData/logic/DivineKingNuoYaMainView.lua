-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingnuoya/view/DivineKingNuoYaMainView.lua

module("logic.extensions.divinekingnuoya.view.DivineKingNuoYaMainView", package.seeall)

local DivineKingNuoYaMainView = class("DivineKingNuoYaMainView", ViewComponent)

function DivineKingNuoYaMainView:ctor()
	DivineKingNuoYaMainView.super.ctor(self)
end

function DivineKingNuoYaMainView:bindEvents()
	DivineKingNuoYaMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnInfo, self._onBtnIntroduceClg, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onBtnChallenge, self)
end

function DivineKingNuoYaMainView:unbindEvents()
	DivineKingNuoYaMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
end

function DivineKingNuoYaMainView:buildUI()
	DivineKingNuoYaMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._con = self:getGo("con")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._btnChallenge = self:getGo("btnExtClg/btn")
end

function DivineKingNuoYaMainView:onExit()
	DivineKingNuoYaMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
end

function DivineKingNuoYaMainView:onEnter()
	DivineKingNuoYaMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 471001
	end

	self._activityType = 471
	self._actCfg = DivineKingNuoYaConfig.instance:getActCfg(self._activityId)

	self:_onSetUI()
	DivineKingNuoYaController.instance:sendPM_DivineKingNoahClgGetInfoReq(self._activityId)
end

function DivineKingNuoYaMainView:_onSetUI()
	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local skinId = self._actCfg.skinId

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self._actCfg.skinId)
end

function DivineKingNuoYaMainView:_onClickBtnJump(jumpIdx)
	local btnStr = self._actCfg.jumpTo[jumpIdx]

	GotoMgr.gotoByString(btnStr)
end

function DivineKingNuoYaMainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self._actCfg.skinId)
end

function DivineKingNuoYaMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DivineKingNuoYaMainView:_onBtnSkillClg()
	local raceId = self:_getRaceId()
	local skinId = self._actCfg.skinId

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DivineKingNuoYaMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivineKingNuoYaMainView:_onBtnChallenge()
	UIStateManager.instance:push(ViewName.DivineKingNuoYaChallengeView, self._activityId)
end

return DivineKingNuoYaMainView
