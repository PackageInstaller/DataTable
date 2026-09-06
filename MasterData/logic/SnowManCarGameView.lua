-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/snowmancar/view/SnowManCarGameView.lua

module("logic.extensions.snowmancar.view.SnowManCarGameView", package.seeall)

local SnowManCarGameView = class("SnowManCarGameView", ViewComponent)

SnowManCarGameView.CarIconPath = "ui/icon/headicon"
SnowManCarGameView.CarBgPath = "ui/bigbg/views/game/snowmancar"

local midCarNum = 6
local carNum = 3

function SnowManCarGameView:ctor()
	SnowManCarGameView.super.ctor(self)
end

function SnowManCarGameView:buildUI()
	SnowManCarGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnLeft = self:getGo("btnLeft")
	self._btnRight = self:getGo("btnRight")
	self._txtScore = self:getTxt("score/txt")
	self._floatWordsArea = self:getGo("score/floatWordsArea")
	self._floatWords = self:getGo("score/floatWords")
	self._countdownTime = self:getTxt("countdown/txt")
	self._hearts = {}

	for i = 1, 3 do
		local heart = self:getGo("hp/hearts/heart_" .. i .. "/img")

		table.insert(self._hearts, heart)
	end

	self._leftCars = {}

	for i = 1, carNum do
		local go = self:getGo("left/car_" .. i)
		local car = GameUtil.AddLuaOnce(go, SnowManCarMo)

		car:onEnter(self)
		table.insert(self._leftCars, car)
	end

	self._rightCars = {}

	for i = 1, carNum do
		local go = self:getGo("right/car_" .. i)
		local car = GameUtil.AddLuaOnce(go, SnowManCarMo)

		car:onEnter(self)
		table.insert(self._rightCars, car)
	end

	self._midList = {}

	for idx = 1, 2 do
		local car = {}

		car.root = self:getGo("middleCarArea/middle_" .. idx)
		car.originAnchor = GameUtil.getAnchoredPos(car.root)
		car.items = {}

		print("[YuTestPrint] =====>\t idx = ", idx)

		for i = 1, midCarNum do
			local cell = {}

			cell.node = goutil.findChild(car.root, "car_" .. i)
			cell.bg = goutil.findChild(car.root, "car_" .. i .. "/bg")
			cell.icon = goutil.findChild(car.root, "car_" .. i .. "/icon")
			cell.errorCricle = goutil.findChild(car.root, "car_" .. i .. "/effect/img")

			table.insert(car.items, cell)
		end

		table.insert(self._midList, car)
	end

	self._midCarRectTrans = self:getGo("middleCarArea"):GetComponent(typeof(UnityEngine.RectTransform))
end

function SnowManCarGameView:bindEvents()
	SnowManCarGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickBtnLeft, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickBtnRight, self)
end

function SnowManCarGameView:unbindEvents()
	SnowManCarGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
end

function SnowManCarGameView:onExit()
	SnowManCarGameView.super.onExit(self)

	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end

	self:_clearCars()
	goutil.clearChildren(self._floatWordsArea)

	self._midListIdx = nil

	for i = 1, 2 do
		local midCars = self._midList[i]

		goutil.setActive(midCars.root, true)
		GameUtil.setAnchoredPos(midCars.root.transform, midCars.originAnchor.x, midCars.originAnchor.y)
	end

	self.unregisterNotify(self, SnowManCarController.AfterCarMoveFinish, self._checkGetScore, self)
	removetimer(self._updateGameTime, self)
	removetimer(self._startGameCountDown, self)
	removetimer(self._redCircleFlash, self)
	removetimer(self._playMatchSuccessAnim, self)
	print("[YuTestPrint] =====>\t 【雪人开车】游戏退出")
end

