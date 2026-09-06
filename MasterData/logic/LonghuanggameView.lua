-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longhuang/LonghuanggameView.lua

module("logic.extensions.timelimitedchallenge.view.longhuang.LonghuanggameView", package.seeall)

local LonghuanggameView = class("LonghuanggameView", ViewComponent)

function LonghuanggameView:ctor()
	LonghuanggameView.super.ctor(self)
end

function LonghuanggameView:buildUI()
	LonghuanggameView.super.buildUI(self)

	self._joystickBg = self:getGo("joystickview/joystickArea/joystickbackground")
	self._virtualJoystick = goutil.addComponentOnce(self._joystickBg, typeof(VirtualJoystick))
	self._initBgPos = Vector2.New(Framework.TransformUtil.GetLocalPos(self._joystickBg.transform, 0, 0, 0))
	self._joystickCtrl = goutil.findChildComponent(self.mainGO, "joystickview", typeof(ClickToShowJoystick))

	self._joystickCtrl.gameObject:SetActive(true)

	self._mainAreaRectTrans = self:getGo("mainArea"):GetComponent(typeof(UnityEngine.RectTransform))
	self._mainBallRectTrans = self:getGo("mainArea/mainBallGo"):GetComponent(typeof(UnityEngine.RectTransform))
	self._btnClose = self:getBtn("btnClose")
	self._fireBallGo = self:getGo("mainArea/fireBallGo")

	self._fireBallGo:SetActive(false)

	self._txtTickedTime = self:getTxt("time/txtTime")
	self._progressBar = self:getSlider("progress/slider")
	self._rule = self:getGo("rule")
	self._startTip = self:getGo("startTip")
	self._buffLvs = self:getGo("progress/buffLvs")

	local sliderRectTrans = self._progressBar:GetComponent(typeof(UnityEngine.RectTransform))

	self._sliderHeight = sliderRectTrans.sizeDelta.y

	self:_initDatas()

	self._tempBg = self:getGo("tempBg")
end

function LonghuanggameView:bindEvents()
	LonghuanggameView.super.bindEvents(self)
	self._virtualJoystick:AddDownListener(self._onJoystickDown, self)
	self._virtualJoystick:AddUpListener(self._onJoystickUp, self)
	self._virtualJoystick:AddDragListener(self._onJoystickDrag, self)
	self._btnClose:AddClickListener(self.close, self)
end

function LonghuanggameView:unbindEvents()
	LonghuanggameView.super.unbindEvents(self)
	self._virtualJoystick:RemoveDownListener()
	self._virtualJoystick:RemoveUpListener()
	self._virtualJoystick:RemoveDragListener()
	self._btnClose:RemoveClickListener()
end

function LonghuanggameView:_onJoystickUp()
	print("JoystickUp")

	self._mainBall.velocity = Vector2.zero
end

function LonghuanggameView:_onJoystickDown()
	print("JoystickDown")

	if not self._isRunning then
		self:_startGame()
	end
end

function LonghuanggameView:_onJoystickDrag(x, y)
	self._mainBall.velocity = self._mainBallBaseVelocity * Vector2.New(x, y)
end

function LonghuanggameView:_onClickStartGame()
	return
end

function LonghuanggameView:destroyUI()
	LonghuanggameView.super.destroyUI(self)
end

function LonghuanggameView:onEnter()
	LonghuanggameView.super.onEnter(self)
	HeadItemController.instance:setMyHeadCellWithoutVip(self._mainBallRectTrans.gameObject)
	self:_initGame()
end

function LonghuanggameView:onEnterFinished()
	LonghuanggameView.super.onEnterFinished(self)
end

function LonghuanggameView:onExit()
	LonghuanggameView.super.onExit(self)
end

function LonghuanggameView:onExitFinished()
	LonghuanggameView.super.onExitFinished(self)
end

local DirectionPlanType = {
	TowardsFixedPoint = 2,
	TowardsMainBall = 1
}

