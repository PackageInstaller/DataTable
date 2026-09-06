-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddarkdragon/view/GodDarkDragonMainView.lua

module("logic.extensions.goddarkdragon.view.GodDarkDragonMainView", package.seeall)

local GodDarkDragonMainView = class("GodDarkDragonMainView", ViewComponent)

function GodDarkDragonMainView:ctor()
	GodDarkDragonMainView.super.ctor(self)
end

function GodDarkDragonMainView:unbindEvents()
	GodDarkDragonMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnCall)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function GodDarkDragonMainView:bindEvents()
	GodDarkDragonMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnCall, self._onClickCall, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickPetInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
end

function GodDarkDragonMainView:buildUI()
	GodDarkDragonMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnPrize = self:getBtn("btnPrize")
	self._btnCall = self:getBtn("btnCall")
	self._btnRank = self:getBtn("btnRank")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._txtTime = self:getTxt("time/txtTime")
	self._petCon = self:getGo("petCon")
	self._txtPetName = self:getTxt("petInfo/name/txtName")
	self._petRareCon = self:getGo("petInfo/name/imgRare")
	self._redPointChallenge = self:getGo("btnChallenge/redpoint")
end

function GodDarkDragonMainView:onExit()
	GodDarkDragonMainView.super.onExit(self)
	MaterialMgr.resetAll(self._petRareCon)
	RoleObjectPool.instance:removeRole(self._roleObj)
end

function GodDarkDragonMainView:onEnter()
	GodDarkDragonMainView.super.onEnter(self)

	self._actId = self:getFirstParam() or GodDarkDragonModel.instance:getCurrActId()
	self._actCfg = GodDarkDragonConfig.instance:getActivityCfg(self._actId)

	MaterialMgr.resetAll(self._petRareCon)
	MaterialMgr.setCell(MatType.Rare, self._actCfg.raceId, self._petRareCon)

	local petCfg = CharacterConfig.instance:getPetCo(self._actCfg.raceId)

	self._txtPetName.text = petCfg.name
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._actCfg.raceId, self._petCon)
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._actId)

	GodDarkDragonAgent.instance:sendPM_GodDarkDragonInfoReq(self._actId)
end

function GodDarkDragonMainView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "goddarkdragon_rule")
end

function GodDarkDragonMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.GodDarkDragonLevelView, self._actId)
end

function GodDarkDragonMainView:_onClickCall()
	GotoMgr.gotoByString(self._actCfg.jumpTo[1])
end

function GodDarkDragonMainView:_onClickPrize()
	GotoMgr.gotoByString(self._actCfg.jumpTo[2])
end

function GodDarkDragonMainView:_onClickRank()
	GotoMgr.gotoByString(self._actCfg.jumpTo[3])
end

function GodDarkDragonMainView:_onClickPetInfo()
	if checknumber(self._actCfg.raceId) > 0 then
		PetbookController.instance:openPetinfoView(self._actCfg.raceId)
	end
end

function GodDarkDragonMainView:_onClickSkill()
	if checknumber(self._actCfg.raceId) > 0 then
		PetbookController.instance:previewBattle(self._actCfg.raceId)
	end
end

return GodDarkDragonMainView
