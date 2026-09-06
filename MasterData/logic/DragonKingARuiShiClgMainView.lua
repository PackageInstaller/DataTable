-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishiclg/view/DragonKingARuiShiClgMainView.lua

module("logic.extensions.dragonkingaruishiclg.view.DragonKingARuiShiClgMainView", package.seeall)

local DragonKingARuiShiClgMainView = class("DragonKingARuiShiClgMainView", ViewComponent)

function DragonKingARuiShiClgMainView:ctor()
	DragonKingARuiShiClgMainView.super.ctor(self)
end

function DragonKingARuiShiClgMainView:unbindEvents()
	DragonKingARuiShiClgMainView.super.unbindEvents(self)
end

function DragonKingARuiShiClgMainView:bindEvents()
	DragonKingARuiShiClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnCall, self._onClickCall, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSKill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
end

function DragonKingARuiShiClgMainView:buildUI()
	DragonKingARuiShiClgMainView.super.buildUI(self)

	self._btnChallenge = self:getGo("btnChallenge")
	self._btnRank = self:getGo("btnRank")
	self._btnCall = self:getGo("btnCall")
	self._btnPrize = self:getGo("btnPrize")
	self._petInfo = self:getGo("petInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._txtPetName = self:getTxt("petInfo/name/txtName")
	self._petCon = self:getGo("petCon")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("btnRule")
	self._txtTime = self:getTxt("time/txtTime")
	self._petRace = self:getGo("petInfo/name/imgRare")
	self._petCon = self:getGo("petCon")
end

function DragonKingARuiShiClgMainView:onExit()
	DragonKingARuiShiClgMainView.super.onExit(self)
	MaterialMgr.resetAll(self._petRace)
	RoleObjectPool.instance:removeRole(self._roleObj)
end

function DragonKingARuiShiClgMainView:onEnter()
	DragonKingARuiShiClgMainView.super.onEnter(self)

	self._activityId = self:getFirstParam() or DragonKingARuiShiClgModel.instance:getCurrActId()
	self._actCfg = DragonKingARuiShiClgConfig.instance:getActivityCfg(self._activityId)

	DragonKingARuiShiClgAgent.instance:sendPM_DragonKingARuiShiClgInfoReq(self._activityId)
	MaterialMgr.resetAll(self._petRace)
	MaterialMgr.setCell(MatType.Rare, self._actCfg.raceId, self._petRace)

	local petCfg = CharacterConfig.instance:getPetCo(self._actCfg.raceId)

	self._txtPetName.text = petCfg.name
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._actCfg.raceId, self._petCon)
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function DragonKingARuiShiClgMainView:_onClickChallenge()
	local cfgs = DragonKingARuiShiClgConfig.instance:getStageCfgs(self._activityId)

	if DragonKingARuiShiClgModel.instance:getPassStage(self._activityId) >= #cfgs then
		FloatWordMgr.instance:show(lang("已通过全部关卡"))
	else
		UIStateManager.instance:push(ViewName.DragonKingARuiShiClgLevelView, self._activityId)
	end
end

function DragonKingARuiShiClgMainView:_onClickRank()
	GotoMgr.gotoByString(self._actCfg.jumpTo[1])
end

function DragonKingARuiShiClgMainView:_onClickCall()
	GotoMgr.gotoByString(self._actCfg.jumpTo[2])
end

function DragonKingARuiShiClgMainView:_onClickPrize()
	GotoMgr.gotoByString(self._actCfg.jumpTo[3])
end

function DragonKingARuiShiClgMainView:_onClickSKill()
	if checknumber(self._actCfg.raceId) > 0 then
		PetbookController.instance:previewBattle(self._actCfg.raceId)
	end
end

function DragonKingARuiShiClgMainView:_onClickInfo()
	if checknumber(self._actCfg.raceId) > 0 then
		PetbookController.instance:openPetinfoView(self._actCfg.raceId)
	end
end

function DragonKingARuiShiClgMainView:_onClickRule()
	TipsFacade.instance:openRulesView("dragon_king_aruishi_rule")
end

return DragonKingARuiShiClgMainView
