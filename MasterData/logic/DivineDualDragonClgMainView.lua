-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedualdragonclg/view/DivineDualDragonClgMainView.lua

module("logic.extensions.divinedualdragonclg.view.DivineDualDragonClgMainView", package.seeall)

local DivineDualDragonClgMainView = class("DivineDualDragonClgMainView", ViewComponent)

function DivineDualDragonClgMainView:ctor()
	DivineDualDragonClgMainView.super.ctor(self)
end

function DivineDualDragonClgMainView:unbindEvents()
	DivineDualDragonClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnCall)
	GameUtil.rmClickHandler(self._btnPrize)
end

function DivineDualDragonClgMainView:bindEvents()
	DivineDualDragonClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnCall, self._onClickCall, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
end

function DivineDualDragonClgMainView:buildUI()
	DivineDualDragonClgMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnChallenge = self:getGo("btnChallenge")
	self._btnRank = self:getGo("btnRank")
	self._btnCall = self:getGo("btnCall")
	self._btnPrize = self:getGo("btnPrize")
	self._petCon = self:getGo("petCon")
	self._petRareCon = self:getGo("petInfo/name/imgRare")
	self._txtName = self:getTxt("petInfo/name/txtName")
	self._time = self:getGo("time")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
end

function DivineDualDragonClgMainView:onExit()
	DivineDualDragonClgMainView.super.onExit(self)
	MaterialMgr.resetAll(self._petRareCon)

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end
end

function DivineDualDragonClgMainView:onEnter()
	DivineDualDragonClgMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 469001
	end

	self._activityCfg = DivineDualDragonClgConfig.instance:getActivityCfg(self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	MaterialMgr.resetAll(self._petRareCon)
	MaterialMgr.setCell(MatType.Rare, self._activityCfg.raceId, self._petRareCon)

	local petCfg = CharacterConfig.instance:getPetCo(self._activityCfg.raceId)

	self._txtName.text = petCfg.name

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._activityCfg.raceId, self._petCon)

	DivineDualDragonClgAgent.instance:sendPM_DivineDualDragonClgGetInfoReq(self._activityId)
	self:_initAoqiGodUI()

	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.DivineDualDragonClg, self._activityId)
end

function DivineDualDragonClgMainView:_initAoqiGodUI()
	GameUtil.SetActive(self._time, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._btnRank, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._btnCall, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._btnPrize, not self._isAoqiGodProcessType)
end

function DivineDualDragonClgMainView:_onClickTip()
	TipsFacade.instance:openRulesView("divine_dual_dragon_clg_rule")
end

function DivineDualDragonClgMainView:_onClickChallenge()
	local isPassAllStage = DivineDualDragonClgController.instance:isPassAllStage(self._activityId)

	if self._isAoqiGodProcessType and isPassAllStage then
		AoqiGodController.instance:doHandleChallengeFinishReady(DivineDualDragonClgController.instance:getActivityType(), self._activityId)
	end

	if isPassAllStage == true then
		FloatWordMgr.instance:show(lang("已通关所有关卡"))

		return
	end

	if not self:_checkPassAoqiGodProcessResult() then
		return
	end

	UIStateManager.instance:push(ViewName.DivineDualDragonClgLevelView, self._activityId)
end

function DivineDualDragonClgMainView:_checkPassAoqiGodProcessResult()
	if not self._isAoqiGodProcessType then
		return true
	end

	local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, DivineDualDragonClgController.instance:getActivityType(), self._activityId)

	return result == GameEnum.ResultCode.Success
end

function DivineDualDragonClgMainView:_onClickRank()
	if self._activityCfg.jumpTo[1] then
		GotoMgr.gotoByString(self._activityCfg.jumpTo[1])
	end
end

function DivineDualDragonClgMainView:_onClickPrize()
	if self._activityCfg.jumpTo[2] then
		GotoMgr.gotoByString(self._activityCfg.jumpTo[2])
	end
end

function DivineDualDragonClgMainView:_onClickCall()
	if self._activityCfg.jumpTo[3] then
		GotoMgr.gotoByString(self._activityCfg.jumpTo[3])
	end
end

function DivineDualDragonClgMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._activityCfg.raceId)
end

function DivineDualDragonClgMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._activityCfg.raceId)
end

return DivineDualDragonClgMainView
