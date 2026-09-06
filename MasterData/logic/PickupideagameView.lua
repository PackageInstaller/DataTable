-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickupidea/view/PickupideagameView.lua

module("logic.extensions.pickupidea.view.PickupideagameView", package.seeall)

local PickupideagameView = class("PickupideagameView", ViewComponent)

PickupideagameView.TipsKey = "PickupideagameView.TipsKey"
PickupideagameView.BgCellSpaceX = 128
PickupideagameView.BgCellSpaceY = 128

function PickupideagameView:ctor()
	PickupideagameView.super.ctor(self)

	self._bgCellSpaceX = PickupideagameView.BgCellSpaceX
	self._bgCellSpaceY = PickupideagameView.BgCellSpaceY
	self._bgCellOffsetX = 0
	self._bgCellOffsetY = 0
	self._cacheV3 = Vector3.New(0, 0, 0)
	self._highBubbleId = 5
	self._cacheColor = nil
	self._mainActorVelocity = 7
end

function PickupideagameView:unbindEvents()
	PickupideagameView.super.unbindEvents(self)
	self._btnStartGame:RemoveClickListener()
	self._virtualJoystick:RemoveDownListener()
	self._virtualJoystick:RemoveUpListener()
	self._virtualJoystick:RemoveDragListener()
	self._btnClose:RemoveClickListener()
end

