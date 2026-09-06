-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shizudragonclg/view/ShiZuDragonClgMainView.lua

module("logic.extensions.shizudragonclg.view.ShiZuDragonClgMainView", package.seeall)

local ShiZuDragonClgMainView = class("ShiZuDragonClgMainView", ViewComponent)

function ShiZuDragonClgMainView:ctor()
	ShiZuDragonClgMainView.super.ctor(self)
end

function ShiZuDragonClgMainView:unbindEvents()
	ShiZuDragonClgMainView.super.unbindEvents(self)
end

function ShiZuDragonClgMainView:bindEvents()
	ShiZuDragonClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnCard, self._onClickCard, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnFirstRank, self._onClickFirstRank, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
end

function ShiZuDragonClgMainView:buildUI()
	ShiZuDragonClgMainView.super.buildUI(self)

	self._btnCard = self:getGo("btnCard")
	self._btnRank = self:getGo("btnRank")
	self._btnPrize = self:getGo("btnPrize")
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnFirstRank = self:getGo("btnFirstRank")
	self._btnChallenge = self:getGo("btnChallenge")
	self._pass = self:getGo("btnChallenge/pass")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._petCon = self:getGo("petCon")
	self._petRareCon = self:getGo("petInfo/name/imgRare")
	self._txtName = self:getTxt("petInfo/name/txtName")
	self._txtTime = self:getTxt("time/txtTime")
end

function ShiZuDragonClgMainView:onExit()
	ShiZuDragonClgMainView.super.onExit(self)
end

function ShiZuDragonClgMainView:onEnter()
	ShiZuDragonClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ShiZuDragonClgGetInfo, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 500001
	end

	self._activityCfg = ShiZuDragonClgConfig.instance:getActivityCfg(self._activityId)

	MaterialMgr.resetAll(self._petRareCon)
	MaterialMgr.setCell(MatType.Rare, self._activityCfg.raceId, self._petRareCon)

	local petCfg = CharacterConfig.instance:getPetCo(self._activityCfg.raceId)

	self._txtName.text = petCfg.name

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._activityCfg.raceId, self._petCon)

	ShiZuDragonClgAgent.instance:sendPM_ShiZuDragonClgInfoReq(self._activityId)

	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
end

function ShiZuDragonClgMainView:_refreshView()
	local phaseCfgs = ShiZuDragonClgConfig.instance:getPhaseCfgs(self._activityId)

	GameUtil.SetActive(self._pass, ShiZuDragonClgModel.instance:getBestPhaseId(self._activityId) >= #phaseCfgs)
end

function ShiZuDragonClgMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._activityCfg.raceId)
end

function ShiZuDragonClgMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._activityCfg.raceId)
end

function ShiZuDragonClgMainView:_onClickFirstRank()
	if not string.nilorempty(self._activityCfg.jumpToFirstRank) then
		GotoMgr.gotoByString(self._activityCfg.jumpToFirstRank)
	end
end

function ShiZuDragonClgMainView:_onClickPrize()
	if not string.nilorempty(self._activityCfg.jumpToPrize) then
		GotoMgr.gotoByString(self._activityCfg.jumpToPrize)
	end
end

function ShiZuDragonClgMainView:_onClickRank()
	if not string.nilorempty(self._activityCfg.jumpToRank) then
		GotoMgr.gotoByString(self._activityCfg.jumpToRank)
	end
end

function ShiZuDragonClgMainView:_onClickCard()
	if not string.nilorempty(self._activityCfg.jumpToCard) then
		GotoMgr.gotoByString(self._activityCfg.jumpToCard)
	end
end

function ShiZuDragonClgMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.ShiZuDragonClgStageView, self._activityId)
end

function ShiZuDragonClgMainView:_onClickTip()
	TipsFacade.instance:openRulesView("shi_zu_dragon_clg_rule")
end

return ShiZuDragonClgMainView
