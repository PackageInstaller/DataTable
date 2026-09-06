-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruilottery/view/FanRuiLotteryGameView.lua

module("logic.extensions.fanruilottery.view.FanRuiLotteryGameView", package.seeall)

local FanRuiLotteryGameView = class("FanRuiLotteryGameView", ViewComponent)

FanRuiLotteryGameView.StateStart = 1
FanRuiLotteryGameView.StateChoose = 2
FanRuiLotteryGameView.StateShow = 3
FanRuiLotteryGameView.StateEnd = 4
FanRuiLotteryGameView.playerWin = 1
FanRuiLotteryGameView.winWin = 0
FanRuiLotteryGameView.enemyWin = -1

function FanRuiLotteryGameView:ctor()
	FanRuiLotteryGameView.super.ctor(self)
end

function FanRuiLotteryGameView:buildUI()
	FanRuiLotteryGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("leftTop/btnTip")
	self._leftTableView = self:getGo("leftHead/tableview")
	self._rightTableView = self:getGo("rightHead/tableview")
	self._tableCell = self:getGo("scoreCell")
	self._leftHead = self:getGo("leftHead")
	self._leftInfo = self:getGo("leftHead/headInfo")
	self._leftAnswer = self:getGo("leftAnswer")
	self._imageChangeAnswerLeft = goutil.findChildComponent(self.mainGO, "leftAnswer/imgAnswer", "UIImageSpriteChange")
	self._cheatInfo = self:getGo("leftHead/cheatInfo")
	self._cheatInfoTxtAnswer = self:getTxt("leftHead/cheatInfo/txt")
	self._cheatInfoImageAnswer = goutil.findChildComponent(self.mainGO, "leftHead/cheatInfo/imgAnswer", "UIImageSpriteChange")
	self._rightHead = self:getGo("rightHead")
	self._rightInfo = self:getGo("rightHead/headInfo")
	self._rightAnswer = self:getGo("rightAnswer")
	self._imageChangeAnswerRight = goutil.findChildComponent(self.mainGO, "rightAnswer/imgAnswer", "UIImageSpriteChange")
	self._btns = self:getGo("answerList/btns")
	self._btnAnswer1 = self:getGo("answerList/btns/btn_1")
	self._btnAnswer2 = self:getGo("answerList/btns/btn_2")
	self._btnAnswer3 = self:getGo("answerList/btns/btn_3")
	self._imgChangeAnswerSelectList = {
		goutil.findChildComponent(self.mainGO, "answerList/btns/btn_1", "UIChangeGroup"),
		goutil.findChildComponent(self.mainGO, "answerList/btns/btn_2", "UIChangeGroup"),
		(goutil.findChildComponent(self.mainGO, "answerList/btns/btn_3", "UIChangeGroup"))
	}
	self._clockTime = self:getGo("clockTime")
	self._txtClockTime = self:getTxt("clockTime/txtClockTime")
	self._resultGo = self:getGo("result")
	self._resultChange = goutil.findChildComponent(self._resultGo, "imgResult", "UIImageSpriteChange")
	self._cheatTipsGo = self:getGo("cheatTips")
	self._cheatTipsCon = self:getGo("cheatTips/con")
	self._txtCheatTips = self:getTxt("cheatTips/txtCheatTips")
	self._mask = self:getGo("viewBoxGo")
end

function FanRuiLotteryGameView:bindEvents()
	FanRuiLotteryGameView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnAnswer1, function()
		self:_onClickAnswer(1)
	end, self)
	GameUtil.addClickHandler(self._btnAnswer2, function()
		self:_onClickAnswer(2)
	end, self)
	GameUtil.addClickHandler(self._btnAnswer3, function()
		self:_onClickAnswer(3)
	end, self)
end

function FanRuiLotteryGameView:unbindEvents()
	FanRuiLotteryGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnAnswer1)
	GameUtil.rmClickHandler(self._btnAnswer2)
	GameUtil.rmClickHandler(self._btnAnswer3)
end

function FanRuiLotteryGameView:onExit()
	FanRuiLotteryGameView.super.onExit(self)
	removetimer(self._startGame, self)
	removetimer(self._onClockTime, self)
	removetimer(self._onStartFight, self)
	removetimer(self._checkEnd, self)
	removetimer(self._onStartClockTime, self)
	MaterialMgr.resetAll(self._cheatTipsCon)
	UIEffectManager.instance:stopEffect(self._resultEff)
end

