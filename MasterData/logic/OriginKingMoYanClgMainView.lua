-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmoyanclg/view/OriginKingMoYanClgMainView.lua

module("logic.extensions.originkingmoyanclg.view.OriginKingMoYanClgMainView", package.seeall)

local OriginKingMoYanClgMainView = class("OriginKingMoYanClgMainView", ViewComponent)

function OriginKingMoYanClgMainView:ctor()
	OriginKingMoYanClgMainView.super.ctor(self)
end

function OriginKingMoYanClgMainView:unbindEvents()
	OriginKingMoYanClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnFirstRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function OriginKingMoYanClgMainView:bindEvents()
	OriginKingMoYanClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnFirstRank, self._onClickFirstRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
end

function OriginKingMoYanClgMainView:buildUI()
	OriginKingMoYanClgMainView.super.buildUI(self)

	self._btnChallenge = self:getGo("btnChallenge")
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

function OriginKingMoYanClgMainView:onExit()
	OriginKingMoYanClgMainView.super.onExit(self)
end

function OriginKingMoYanClgMainView:onEnter()
	OriginKingMoYanClgMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 559001
	end

	self._activityCfg = OriginKingMoYanClgConfig.instance:getActivityCfg(self._activityId)

	MaterialMgr.resetAll(self._petRareCon)
	MaterialMgr.setCell(MatType.Rare, self._activityCfg.raceId, self._petRareCon)

	local petCfg = CharacterConfig.instance:getPetCo(self._activityCfg.raceId)

	self._txtName.text = petCfg.name

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._activityCfg.raceId, self._petCon)

	OriginKingMoYanClgAgent.instance:sendPM_OriginKingMoYanClgGetInfoReq(self._activityId)

	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
end

function OriginKingMoYanClgMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.OriginKingMoYanClgLevelView, self._activityId)
end

function OriginKingMoYanClgMainView:_onClickFirstRank()
	if not string.nilorempty(self._activityCfg.jumpToFirstRank) then
		GotoMgr.gotoByString(self._activityCfg.jumpToFirstRank)
	end
end

function OriginKingMoYanClgMainView:_onClickRank()
	if not string.nilorempty(self._activityCfg.jumpToRank) then
		GotoMgr.gotoByString(self._activityCfg.jumpToRank)
	end
end

function OriginKingMoYanClgMainView:_onClickPrize()
	if not string.nilorempty(self._activityCfg.jumpToPrize) then
		GotoMgr.gotoByString(self._activityCfg.jumpToPrize)
	end
end

function OriginKingMoYanClgMainView:_onClickShop()
	if not string.nilorempty(self._activityCfg.jumpToShop) then
		GotoMgr.gotoByString(self._activityCfg.jumpToShop)
	end
end

function OriginKingMoYanClgMainView:_onClickTip()
	TipsFacade.instance:openRulesView("origin_king_mo_yan_clg_rule")
end

function OriginKingMoYanClgMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._activityCfg.raceId)
end

function OriginKingMoYanClgMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._activityCfg.raceId)
end

return OriginKingMoYanClgMainView
