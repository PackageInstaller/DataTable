-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/games/burygame/SeasonBuryGameMainView.lua

module("logic.extensions.season.view.games.burygame.SeasonSeasonBuryGameMainView", package.seeall)

local SeasonBuryGameMainView = class("SeasonBuryGameMainView", ViewComponent)
local rightScorePer, wrongScorePer

function SeasonBuryGameMainView:unbindEvents()
	SeasonBuryGameMainView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function SeasonBuryGameMainView:bindEvents()
	SeasonBuryGameMainView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function SeasonBuryGameMainView:onExit()
	SeasonBuryGameMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.BuryPitSuccess, self._onBuryPitSuccess, self)
	removetimer(self._onTicking, self)

	for _, v in pairs(self._buryPits) do
		v:onDestroy()
	end

	for _, v in ipairs(self._freePits) do
		v:onDestroy()
	end

	if self._buryBao then
		self._buryBao:onDestroy()
	end

	self._buryPits = nil
	self._freePits = nil
	self._buryBao = nil
end

function SeasonBuryGameMainView:buildUI()
	SeasonBuryGameMainView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtCountDown = self:getTxt("countdown/txtTime")
	self._txtCombo = self:getGo("combo/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self._txtScore = self:getTxt("score/txtIntegral")
	self._pitGo = self:getGo("pit")

	self._pitGo:SetActive(false)

	self._holes = {}

	for i = 1, 9 do
		table.insert(self._holes, self:getGo("holes/hole_" .. i))
	end

	self._txtRule = self:getTxt("rule/txtRule")
end

function SeasonBuryGameMainView:onEnter()
	SeasonBuryGameMainView.super.onEnter(self)

	self.seasonEvt = self:getFirstParam()

	GlobalDispatcher:addListener(GlobalNotify.BuryPitSuccess, self._onBuryPitSuccess, self)

	self._dataReady = false
	self._countDownReady = false

	self:_initGame()
end

function SeasonBuryGameMainView:onEnterFinished()
	SeasonBuryGameMainView.super.onEnterFinished(self)

	local key = "BURY_GAME_MAIN_VIEW"
	local value = Framework.LocalStorage.Instance:GetInt(key, -1)

	if checknumber(value) <= 0 then
		Framework.LocalStorage.Instance:SetInt(key, 1)
		UIStateManager.instance:push(ViewName.BuryGameRuleView, self._startCountDown, self)
	else
		self:_startCountDown()
	end
end

function SeasonBuryGameMainView:_onTicking()
	if self._isPausing then
		return
	end

	local deltaTime = UnityEngine.Time.deltaTime

	self._tickedTime = self._tickedTime + deltaTime

	local remainingTime = math.max(0, self._duration - self._tickedTime)

	self._txtCountDown.text = math.ceil(remainingTime)

	if remainingTime <= 0 then
		self:_endGame()
	end

	local newCfg = BuryGameConfig.instance:getGamePlanCfg(self._gamePlanId, self._tickedTime)

	if newCfg ~= self._gamePlanCfg then
		self._lastTime = not self._gamePlanCfg and newCfg.time or newCfg.time - self._gamePlanCfg.time
		self._gamePlanCfg = newCfg

		self:_insertPitsToQueue()
	end

	local data = self._queue[1]

	if data and self._tickedTime >= data.bornTime then
		table.remove(self._queue, 1)
		self:_createPit(data)
	end

	for k, v in pairs(self._buryPits) do
		v:onTicking(deltaTime)

		if v:isDead() then
			self:_removePit(k)
		end
	end

	if self._buryBao and not self._buryBao:isDead() then
		self._buryBao:onTicking(deltaTime)
	end
end

function SeasonBuryGameMainView:_removePit(posId)
	local pit = self._buryPits[posId]

	self._buryPits[posId] = nil

	table.insert(self._freePits, pit)
end

function SeasonBuryGameMainView:_onBuryPitSuccess(pitType, x, y, z, x1, y1, z1)
	print("_onBuryPitSuccess")

	self._buryedDict[pitType] = checknumber(self._buryedDict[pitType]) + 1

	local color, addScore

	if pitType == 1 then
		addScore = rightScorePer
		self._comboNum = self._comboNum + 1
		color = "20b376"
	else
		addScore = -wrongScorePer
		self._comboNum = 0
		color = "eb4642"
	end

	self._curScore = math.max(0, self._curScore + addScore)

	local tips = string.format("积分<color=#%s>%+d</color>", color, addScore)

	FloatWordMgr.instance:show(tips)
	self:_updateUI()

	if self._buryBao and not self._buryBao:isDead() then
		-- block empty
	else
		self._buryBao = self._buryBao or ItemBuryBao.New(self:getGo("burybao"), self)

		self._buryBao:startBury(x, y, z)
	end

	local url = "fx_ui_yirenzhixia/mairenxiaoyouxi/fx_mairen_hit.prefab"

	self._hitEffect = UIEffectManager.instance:playEffect(self, url, self.mainGO, 0, 0, false, nil, nil, function(o, eff)
		eff:setParent(self.mainGO.transform)
		eff:setScale(90)
		eff:setPos(x1, y1, z1)
	end)
end

function SeasonBuryGameMainView:_updateUI()
	self._txtCombo:SetText(self._comboNum)

	self._txtScore.text = self._curScore
end

function SeasonBuryGameMainView:_createPit(data)
	local posId = self:_findFreePosId()

	if posId then
		local hole = self._holes[posId]
		local pit = self:_findFreePit()

		if not pit then
			local go = goutil.clone(self._pitGo)

			pit = ItemBuryPit.New(go, self)
		end

		local pitGo = pit:getMainGo()

		goutil.addChildToParent(pitGo, hole.transform)
		Framework.TransformUtil.SetLocalPos(pitGo.transform, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(pitGo.transform, 1, 1, 1)

		self._buryPits[posId] = pit

		pitGo:SetActive(true)
		pit:init(posId, data)
	end
end

function SeasonBuryGameMainView:_findFreePit()
	local pit = self._freePits[1]

	if pit then
		table.remove(self._freePits, 1)

		return pit
	end
end

function SeasonBuryGameMainView:_findFreePosId()
	local t = {}

	for k, v in pairs(self._buryPits) do
		local posId = checknumber(k)

		t[posId] = true
	end

	local list = {}

	for i = 1, 9 do
		if not t[i] then
			table.insert(list, i)
		end
	end

	GameUtil.permuteArray(list)

	return list[2]
end

function SeasonBuryGameMainView:_insertPitsToQueue()
	self._queue = {}

	local gamePlanCfg = self._gamePlanCfg
	local startTime = gamePlanCfg.time - self._lastTime
	local num = self:_randomGetNum(gamePlanCfg.numberWeights)

	for i = 1, num do
		local data = {
			bornTime = (i + math.random() - 1) / num * self._lastTime + startTime,
			pitType = self:_randomGetNum(gamePlanCfg.directionWeights),
			duration = gamePlanCfg.velocityRatio
		}

		print("bornTime = " .. data.bornTime .. " i = " .. i .. "num = " .. num .. "self._lastTime = " .. self._lastTime)
		table.insert(self._queue, 1 + #self._queue, data)
	end
end

function SeasonBuryGameMainView:_randomGetNum(weights)
	local array = string.split(weights, "#")
	local maxWeight = 0

	for _, v in ipairs(array) do
		local num, weight = unpack(string.splitToNumber(v, ":"))

		maxWeight = maxWeight + weight
	end

	local random = math.random(1, maxWeight)
	local totalWeight = 0

	for _, v in ipairs(array) do
		local num, weight = unpack(string.splitToNumber(v, ":"))

		totalWeight = totalWeight + weight

		if random <= totalWeight then
			return num
		end
	end
end

function SeasonBuryGameMainView:_startCountDown()
	self:_startGameRes()
	UIStateManager.instance:open(ViewName.BuryCountDownView, "游戏即将开始", 3, self._startGame, self)
end

function SeasonBuryGameMainView:_initGame()
	self._duration = checknumber(BuryGameConfig.instance:getConstantValue("t4"))
	self._tickedTime = 0
	self._comboNum = 0
	self._curScore = 0
	self._gainedPrizeNum = 0
	self._buryedDict = {}
	self._txtCountDown.text = self._duration

	self:_updateUI()

	local activityId = 50001
	local cfg = BuryGameConfig.instance:getCfgById(activityId)

	self._gamePlanId = cfg.gamePlanId
	self._eggPlanId = cfg.eggPlanId
	self._buryPits = {}
	self._queue = {}
	self._freePits = {}
	rightScorePer = checknumber(BuryGameConfig.instance:getConstantValue("t2"))
	wrongScorePer = checknumber(BuryGameConfig.instance:getConstantValue("t3"))
	self._checkedId = 0
	self._egged = false
	self._isPausing = false

	local ruleCfg = RulesConfig.instance:getRuleCo("burygamegate2")

	self._txtRule.text = "1.点击骨蛇进行掩埋，埋1个<color=#20b376>+10</color>积分\n2.注意，误埋小诺<color=#eb4642>-5</color>积分"
end

function SeasonBuryGameMainView:_startGameRes()
	self._dataReady = true

	if self._countDownReady then
		self:_realStartGame()
	end
end

function SeasonBuryGameMainView:_startGame()
	self._countDownReady = true

	if self._dataReady then
		self:_realStartGame()
	end
end

function SeasonBuryGameMainView:_realStartGame()
	settimer(0, self._onTicking, self)
	self:_onTicking()
end

function SeasonBuryGameMainView:_endGame()
	print("click endGame")
	removetimer(self._onTicking, self)

	local rightNum, wrongNum = self:_calcuRightNum()
	local dict = {
		contentFmt = "获得<color=#eb4642>%d</color>积分！",
		tip = "<size=28>本局游戏</size>",
		title = "游戏结束",
		sureBtnText = "知道了",
		rightNum = rightNum,
		wrongNum = wrongNum,
		score = self._curScore,
		sureHandler = self._sendEndGameReq,
		handlerObj = self
	}

	UIStateManager.instance:push(ViewName.BuryGamePopView, dict)
end

function SeasonBuryGameMainView:_sendEndGameReq()
	if self.seasonEvt then
		local obj = {}

		obj.score = self._curScore

		self.seasonEvt:_doSendEndGame({
			self._curScore
		}, "scorelist", obj)
	end

	self:_onEndGameRes()
end

function SeasonBuryGameMainView:_onEndGameRes()
	self:close()
	FloatWordMgr.instance:show("游戏结束")
end

function SeasonBuryGameMainView:_onClickClose()
	if not self._dataReady or not self._countDownReady then
		return
	end

	self:_pauseGame()

	local rightNum, wrongNum = self:_calcuRightNum()
	local dict = {
		contentFmt = "获得<color=#eb4642>%d</color>积分！",
		tip = "你确定要退出游戏吗？",
		title = "提示",
		rightNum = rightNum,
		wrongNum = wrongNum,
		score = self._curScore,
		sureHandler = self._sendEndGameReq,
		handlerObj = self,
		cancelHandler = self._resumeGame
	}

	UIStateManager.instance:push(ViewName.BuryGamePopView, dict)
end

function SeasonBuryGameMainView:_calcuRightNum()
	local rightNum = 0
	local wrongNum = 0

	for k, v in pairs(self._buryedDict) do
		if k == GameEnum.BuryPitEnum.DEAD then
			rightNum = rightNum + v
		elseif k == GameEnum.BuryPitEnum.DUCK or k == GameEnum.BuryPitEnum.CHICK then
			wrongNum = wrongNum + v
		end
	end

	return rightNum, wrongNum
end

function SeasonBuryGameMainView:_pauseGame()
	FloatWordMgr.instance:show("游戏暂停")

	self._isPausing = true

	for _, v in pairs(self._buryPits) do
		v:onPause()
	end

	if self._buryBao then
		self._buryBao:onPause()
	end
end

function SeasonBuryGameMainView:_resumeGame()
	FloatWordMgr.instance:show("游戏恢复~")

	self._isPausing = false

	for _, v in pairs(self._buryPits) do
		v:onResume()
	end

	if self._buryBao then
		self._buryBao:onResume()
	end
end

return SeasonBuryGameMainView
