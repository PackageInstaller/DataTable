-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originholychallenge/view/OriginHolyChallengeMainView.lua

module("logic.extensions.originholychallenge.view.OriginHolyChallengeMainView", package.seeall)

local OriginHolyChallengeMainView = class("OriginHolyChallengeMainView", ViewComponent)

function OriginHolyChallengeMainView:ctor()
	OriginHolyChallengeMainView.super.ctor(self)
end

function OriginHolyChallengeMainView:unbindEvents()
	OriginHolyChallengeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnBuy)
	GameUtil.rmClickHandler(self._btnPack)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function OriginHolyChallengeMainView:bindEvents()
	OriginHolyChallengeMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
	GameUtil.addClickHandler(self._btnPack, self._onClickPack, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function OriginHolyChallengeMainView:buildUI()
	OriginHolyChallengeMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnChallenge = self:getGo("btnChallenge")
	self._bubble = self:getGo("bubble")
	self._showConBubble = self:getGo("bubble/showCon")
	self._passBubble = self:getGo("bubble/pass")
	self._petCon = self:getGo("con")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._rare = self:getGo("petInfo/rare")
	self._txtName = self:getTxt("petInfo/txtName")
	self._txtTime = self:getTxt("time/txt")
	self._btnRank = self:getGo("jumpBtnCol/btnRank")
	self._btnShop = self:getGo("jumpBtnCol/btnShop")
	self._btnBuy = self:getGo("jumpBtnCol/btnBuy")
	self._btnPack = self:getGo("jumpBtnCol/btnPack")
	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._redBuff = self:getGo("buffCol/cell/redPoint")
	self._goPass = self:getGo("btnChallenge/goPass")
end

function OriginHolyChallengeMainView:onExit()
	OriginHolyChallengeMainView.super.onExit(self)

	if self._rare then
		MaterialMgr.resetAll(self._rare)
	end

	if self._showConBubble then
		MaterialMgr.resetAll(self._showConBubble)
	end

	if self._role then
		RoleObjectPool.instance:removeRole(self._role)

		self._role = nil
	end

	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function OriginHolyChallengeMainView:onEnter()
	OriginHolyChallengeMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 608001
	end

	self._actCfg = OriginHolyChallengeConfig.instance:getActivity(self._activityId)
	self._raceId = self._actCfg.raceId

	self.addGEvent(self, GlobalNotify.PM_Notify_OriginHolyChallengeChallengeResultRes, self._refreshPassState, self)
	self.addGEvent(self, GlobalNotify.PM_OriginHolyChallengeGetInfoRes, self._refreshPassState, self)
	self:_initUI()
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
	OriginHolyChallengeController.instance:sendInfoReq(self._activityId)
end

function OriginHolyChallengeMainView:_initUI()
	self:_initTime()
	self:_initPetInfo()
	self:_initBubble()
	self:_refreshPassState()
end

function OriginHolyChallengeMainView:_initTime()
	if self._txtTime then
		self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end
end

function OriginHolyChallengeMainView:_initPetInfo()
	local petData = CharacterConfig.instance:getPetCo(self._raceId)

	if petData and self._txtName then
		self._txtName.text = petData.name
	end

	if self._petCon then
		self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._raceId, self._petCon, nil, nil, true, nil, nil)
	end

	if self._rare and self._raceId > 0 then
		MaterialMgr.resetAll(self._rare)
		MaterialMgr.setCell(MatType.Rare, self._raceId, self._rare)
	end
end

function OriginHolyChallengeMainView:_initBubble()
	local prize = self._actCfg.prize

	if self._showConBubble and not GameUtil.isEmptyString(prize) then
		MaterialMgr.setCellByCfg(prize, self._showConBubble)
	end

	GameUtil.SetActive(self._bubble, not GameUtil.isEmptyString(prize))
	self:_refreshBubble()
end

function OriginHolyChallengeMainView:_refreshBubble()
	GameUtil.SetActive(self._passBubble, OriginHolyChallengeController.instance:isAllStagePassed(self._activityId))
end

function OriginHolyChallengeMainView:_refreshPassState()
	local isAllPassed = OriginHolyChallengeController.instance:isAllStagePassed(self._activityId)

	GameUtil.SetActive(self._goPass, isAllPassed)
	self:_refreshBubble()
end

function OriginHolyChallengeMainView:_onClickTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function OriginHolyChallengeMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function OriginHolyChallengeMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._raceId)
end

function OriginHolyChallengeMainView:_onClickChallenge()
	if OriginHolyChallengeController.instance:isAllStagePassed(self._activityId) then
		FloatWordMgr.instance:show(lang("已通关"))

		return
	end

	UIStateManager.instance:push(ViewName.OriginHolyChallengeStageView, self._activityId)
end

function OriginHolyChallengeMainView:_onClickRank()
	GotoMgr.gotoByString(self._actCfg.jumpToRank)
end

function OriginHolyChallengeMainView:_onClickShop()
	GotoMgr.gotoByString(self._actCfg.jumpToShop)
end

function OriginHolyChallengeMainView:_onClickBuy()
	GotoMgr.gotoByString(self._actCfg.jumpToPrize)
end

function OriginHolyChallengeMainView:_onClickPack()
	GotoMgr.gotoByString(self._actCfg.jumpToPack)
end

function OriginHolyChallengeMainView:_updateBuffUI(param)
	GameUtil.SetActive(self._redBuff, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or lang("点击激活Buff")
	end
end

return OriginHolyChallengeMainView
