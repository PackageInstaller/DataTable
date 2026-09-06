-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/view/QiChallengeMainView.lua

module("logic.extensions.qichallenge.view.QiChallengeMainView", package.seeall)

local QiChallengeMainView = class("QiChallengeMainView", ViewComponent)

function QiChallengeMainView:buildUI()
	QiChallengeMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._txtTime = self:getTxt("time/txt")
	self._btnDailyChallenge = self:getBtn("btnDailyChallenge")
	self._redPointDailyChallenge = self:getGo("btnDailyChallenge/redpoint")
	self._btnHardChallenge = self:getBtn("btnHardChallenge")
	self._redPointHardChallenge = self:getGo("btnHardChallenge/redpoint")
	self._btnGift = self:getBtn("btnGift")
	self._btnExchange = self:getBtn("btnExchange")
	self._btnCall = self:getBtn("btnCall")
	self._btnRank = self:getBtn("btnRank")
	self._btnPetSkill = self:getBtn("petInfo/btnSkill")
	self._btnPetIntroduce = self:getBtn("petInfo/btnIntroduce")
	self._rareCon = self:getGo("petInfo/pointRare")
	self._txtPetInfo = self:getTxt("petInfo/txtName")
	self._con = self:getGo("con")
end

function QiChallengeMainView:bindEvents()
	QiChallengeMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnDailyChallenge, self._onClickDailyChallenge, self)
	GameUtil.addClickHandler(self._btnHardChallenge, self._onClickHardChallenge, self)
	GameUtil.addClickHandler(self._btnGift, self._onClickGift, self)
	GameUtil.addClickHandler(self._btnExchange, self._onClickExchange, self)
	GameUtil.addClickHandler(self._btnCall, self._onClickCall, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnPetSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnPetIntroduce, self._onClickIntroduce, self)
end

function QiChallengeMainView:unbindEvents()
	QiChallengeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnDailyChallenge)
	GameUtil.rmClickHandler(self._btnHardChallenge)
	GameUtil.rmClickHandler(self._btnGift)
	GameUtil.rmClickHandler(self._btnExchange)
	GameUtil.rmClickHandler(self._btnCall)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPetSkill)
	GameUtil.rmClickHandler(self._btnPetIntroduce)
end

function QiChallengeMainView:onEnter()
	QiChallengeMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 244001
	end

	if not self._activityId then
		FloatWordMgr.instance:show(lang("未到活动时间"))
		self:close()

		return
	end

	self._activityCfg = QiChallengeConfig.instance:getActivityCfg(self._activityId)

	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_QICHALLENGE_ENTER)

	local cfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.QI_CHALLENGE, self._activityId)

	self._endTime = GameUtil.string2time(cfg.endTime)

	RoleObjectPool.instance:addRoleToParent(self._raceCon, self._activityCfg.raceId, self._con)
	MaterialMgr.setCell(MatType.Rare, self._activityCfg.raceId, self._rareCon)
	GameUtil.SetActive(self._redPointDailyChallenge, false)
	GameUtil.SetActive(self._redPointHardChallenge, false)

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function QiChallengeMainView:onExit()
	QiChallengeMainView.super.onExit(self)

	if self._raceCon then
		RoleObjectPool.instance:removeRole(self._raceCon)
	end

	MaterialMgr.resetAll(self._rareCon)
end

function QiChallengeMainView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, self._activityCfg.ruleKey)
end

function QiChallengeMainView:_onClickDailyChallenge()
	UIStateManager.instance:push(ViewName.QiChallengeDailyLevelView, self._activityId)
end

function QiChallengeMainView:_onClickHardChallenge()
	UIStateManager.instance:push(ViewName.QiChallengeHardLevelView, self._activityId)
end

function QiChallengeMainView:_onClickGift()
	if not string.nilorempty(self._activityCfg.funcId[1]) then
		GotoMgr.gotoByString(self._activityCfg.funcId[1])
	end
end

function QiChallengeMainView:_onClickExchange()
	if not string.nilorempty(self._activityCfg.funcId[2]) then
		GotoMgr.gotoByString(self._activityCfg.funcId[2])
	end
end

function QiChallengeMainView:_onClickCall()
	if not string.nilorempty(self._activityCfg.funcId[3]) then
		GotoMgr.gotoByString(self._activityCfg.funcId[3])
	end
end

function QiChallengeMainView:_onClickRank()
	if not string.nilorempty(self._activityCfg.funcId[4]) then
		GotoMgr.gotoByString(self._activityCfg.funcId[4])
	end
end

function QiChallengeMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._activityCfg.raceId)
end

function QiChallengeMainView:_onClickIntroduce()
	PetbookController.instance:openPetinfoView(self._activityCfg.raceId)
end

function QiChallengeMainView:_onClockTime()
	if checknumber(self._endTime) > 0 then
		self._txtTime.text = langPara("剩余时间：%s", GameUtil.FormatTimeWordsNoSec(self._endTime - ServerTime.now()))
	else
		removetimer(self._onClockTime, self)
	end
end

return QiChallengeMainView
