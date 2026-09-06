-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineaojiu/view/DivineAoJiuMainView.lua

module("logic.extensions.divineaojiu.view.DivineAoJiuMainView", package.seeall)

local DivineAoJiuMainView = class("DivineAoJiuMainView", ViewComponent)

function DivineAoJiuMainView:ctor()
	DivineAoJiuMainView.super.ctor(self)
end

function DivineAoJiuMainView:unbindEvents()
	DivineAoJiuMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnFirstRank)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnCard)
	GameUtil.rmClickHandler(self._btnPassport)
	GameUtil.rmClickHandler(self._btnExtChallenge)
	GameUtil.rmClickHandler(self._btnNormalChallenge)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function DivineAoJiuMainView:bindEvents()
	DivineAoJiuMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnFirstRank, self._onClickFirstRank, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnCard, self._onClickCard, self)
	GameUtil.addClickHandler(self._btnPassport, self._onClickPassport, self)
	GameUtil.addClickHandler(self._btnExtChallenge, self._onClickExtChallenge, self)
	GameUtil.addClickHandler(self._btnNormalChallenge, self._onClickNormalChallenge, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickInfo, self)
end

function DivineAoJiuMainView:buildUI()
	DivineAoJiuMainView.super.buildUI(self)

	self._btnFirstRank = self:getGo("btnFirstRank")
	self._btnRank = self:getGo("btnRank")
	self._btnPrize = self:getGo("btnPrize")
	self._btnCard = self:getGo("btnCard")
	self._btnPassport = self:getGo("btnPassport")
	self._btnExtChallenge = self:getGo("btnExtChallenge")
	self._extPass = self:getGo("btnExtChallenge/pass")
	self._petCon = self:getGo("petCon")
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnNormalChallenge = self:getGo("btnNormalChallenge")
	self._normalPass = self:getGo("btnNormalChallenge/pass")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._petCon = self:getGo("petCon")
	self._petRareCon = self:getGo("petInfo/name/imgRare")
	self._txtName = self:getTxt("petInfo/name/txtName")
	self._txtTime = self:getTxt("time/txtTime")
end

function DivineAoJiuMainView:onExit()
	DivineAoJiuMainView.super.onExit(self)
end

function DivineAoJiuMainView:onEnter()
	DivineAoJiuMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineAoJiuClgGetInfo, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 511001
	end

	self._activityCfg = DivineAoJiuConfig.instance:getActivityCfg(self._activityId)

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

	DivineAoJiuClgAgent.instance:sendPM_DivineAoJiuClgGetInfoReq(self._activityId)
end

function DivineAoJiuMainView:_refreshView()
	GameUtil.SetActive(self._extPass, DivineAoJiuModel.instance:getIsGainPassPrize(self._activityId))

	local passCount = DivineAoJiuModel.instance:getPassNormalStage(self._activityId)
	local stageCfgs = DivineAoJiuConfig.instance:getNormalStageCfgs(self._activityId)

	GameUtil.SetActive(self._normalPass, passCount >= #stageCfgs)
end

function DivineAoJiuMainView:_onClickTip()
	TipsFacade.instance:openRulesView("divine_ao_jiu_clg_rule")
end

function DivineAoJiuMainView:_onClickFirstRank()
	UltimateTrialController.instance:gotoFirstPassRankView(self._activityId)
end

function DivineAoJiuMainView:_onClickRank()
	if not string.nilorempty(self._activityCfg.jumpTo[1]) then
		GotoMgr.gotoByString(self._activityCfg.jumpTo[1])
	end
end

function DivineAoJiuMainView:_onClickCard()
	if not string.nilorempty(self._activityCfg.jumpTo[2]) then
		GotoMgr.gotoByString(self._activityCfg.jumpTo[2])
	end
end

function DivineAoJiuMainView:_onClickPrize()
	if not string.nilorempty(self._activityCfg.jumpTo[3]) then
		GotoMgr.gotoByString(self._activityCfg.jumpTo[3])
	end
end

function DivineAoJiuMainView:_onClickPassport()
	if not string.nilorempty(self._activityCfg.jumpTo[4]) then
		GotoMgr.gotoByString(self._activityCfg.jumpTo[4])
	end
end

function DivineAoJiuMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._activityCfg.raceId)
end

function DivineAoJiuMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._activityCfg.raceId)
end

function DivineAoJiuMainView:_onClickExtChallenge()
	UIStateManager.instance:push(ViewName.DivineAoJiuExtStageView, self._activityId)
end

function DivineAoJiuMainView:_onClickNormalChallenge()
	UIStateManager.instance:push(ViewName.DivineAoJiuNormalStageView, self._activityId)
end

return DivineAoJiuMainView
