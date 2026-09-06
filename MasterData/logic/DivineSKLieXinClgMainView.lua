-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineskliexinclg/view/DivineSKLieXinClgMainView.lua

module("logic.extensions.divineskliexinclg.view.DivineSKLieXinClgMainView", package.seeall)

local DivineSKLieXinClgMainView = class("DivineSKLieXinClgMainView", ViewComponent)

function DivineSKLieXinClgMainView:ctor()
	DivineSKLieXinClgMainView.super.ctor(self)
end

function DivineSKLieXinClgMainView:unbindEvents()
	DivineSKLieXinClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnCall)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnFirstRank)
	GameUtil.rmClickHandler(self._btnMonthCard)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
end

function DivineSKLieXinClgMainView:bindEvents()
	DivineSKLieXinClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnCall, self._onClickCall, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnFirstRank, self._onClickFirstRank, self)
	GameUtil.addClickHandler(self._btnMonthCard, self._onClickMonthCard, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
end

function DivineSKLieXinClgMainView:buildUI()
	DivineSKLieXinClgMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnChallenge = self:getGo("btnChallenge")
	self._btnRank = self:getGo("btnRank")
	self._btnCall = self:getGo("btnCall")
	self._btnPrize = self:getGo("btnPrize")
	self._btnFirstRank = self:getGo("btnFirstRank")
	self._btnMonthCard = self:getGo("btnMonthCard")
	self._petCon = self:getGo("petCon")
	self._petRareCon = self:getGo("petInfo/name/imgRare")
	self._txtName = self:getTxt("petInfo/name/txtName")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
end

function DivineSKLieXinClgMainView:onExit()
	DivineSKLieXinClgMainView.super.onExit(self)
	MaterialMgr.resetAll(self._petRareCon)

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end
end

function DivineSKLieXinClgMainView:onEnter()
	DivineSKLieXinClgMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 478001
	end

	self._activityCfg = DivineSKLieXinClgConfig.instance:getActivityCfg(self._activityId)

	if DivineSKLieXinClgModel.instance:getTempActivity() ~= self._activityId then
		DivineSKLieXinClgModel.instance:resetAllTempTagPos()
		DivineSKLieXinClgModel.instance:saveTempSelectStage(nil)
		DivineSKLieXinClgModel.instance:saveTempActivity(self._activityId)
	end

	MaterialMgr.resetAll(self._petRareCon)
	MaterialMgr.setCell(MatType.Rare, self._activityCfg.raceId, self._petRareCon)

	local petCfg = CharacterConfig.instance:getPetCo(self._activityCfg.raceId)

	self._txtName.text = petCfg.name

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._activityCfg.raceId, self._petCon)

	GameUtil.SetActive(self._btnRank, self._activityCfg.jumpTo ~= nil)
	GameUtil.SetActive(self._btnCall, self._activityCfg.jumpTo ~= nil)
	GameUtil.SetActive(self._btnPrize, self._activityCfg.jumpTo ~= nil)

	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	DivineSKLieXinClgAgent.instance:sendPM_DivineSKLieXinClgGetInfoReq(self._activityId)
end

function DivineSKLieXinClgMainView:_onClickTip()
	TipsFacade.instance:openRulesView("divine_sk_liexin_clg_rule")
end

function DivineSKLieXinClgMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.DivineSKLieXinClgLevelView, self._activityId)
end

function DivineSKLieXinClgMainView:_onClickRank()
	if self._activityCfg.jumpTo then
		GotoMgr.gotoByString(self._activityCfg.jumpTo[1])
	end
end

function DivineSKLieXinClgMainView:_onClickCall()
	if self._activityCfg.jumpTo then
		GotoMgr.gotoByString(self._activityCfg.jumpTo[2])
	end
end

function DivineSKLieXinClgMainView:_onClickPrize()
	if self._activityCfg.jumpTo then
		GotoMgr.gotoByString(self._activityCfg.jumpTo[3])
	end
end

function DivineSKLieXinClgMainView:_onClickFirstRank()
	UltimateTrialController.instance:gotoFirstPassRankView(self._activityId)
end

function DivineSKLieXinClgMainView:_onClickMonthCard()
	if self._activityCfg.jumpTo then
		GotoMgr.gotoByString(self._activityCfg.jumpTo[4])
	end
end

function DivineSKLieXinClgMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._activityCfg.raceId)
end

function DivineSKLieXinClgMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._activityCfg.raceId)
end

function DivineSKLieXinClgMainView:_onClickClose()
	DivineSKLieXinClgModel.instance:resetAllTempTagPos()
	DivineSKLieXinClgModel.instance:saveTempSelectStage(nil)
	self:close()
end

return DivineSKLieXinClgMainView