function LonghuanggameView:_initDatas()
	local areaSizeDelta = self._mainAreaRectTrans.sizeDelta

	self._mainAreaSize = Vector2.New(areaSizeDelta.x, areaSizeDelta.y)
	self._mainAreaMinPoint = -0.5 * self._mainAreaSize
	self._mainBall = {}
	self._mainBall.velocity = Vector2.zero
	self._mainBall.pos = Vector2.zero
	self._mainBall.rectTrans = self._mainBallRectTrans

	local mainBallSize = checknumber(TimeLimitedConfig.instance:getLongHuangCommonValue("MAIN_BALL_SIZE"))
	local mainBallScale = checknumber(TimeLimitedConfig.instance:getLongHuangCommonValue("MAIN_BALL_SCALE"))

	self._mainBall.radius = mainBallSize * mainBallScale / 2
	self._mainBall.rectTrans.sizeDelta = UnityEngine.Vector2.New(mainBallSize, mainBallSize)

	Framework.TransformUtil.SetLocalScale(self._mainBall.rectTrans, mainBallScale, mainBallScale, 1)

	self._mainBallBaseVelocity = checknumber(TimeLimitedConfig.instance:getLongHuangCommonValue("MAIN_BALL_BASE_VELOCITY"))
	self._fireBallBaseVelocity = checknumber(TimeLimitedConfig.instance:getLongHuangCommonValue("FIRE_BALL_BASE_VELOCITY"))
	self._bornPointCount = checknumber(TimeLimitedConfig.instance:getLongHuangCommonValue("FIRE_BALL_BIRTH_POINTS_NUMBER"))

	self:_initFixedPoints()
	self:_initBornPoints()

	self._usedFireBalls = {}
	self._freeFireBalls = {}

	local buffCfgs = TimeLimitedConfig.instance:getLongHuangGameBuffCfgs()

	self._maxSecs = buffCfgs[#buffCfgs].timeThreshold

	GameUtil.updateCellsWithCreate(self._buffLvs, buffCfgs, function(cell, buffCfg)
		local txtSecond = goutil.findChildTextComponent(cell, "txtSecond")
		local txtLevel = goutil.findChildTextComponent(cell, "txtLevel")

		txtSecond.text = buffCfg.timeThreshold .. "秒"
		txtLevel.text = buffCfg.grade .. "级"

		local h = self._sliderHeight * buffCfg.timeThreshold / self._maxSecs

		Framework.TransformUtil.SetLocalPos(cell.transform, 0, h, 0)
	end)

	self._challengeId = 3
end

function LonghuanggameView:_initFixedPoints()
	local str = TimeLimitedConfig.instance:getLongHuangCommonValue("FIXED_POINTS_POSITION")
	local strArr = string.split(str, "#")

	self._fixedPoints = {}

	for _, v in ipairs(strArr) do
		local ratio = Vector2.New(unpack(string.splitToNumber(v, ",")))
		local fixedPoint = self._mainAreaMinPoint + Vector2.Scale(self._mainAreaSize, ratio)

		self:logVector2(fixedPoint, "fixedPoint")
		table.insert(self._fixedPoints, fixedPoint)
	end
end

function LonghuanggameView:_initBornPoints()
	local sizeX, sizeY = self._mainAreaSize.x, self._mainAreaSize.y

	self._operations = {
		Vector2.New(sizeX, 0),
		Vector2.New(0, sizeY),
		Vector2.New(-sizeX, 0),
		Vector2.New(0, -sizeY)
	}
end

function LonghuanggameView:_initGame()
	self._btnClose.gameObject:SetActive(true)

	self._isRunning = false
	self._txtTickedTime.text = "0"

	self._progressBar:SetValue(0)
	self._rule:SetActive(true)
	self._startTip:SetActive(true)

	for _, v in ipairs(self._usedFireBalls) do
		v.rectTrans.gameObject:SetActive(false)
		table.insert(self._freeFireBalls, v)
	end

	self._usedFireBalls = {}
	self._mainBall.velocity = Vector2.zero
	self._mainBall.pos = Vector2.zero

	Framework.TransformUtil.SetAnchoredPos(self._mainBall.rectTrans, 0, 0)
	self._tempBg:SetActive(true)
	Framework.TransformUtil.SetLocalPos(self._joystickBg.transform, self._initBgPos.x, self._initBgPos.y, 0)
end

function LonghuanggameView:_startGame()
	local clientKey = LonghuangGameModel.instance:randomClientKey()

	TimedChallengeGameAgent.instance:sendPM_TimedChallengeStartGameReq(self._challengeId, clientKey, self._onStartGameRes, self)
end

function LonghuanggameView:_onStartGameRes(msg)
	self._btnClose.gameObject:SetActive(false)
	self._tempBg:SetActive(false)
	LonghuangGameModel.instance:setServerKey(msg.serverKey)
	FloatWordMgr.instance:show("开始游戏")

	self._tickedTime = 0
	self._isRunning = true
	self._cfg = TimeLimitedConfig.instance:getLongHuangGameTimeCfg(self._tickedTime)

	self:_bornFireBalls()
	self._rule:SetActive(false)
	self._startTip:SetActive(false)
	settimer(0, self._onTickGame, self, true)
end

function LonghuanggameView:_endGame(isWin)
	removetimer(self._onTickGame, self)
	self._joystickCtrl:StopJoystickMove()

	self._tickedTime = math.max(TimeLimitedConfig.instance:getMinDodgeTime(), self._tickedTime)

	local dodgeTime = math.floor(self._tickedTime * 1000)
	local encryptedKey = LonghuangGameModel.instance:getEncryptedKey(dodgeTime)

	TimedChallengeGameAgent.instance:sendPM_TimedChallengeEndGameReq(self._challengeId, dodgeTime, encryptedKey, self._onEndGameRes, self)
end

function LonghuanggameView:_onEndGameRes(msg)
	local oldDodgeTime = LonghuangGameModel.instance:getDodgeTime()

	LonghuangGameModel.instance:setDodgeTime(msg.dodgeTime, false)

	local oldBuffCfg = TimeLimitedConfig.instance:getLongHuangGameBuffCfg(oldDodgeTime)
	local newBuffCfg = TimeLimitedConfig.instance:getLongHuangGameBuffCfg(self._tickedTime)
	local params = {
		tickedTime = self._tickedTime,
		oldBuffCfg = oldBuffCfg,
		newBuffCfg = newBuffCfg
	}

	self:_initGame()
	GlobalDispatcher:dispatch(GlobalNotify.LonghuangBuffUpdate)
	self:close()
	UIStateManager.instance:push(ViewName.LonghuanggameresultView, params)
end

function LonghuanggameView:_onTickGame()
	local deltaTime = UnityEngine.Time.deltaTime

	self._tickedTime = self._tickedTime + deltaTime
	self._txtTickedTime.text = string.format("%.2f", self._tickedTime)

	self._progressBar:SetValue(self._tickedTime / self._maxSecs)

	local newCfg = TimeLimitedConfig.instance:getLongHuangGameTimeCfg(self._tickedTime)

	if newCfg ~= self._cfg then
		self._cfg = newCfg

		self:_bornFireBalls()
	end

	self:_moveOneFrame(deltaTime, self._mainBall, true)

	for _, v in ipairs(self._usedFireBalls) do
		self:_moveOneFrame(deltaTime, v)

		if GameUtil.getVector2Distance(v.pos, self._mainBall.pos) <= self._mainBall.radius + v.radius then
			self:_endGame()

			break
		end
	end

	if self._tickedTime >= self._maxSecs then
		self:_endGame(true)
	end
end

function LonghuanggameView:_bornFireBalls()
	if self._cfg == nil then
		return
	end

	local bornNum = checknumber(self:_randomGetNum(self._cfg.numberWeights))
	local directionPlan = checknumber(self:_randomGetNum(self._cfg.directionWeights))
	local velocityRatio = self._cfg.velocityRatio

	if bornNum == 0 then
		print("bornNum == 0")
	end

	for i = 1, bornNum do
		local fireBall = self:_getFireBall()

		fireBall.rectTrans.gameObject:SetActive(true)

		fireBall.pos = self:_randomGetBornPos()

		local towardPointPos = Vector2.zero

		if directionPlan == DirectionPlanType.TowardsMainBall then
			towardPointPos = self._mainBall.pos
		elseif directionPlan == DirectionPlanType.TowardsFixedPoint then
			towardPointPos = self._fixedPoints[math.random(1, #self._fixedPoints)]
		end

		local normalizedDir = Vector2.Normalize(towardPointPos - fireBall.pos)

		fireBall.velocity = normalizedDir * self._fireBallBaseVelocity * velocityRatio

		self:logVector2(fireBall.velocity, "fireBall velocity")

		local pos = fireBall.pos

		Framework.TransformUtil.SetAnchoredPos(fireBall.rectTrans, pos.x, pos.y)
		table.insert(self._usedFireBalls, fireBall)
	end
end

function LonghuanggameView:_getFireBall()
	local freeBall = self._freeFireBalls[1]

	if freeBall ~= nil then
		table.remove(self._freeFireBalls, 1)

		return freeBall
	end

	local fireBall = {}
	local go = goutil.cloneAndSetParent(self._fireBallGo, self._mainAreaRectTrans.transform)

	fireBall.rectTrans = go:GetComponent(typeof(UnityEngine.RectTransform))
	fireBall.radius = 15

	return fireBall
end

function LonghuanggameView:_randomGetBornPos()
	local sizeX, sizeY = self._mainAreaSize.x, self._mainAreaSize.y
	local randomLen = math.random(0, (sizeX + sizeY) * 2)
	local point = self._mainAreaMinPoint

	for _, v in ipairs(self._operations) do
		if v.x ~= 0 then
			local len = math.abs(v.x or v.y)

			if randomLen <= len then
				point = point + v * (randomLen / len)

				return point
			else
				point = point + v
				randomLen = randomLen - len
			end
		end
	end

	return point
end

function LonghuanggameView:_randomGetNum(weights)
	local array = string.split(weights, "#")
	local maxWeight = 0

	for _, v in ipairs(array) do
		local num, weight = unpack(string.splitToNumber(v, ","))

		maxWeight = maxWeight + weight
	end

	local random = math.random(1, maxWeight)
	local totalWeight = 0

	for _, v in ipairs(array) do
		local num, weight = unpack(string.splitToNumber(v, ","))

		totalWeight = totalWeight + weight

		if random <= totalWeight then
			return num
		end
	end
end

function LonghuanggameView:_moveOneFrame(deltaTime, ball, isInBound)
	local pos = ball.pos

	pos = pos + deltaTime * ball.velocity

	if isInBound then
		local minPoint = self._mainAreaMinPoint + Vector2.New(ball.radius, ball.radius)

		pos = Vector2.Min(pos, -minPoint)
		pos = Vector2.Max(pos, minPoint)
	end

	Framework.TransformUtil.SetAnchoredPos(ball.rectTrans, pos.x, pos.y)

	ball.pos = pos
end

function LonghuanggameView:logVector2(vector, peffix)
	print(peffix .. " x = " .. vector.x .. " y = " .. vector.y)
end

return LonghuanggameView
