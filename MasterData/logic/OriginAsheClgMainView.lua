-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originasheclg/view/OriginAsheClgMainView.lua

module("logic.extensions.originasheclg.view.OriginAsheClgMainView", package.seeall)

local OriginAsheClgMainView = class("OriginAsheClgMainView", ViewComponent)

function OriginAsheClgMainView:ctor()
	OriginAsheClgMainView.super.ctor(self)
end

function OriginAsheClgMainView:unbindEvents()
	OriginAsheClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnFirstRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function OriginAsheClgMainView:bindEvents()
	OriginAsheClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnFirstRank, self._onClickFirstRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
end

function OriginAsheClgMainView:buildUI()
	OriginAsheClgMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnRank = self:getGo("btnRank")
	self._btnPrize = self:getGo("btnPrize")
	self._btnFirstRank = self:getGo("btnFirstRank")
	self._btnShop = self:getGo("btnShop")
	self._btnChallenge = self:getGo("btnChallenge")
	self._passGo = self:getGo("btnChallenge/pass")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._petCon = self:getGo("petCon")
	self._petRareCon = self:getGo("petInfo/name/imgRare")
	self._txtName = self:getTxt("petInfo/name/txtName")
	self._txtTime = self:getTxt("time/txtTime")
end

function OriginAsheClgMainView:onExit()
	OriginAsheClgMainView.super.onExit(self)
end

function OriginAsheClgMainView:onEnter()
	OriginAsheClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_OriginAsheClgGetInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 533001
	end

	self._activityCfg = OriginAsheClgConfig.instance:getActivityCfg(self._activityId)

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

	OriginAsheClgAgent.instance:sendPM_OriginAsheClgGetInfoReq(self._activityId)
end

function OriginAsheClgMainView:_refreshView()
	local list = OriginAsheClgConfig.instance:getStageCfgs(self._activityId)

	self._maxPassStage = OriginAsheClgModel.instance:getMaxPassStage(self._activityId)

	GameUtil.SetActive(self._passGo, self._maxPassStage >= #list)
end

function OriginAsheClgMainView:_onClickFirstRank()
	if not string.nilorempty(self._activityCfg.jumpToFirstRank) then
		GotoMgr.gotoByString(self._activityCfg.jumpToFirstRank)
	end
end

function OriginAsheClgMainView:_onClickRank()
	if not string.nilorempty(self._activityCfg.jumpToRank) then
		GotoMgr.gotoByString(self._activityCfg.jumpToRank)
	end
end

function OriginAsheClgMainView:_onClickPrize()
	if not string.nilorempty(self._activityCfg.jumpToPrize) then
		GotoMgr.gotoByString(self._activityCfg.jumpToPrize)
	end
end

function OriginAsheClgMainView:_onClickShop()
	if not string.nilorempty(self._activityCfg.jumpToShop) then
		GotoMgr.gotoByString(self._activityCfg.jumpToShop)
	end
end

function OriginAsheClgMainView:_onClickTip()
	TipsFacade.instance:openRulesView("origin_ashe_clg_rule")
end

function OriginAsheClgMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._activityCfg.raceId)
end

function OriginAsheClgMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._activityCfg.raceId)
end

function OriginAsheClgMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.OriginAsheClgLevelView, self._activityId)
end

return OriginAsheClgMainView
