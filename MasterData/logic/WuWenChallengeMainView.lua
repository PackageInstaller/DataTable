-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/view/WuWenChallengeMainView.lua

module("logic.extensions.wuwenchallenge.view.WuWenChallengeMainView", package.seeall)

local WuWenChallengeMainView = class("WuWenChallengeMainView", ViewComponent)

function WuWenChallengeMainView:ctor()
	WuWenChallengeMainView.super.ctor(self)
end

function WuWenChallengeMainView:unbindEvents()
	WuWenChallengeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnCall)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
end

function WuWenChallengeMainView:bindEvents()
	WuWenChallengeMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnCall, self._onClickCall, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
end

function WuWenChallengeMainView:buildUI()
	WuWenChallengeMainView.super.buildUI(self)

	self._btnChallenge = self:getGo("btnChallenge")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRank = self:getGo("btnRank")
	self._btnCall = self:getGo("btnCall")
	self._btnPrize = self:getGo("btnPrize")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnRule = self:getGo("btnRule")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._txtName = self:getTxt("petInfo/name/txtName")
	self._petRareCon = self:getGo("petInfo/name/imgRare")
	self._petCon = self:getGo("petCon")
end

function WuWenChallengeMainView:onExit()
	WuWenChallengeMainView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._roleObj)
end

function WuWenChallengeMainView:onEnter()
	WuWenChallengeMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = WuWenChallengeModel.instance:getCurrActId()
	end

	self._actCfg = WuWenChallengeConfig.instance:getActivityCfg(self._activityId)

	MaterialMgr.resetAll(self._petRareCon)
	MaterialMgr.setCell(MatType.Rare, self._actCfg.raceId, self._petRareCon)

	local petCfg = CharacterConfig.instance:getPetCo(self._actCfg.raceId)

	self._txtName.text = petCfg.name
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._actCfg.raceId, self._petCon)
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	WuWenClgAgent.instance:sendPM_WuWenClgGetInfoReq(self._activityId)
end

function WuWenChallengeMainView:_onClickRank()
	GotoMgr.gotoByString(self._actCfg.jumpTo[1])
end

function WuWenChallengeMainView:_onClickCall()
	GotoMgr.gotoByString(self._actCfg.jumpTo[2])
end

function WuWenChallengeMainView:_onClickPrize()
	GotoMgr.gotoByString(self._actCfg.jumpTo[3])
end

function WuWenChallengeMainView:_onClickRule()
	TipsFacade.instance:openRulesView("wu_wen_challenge_rule")
end

function WuWenChallengeMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._actCfg.raceId)
end

function WuWenChallengeMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._actCfg.raceId)
end

function WuWenChallengeMainView:_onClickChallenge()
	local levelCfgs = WuWenChallengeConfig.instance:getPhaseCfgs(self._activityId)

	if WuWenChallengeModel.instance:getCurLevel(self._activityId) > #levelCfgs then
		FloatWordMgr.instance:show(lang("您已通关"))

		return
	else
		UIStateManager.instance:push(ViewName.WuWenChallengeLevelView, self._activityId)
	end
end

return WuWenChallengeMainView
