-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/view/QiChallengeDailyLevelView.lua

module("logic.extensions.qichallenge.view.QiChallengeDailyLevelView", package.seeall)

local QiChallengeDailyLevelView = class("QiChallengeDailyLevelView", ViewComponent)

function QiChallengeDailyLevelView:buildUI()
	QiChallengeDailyLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnRule = self:getBtn("leftTop/btnTip")
	self._btnBlock = self:getBtn("btnBlock")
	self._sldBlock = self:getSlider("blockSlider")
	self._txtBlock = self:getTxt("blockSlider/txtCurBlock")
	self._challenges = {}

	for i = 1, 3 do
		local go = self:getGo("challenge" .. i)
		local enemyList = {}

		for i = 1, 9 do
			enemyList[i] = {
				go = goutil.findChild(go, "teamEnemy/cell_" .. i),
				con = goutil.findChild(go, "teamEnemy/cell_" .. i .. "/icon")
			}
		end

		self._challenges[i] = {
			go = go,
			btnChallenge = GameUtil.asBtn(goutil.findChild(go, "btnChallenge")),
			rewardGo = goutil.findChild(go, "reward"),
			txtReward = goutil.findChildTextComponent(go, "reward/txtReward"),
			rewardCon = goutil.findChild(go, "reward/txtReward/rewardCon"),
			pass = goutil.findChild(go, "pass"),
			enemyList = enemyList
		}
	end
end

function QiChallengeDailyLevelView:bindEvents()
	QiChallengeDailyLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBlock, self._onClickBlock, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)

	for i = 1, 3 do
		GameUtil.addClickHandler(self._challenges[i].btnChallenge, function()
			self:_onClickChallenge(i)
		end, self)
	end
end

function QiChallengeDailyLevelView:unbindEvents()
	QiChallengeDailyLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBlock)
	GameUtil.rmClickHandler(self._btnRule)

	for i = 1, 3 do
		GameUtil.rmClickHandler(self._challenges[i].btnChallenge)
	end
end

function QiChallengeDailyLevelView:onEnter()
	QiChallengeDailyLevelView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_QiChallengeGetInfoRes, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_QiChallengeAllSealRes, self._refreshView, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._activityCfg = QiChallengeConfig.instance:getActivityCfg(self._activityId)

	QiChallengeAgent.instance:sendPM_QiChallengeGetInfoReq(self._activityId)
end

function QiChallengeDailyLevelView:onExit()
	QiChallengeDailyLevelView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_QiChallengeGetInfoRes, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_QiChallengeAllSealRes, self._refreshView, self)
end

function QiChallengeDailyLevelView:_refreshView()
	for i = 1, 3 do
		self:_refreshEmeny(i)
	end

	local blockRaceCount = QiChallengeModel.instance:getBlockRaceCount()

	self._txtBlock.text = langPara("%d/%d", blockRaceCount, checknumber(self._activityCfg.sealNum))

	self._sldBlock:SetValue(blockRaceCount / checknumber(self._activityCfg.sealNum))
end

function QiChallengeDailyLevelView:_refreshEmeny(index)
	local info = QiChallengeModel.instance:getAllChallengeInfo(index)
	local challengeCell = self._challenges[index]

	for i = 1, 9 do
		MaterialMgr.resetAll(challengeCell.enemyList[i].con)
		GameUtil.SetActive(challengeCell.enemyList[i].go, false)
	end

	if info then
		local challengeCfg = QiChallengeConfig.instance:getAllChallengeCfg(self._activityCfg.allPlanId, info.id)

		if not challengeCfg or challengeCfg.hard ~= index then
			return
		end

		local creepCfg = QiChallengeConfig.instance:getCreepsCfg(challengeCfg.creepsMasterId)

		for i, v in ipairs(creepCfg) do
			GameUtil.setLocalScale(challengeCell.enemyList[v.posId].con, 0.8, 0.8, 0.8)

			local proxy = MaterialMgr.setCell(MatType.Pet, v.raceId, challengeCell.enemyList[v.posId].con)

			GameUtil.SetActive(challengeCell.enemyList[v.posId].go, true)
		end

		GameUtil.SetActive(challengeCell.btnChallenge, true)
		GameUtil.SetActive(challengeCell.pass, false)

		if info.isFinish == true then
			GameUtil.SetActive(challengeCell.pass, true)
		else
			GameUtil.SetActive(challengeCell.pass, false)
		end

		MaterialMgr.clearIcon(challengeCell.rewardCon)

		if not string.nilorempty(challengeCfg.prize) and not info.isFinish then
			local prizes = string.split(challengeCfg.prize, "#")
			local matType, matId, matNum = MaterialMgr.getMatParams(prizes[1])

			self._challenges[index].txtReward.text = langPara("x%d", checknumber(matNum))

			MaterialMgr.setIcon(challengeCell.rewardCon, matType, matId)
			GameUtil.SetActive(challengeCell.rewardGo, true)
		else
			GameUtil.SetActive(challengeCell.rewardGo, false)
		end
	else
		GameUtil.SetActive(challengeCell.btnChallenge, false)
		GameUtil.SetActive(challengeCell.rewardGo, false)
		GameUtil.SetActive(challengeCell.pass, false)
	end
end

function QiChallengeDailyLevelView:_onClickChallenge(index)
	local info = QiChallengeModel.instance:getAllChallengeInfo(index)

	if info.isFinish == true then
		FloatWordMgr.instance:show(lang("今日已挑战"))

		return
	else
		local fmtMo = QiChallengeModel.instance:getDailyFmtMo()

		fmtMo:initParams(self._activityId, self._activityCfg.allPlanId, info.id)
		CustomFmtController.instance:showMissionView(fmtMo)
	end
end

function QiChallengeDailyLevelView:_onClickBlock()
	UIStateManager.instance:push(ViewName.QiChallengeBlockView, self._activityId)
end

function QiChallengeDailyLevelView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, self._activityCfg.dailyRuleKey)
end

return QiChallengeDailyLevelView
