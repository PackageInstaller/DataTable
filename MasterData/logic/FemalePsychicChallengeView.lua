-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalepsychic/view/FemalePsychicChallengeView.lua

module("logic.extensions.femalepsychic.view.FemalePsychicChallengeView", package.seeall)

local FemalePsychicChallengeView = class("FemalePsychicChallengeView", ViewComponent)

function FemalePsychicChallengeView:ctor()
	FemalePsychicChallengeView.super.ctor(self)
end

function FemalePsychicChallengeView:unbindEvents()
	FemalePsychicChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnLottery)
end

function FemalePsychicChallengeView:bindEvents()
	FemalePsychicChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickJumpShop, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickJumpRank, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickJumpLottery, self)
end

function FemalePsychicChallengeView:buildUI()
	FemalePsychicChallengeView.super.buildUI(self)

	self._con = self:getGo("con")
	self._rare = self:getGo("petInfo/rare")
	self._zdl = self:getGo("zdl/imgRecZdl"):GetComponent(typeof(UIImgNumeralText))
	self._txtTime = self:getTxt("time/txtTime")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnEnter = self:getBtn("btnEnter")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnShop = self:getBtn("jumpButton/btnShop")
	self._btnRank = self:getBtn("jumpButton/btnRank")
	self._btnLottery = self:getBtn("jumpButton/btnLottery")
end

function FemalePsychicChallengeView:onExit()
	FemalePsychicChallengeView.super.onExit(self)
	MaterialMgr.resetAll(self._rare)
	RoleObjectPool.instance:removeRole(self._loader)
end

function FemalePsychicChallengeView:onEnter()
	FemalePsychicChallengeView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.FemalePsychicChallenge)
	end

	self._activityCfg = FemalePsychicChallengeConfig.instance:getActivityCfgById(self._activityId)

	self._zdl:SetNum(self._activityCfg.recZdl)
	self:_showPetInfo()
	self:_setTimeUI()
end

function FemalePsychicChallengeView:_setTimeUI()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.FemalePsychicChallenge, self._activityId)
	local startDate, endDate = GameUtil.time2date(startTime), GameUtil.time2date(endTime)

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function FemalePsychicChallengeView:_showPetInfo()
	self._raceId = 16014

	MaterialMgr.setCell(MatType.Rare, self._raceId, self._rare)

	local x, y, scale = 0, 0, 1

	self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, self._raceId, self._con, scale, nil, true, x, y)
end

function FemalePsychicChallengeView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function FemalePsychicChallengeView:_onClickSkill()
	PetbookController.instance:previewBattle(self._raceId, self._raceId)
end

function FemalePsychicChallengeView:_onClickTip()
	TipsFacade.instance:openRulesView("femalepsychicchallengelview")
end

function FemalePsychicChallengeView:_onClickEnter()
	UIStateManager.instance:push(ViewName.FemalePsychicLevelView)
end

function FemalePsychicChallengeView:_onClickJumpShop()
	GotoMgr.gotoByString(self._activityCfg.jumpToShop)
end

function FemalePsychicChallengeView:_onClickJumpRank()
	GotoMgr.gotoByString(self._activityCfg.jumpToRank)
end

function FemalePsychicChallengeView:_onClickJumpLottery()
	GotoMgr.gotoByString(self._activityCfg.jumpToLottery)
end

return FemalePsychicChallengeView
