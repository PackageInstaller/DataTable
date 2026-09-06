-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialBossView.lua

module("logic.extensions.goddesstrial.view.GoddessTrialBossView", package.seeall)

local GoddessTrialBossView = class("GoddessTrialBossView", ViewComponent)

function GoddessTrialBossView:ctor()
	GoddessTrialBossView.super.ctor(self)
end

function GoddessTrialBossView:unbindEvents()
	GoddessTrialBossView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnPractice)
	GameUtil.rmClickHandler(self._btnPrize)
end

function GoddessTrialBossView:bindEvents()
	GoddessTrialBossView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnPractice, self._onClickPractice, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
end

function GoddessTrialBossView:buildUI()
	GoddessTrialBossView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnChallenge = self:getGo("btnChallenge")
	self._btnPractice = self:getGo("btnPractice")
	self._btnPrize = self:getGo("btnPrize")
	self._redPointPrize = self:getGo("btnPrize/redpoint")
	self._weekTablecell = self:getGo("weekTableview/weekTablecell")
	self._weekTableview = self:getGo("weekTableview")
	self._weekTableList = ScrollerList.create(self._weekTableview, self._weekTablecell, GameUtil.handler(self._updateWeekCell, self), GameUtil.handler(self._clearWeekCell, self))
	self._scoreTablecell = self:getGo("scoreTableview/scoreTablecell")
	self._scoreTableview = self:getGo("scoreTableview")
	self._scoreTableList = ScrollerList.create(self._scoreTableview, self._scoreTablecell, GameUtil.handler(self._updateScoreCell, self), GameUtil.handler(self._clearScoreCell, self))
	self._petCon = self:getGo("petCon")
	self._txtRule = self:getTxt("rule/txtRule")
	self._txtMaxDamage = self:getTxt("maxDamage/txtMaxDamage")
	self._txtTime = self:getTxt("btnChallenge/challengeTime/txtTime")
end

function GoddessTrialBossView:onExit()
	GoddessTrialBossView.super.onExit(self)

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	RedPointController.instance:unregRedPoint(self._redPointPrize)
end

function GoddessTrialBossView:onEnter()
	GoddessTrialBossView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_GoddessTrialGetInfoRes, self._refreshView, self)

	self._activityId = self:getFirstParam()
	self._activityCfg = GoddessTrialConfig.instance:getActivityCfg(self._activityId)
	self._stepId = GoddessTrialController.instance:getCurStepId(self._activityId)

	RedPointController.instance:regRedPoint(self._redPointPrize, self._activityCfg.redPointId)
	self:_refreshView()
end

function GoddessTrialBossView:_refreshView()
	local stepCfg = GoddessTrialConfig.instance:getStepCfg(self._activityId, self._stepId)
	local bossCfg = GoddessTrialConfig.instance:getBossCfg(stepCfg.bossId)
	local stepCfgs = GoddessTrialConfig.instance:getStepCfgs(self._activityId)

	self._weekTableList:reloadData(stepCfgs)

	local damagePlanCfg = GoddessTrialConfig.instance:getBossDamagePlanCfg(bossCfg.damageScorePlanId)
	local scoreList = {}

	for i = 1, #damagePlanCfg do
		if damagePlanCfg[i + 1] then
			table.insert(scoreList, {
				min = damagePlanCfg[i].damage,
				max = damagePlanCfg[i + 1].damage,
				score = damagePlanCfg[i].score
			})
		else
			table.insert(scoreList, {
				min = damagePlanCfg[i].damage,
				score = damagePlanCfg[i].score
			})
		end
	end

	self._scoreTableList:reloadData(scoreList)

	local petCfg = CharacterConfig.instance:getPetCo(bossCfg.raceId)

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, bossCfg.raceId, self._petCon)

	local teamCfg = GoddessTrialConfig.instance:getTeamCfg(bossCfg.creepsMasterId)

	self._txtRule.text = teamCfg.ruleDesc

	local fightTime = GoddessTrialModel.instance:getTodayFightBossTimes(self._activityId)
	local activityCfg = GoddessTrialConfig.instance:getActivityCfg(self._activityId)
	local curBattleTime = math.max(activityCfg.dailyBossTimes - fightTime, 0)

	self._txtTime.text = langPara("挑战次数：%d/%d", curBattleTime, activityCfg.dailyBossTimes)
	self._txtMaxDamage.text = langPara("今日最高伤害：%s", GoddessTrialModel.instance:getTodayFightBossDamage(self._activityId))
end

function GoddessTrialBossView:_updateWeekCell(view, cell, data, tag)
	local go = cell.gameObject
	local selectGo = goutil.findChild(go, "select")
	local curGo = goutil.findChild(go, "cur")
	local endGo = goutil.findChild(go, "end")
	local openGo = goutil.findChild(go, "openTime")
	local txtTime = goutil.findChildTextComponent(openGo, "txtOpen")
	local con = goutil.findChild(go, "con")
	local startTime = GameUtil.string2time(data.startTime)
	local endTime = GameUtil.string2time(data.endTime)
	local isOpen = startTime < ServerTime.now() and endTime > ServerTime.now()
	local openDate = GameUtil.string2date(data.startTime)

	txtTime.text = langPara("%d.%d开启", openDate.month, openDate.day)

	GameUtil.SetActive(selectGo, self._stepId == data.stepId)
	GameUtil.SetActive(curGo, isOpen)
	GameUtil.SetActive(openGo, startTime > ServerTime.now())
	GameUtil.SetActive(endGo, endTime < ServerTime.now())

	local bossCfg = GoddessTrialConfig.instance:getBossCfg(data.bossId)

	MaterialMgr.setIcon(con, MatType.Pet, bossCfg.raceId)
end

function GoddessTrialBossView:_clearWeekCell(cell)
	return
end

function GoddessTrialBossView:_updateScoreCell(view, cell, data, tag)
	local go = cell.gameObject
	local txt = goutil.findChildTextComponent(go, "txt")
	local strMinScore = MmUtil.formatNumber(data.min, MmUtil.Units_CN, 1)

	if data.max then
		local strMaxScore = MmUtil.formatNumber(data.max, MmUtil.Units_CN, 1)

		txt.text = langPara("%s~%s获得积分\n<color=#CF4345FF>%d</color>", strMinScore, strMaxScore, data.score)
	else
		txt.text = langPara("%s以上获得积分\n<color=#CF4345FF>%d</color>", strMinScore, data.score)
	end
end

function GoddessTrialBossView:_clearScoreCell(cell)
	return
end

function GoddessTrialBossView:_onClickChallenge()
	local fightTime = GoddessTrialModel.instance:getTodayFightBossTimes(self._activityId)
	local activityCfg = GoddessTrialConfig.instance:getActivityCfg(self._activityId)
	local curBattleTime = math.max(activityCfg.dailyBossTimes - fightTime, 0)

	if curBattleTime <= 0 then
		FloatWordMgr.instance:show(lang("已无挑战次数"))
	else
		GoddessTrialController.instance:openBossMissionView(self._activityId, 1)
	end
end

function GoddessTrialBossView:_onClickPractice()
	GoddessTrialController.instance:openBossMissionView(self._activityId, 2)
end

function GoddessTrialBossView:_onClickPrize()
	UIStateManager.instance:push(ViewName.GoddessTrialPrizeView, self._activityId)
end

function GoddessTrialBossView:_onClickTip()
	TipsFacade.instance:openRulesView("goddess_trial_rule")
end

return GoddessTrialBossView
