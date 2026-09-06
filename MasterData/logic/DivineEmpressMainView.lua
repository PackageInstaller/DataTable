-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/view/DivineEmpressMainView.lua

module("logic.extensions.divineempress.view.DivineEmpressMainView", package.seeall)

local DivineEmpressMainView = class("DivineEmpressMainView", ViewComponent)

function DivineEmpressMainView:ctor()
	DivineEmpressMainView.super.ctor(self)
end

function DivineEmpressMainView:unbindEvents()
	DivineEmpressMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnFirstRank)
	GameUtil.rmClickHandler(self._btnNormal)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnCall)
	GameUtil.rmClickHandler(self._btnExChallenge)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function DivineEmpressMainView:bindEvents()
	DivineEmpressMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnFirstRank, self._onClickFirstRank, self)
	GameUtil.addClickHandler(self._btnNormal, self._onClickNormal, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnCall, self._onClickCall, self)
	GameUtil.addClickHandler(self._btnExChallenge, self._onClickExChallenge, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickInfo, self)
end

function DivineEmpressMainView:buildUI()
	DivineEmpressMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnRank = self:getGo("btnRank")
	self._btnFirstRank = self:getGo("btnFirstRank")
	self._btnNormal = self:getGo("btnNormal")
	self._normalRedPoint = self:getGo("btnNormal/redpoint")
	self._btnTip = self:getGo("btnTip")
	self._btnPrize = self:getGo("btnPrize")
	self._btnShop = self:getGo("btnShop")
	self._btnCall = self:getGo("btnCall")
	self._btnExChallenge = self:getGo("btnExChallenge")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._petCon = self:getGo("petCon")
	self._petRareCon = self:getGo("petInfo/name/imgRare")
	self._txtName = self:getTxt("petInfo/name/txtName")
	self._extraPass = self:getGo("btnExChallenge/pass")
	self._passPrize = self:getGo("passPrize")
	self._receivedExtra = self:getGo("passPrize/received")
	self._prizeCon = self:getGo("passPrize/con")
	self._normalPass = self:getGo("btnNormal/pass")
	self._txtTime = self:getTxt("time/txtTime")
end

function DivineEmpressMainView:onExit()
	DivineEmpressMainView.super.onExit(self)
	MaterialMgr.resetAll(self._petRareCon)
	MaterialMgr.resetAll(self._prizeCon)

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end
end

function DivineEmpressMainView:onEnter()
	DivineEmpressMainView.super.onEnter(self)
	self:addGEvent(GlobalNotify.PM_DivineEmpressGainProgreePrizeRes, self._refreshView)
	self:addGEvent(GlobalNotify.PM_Notify_DivineDualDragonClgChallengeRes, self._refreshView)
	self:addGEvent(GlobalNotify.DivineEmpressClgGetInfo, self._refreshView)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 485001
	end

	self._activityCfg = DivineEmpressConfig.instance:getActivityCfg(self._activityId)

	MaterialMgr.resetAll(self._petRareCon)
	MaterialMgr.setCell(MatType.Rare, self._activityCfg.raceId, self._petRareCon)

	local petCfg = CharacterConfig.instance:getPetCo(self._activityCfg.raceId)

	self._txtName.text = petCfg.name

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._activityCfg.raceId, self._petCon)

	MaterialMgr.setCellByCfg(self._activityCfg.extremeClgPrize, self._prizeCon)
	DivineEmpressChallengeAgent.instance:sendPM_DivineEmpressClgGetInfoReq(self._activityId)

	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	RedPointController.instance:regRedPoint(self._normalRedPoint, self._activityCfg.redPointId)
end

function DivineEmpressMainView:_refreshView()
	GameUtil.SetActive(self._extraPass, DivineEmpressModel.instance:isPassExtremeClg(self._activityId))
	GameUtil.SetActive(self._receivedExtra, DivineEmpressModel.instance:isPassExtremeClg(self._activityId))

	local prizeCfgs = DivineEmpressConfig.instance:getNormalPrizeCfgs(self._activityId)
	local isGainAll = true

	for i, v in ipairs(prizeCfgs) do
		if not DivineEmpressModel.instance:isNormalGainPrize(self._activityId, v.progressId) then
			isGainAll = false

			break
		end
	end

	GameUtil.SetActive(self._normalPass, isGainAll)
end

function DivineEmpressMainView:_onClickNormal()
	local prizeCfgs = DivineEmpressConfig.instance:getNormalPrizeCfgs(self._activityId)
	local isGainAll = true

	for i, v in ipairs(prizeCfgs) do
		if not DivineEmpressModel.instance:isNormalGainPrize(self._activityId, v.progressId) then
			isGainAll = false

			break
		end
	end

	if isGainAll == true then
		FloatWordMgr.instance:show(lang("已通关"))
	else
		UIStateManager.instance:push(ViewName.DivineEmpressNormalStageView, self._activityId)
	end
end

function DivineEmpressMainView:_onClickExChallenge()
	UIStateManager.instance:push(ViewName.DivineEmpressExtreStageView, self._activityId)
end

function DivineEmpressMainView:_onClickTip()
	TipsFacade.instance:openRulesView("divine_empress_clg_rule")
end

function DivineEmpressMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._activityCfg.raceId)
end

function DivineEmpressMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._activityCfg.raceId)
end

function DivineEmpressMainView:_onClickRank()
	if not string.nilorempty(self._activityCfg.jumpTo[1]) then
		GotoMgr.gotoByString(self._activityCfg.jumpTo[1])
	end
end

function DivineEmpressMainView:_onClickCall()
	if not string.nilorempty(self._activityCfg.jumpTo[2]) then
		GotoMgr.gotoByString(self._activityCfg.jumpTo[2])
	end
end

function DivineEmpressMainView:_onClickShop()
	if not string.nilorempty(self._activityCfg.jumpTo[3]) then
		GotoMgr.gotoByString(self._activityCfg.jumpTo[3])
	end
end

function DivineEmpressMainView:_onClickFirstRank()
	UltimateTrialController.instance:gotoFirstPassRankView(self._activityId)
end

function DivineEmpressMainView:_onClickPrize()
	if not string.nilorempty(self._activityCfg.jumpTo[4]) then
		GotoMgr.gotoByString(self._activityCfg.jumpTo[4])
	end
end

return DivineEmpressMainView
