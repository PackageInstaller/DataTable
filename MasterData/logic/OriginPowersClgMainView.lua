-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpowersclg/view/OriginPowersClgMainView.lua

module("logic.extensions.originpowersclg.view.OriginPowersClgMainView", package.seeall)

local OriginPowersClgMainView = class("OriginPowersClgMainView", ViewComponent)

function OriginPowersClgMainView:ctor()
	OriginPowersClgMainView.super.ctor(self)
end

function OriginPowersClgMainView:unbindEvents()
	OriginPowersClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnChallengeExtreme)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnFirstRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function OriginPowersClgMainView:bindEvents()
	OriginPowersClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnChallengeExtreme, self._onClickExtreme, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnFirstRank, self._onClickFirstRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
end

function OriginPowersClgMainView:buildUI()
	OriginPowersClgMainView.super.buildUI(self)

	self._btnChallengeExtreme = self:getGo("btnChallengeExtreme")
	self._extremePassGo = self:getGo("btnChallengeExtreme/pass")
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnRank = self:getGo("btnRank")
	self._btnPrize = self:getGo("btnPrize")
	self._btnFirstRank = self:getGo("btnFirstRank")
	self._btnShop = self:getGo("btnShop")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._petCon = self:getGo("petCon")
	self._petRareCon = self:getGo("petInfo/name/imgRare")
	self._txtName = self:getTxt("petInfo/name/txtName")
	self._txtTime = self:getTxt("time/txtTime")
end

function OriginPowersClgMainView:onExit()
	OriginPowersClgMainView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._roleObj)
	MaterialMgr.resetAll(self._petRareCon)
end

function OriginPowersClgMainView:onEnter()
	OriginPowersClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginPowersInfoRes, self._refreshView, self)

	self._activityId = 0

	if self._activityId == 0 then
		self._activityId = 576001
	end

	self._activityCfg = OriginPowersClgConfig.instance:getActivityCfg(self._activityId)

	MaterialMgr.resetAll(self._petRareCon)
	MaterialMgr.setCell(MatType.Rare, self._activityCfg.raceId, self._petRareCon)

	local petCfg = CharacterConfig.instance:getPetCo(self._activityCfg.raceId)

	self._txtName.text = petCfg.name

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._activityCfg.raceId, self._petCon)
	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	OriginPowersClgAgent.instance:sendPM_OriginPowersExtremeInfoReq(self._activityId)
end

function OriginPowersClgMainView:_refreshView()
	GameUtil.SetActive(self._extremePassGo, OriginPowersClgModel.instance:isGainExtremePrize(self._activityId))
end

function OriginPowersClgMainView:_onClickExtreme()
	UIStateManager.instance:push(ViewName.OriginPowersClgExtremeView, self._activityId)
end

function OriginPowersClgMainView:_onClickFirstRank()
	if not string.nilorempty(self._activityCfg.jumpToFirstRank) then
		GotoMgr.gotoByString(self._activityCfg.jumpToFirstRank)
	end
end

function OriginPowersClgMainView:_onClickRank()
	if not string.nilorempty(self._activityCfg.jumpToRank) then
		GotoMgr.gotoByString(self._activityCfg.jumpToRank)
	end
end

function OriginPowersClgMainView:_onClickPrize()
	if not string.nilorempty(self._activityCfg.jumpToPrize) then
		GotoMgr.gotoByString(self._activityCfg.jumpToPrize)
	end
end

function OriginPowersClgMainView:_onClickShop()
	if not string.nilorempty(self._activityCfg.jumpToShop) then
		GotoMgr.gotoByString(self._activityCfg.jumpToShop)
	end
end

function OriginPowersClgMainView:_onClickTip()
	TipsFacade.instance:openRulesView("origin_powers_clg_rule")
end

function OriginPowersClgMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._activityCfg.raceId)
end

function OriginPowersClgMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._activityCfg.raceId)
end

return OriginPowersClgMainView