function PickupideagameView:bindEvents()
	PickupideagameView.super.bindEvents(self)
	self._btnStartGame:AddClickListener(self._onClickStartGame, self)
	self._virtualJoystick:AddDownListener(self._onJoystickDown, self)
	self._virtualJoystick:AddUpListener(self._onJoystickUp, self)
	self._virtualJoystick:AddDragListener(self._onJoystickDrag, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function PickupideagameView:destroyUI()
	PickupideagameView.super.destroyUI(self)
	self._bubblePool:clear()
end

function PickupideagameView:buildUI()
	PickupideagameView.super.buildUI(self)

	self._startTip = self:getGo("gamestartTip")
	self._btnStartGame = self:getBtn("gamestartTip/btnStartGame")
	self._joystickBg = self:getGo("joystickview/joystickArea/joystickbackground")
	self._virtualJoystick = goutil.addComponentOnce(self._joystickBg, typeof(VirtualJoystick))
	self._initBgPos = Vector2.New(Framework.TransformUtil.GetLocalPos(self._joystickBg.transform, 0, 0, 0))
	self._joystickCtrl = goutil.findChildComponent(self.mainGO, "joystickview", typeof(ClickToShowJoystick))

	self._joystickCtrl:SetFixed(true)

	self._goMainActor = self:getGo("mainContainer/mainActor")
	self._goWudiBubble = self:getGo("mainContainer/mainActor/bubble")
	self._mainActor = {}
	self._mainActor.velocity = Vector2.zero
	self._mainActor.rectTrans = self:getGo("mainContainer/mainActor"):GetComponent(typeof(UnityEngine.RectTransform))
	self._mainActor.go = self:getGo("mainContainer/mainActor")
	self._rigidbody = self._mainActor.go:GetComponent(typeof(UnityEngine.Rigidbody2D))
	self._txtTime = self:getTxt("txtTime")
	self._bubbleList = {}
	self._itemCenter = self:getGo("itemCenter").transform
	self._bubbleCellGo = self:getGo("itemCenter/bubble")

	local function createFunc()
		local go = goutil.cloneAndSetParent(self._bubbleCellGo, self._itemCenter)
		local class = Framework.LuaComponentContainer.Add(go, PickUpGameBubble)

		return {
			gameObject = go,
			transform = go.transform,
			class = class
		}
	end

	local function disposeFunc(item)
		return
	end

	local function resetFunc(item)
		item.class:onExit()
		goutil.setActive(item.gameObject, false)
	end

	self._bubblePool = ObjectPool.New(25, createFunc, disposeFunc, resetFunc)
	self._bgCenterGo = self:getGo("bgCenter")
	self._bgCellGo = self:getGo("bgCenter/bgCell")
	self._bubble1Change = self:getGo("condition/bubble1"):GetComponent(ComponentType.UIImageSpriteChange)
	self._bubble2Change = self:getGo("condition/bubble2"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtScore = self:getTxt("txtScore")
	self._spiderGo = self:getGo("mainContainer/spider")

	goutil.setActive(self._spiderGo, false)

	self._joystickbackgroundFakeGo = self:getGo("joystickbackgroundFake")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._scoreMsgItemGo = self:getGo("mainContainer/scoreMsgItem")
	self._mainContainerTr = self:getGo("mainContainer").transform

	goutil.setActive(self._scoreMsgItemGo, false)

	self._scoreMsgItems = {}
	self._scoreMsgItemFrees = {}
	self._mainActor.class = Framework.LuaComponentContainer.Add(self._goMainActor, PickUpGameMainRole)

	self._mainActor.class:setView(self)
	self._mainActor.class:loadActor(self:_getActorPath())
end

function PickupideagameView:onExit()
	PickupideagameView.super.onExit(self)
	self:_removeTimer()

	if self._skillEffect then
		UIEffectManager.instance:stopEffect(self._skillEffect)

		self._skillEffect = nil
	end

	if self._towerEff then
		UIEffectManager.instance:stopEffect(self._towerEff)

		self._towerEff = nil
	end

	if self._towerDeadEffect then
		UIEffectManager.instance:stopEffect(self._towerDeadEffect)

		self._towerDeadEffect = nil
	end

	for k, list in pairs(self._mapBgCellObjs) do
		for _, v in pairs(list) do
			v:resetNormal()
		end
	end

	if self._spider then
		self._spider:setActive(false)
	end

	self._mainActor.class:onExit()
end

function PickupideagameView:_removeTimer()
	removetimer(self._tick, self)
	removetimer(self._tickLeftTime, self)
	removetimer(self._buildBubbles, self)
	removetimer(self._buildBlock, self)
	removetimer(self._buildSpider, self)
	removetimer(self._onTimeEndHitSpider, self)
	removetimer(self._tickWudi, self)
	removetimer(self._playHitSpiderEffect, self)
end

function PickupideagameView:onEnter()
	PickupideagameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PickUpIdeaBlockActive, self._onPickUpIdeaBlockActive, self)
	self.addGEvent(self, GlobalNotify.PickUpIdeaReliveRes, self._relive, self)
	self.addGEvent(self, GlobalNotify.PickUpIdeaBubbleMoveEnd, self._onPickUpIdeaBubbleMoveEnd, self)
	self._joystickCtrl.gameObject:SetActive(true)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = 338001
	end

	self._actCfg = PickupideaConfig.instance:getActivityCfg(self._activityId)
	self._lowBubbleId = 0

	goutil.setActive(self._joystickbackgroundFakeGo, true)
	goutil.setActive(self._startTip, true)
	self:_initGamePlan()
	self:_initGameData()
	self:_updateScore()
	self:_setTime()
	self:_buildMapBg()
	self:_calMainRoleMoveLimit()
	self:_setMainRolePos(1, 1)
	self:_buildBubbles(true)
	self:_showTipsView()
end

function PickupideagameView:_initGameData()
	self._animationScale = 1
	self._mapSize = PickupideaConfig.instance:getSize(self._activityId)
	self._score = 0
	self._tickedTime = 0
	self._isRunning = false
	self._maxTime = self._actCfg.gameTime
	self._vector2Cache = Vector2.New(0, 0)
	self._isJoystickDown = false
	self._radius = 37.5
	self._bgCellOffsetX = -self._mapSize[2] * self._bgCellSpaceX / 2 - self._bgCellSpaceX / 2 - 5
	self._bgCellOffsetY = self._mapSize[1] * self._bgCellSpaceY / 2 + self._bgCellSpaceY / 2
	self._roundBlockTime = self._actCfg.timeBlock
	self._roundSpiderTime = self._actCfg.timeSpider
	self._blockObjList = {}
	self._protectedTime = 0
	self._isCanMoving = true
end

function PickupideagameView:_initGamePlan()
	local ids = PickupideaConfig.instance:getGamePlanIds()

	self._gamePlanId = math.random(1, #ids)
	self._gamePlanCfgs = PickupideaConfig.instance:getGamePlanCfgs(self._gamePlanId)
	self._roundTime = math.floor(self._actCfg.gameTime / #self._gamePlanCfgs)
end

function PickupideagameView:_onClickStartGame()
	if not self._isRunning then
		self:_startGame()
	end
end

function PickupideagameView:_startGame()
	goutil.setActive(self._startTip, false)

	self._isRunning = true
	self._isProtected = false

	settimer(0, self._tick, self, true)
	settimer(1, self._tickLeftTime, self, true)
	settimer(self._roundTime, self._buildBubbles, self, true)
	settimer(self._roundBlockTime, self._buildBlock, self, true)
	settimer(self._roundSpiderTime, self._buildSpider, self, true)
end

function PickupideagameView:_onJoystickUp()
	self._isJoystickDown = false
	self._vector2Cache.x = 0
	self._vector2Cache.y = 0
	self._mainActor.velocity = self._vector2Cache

	goutil.setActive(self._joystickbackgroundFakeGo, true)
end

function PickupideagameView:_onJoystickDown()
	self._isJoystickDown = true

	goutil.setActive(self._joystickbackgroundFakeGo, false)
end

function PickupideagameView:_onJoystickDrag(x, y)
	if not self._isRunning then
		return
	end

	if not self._isCanMoving then
		self._vector2Cache.x = 0
		self._vector2Cache.y = 0
	else
		self._vector2Cache.x = x
		self._vector2Cache.y = y
	end

	self._mainActor.velocity = self._vector2Cache
end

function PickupideagameView:_tickLeftTime()
	self:_setTime()
end

function PickupideagameView:_tick()
	if not self._isRunning then
		return
	end

	self._tickedTime = self._tickedTime + UnityEngine.Time.deltaTime

	if self._tickedTime > self._maxTime then
		self:_playDeadEffect()

		return
	end

	local triggerPosV2 = self._mainActor.class:getTriggerPos()

	self:_checkBubbleHit(triggerPosV2)
	self:_moveMainActor()
	self:_checkSpiderHit(triggerPosV2)
	self:_checkBlockHit(triggerPosV2)
end

function PickupideagameView:_moveMainActor()
	if not self._isJoystickDown then
		return
	end

	local x, y, z = Framework.TransformUtil.GetLocalPos(self._mainActor.go.transform, 0, 0, 0)

	x = x + self._mainActorVelocity * self._mainActor.velocity.x
	y = y + self._mainActorVelocity * self._mainActor.velocity.y
	x, y = self:_checkPos(x, y)

	Framework.TransformUtil.SetLocalPos(self._mainActor.go.transform, x, y, z)

	if Mathf.Abs(self._mainActor.velocity.x - 0) > 1e-05 then
		self._mainActor.class:setDirection(self._mainActor.velocity.x < 0)
	end
end

function PickupideagameView:_checkBubbleHit(triggerPosV2)
	local isMoving = self._mainActor.velocity.x ~= 0 or self._mainActor.velocity.y ~= 0

	self._mainActor.class:_playAnimationAndEffect(self._animationScale, isMoving)

	for k, v in pairs(self._bubbleList) do
		if v.class:checkCollide(triggerPosV2, self._radius) then
			self._bubblePool:returnObject(v)

			self._bubbleList[k] = nil

			local row, col = v.class:getRowCol()

			self:_isHitBubble(v.class:getId())
		end
	end
end

function PickupideagameView:_getActorPath()
	return {
		"effect/prefabs/ui/20211028/zhiren_aoqi/zhiren_aoqi-ui_p.prefab"
	}
end

function PickupideagameView:_playDeadEffect()
	if self._isRunning then
		self:_setTime()
		self._joystickCtrl:StopJoystickMove()

		local deadUrl = "xiaoyouxi/xiaoanlongyouxi/fx_xiaoyouxi_siwang_02.prefab"

		self._towerDeadEffect = UIEffectManager.instance:playEffect(self, deadUrl, self.mainGO, 0, 0, false, nil, function()
			return
		end, function(o, eff)
			return
		end)

		self._towerDeadEffect:setParent(self.mainGO.transform)
		self._towerDeadEffect:setLocalPos(0, 0, 0)
		self._towerDeadEffect:setScale(20)

		self._isRunning = false

		local isOver = self:_isTimeOver()

		if isOver then
			self:_stopGame()
		else
			self:_tryRelive()
		end
	end
end

function PickupideagameView:_tryRelive()
	local matType, matId, matCount = MaterialMgr.getMatParams(self._actCfg.reliveItem)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local content = string.format("使用%s个%s复活吗？", matCount, matName)

	local function otherCallBack(res)
		if res == TipsFacade.STATE_CANCEL or res == TipsFacade.STATE_FAIL then
			self:_stopGame()
		end
	end

	local function successCallBack()
		self:_sendRelive()
	end

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matCount, content, successCallBack, nil, nil, nil, otherCallBack)
end

function PickupideagameView:_isTimeOver()
	return self._tickedTime >= self._maxTime
end

function PickupideagameView:_stopGame()
	self:_removeTimer()

	for k, v in pairs(self._bubbleList) do
		v.class:onExit()
	end

	PickupideaController.instance:sendPM_PickUpIdeaEndGameReq(self._score)
	self:close()
end

function PickupideagameView:_bornBubble(row, col, id)
	local x, y = self:_getTilePos(row, col)
	local item = self._bubblePool:fetchObject()

	goutil.setActive(item.gameObject, true)
	item.class:setParams(self, id, row, col)
	Framework.TransformUtil.SetLocalPos(item.transform, x, 400, 0)
	item.class:beginMove({
		x = x,
		y = y
	})

	self._bubbleList[item.gameObject] = item
end

function PickupideagameView:_buildBubbles(force)
	self:_setNeedBubbleIds()

	if not self._isRunning and not force then
		return
	end

	for k, v in pairs(self._bubbleList) do
		self._bubblePool:returnObject(v)

		self._bubbleList[k] = nil
	end

	local idx = math.random(1, #self._gamePlanCfgs)
	local cfg = self._gamePlanCfgs[idx]
	local needLow = cfg.lowNums
	local needHigh = cfg.highNums
	local noNeedLowNums = cfg.noNeedLowNums
	local creatIds = {}
	local noNeedLowIds = {}

	for i = 1, needLow do
		table.insert(creatIds, self._lowBubbleId)
	end

	for i = 1, 4 do
		if i ~= self._lowBubbleId then
			table.insert(noNeedLowIds, i)
		end
	end

	for i = 1, noNeedLowNums do
		local i = math.random(1, #noNeedLowIds)

		table.insert(creatIds, noNeedLowIds[i])
	end

	for i = 1, needHigh do
		table.insert(creatIds, self._highBubbleId)
	end

	local grids = self:_tryToPlaceIds(self._mapSize[1], self._mapSize[2], creatIds)

	for row, list in ipairs(grids) do
		for col, id in ipairs(list) do
			if id > 0 then
				self:_bornBubble(row, col, id)
			end
		end
	end
end

function PickupideagameView:_setTime()
	local leftTime = self._maxTime - self._tickedTime

	self._txtTime.text = leftTime <= 0 and lang("游戏结束") or string.format("%s秒", math.floor(leftTime))
end

function PickupideagameView:_buildMapBg()
	local x, y = 0, 0

	for row = 1, self._mapSize[1] do
		for col = 1, self._mapSize[2] do
			self._mapBgCellObjs = self._mapBgCellObjs or {}
			self._mapBgCellObjs[row] = self._mapBgCellObjs[row] or {}

			local obj = self._mapBgCellObjs[row][col]

			if not obj then
				local go = goutil.cloneAndSetParent(self._bgCellGo, self._bgCenterGo.transform)

				obj = PickUpGameBgCell.New(go, row, col)

				local var_35_0, var_35_1 = self:_getTilePos(row, col)

				obj:setPos(var_35_0, var_35_1)
				goutil.setActive(go, true)

				self._mapBgCellObjs[row][col] = obj
			end
		end
	end
end

function PickupideagameView:_getTilePos(row, col)
	local newPos = {
		row = col,
		col = -row
	}
	local x = newPos.row * self._bgCellSpaceX + self._bgCellOffsetX
	local y = newPos.col * self._bgCellSpaceY + self._bgCellOffsetY

	return x, y
end

function PickupideagameView:_tryToPlaceIds(n, m, creatIds)
	local grid = {}

	for i = 1, n do
		grid[i] = {}

		for j = 1, m do
			grid[i][j] = 0
		end
	end

	local shuffledIds = {}

	for i, v in ipairs(creatIds) do
		table.insert(shuffledIds, {
			placed = false,
			id = v
		})
	end

	for i = #shuffledIds, 2, -1 do
		local j = math.random(1, i - 1)

		shuffledIds[i], shuffledIds[j] = shuffledIds[j], shuffledIds[i]
	end

	local triggerPos = self._mainActor.class:getTriggerPos()

	for _, item in ipairs(shuffledIds) do
		local placed = false
		local attempts = 0

		while not placed and attempts < n * m do
			local x = math.random(1, n)
			local y = math.random(1, m)

			if grid[x][y] == 0 and self:_canPlace(grid, x, y, item.id) then
				local posx, posy = self:_getTilePos(x, y)

				if not self:_checkTwoCollider(triggerPos, {
					x = posx,
					y = posy
				}) then
					grid[x][y] = item.id
					placed = true
					item.placed = true
				end
			end

			attempts = attempts + 1
		end
	end

	for _, item in ipairs(shuffledIds) do
		if not item.placed then
			local placed = false

			while not placed do
				local x = math.random(1, n)
				local y = math.random(1, m)

				if grid[x][y] == 0 then
					grid[x][y] = item.id
					placed = true
				end
			end
		end
	end

	return grid
end

function PickupideagameView:_canPlace(grid, x, y, id)
	for i = 0, 1 do
		for j = 0, 1 do
			if grid[x - i] and grid[x - i][y - j] and grid[x - i][y - j] == id then
				return false
			end
		end
	end

	return true
end

function PickupideagameView:_setMainRolePos(row, col)
	local x, y = self:_getTilePos(row, col)

	Framework.TransformUtil.SetLocalPos(self._mainActor.go.transform, x, y, 0)
end

function PickupideagameView:_calMainRoleMoveLimit()
	local x1, y1 = self:_getTilePos(1, 1)
	local x2, y2 = self:_getTilePos(self._mapSize[1], self._mapSize[2])

	self._moveLimitData = {
		leftTop = {
			x = x1 - self._bgCellSpaceX / 2,
			y = y1 + self._bgCellSpaceY / 2
		},
		rigthBottom = {
			x = x2 + self._bgCellSpaceX / 2,
			y = y2 - self._bgCellSpaceY / 2
		}
	}
end

function PickupideagameView:_checkPos(x, y)
	x = Mathf.Clamp(x, self._moveLimitData.leftTop.x, self._moveLimitData.rigthBottom.x)
	y = Mathf.Clamp(y, self._moveLimitData.rigthBottom.y, self._moveLimitData.leftTop.y)

	return x, y
end

function PickupideagameView:_checkTwoCollider(pos1, pos2)
	return (pos1.x - pos2.x)^2 + (pos1.y - pos2.y)^2 <= math.pow(self._radius * 2, 2)
end

function PickupideagameView:_updateScore()
	self._txtScore.text = self._score
end

function PickupideagameView:_setNeedBubbleIds()
	if self._lowBubbleId > 0 then
		return
	end

	local list = {
		1,
		2,
		3,
		4
	}
	local idx = math.random(1, #list)

	self._lowBubbleId = list[idx]

	self._bubble1Change:SetState(self._lowBubbleId - 1)
	self._bubble2Change:SetState(self._highBubbleId - 1)
end

function PickupideagameView:_isHitBubble(id)
	local cfg = PickupideaConfig.instance:getBubbleCfg(id)
	local score = 0

	score = self:_checkIsNeedBubbleId(id) and cfg.score or -cfg.score
	self._score = self._score + score
	self._score = math.max(self._score, 0)

	self:_updateScore()
	self:_showScoreChangeAnim(score)
	self:_checkScoreMax()
end

function PickupideagameView:_showScoreChangeAnim(score)
	local absScore = math.abs(score)
	local item = table.remove(self._scoreMsgItemFrees, 1)

	item = item or goutil.cloneAndSetParent(self._scoreMsgItemGo, self._mainContainerTr)

	Framework.TransformUtil.SetLocalPos(item.transform, 0, 1000, 0)
	goutil.setActive(item, true)

	local txtScore = goutil.findChildTextComponent(item, "txt")

	if score <= 0 then
		if not GameEnum.ColorConst.Red then
			local color = GameEnum.ColorConst.Green
			local scoreSysbom = score <= 0 and "-" or "+"

			txtScore.text = string.format("<color=%s>%s%d</color>", color, scoreSysbom, absScore)
			self._scoreMsgItems[item] = item

			local tween = item:GetComponent(UnityTweensType.TweenPosition)

			tween:AddListener(function()
				goutil.setActive(item, false)

				self._scoreMsgItems[item] = nil

				table.insert(self._scoreMsgItemFrees, item)
			end)

			local x, y = Framework.TransformUtil.GetLocalPos(self._mainActor.rectTrans, 0, 0, 0)

			self._cacheV3.x = x
			self._cacheV3.y = y
			self._cacheV3.z = 0
			tween.from = self._cacheV3
			self._cacheV3.y = y + 50
			tween.to = self._cacheV3

			tween:Begin()
		end
	end
end

function PickupideagameView:_buildBlock()
	if not self._isRunning then
		return
	end

	self:_resetBgCells()

	local planId = PickupideaConfig.instance:getRandomBlockPlanId()
	local cfgs = PickupideaConfig.instance:getBlockCfgs(planId)
	local row, col = 0, 0

	self._blockObjList = {}

	for i, v in ipairs(cfgs) do
		local obj = self._mapBgCellObjs[v.pos[1]][v.pos[2]]

		obj:playWarning()
		table.insert(self._blockObjList, obj)
	end
end

function PickupideagameView:_buildSpider()
	if not self._isRunning then
		return
	end

	local grid = {}
	local row = 0
	local col = 0
	local triggerPos = self._mainActor.class:getTriggerPos()
	local maxTime = self._mapSize[1] * self._mapSize[2]
	local count = 0

	while count < maxTime do
		count = count + 1
		row = math.random(1, self._mapSize[1])
		col = math.random(1, self._mapSize[2])

		if not grid[row] or not grid[row][col] then
			grid[row] = grid[row] or {}
			grid[row][col] = true

			local obj = self._mapBgCellObjs[row][col]
			local posx, posy = obj:getPos()

			if not self:_checkTwoCollider(triggerPos, {
				x = posx,
				y = posy
			}) then
				self:_realBuildSpider(posx, posy)

				return
			end
		end
	end
end

function PickupideagameView:_realBuildSpider(posx, posy)
	self._spider = self._spider or PickUpGameSpider.New(self._spiderGo)

	self._spider:setPos(posx, posy)
	self._spider:setActive(true)
	self._spider:SetAsFirstSibling()
end

function PickupideagameView:_onPickUpIdeaBlockActive(row, col)
	for k, v in pairs(self._bubbleList) do
		if not v.class:isMoving() and v.class:isMe(row, col) then
			local r, c = v.class:getRowCol()

			self:_playBreakEffect(r, c)
			self._bubblePool:returnObject(v)

			self._bubbleList[k] = nil
		end
	end
end

function PickupideagameView:_checkSpiderHit(triggerPosV2)
	if self._isProtected then
		return
	end

	if self._spider and self._spider:isAlive() and self._spider:checkCollider(triggerPosV2, self._radius) then
		self._spider:die()
		self:_isHitSpider()
	end
end

function PickupideagameView:_checkBlockHit(triggerPosV2)
	if self._isProtected then
		return
	end

	for _, obj in pairs(self._blockObjList) do
		if obj:checkCollider(triggerPosV2, self._radius) then
			self:_playDeadEffect()

			return
		end
	end
end

function PickupideagameView:_showTipsView()
	local isOpen = GameUtil.getUserData(PickupideagameView.TipsKey)

	if isOpen then
		return
	end

	UIStateManager.instance:push(ViewName.PickupideatipsView)
end

function PickupideagameView:_resetBgCells()
	for k, list in pairs(self._mapBgCellObjs) do
		for _, v in pairs(list) do
			v:resetNormal()
		end
	end
end

function PickupideagameView:_sendRelive()
	PickUpIdeaAgent.instance:sendPM_PickUpIdeaReliveReq()
end

function PickupideagameView:_relive(status)
	if status < 0 then
		FloatWordMgr.instance:show("复活失败，结束游戏" .. status)
		self:_stopGame()

		return
	end

	self:_overHitSpiderTime()

	if table.nums(self._bubbleList) > 0 then
		for k, v in pairs(self._bubbleList) do
			local r, c = v.class:getRowCol()
			local isNeed = self:_checkIsNeedBubbleId(v.class:getId())

			if isNeed then
				self:_setMainRolePos(r, c)

				break
			end
		end
	else
		local isHit = false

		for row, list in pairs(self._mapBgCellObjs) do
			for col, obj in pairs(list) do
				if not obj:isDanger() then
					self:_setMainRolePos(row, col)

					isHit = true

					break
				end
			end

			if isHit then
				break
			end
		end
	end

	self:_addWudiBubble()

	self._isRunning = true
end

function PickupideagameView:_addWudiBubble()
	self._isProtected = true
	self._protectedTime = ServerTime.now() + self._actCfg.protectTime

	goutil.setActive(self._goWudiBubble, true)
	settimer(1, self._tickWudi, self, true)
end

function PickupideagameView:_isHitSpider()
	self._isCanMoving = false

	removetimer(self._buildSpider, self)
	settimer(self._actCfg.standTime, self._onTimeEndHitSpider, self, false)

	self._stopHitSpiderEffectTargetTime = ServerTime.now() + self._actCfg.standTime

	settimer(0.1, self._playHitSpiderEffect, self, true)
	self._spider:SetAsLastSibling()
	self._mainActor.class:hitSpider()
end

function PickupideagameView:_onTimeEndHitSpider()
	self:_overHitSpiderTime()
	settimer(self._roundSpiderTime, self._buildSpider, self, true)
end

function PickupideagameView:_overHitSpiderTime()
	removetimer(self._onTimeEndHitSpider, self)
	self._spider:setActive(false)
	self._mainActor.class:overHitSpider()

	self._isCanMoving = true
end

function PickupideagameView:_playHitSpiderEffect()
	if ServerTime.now() >= self._stopHitSpiderEffectTargetTime then
		self._mainActor.class:resetRoleHitSpiderEffect()

		return
	end

	self._mainActor.class:playHitSpiderEffect()
end

function PickupideagameView:_tickWudi()
	if self._protectedTime <= ServerTime.now() then
		self._isProtected = false

		removetimer(self._tickWudi, self)
		self:_hideWudiBubble()
	end
end

function PickupideagameView:_hideWudiBubble()
	goutil.setActive(self._goWudiBubble, false)
end

function PickupideagameView:_onClickbtnClose()
	local function okFunc()
		self:_stopGame()
	end

	local text = "立即结算游戏？"

	TipsFacade.instance:openPopupWindow("提示", text, okFunc)
end

function PickupideagameView:_checkIsNeedBubbleId(id)
	return self._lowBubbleId == id or self._highBubbleId == id
end

function PickupideagameView:_onPickUpIdeaBubbleMoveEnd(row, col)
	for i, v in ipairs(self._blockObjList) do
		local r, c = v:getRolCol()

		if r == row and c == col then
			self:_onPickUpIdeaBlockActive(row, col)
		end
	end
end

function PickupideagameView:_playBreakEffect(row, col)
	local x, y = self:_getTilePos(row, col)
	local effName = "20240209/shiqulinggan/fx_ui_shiqulinggan.prefab"
	local handle = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false)

	handle:setParent(self._itemCenter.transform)
	handle:setScale(1)
	handle:setLocalPos(x, y, 0)
end

function PickupideagameView:_checkScoreMax()
	if self._score >= 500 then
		self._score = 500

		self:_updateScore()

		self._isRunning = false

		local text = string.format("已达到单局积分上限%s分，恭喜通关~", self._score)

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			self:_stopGame()
		end)
	end
end

return PickupideagameView