function SnowManCarGameView:onEnter()
	SnowManCarGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SnowmanCarStartRes, self._openCountDownMask, self)
	self.registerNotify(self, SnowManCarController.AfterCarMoveFinish, self._checkGetScore, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开启")
		Debug.logError("[YuTestPrint] =====>\t 打开SnowManCarGameView时传参错误！")
		self:close()
	end

	self:_loadGame()
	self:_sendGameStartReq()
end

function SnowManCarGameView:_onClickBtnClose()
	self:_pauseGame()

	local function okFunc()
		self:close()
	end

	local function cencelFunc()
		self:_resumeGame()
	end

	TipsFacade.instance:openPopupWindow("提示", "是否要退出游戏，现阶段退出不累计当前所获得积分", okFunc, cencelFunc, "确定", "取消")
end

function SnowManCarGameView:_onClickBtnLeft()
	if self._leftCarIdx > carNum then
		self:_changeHp(-1)
		FloatWordMgr.instance:show("左边已无待匹配车辆")
		self:_checkEndGame()

		return
	end

	if not self:_checkCarCanMove() then
		FloatWordMgr.instance:show("正在移动中，请稍后再试")

		return
	end

	self._isLeftCar = true
	self._curCar = self._leftCars[self._leftCarIdx]

	self._curCar:move(self._carDuration)
	self:_setCarMovingState(true)
end

function SnowManCarGameView:_onClickBtnRight()
	if self._rightCarIdx > carNum then
		self:_changeHp(-1)
		FloatWordMgr.instance:show("右边已无待匹配车辆")
		self:_checkEndGame()

		return
	end

	if not self:_checkCarCanMove() then
		FloatWordMgr.instance:show("正在移动中，请稍后再试")

		return
	end

	self._isLeftCar = false
	self._curCar = self._rightCars[self._rightCarIdx]

	self._curCar:move(self._carDuration)
	self:_setCarMovingState(true)
end

function SnowManCarGameView:_loadGame()
	self._score = 0

	self:_getGameConfig()
	self:_changeScore(0)
	self:_changeHp(0)
	self:_resetGameRound()

	self._countdownTime.text = self._gameTime .. "秒"
end

function SnowManCarGameView:_getGameConfig()
	self._iconCfg = SnowManCarConfig.instance:getCarIconCfg()

	local actCfg = SnowManCarConfig.instance:getActivityCfgByActId(self._activityId)

	if actCfg then
		self._hp = actCfg.carBlood or 3
		self._gameTime = actCfg.gameTime or 60
		self._addOnceScore = actCfg.carScoreRate or 1
	end

	local gameCfg = SnowManCarConfig.instance:getGameCfgByActId(self._activityId)

	if gameCfg then
		self._carDuration = gameCfg.carDuration or 1
		self._midCarDuration = gameCfg.midCarDuration or 1
		self._floatWordsDuration = gameCfg.floatWordsDuration or 0.75
		self._waitingTime = gameCfg.waitingTime or 0.05
	end
end

function SnowManCarGameView:_loadCarsIcon()
	self._leftIconId, self._rightIconId = SnowManCarController.instance:getIconCfg(self._activityId)

	for i = 1, carNum do
		local leftCar = self._leftCars[i]
		local rightCar = self._rightCars[i]

		leftCar:initUI(self._iconCfg[self._leftIconId].iconPath)
		rightCar:initUI(self._iconCfg[self._rightIconId].iconPath)
	end

	self._midIconIds = {}

	local leftCount = 0
	local rightCount = 0

	for i, car in ipairs(self._midCars) do
		local isLeft = math.random(0, 1) == 1

		if isLeft then
			leftCount = leftCount + 1
		else
			rightCount = rightCount + 1
		end

		if rightCount > carNum or leftCount > carNum then
			isLeft = rightCount > carNum
		end

		if isLeft then
			if not self._leftIconId then
				local midIconId = self._rightIconId

				SnowManCarController:setSpriteToImage(car.bg, SnowManCarGameView.CarBgPath, self._iconCfg[midIconId].carBgPath)
				SnowManCarController:setSpriteToImage(car.icon, SnowManCarGameView.CarIconPath, self._iconCfg[midIconId].iconPath)
				table.insert(self._midIconIds, midIconId)
			end
		end
	end
end

function SnowManCarGameView:_refreshMidCar()
	local midCar = self._midCars[1]

	goutil.setActive(midCar.icon, false)
	table.remove(self._midIconIds, 1)

	for i, midCar in ipairs(self._midCars) do
		if i > self._noMatchCount then
			goutil.setActive(midCar.node, false)
		else
			local midIconId = self._midIconIds[i]

			SnowManCarController:setSpriteToImage(midCar.bg, SnowManCarGameView.CarBgPath, self._iconCfg[midIconId].carBgPath)
			SnowManCarController:setSpriteToImage(midCar.icon, SnowManCarGameView.CarIconPath, self._iconCfg[midIconId].iconPath)
		end
	end
end

function SnowManCarGameView:_resetGameRound()
	self._leftCarIdx = 1
	self._rightCarIdx = 1
	self._noMatchCount = midCarNum

	self:_clearCars()

	self._midListIdx = self._midListIdx == nil and 1 or self._midListIdx % 2 + 1
	self._midCars = self._midList[self._midListIdx].items

	self:_loadCarsIcon()
	self:_setCarMovingState(false)
end

function SnowManCarGameView:_openCountDownMask()
	UIStateManager.instance:open(ViewName.SuppressGameStartMask, self._readyStartGame, self)
end

function SnowManCarGameView:_readyStartGame()
	self._countDown = 2

	GameUtil.SetActive(self._gameMask, true)
	GameUtil.SetActive(self._startMask, false)
	removetimer(self._startGameCountDown, self)
	settimer(1, self._startGameCountDown, self, true)
end

function SnowManCarGameView:_startGameCountDown()
	if self._countDown <= 1 then
		removetimer(self._startGameCountDown, self)
		self:_startGame()

		return
	end

	self._countDown = self._countDown - 1
end

function SnowManCarGameView:_startGame()
	print("[YuTestPrint] =====>\t 【雪人开车】游戏开始")

	self._curGameTime = self._gameTime

	settimer(1, self._updateGameTime, self, true)
end

function SnowManCarGameView:_updateGameTime()
	if self._curGameTime < 1 then
		print("[YuTestPrint] =====>\t 游戏剩余时间耗尽，游戏结束！")

		self._countdownTime.text = "0秒"

		self:_endGame()

		return
	end

	self._curGameTime = self._curGameTime - 1
	self._countdownTime.text = math.ceil(self._curGameTime) .. "秒"
end

function SnowManCarGameView:_changeScore(changeNum)
	if changeNum > 0 then
		self:_showFloatWords("积分 + " .. changeNum)
	end

	self._score = self._score + changeNum
	self._txtScore.text = self._score
end

function SnowManCarGameView:_changeHp(changeNum)
	if changeNum < 0 then
		self:_showFloatWords("血量 " .. changeNum)
	end

	self._hp = self._hp + changeNum

	for i = 1, 3 do
		local heart = self._hearts[i]

		goutil.setActive(heart, i <= self._hp)
	end

	self:_checkEndGame()
end

function SnowManCarGameView:_checkCarCanMove()
	return not self._isMoving
end

function SnowManCarGameView:_setCarMovingState(isMoving)
	self._isMoving = isMoving
end

function SnowManCarGameView:_clearCars()
	for i = 1, carNum do
		local leftCar = self._leftCars[i]
		local rightCar = self._rightCars[i]

		leftCar:clear()
		rightCar:clear()
	end

	if not self._midCars then
		return
	end

	for i = 1, midCarNum do
		self:_clearMidCar(i)
	end
end

function SnowManCarGameView:_clearMidCar(carIdx)
	local midCar = self._midCars[carIdx]

	goutil.setActive(midCar.icon, false)
	goutil.setActive(midCar.errorCricle, false)
	goutil.setActive(midCar.node, true)
	MaterialMgr.resetAll(midCar.icon)
end

function SnowManCarGameView:_checkGetScore(curCar)
	if self._isLeftCar then
		if not self._leftIconId then
			local ans = self._rightIconId
			local target = self._midIconIds[1]
			local midCar = self._midCars[1]
			local isMatch = ans == target

			curCar:setActive(not isMatch)
			self:_setCarMovingState(false)

			if isMatch then
				goutil.setActive(midCar.icon, true)
				self:_changeScore(self._addOnceScore)
				settimer(self._waitingTime, self._playMatchSuccessAnim, self)

				if self._isLeftCar then
					self._leftCarIdx = self._leftCarIdx + 1
				else
					self._rightCarIdx = self._rightCarIdx + 1
				end
			else
				self:_playEffectMatchError(1)
				self:_changeHp(-1)
			end
		end
	end
end

function SnowManCarGameView:_checkEndGameRound()
	if #self._midIconIds < 1 then
		print("[YuTestPrint] =====>\t 当前轮次已匹配完毕, 加载新一轮次游戏！")
		self:_playMidCarAnimation()
		self:_resetGameRound()

		return
	end
end

function SnowManCarGameView:_checkEndGame()
	if self._hp <= 0 then
		print("[YuTestPrint] =====>\t self._hp <= 0, 游戏结束！")
		self:_endGame()

		return true
	end

	return false
end

function SnowManCarGameView:_showFloatWords(text)
	local curAnchor = Vector2.New(0, 0)
	local targetAnchor = Vector2.New(0, 80)
	local floatWords = goutil.cloneAndSetParent(self._floatWords, self._floatWordsArea.transform, "floatWords")
	local txt = goutil.findChildTextComponent(floatWords, "container/txt")

	goutil.setActive(floatWords, true)

	txt.text = text

	local function callBack(data)
		local tween = data[1]
		local floatWords = data[2]

		tween:RemoveListener()
		goutil.destroy(floatWords)
	end

	local floatTween = UnityTweens.TweenPosition.StartTween(floatWords, curAnchor, targetAnchor, self._floatWordsDuration, UnityTweens.EaseType.easeOutQuad, 0, UnityTweens.CoordSpace.Anchor)

	floatTween:AddListener(callBack, {
		floatTween,
		floatWords
	})
end

function SnowManCarGameView:_playMatchSuccessAnim()
	print("[YuTestPrint] =====>\t 图标匹配成功，播放动画")
	removetimer(self._playMatchSuccessAnim, self)

	self._noMatchCount = self._noMatchCount - 1

	self:_refreshMidCar()
	self:_checkEndGameRound()
end

function SnowManCarGameView:_playMidCarAnimation()
	print("[YuTestPrint] =====>\t 当下一轮游戏开始前，播放中间车辆动画")
	ViewBlockMgr.instance:blockClick(true, self)

	local curCar = self._midList[self._midListIdx].root
	local nextCar = self._midList[self._midListIdx % 2 + 1].root
	local curCarAnchor = GameUtil.getAnchoredPos(curCar)
	local nextCarAnchor = GameUtil.getAnchoredPos(nextCar)
	local targetAnchor = Vector3.New(curCarAnchor.x, -745, 0)

	goutil.setActive(nextCar, true)

	local function callBack1(data)
		local tween = data[1]
		local car = data[2]
		local isNextCar = data[3]

		tween:RemoveListener()
		UnityTweens.TweenPosition.StopTween(car)

		if not isNextCar then
			goutil.setActive(car, false)
			GameUtil.setAnchoredPos(car, nextCarAnchor.x, nextCarAnchor.y)
		end
	end

	local function callBack2(data)
		ViewBlockMgr.instance:blockClick(false, self)

		local tween = data[1]
		local car = data[2]
		local isNextCar = data[3]

		tween:RemoveListener()
		UnityTweens.TweenPosition.StopTween(car)

		if not isNextCar then
			goutil.setActive(car, false)
			GameUtil.setAnchoredPos(car, nextCarAnchor.x, nextCarAnchor.y)
		end
	end

	local curCarTween = UnityTweens.TweenPosition.StartTween(curCar, curCarAnchor, targetAnchor, self._midCarDuration, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.Anchor)

	curCarTween:AddListener(callBack1, {
		curCarTween,
		curCar,
		false
	})

	local nextCarTween = UnityTweens.TweenPosition.StartTween(nextCar, nextCarAnchor, curCarAnchor, self._midCarDuration, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.Anchor)

	nextCarTween:AddListener(callBack2, {
		nextCarTween,
		nextCar,
		true
	})
end

function SnowManCarGameView:_playEffectMatchError()
	self._flashTimes = 0

	removetimer(self._redCircleFlash, self)
	settimer(0.1, self._redCircleFlash, self)
end

function SnowManCarGameView:_redCircleFlash()
	self._flashTimes = self._flashTimes + 1

	goutil.setActive(self._midCars[1].errorCricle, self._flashTimes % 2 ~= 0)

	if self._flashTimes >= 6 then
		removetimer(self._redCircleFlash, self)
	end
end

function SnowManCarGameView:_pauseGame()
	print("[YuTestPrint] =====>\t 【雪人开车】游戏暂停")
	removetimer(self._updateGameTime, self)
end

function SnowManCarGameView:_resumeGame()
	print("[YuTestPrint] =====>\t 【雪人开车】游戏继续")
	settimer(1, self._updateGameTime, self)
end

function SnowManCarGameView:_endGame()
	removetimer(self._updateGameTime, self)
	self:_sendGameEndReq()
	self:_showGameResult()
end

function SnowManCarGameView:_showGameResult()
	print("[YuTestPrint] =====>\t 游戏结束，显示游戏结果")

	local text = string.format("本次累计获得%d积分", self._score)

	local function func()
		self:close()
	end

	TipsFacade.instance:openTipWindow("提示", text, func, "确定")
end

function SnowManCarGameView:_sendGameStartReq()
	SnowManCarController.instance:sendGameStartReq(self._activityId)
end

function SnowManCarGameView:_sendGameEndReq()
	SnowManCarController.instance:sendGameEndReq(self._activityId, self._score)
end

return SnowManCarGameView