function FanRuiLotteryGameView:onEnter()
	FanRuiLotteryGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PopupImageRuleClose, self._onCloseRuleView, self)
	self.addGEvent(self, GlobalNotify.handlePM_FanRuiLotteryStartGameRes, self._PM_FanRuiLotteryStartGameRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_FanRuiLotteryEndGameRes, self._PM_FanRuiLotteryEndGameRes, self)

	local params = self:getOpenParam()

	self._actId = params[1]
	self._useCost = params[2]
	self._useCheat = params[3]
	self._leftTableList = ScrollerList.create(self._leftTableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._rightTableList = ScrollerList.create(self._rightTableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._gameCfg = FanRuiLotteryConfig.instance:getGameCfg(self._actId)

	if not FanRuiLotteryModel.instance:getIsReadRule() then
		self._isFirstReadRule = true

		self:_onClickRule()
		FanRuiLotteryModel.instance:setIsReadRule()
	else
		self._isFirstReadRule = false

		self:_readyStartGame()
	end

	self:_initGame()
end

function FanRuiLotteryGameView:_initGame()
	self._leftLose = 0
	self._rightLose = 0
	self._wait = 0
	self._state = FanRuiLotteryGameView.StateStart
	self._preSelect = 0

	GameUtil.setAnchoredPos(self._btns, 0, -100)
	GameUtil.SetActive(self._btns, false)
	GameUtil.SetActive(self._clockTime, false)
	GameUtil.SetActive(self._leftAnswer, false)
	GameUtil.SetActive(self._rightAnswer, false)
	GameUtil.SetActive(self._resultGo, false)
	GameUtil.SetActive(self._cheatInfo, false)
	GameUtil.SetActive(self._cheatTipsGo, self._useCheat)
	GameUtil.SetActive(self._mask, true)

	self._txtCheatTips.text = langPara("当前已使用%s", MaterialMgr.getMaterialsNameByCfg(self._gameCfg.cheatCost))

	local matType, matId, matNum = MaterialMgr.getMatParams(self._gameCfg.cheatCost)

	MaterialMgr.setIcon(self._cheatTipsCon, matType, matId)

	self._curSelectAnswer = 1

	self:_refreshScore()
	self:_refreshBtns()
end

function FanRuiLotteryGameView:_readyStartGame()
	FanRuiLotteryController.instance:sendPM_FanRuiLotteryStartGameReq(self._actId, self._useCheat, self._useCost, clientKey)

	self._txtClockTime.text = ""
end

function FanRuiLotteryGameView:_startGame()
	removetimer(self._onStartClockTime, self)

	self._targetTime = nil

	GameUtil.SetActive(self._mask, false)
	GameUtil.SetActive(self._clockTime, false)
	self:_showBtns()
end

function FanRuiLotteryGameView:_showHeadInfo()
	GameUtil.SetActive(self._leftInfo, true)
	GameUtil.SetActive(self._rightInfo, true)
	GameUtil.SetActive(self._leftTableView, true)
	GameUtil.SetActive(self._rightTableView, true)
	UnityTweens.TweenPositionBy.StartTween(self._leftInfo, Vector3(230, 0, 0), 2, UnityTweens.EaseType.easeOutElastic)
	UnityTweens.TweenPositionBy.StartTween(self._rightInfo, Vector3(-230, 0, 0), 2, UnityTweens.EaseType.easeOutElastic)
	UnityTweens.TweenPositionBy.StartTween(self._leftTableView, Vector3(150, 0, 0), 2, UnityTweens.EaseType.easeOutElastic)
	UnityTweens.TweenPositionBy.StartTween(self._rightTableView, Vector3(-150, 0, 0), 2, UnityTweens.EaseType.easeOutElastic)
end

function FanRuiLotteryGameView:_showBtns()
	GameUtil.SetActive(self._btns, true)
	GameUtil.setAnchoredPos(self._btns, 0, -100)

	local tween = UnityTweens.TweenPositionBy.StartTween(self._btns, Vector3(0, 250, 0), 2, UnityTweens.EaseType.easeInOutCubic)

	tween:RemoveListener()
	tween:AddListener(function()
		GameUtil.setAnchoredPos(self._btns, 0, 150)
		self:_onStartTurn()
	end)
end

function FanRuiLotteryGameView:_hideBtns()
	GameUtil.setAnchoredPos(self._btns, 0, 150)

	local tween = UnityTweens.TweenPositionBy.StartTween(self._btns, Vector3(0, -250, 0), 2, UnityTweens.EaseType.easeOutQuint)

	tween:RemoveListener()
	tween:AddListener(function()
		GameUtil.setAnchoredPos(self._btns, 0, -100)
		GameUtil.SetActive(self._btns, false)
	end)
end

function FanRuiLotteryGameView:_refreshScore()
	local leftScoreList = {}
	local rightScoreList = {}

	for i = 1, self._gameCfg.winTime do
		if i <= self._leftLose then
			table.insert(leftScoreList, true)
		else
			table.insert(leftScoreList, false)
		end

		if i <= self._rightLose then
			table.insert(rightScoreList, true)
		else
			table.insert(rightScoreList, false)
		end
	end

	self._leftTableList:reloadData(leftScoreList)
	self._rightTableList:reloadData(rightScoreList)
end

function FanRuiLotteryGameView:_refreshBtns()
	for i, v in ipairs(self._imgChangeAnswerSelectList) do
		if checknumber(self._curSelectAnswer) == i then
			v:SetState(1)
		else
			v:SetState(0)
		end
	end
end

function FanRuiLotteryGameView:_setEnemyAnswer()
	if checknumber(self._preSelect) == 0 then
		self._enemyAnswer = math.random(1, 3)
	else
		self._enemyAnswer = (self._preSelect + 1) % 3

		if self._enemyAnswer == 0 then
			self._enemyAnswer = 3
		end
	end
end

function FanRuiLotteryGameView:_calcWiner()
	if self._enemyAnswer == self._curSelectAnswer then
		return FanRuiLotteryGameView.winWin
	end

	local winAnswer = (self._enemyAnswer + 1) % 3

	if winAnswer == 0 then
		winAnswer = 3
	end

	if winAnswer == self._curSelectAnswer then
		return FanRuiLotteryGameView.playerWin
	end

	winAnswer = (self._curSelectAnswer + 1) % 3

	if (self._curSelectAnswer + 1) % 3 == 0 then
		winAnswer = 3
	end

	if winAnswer == self._enemyAnswer then
		return FanRuiLotteryGameView.enemyWin
	end

	return FanRuiLotteryGameView.winWin
end

function FanRuiLotteryGameView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgLose = goutil.findChild(go, "imgLose")

	GameUtil.SetActive(imgLose, data)
end

function FanRuiLotteryGameView:_clearCell(cell)
	return
end

function FanRuiLotteryGameView:_checkEnd()
	if self._leftLose >= self._gameCfg.winTime then
		self._state = FanRuiLotteryGameView.StateEnd
		self._playerWinGame = true

		self:_onGameEnd()
	elseif self._rightLose >= self._gameCfg.winTime then
		self._state = FanRuiLotteryGameView.StateEnd
		self._playerWinGame = false

		self:_onGameEnd()
	else
		GameUtil.SetActive(self._resultGo, false)
		GameUtil.SetActive(self._leftAnswer, false)
		GameUtil.SetActive(self._rightAnswer, false)

		self._curSelectAnswer = 1

		self:_refreshBtns()
		self:_showBtns()
	end
end

function FanRuiLotteryGameView:_onGameEnd()
	FanRuiLotteryController.instance:sendPM_FanRuiLotteryEndGameReq(self._actId, self._playerWinGame)
end

function FanRuiLotteryGameView:_onStartTurn()
	self._state = FanRuiLotteryGameView.StateChoose
	self._targetTime = ServerTime.now() + self._gameCfg.waitTime

	self:_setEnemyAnswer()

	if self._useCheat == true then
		self._cheatInfoImageAnswer:SetState(self._enemyAnswer - 1)
		GameUtil.SetActive(self._cheatInfo, true)
	else
		GameUtil.SetActive(self._cheatInfo, false)
	end

	self:_onClockTime()
	GameUtil.SetActive(self._resultGo, false)
	GameUtil.SetActive(self._clockTime, true)
	removetimer(self._onClockTime, self)
	settimer(1, self._onClockTime, self, true)
end

function FanRuiLotteryGameView:_onEndChoose()
	self._state = FanRuiLotteryGameView.StateShow

	self:_hideBtns()
	removetimer(self._onClockTime, self)
	GameUtil.SetActive(self._clockTime, false)
	GameUtil.SetActive(self._cheatInfo, false)

	self._result = self:_calcWiner()
	self._preSelect = self._curSelectAnswer

	if self._result == FanRuiLotteryGameView.playerWin then
		self._leftLose = self._leftLose + 1

		self._resultChange:SetState(0)
	elseif self._result == FanRuiLotteryGameView.enemyWin then
		self._rightLose = self._rightLose + 1

		self._resultChange:SetState(1)
	else
		self._resultChange:SetState(2)
	end

	self._targetTime = nil

	removetimer(self._onStartFight, self)
	settimer(1, self._onStartFight, self, false)
end

function FanRuiLotteryGameView:_onStartFight()
	self._imageChangeAnswerLeft:SetState(self._enemyAnswer - 1)
	self._imageChangeAnswerRight:SetState(self._curSelectAnswer - 1)
	GameUtil.setAnchoredPos(self._leftAnswer, 75, -164)
	GameUtil.setAnchoredPos(self._rightAnswer, -75, -164)
	GameUtil.SetActive(self._leftAnswer, true)
	GameUtil.SetActive(self._rightAnswer, true)

	local tween = UnityTweens.TweenPosition.StartTween(self._leftAnswer, self._leftAnswer.transform.localPosition, Vector3(-70, -164, 0), 1, UnityTweens.EaseType.easeOutBounce, 2)

	tween:RemoveListener()
	tween:AddListener(function()
		GameUtil.SetActive(self._resultGo, true)
		UIEffectManager.instance:stopEffect(self._resultEff)

		self._resultEff = self._result == FanRuiLotteryGameView.playerWin and UIEffectManager.instance:playEffect(self, "20230825/fanruixiaoyouxi/fx_ui_xiaoyouxi_shengli.prefab", nil, 0, 0, false) or self._result == FanRuiLotteryGameView.enemyWin and UIEffectManager.instance:playEffect(self, "20230825/fanruixiaoyouxi/fx_ui_xiaoyouxi_shibai.prefab", nil, 0, 0, false) or UIEffectManager.instance:playEffect(self, "20230825/fanruixiaoyouxi/fx_ui_xiaoyouxi_pingju.prefab", nil, 0, 0, false)

		self._resultEff:setParent(self._resultGo.transform)
		self._resultEff:setLocalPos(0, 0, 0)
		self._resultEff:setScale(1)
		self:_refreshScore()
		removetimer(self._checkEnd, self)
		settimer(2, self._checkEnd, self, false)
	end)
	UnityTweens.TweenPosition.StartTween(self._rightAnswer, self._rightAnswer.transform.localPosition, Vector3(70, -164, 0), 1, UnityTweens.EaseType.easeOutBounce, 2)
end

function FanRuiLotteryGameView:_onClockTime()
	if self._timePause == true then
		return
	end

	if ServerTime.now() >= self._targetTime then
		self:_onEndChoose()
		removetimer(self._onClockTime, self)
	else
		self._txtClockTime.text = langPara("%ds", self._targetTime - ServerTime.now())
	end
end

function FanRuiLotteryGameView:_onStartClockTime()
	if self._timePause == true then
		return
	end

	if ServerTime.now() >= self._targetTime then
		self:_startGame()
		removetimer(self._onStartClockTime, self)
	else
		self._txtClockTime.text = langPara("%ds", self._targetTime - ServerTime.now())
	end
end

function FanRuiLotteryGameView:_onClickAnswer(index)
	if self._state == FanRuiLotteryGameView.StateChoose then
		self._curSelectAnswer = index

		self:_refreshBtns()
	end
end

function FanRuiLotteryGameView:_onClickRule()
	local ruleCfg = FanRuiLotteryConfig.instance:getRuleCfgs(self._gameCfg.ruleId)
	local ruleList = {}

	for i, v in ipairs(ruleCfg) do
		local obj = {}

		obj.url = v.resPath
		obj.desc = v.desc

		table.insert(ruleList, obj)
	end

	TipsFacade:openImageRuleView(ruleList, "游戏规则")

	self._timePause = true
	self._haveTime = checknumber(self._targetTime) > 0 and self._targetTime - ServerTime.now() or self._gameCfg.waitTime
end

function FanRuiLotteryGameView:_onClickClose()
	self._timePause = true
	self._haveTime = checknumber(self._targetTime) > 0 and self._targetTime - ServerTime.now() or self._gameCfg.waitTime

	TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否确认退出博弈？\n注：投入的大鸡腿将会<color=#df5757>全部返还。</color>"), function()
		self._playerWinGame = false
		self._targetTime = nil

		FanRuiLotteryAgent.instance:sendPM_FanRuiLotteryExitGameReq(self._actId)

		self._timePause = false
		self._targetTime = nil

		self:close()
	end, function()
		self._timePause = false
		self._targetTime = ServerTime.now() + checknumber(self._haveTime)
	end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
end

function FanRuiLotteryGameView:_onCloseRuleView()
	if self._isFirstReadRule == true then
		self:_readyStartGame()
	end

	self._isFirstReadRule = false
	self._timePause = false
	self._targetTime = ServerTime.now() + checknumber(self._haveTime)
end

function FanRuiLotteryGameView:_PM_FanRuiLotteryStartGameRes()
	self._targetTime = ServerTime.now() + 3

	self:_onStartClockTime()
	GameUtil.SetActive(self._clockTime, true)
	settimer(1, self._onStartClockTime, self, true)
end

function FanRuiLotteryGameView:_PM_FanRuiLotteryEndGameRes(changeSetId)
	UIStateManager.instance:push(ViewName.FanRuiLotteryOverView, self._actId, self._playerWinGame, self._useCost, changeSetId)
end

return FanRuiLotteryGameView
