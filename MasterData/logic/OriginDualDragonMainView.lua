-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindualdragon/view/OriginDualDragonMainView.lua

module("logic.extensions.origindualdragon.view.OriginDualDragonMainView", package.seeall)

local OriginDualDragonMainView = class("OriginDualDragonMainView", ViewComponent)

function OriginDualDragonMainView:ctor()
	OriginDualDragonMainView.super.ctor(self)
end

function OriginDualDragonMainView:unbindEvents()
	OriginDualDragonMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnBuy)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnPack)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function OriginDualDragonMainView:bindEvents()
	OriginDualDragonMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnPack, self._onClickPack, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function OriginDualDragonMainView:buildUI()
	OriginDualDragonMainView.super.buildUI(self)

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
	self._btnBuy = self:getGo("jumpBtnCol/btnBuy")
	self._btnShop = self:getGo("jumpBtnCol/btnShop")
	self._btnPack = self:getGo("jumpBtnCol/btnPack")
end

function OriginDualDragonMainView:onExit()
	OriginDualDragonMainView.super.onExit(self)

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
end

function OriginDualDragonMainView:onEnter()
	OriginDualDragonMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 618001
	end

	self._actCfg = OriginDualDragonConfig.instance:getActivity(self._activityId) or {}
	self._raceId = checknumber(self._actCfg.raceId)

	self.addGEvent(self, GlobalNotify.PM_OriginDualDragonInfoRes, self._refreshUI, self)
	self.addGEvent(self, GlobalNotify.PM_OriginDualDragonNotifyChallengeRes, self._refreshUI, self)
	self:_initUI()
	OriginDualDragonController.instance:sendInfoReq(self._activityId)
end

function OriginDualDragonMainView:_initUI()
	self:_initTime()
	self:_initPetInfo()
	self:_refreshUI()
end

function OriginDualDragonMainView:_initTime()
	if self._txtTime then
		self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end
end

function OriginDualDragonMainView:_initPetInfo()
	if self._raceId <= 0 then
		return
	end

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

function OriginDualDragonMainView:_refreshUI()
	local prize = self._actCfg.prize

	if self._showConBubble and not GameUtil.isEmptyString(prize) then
		MaterialMgr.setCellByCfg(prize, self._showConBubble)
	end

	GameUtil.SetActive(self._bubble, not GameUtil.isEmptyString(prize))
	GameUtil.SetActive(self._passBubble, OriginDualDragonController.instance:hasGainPrize(self._activityId))
end

function OriginDualDragonMainView:_onClickTip()
	local key = self._actCfg.ruleKeyMain

	if GameUtil.isEmptyString(key) then
		return
	end

	TipsFacade.instance:openRulesView(key)
end

function OriginDualDragonMainView:_onClickInfo()
	if self._raceId <= 0 then
		return
	end

	PetbookController.instance:openPetinfoView(self._raceId)
end

function OriginDualDragonMainView:_onClickSkill()
	if self._raceId <= 0 then
		return
	end

	PetbookController.instance:previewBattle(self._raceId)
end

function OriginDualDragonMainView:_onClickRank()
	local jumpToStr = self._actCfg.jumpToRank

	if not GameUtil.isEmptyString(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function OriginDualDragonMainView:_onClickBuy()
	local jumpToStr = self._actCfg.jumpToPrize

	if not GameUtil.isEmptyString(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function OriginDualDragonMainView:_onClickShop()
	local jumpToStr = self._actCfg.jumpToShop

	if not GameUtil.isEmptyString(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function OriginDualDragonMainView:_onClickPack()
	local jumpToStr = self._actCfg.jumpToPack

	if not GameUtil.isEmptyString(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function OriginDualDragonMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.OriginDualDragonStageView, self._activityId)
end

return OriginDualDragonMainView
