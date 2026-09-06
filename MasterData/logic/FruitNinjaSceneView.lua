-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fruitninja/view/FruitNinjaSceneView.lua

module("logic.extensions.fruitninja.view.FruitNinjaSceneView", package.seeall)

local FruitNinjaSceneView = class("FruitNinjaSceneView", ViewComponent)

function FruitNinjaSceneView:ctor()
	FruitNinjaSceneView.super.ctor(self)

	self._fruitCellList = {}
	self._fruitCellDic = {}
	self._fruitCompPools = {}
	self._fruitGoPools = {}
	self._clipGoPools = {}
	self._animClipGoInfos = {}
	self._fruitPipes = {}
	self._timerFinishCallBacks = {}
	self._timerFinishCds = {}
	self._critEffPool = {}
	self._sliceEffPool = {}
	self._pencilCellDic = {}
	self._draggingPointerIds = {}
	self._stateMachine = SimpleFSM.New()

	self._stateMachine:addState(FruitNinjaEnum.State_Preparing, GameUtil.handler(self._onPreparingEnter, self), nil, nil, nil)
	self._stateMachine:addState(FruitNinjaEnum.State_Runing, GameUtil.handler(self._onRuningEnter, self), nil, GameUtil.handler(self._onRuningUpdate, self), nil)
	self._stateMachine:addState(FruitNinjaEnum.State_Stoping, GameUtil.handler(self._onStopingEnter, self), nil, nil, nil)
	self._stateMachine:addState(FruitNinjaEnum.State_Ended, GameUtil.handler(self._onEndedEnter, self), nil, nil, nil)

	local linkedList = {
		[FruitNinjaEnum.State_Preparing] = {
			FruitNinjaEnum.State_Runing
		},
		[FruitNinjaEnum.State_Runing] = {
			FruitNinjaEnum.State_Stoping,
			FruitNinjaEnum.State_Ended
		},
		[FruitNinjaEnum.State_Stoping] = {
			FruitNinjaEnum.State_Runing,
			FruitNinjaEnum.State_Ended
		},
		[FruitNinjaEnum.State_Ended] = {
			FruitNinjaEnum.State_Preparing
		}
	}

	self._stateMachine:addLinkByLinkedList(linkedList)
end

function FruitNinjaSceneView:buildUI()
	FruitNinjaSceneView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._poolRoot = self:getGo("poolRoot")
	self._gameView = self:getGo("gameView")
	self._gameViewTran = self._gameView:GetComponent(goutil.Type_RectTransform)
	self._triggerPlane = self:getGo("triggerPlane")
	self._hitEffRoot = self:getGo("hitEffRoot")
	self._txtScore = self:getTxt("score/txt")
	self._leftTimeGo = self:getGo("leftTime")
	self._txtLeftTime = self:getTxt("leftTime/txt")
	self._startTips = self:getGo("startTips")
	self._comboTips = self:getGo("comboTips")
	self._txtComboTips = self:getTxt("comboTips/txt")
	self._critTips = self:getGo("critTips")
	self._txtCritTips = self:getTxt("critTips/txt")
	self._bottomView = self:getGo("bottomView")
	self._topView = self:getGo("topView")
	self._doubleTimeGo = self:getGo("stateView/doubleTime")
	self._txtDoubleTime = self:getTxt("stateView/doubleTime/txt")
	self._crazyTimeGo = self:getGo("stateView/crazyTime")
	self._txtCrazyTime = self:getTxt("stateView/crazyTime/txt")
	self._comboWin = self:getGo("stateView/comboWin")
	self._txtComboWin = self:getTxt("stateView/comboWin/txt")
	self._comboFinish = self:getGo("stateView/comboFinish")
	self._txtScoreComboFinish = self:getTxt("stateView/comboFinish/txtScore")
	self._txtComboFinish = self:getTxt("stateView/comboFinish/txtCombo")
	self._boomTipsView = self:getGo("boomTipsView")
	self._critBoomTips = self:getGo("critBoomTips")
	self._pencilCell = self:getGo("pencilCell")
	self._pencilView = self:getGo("pencilView")
	self._healthCells = {}
	self._healthGo = self:getGo("stateView/health")

	local healthView = self:getGo("stateView/health/view")

	for idx = 1, healthView.transform.childCount do
		self._healthCells[idx] = healthView.transform:GetChild(idx - 1).gameObject
	end

	local norShootPipes = self:getGo("norShootPipes")

	self._norShootPipesList = {}

	for idx = 1, norShootPipes.transform.childCount do
		self._norShootPipesList[idx] = norShootPipes.transform:GetChild(idx - 1).gameObject
	end

	local spShootPipes = self:getGo("spShootPipes")

	self._spShootPipesList = {}

	for idx = 1, spShootPipes.transform.childCount do
		self._spShootPipesList[idx] = spShootPipes.transform:GetChild(idx - 1).gameObject
	end

	self._mapBound = self:getGo("mapBound")

	local boxX, boxY, boxZ = Framework.TransformUtil.GetPos(self._mapBound.transform, nil, nil, nil)

	self._mapBoundBox2D = BoundingBox2D.New()

	self._mapBoundBox2D:setSize(self._mapBound.transform.sizeDelta.x, self._mapBound.transform.sizeDelta.y)
	self._mapBoundBox2D:setCenter(boxX, boxY)
	GameUtil.SetActive(self._comboTips, false)
	GameUtil.SetActive(self._comboWin, false)
	GameUtil.SetActive(self._comboFinish, false)
	GameUtil.SetActive(self._doubleTimeGo, false)
	GameUtil.SetActive(self._crazyTimeGo, false)
end

function FruitNinjaSceneView:bindEvents()
	FruitNinjaSceneView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._exitGame, self)
	GameUtil.addClickHandler(self._startTips, self._onClickStartTips, self)

	local triggerGo = self._triggerPlane

	self._pointerDownHandler = PointerDownHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:_onPointerDownHandler(_go, eventData)
	end)
	self._beginDragHandler = BeginDragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:_onBeginDragHandler(_go, eventData)
	end)
	self._endDragHandler = EndDragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:_onEndDragHandler(_go, eventData)
	end)
	self._dragHandler = DragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
		self:_onDragHandler(_go, eventData)
	end)
end

function FruitNinjaSceneView:unbindEvents()
	FruitNinjaSceneView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._startTips)

	local triggerGo = self._triggerPlane

	self._pointerDownHandler = PointerDownHandler.Get(triggerGo):RemoveLuaHandler(self._pointerDownHandler)
	self._beginDragHandler = BeginDragHandler.Get(triggerGo):RemoveLuaHandler(self._beginDragHandler)
	self._endDragHandler = EndDragHandler.Get(triggerGo):RemoveLuaHandler(self._endDragHandler)
	self._dragHandler = DragHandler.Get(triggerGo):RemoveLuaHandler(self._dragHandler)
end

function FruitNinjaSceneView:onEnter()
	FruitNinjaSceneView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._gameParam = params[1] or FruitNinjaGameParam.New()
	self._gameMode = self._gameParam:getGameMode()
	self._gamePlanId = self._gameParam:getGamePlanId()
	self._maxTotalScoreLimit = self._gameParam:getMaxTotalScoreLimit()
	self._uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	self:_initAllPencilCell()
	self.addGEvent(self, GlobalNotify.GameSureCloseView, self._gameSureCloseView, self)
	self.addGEvent(self, GlobalNotify.GameCancelCloseView, self._gameCancelCloseView, self)
	self.addGEvent(self, GlobalNotify.GameResetProcess, self._gameResetProcess, self)
	self.addGEvent(self, GlobalNotify.FruitNinjaFruitTrickHit, self._fruitNinjaFruitTrickHit, self)
	self._stateMachine:startTimer()
	self._stateMachine:gotoState(FruitNinjaEnum.State_Preparing)
end

function FruitNinjaSceneView:onExit()
	FruitNinjaSceneView.super.onExit(self)

	self._uiCamera = nil

	self._stateMachine:stopTimer()

	if self._doubleStateEff then
		self:stopViewEffect(self._doubleStateEff)

		self._doubleStateEff = nil
	end

	if self._crazyStateEff then
		self:stopViewEffect(self._crazyStateEff)

		self._crazyStateEff = nil
	end

	self:_clearAllPencilCell()
	self:_clearAllTimerFinishHandler()
	self:_clearAllPipe()
	self:_clearFruitCellPool()
	self:_clearAllCritEff()
	self:_clearAllSliceEff()
end

function FruitNinjaSceneView:destroyUI()
	FruitNinjaSceneView.super.destroyUI(self)
	self._stateMachine:clear()
end

function FruitNinjaSceneView:_gameSureCloseView()
	self:_closeGame()
end

function FruitNinjaSceneView:_gameCancelCloseView()
	self._stateMachine:gotoState(FruitNinjaEnum.State_Runing)
end

function FruitNinjaSceneView:_gameResetProcess()
	self._stateMachine:gotoState(FruitNinjaEnum.State_Preparing)
end

function FruitNinjaSceneView:_fruitNinjaFruitTrickHit(pointerId, entityId)
	local cell = self._fruitCellDic[entityId]

	if cell == nil then
		printError(string.format("cell is nil, entityId = %d", entityId))

		return
	end

	local fruitId = cell:getFruitId()
	local fruitRigidBody = cell:getRigidBody()
	local fruitMainGo = cell:getGameObject()
	local localX, localY, localZ = cell:getGoLocalPos()
	local worldX, worldY, worldZ = cell:getGoWorldPos()
	local rX, rY, rZ = Framework.TransformUtil.GetLocalRotation(fruitMainGo.transform, 0, 0, 0)
	local addHealth = FruitNinjaConfig.instance:getSliceHealth(fruitId)

	self._curHealth = Mathf.Max(self._curHealth + addHealth, 0)

	local addScore = FruitNinjaConfig.instance:getFruitScore(fruitId)
	local criticalScore = FruitNinjaConfig.instance:getFruitCriticalScore(fruitId)

	if criticalScore ~= 0 then
		local critRandomValue = Mathf.Random(0, 100)
		local isCrit = critRandomValue <= self._criticalRate

		if isCrit then
			addScore = addScore + FruitNinjaConfig.instance:getFruitCriticalScore(fruitId)
		end
	end

	if self._curDoubleTime > 0 then
		addScore = addScore * 2
	end

	self:_addScore(addScore)

	local doubleTime = FruitNinjaConfig.instance:getFruitDoubleTime(fruitId)

	self._curDoubleTime = self._curDoubleTime + doubleTime

	local crazyTime = FruitNinjaConfig.instance:getFruitCrazyTime(fruitId)

	self._curCrazyTime = self._curCrazyTime + crazyTime
	self._comboSliceTimes = self._comboSliceTimes + 1
	self._curSliceDuration = 0

	if FruitNinjaConfig.instance:isClearScreen(fruitId) then
		self._isNeedClearScreen = true
	end

	self:_updateHealthValue(self._curHealth)

	if isCrit then
		self:_showCritTips(addScore, worldX, worldY, worldZ)
		self:_showCritEff(fruitId, worldX, worldY, worldZ)
	elseif self._comboSliceTimes >= 3 then
		self:_showCombo(self._comboSliceTimes, addScore, worldX, worldY, worldZ)
	end

	self:_showSliceEff(fruitId, worldX, worldY, worldZ)

	local pencilCell = self:_getPencilCell(pointerId)
	local direction = Vector3.Normalize(pencilCell._direction)
	local pencilMagnitude = pencilCell._direction:SqrMagnitude()
	local position = pencilCell._mainGo.transform.position
	local rbVelocity = fruitRigidBody.velocity
	local velocityMagnitude = rbVelocity.x * rbVelocity.x + rbVelocity.y * rbVelocity.y
	local force = velocityMagnitude == 0 and 0 or pencilMagnitude / velocityMagnitude

	force = Mathf.Clamp(force, 0.8, 1.8)

	local clipPath = FruitNinjaConfig.instance:getFruitClipPath(fruitId) or {}

	for idx = 1, #clipPath do
		local clipGo = self:_fetchClipGo(fruitId)

		self._animClipGoInfos[clipGo] = {
			fruitId = fruitId,
			mainGo = clipGo,
			cd = FruitNinjaEnum.ClipAnimTimes
		}

		if clipGo and not string.nilorempty(clipPath[idx]) then
			local spriteName = GameUrl.getBigbgPngUrl(clipPath[idx])

			uGuiUtil.setSpriteToImage(clipGo, uGuiUtil.SpriteType.BigBg, spriteName, function()
				clipGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end)
		end

		GameUtil.SetActive(clipGo, true)
		GameUtil.setLocalPos(clipGo, localX, localY, localZ)
		GameUtil.setLocalRotation(clipGo, rX, rY, rZ)
		GameUtil.setLocalScale(clipGo, cell:getBaseScale())

		local rbObj = clipGo:GetComponent(ComponentType.Rigidbody2D)

		rbObj.gravityScale = fruitRigidBody.gravityScale
		rbObj.velocity = fruitRigidBody.velocity
		rbObj.angularVelocity = fruitRigidBody.angularVelocity

		local angle = FruitNinjaEnum.SlicedAngles[(idx - 1) % #FruitNinjaEnum.SlicedAngles + 1]
		local dir = MmUtil.rotateVector2(direction, angle):Mul(force)

		rbObj:AddForceAtPosition(dir, position, FruitNinjaEnum.ForceMode2D.Impulse)
	end
end

function FruitNinjaSceneView:_onClickStartTips()
	GameUtil.SetActive(self._startTips, false)
	self._stateMachine:gotoState(FruitNinjaEnum.State_Runing)
end

function FruitNinjaSceneView:_onPreparingEnter()
	self:_resetGame()
end

function FruitNinjaSceneView:_onRuningEnter()
	self:_continueGame()
end

function FruitNinjaSceneView:_onStopingEnter()
	self:_stopGame()
end

function FruitNinjaSceneView:_onEndedEnter()
	self:_endGame()
end

function FruitNinjaSceneView:_onRuningUpdate()
	self._deltaTime = UnityEngine.Time.deltaTime
	self._curGameTime = self._curGameTime + self._deltaTime
	self._leftGameTime = Mathf.Max(self._maxGameTime - self._curGameTime, 0)
	self._curDoubleTime = Mathf.Max(self._curDoubleTime - self._deltaTime, 0)
	self._oldCrazyTime = self._curCrazyTime
	self._curCrazyTime = Mathf.Max(self._curCrazyTime - self._deltaTime, 0)
	self._curShootDurationCd = self._curShootDurationCd - self._deltaTime

	if self._curCrazyTime <= 0 then
		if self._curShootDurationCd <= 0 then
			self._curShootDurationCd = self._shootDuration

			local r1 = self._eachShootCount[1]

			if not self._eachShootCount[2] then
				local r2 = r1
				local fruitCount = Mathf.Random(r1, r2)
				local fruitIdList = MmUtil.randomPick(self._fruitCategory, fruitCount)

				if #self._specialFruitIdList > 0 then
					local specialRandomValue = Mathf.Random(0, 100)

					for i = 1, (specialRandomValue <= self._specialFruitRate or nil) and 1 do
						local fruitId = table.remove(self._specialFruitIdList, #self._specialFruitIdList)

						table.insert(fruitIdList, Mathf.Random(1, #fruitIdList), fruitId)
					end
				end

				local shootPipesList = self._norShootPipesList
				local popCd = Mathf.Min(self._shootDuration, self._furuitPopCd)

				for idx = 1, #fruitIdList do
					local pipe = shootPipesList[Mathf.Random(1, #shootPipesList)]
					local fruitId = fruitIdList[idx]

					self:_addFruitToPipe(pipe, fruitId, self._shootForce, popCd)
				end
			end
		end
	elseif self._curShootDurationCd <= 0 then
		self._curShootDurationCd = self._furuitPopCd

		local shootPipesList = self._spShootPipesList
		local fruitCount = #shootPipesList
		local fruitIdList = MmUtil.randomPick(self._fruitCategory, fruitCount)

		if #self._specialFruitIdList > 0 then
			local specialRandomValue = Mathf.Random(0, 100)

			for i = 1, (specialRandomValue <= self._specialFruitRate or nil) and 1 do
				local fruitId = table.remove(self._specialFruitIdList, #self._specialFruitIdList)

				table.remove(fruitIdList, #fruitIdList)
				table.insert(fruitIdList, Mathf.Random(1, #fruitIdList), fruitId)
			end
		end

		for idx = 1, #shootPipesList do
			local pipe = shootPipesList[idx]
			local fruitId = fruitIdList[idx]

			if fruitId and fruitId > 0 then
				self:_addFruitToPipe(pipe, fruitId, self._shootForce, self._furuitPopCd)
			end
		end
	end

	for pipe, queue in pairs(self._fruitPipes) do
		local info = queue:peekFront()

		if info then
			info.cd = info.cd - self._deltaTime

			if info.cd <= 0 then
				queue:popFront()
				self:_shootFruits(info.fruitId, pipe, info.force, 1)
			end
		end
	end

	for _, cell in ipairs(self._fruitCellList) do
		cell:onTicking(self._deltaTime)
	end

	if self._isNeedClearScreen then
		self._isNeedClearScreen = false

		for _, cell in ipairs(self._fruitCellList) do
			if cell:getState() == FruitNinjaEnum.CellState_Running then
				cell:trickClearScreen()
			end
		end

		for pipe, queue in pairs(self._fruitPipes) do
			local info = queue:peekFront()

			if info then
				info.cd = 4
			end
		end
	end

	local x, y, z = 0, 0, 0

	for _, cell in ipairs(self._fruitCellList) do
		if cell:getState() == FruitNinjaEnum.CellState_Running then
			local var_22_1, var_22_2, var_22_3 = cell:getGoLocalPos()

			z = var_22_3

			if not self._mapBoundBox2D:contains(var_22_1, var_22_2) then
				if self._curCrazyTime <= 0 then
					local fruitId = cell:getFruitId()
					local addHealth = FruitNinjaConfig.instance:getOutHealth(fruitId)

					self._curHealth = Mathf.Max(self._curHealth + addHealth, 0)
				end

				cell:trickOutBound()
			end
		end
	end

	local tempCellList = {}

	for _, cell in ipairs(self._fruitCellList) do
		if cell:getState() == FruitNinjaEnum.CellState_Ended then
			table.insert(tempCellList, cell)
		end
	end

	for _, cell in ipairs(tempCellList) do
		self:_returnFruitCell(cell)
	end

	for key, info in pairs(self._animClipGoInfos) do
		info.cd = info.cd - self._deltaTime

		if info.cd <= 0 then
			self:_returnClipGo(info.fruitId, info.mainGo)

			self._animClipGoInfos[key] = nil
		end
	end

	self._curSliceDuration = self._curSliceDuration + self._deltaTime

	if self._curSliceDuration >= FruitNinjaEnum.MaxSliceDuration then
		self._comboSliceTimes = 0
	end

	if self._oldCrazyTime > 0 and self._curCrazyTime <= 0 or self._oldCrazyTime <= 0 and self._curCrazyTime > 0 then
		self:_clearAllPipe()
		self:_updateRhythm()
	end

	self:_updateHealthValue(self._curHealth)

	for key, cd in pairs(self._timerFinishCds) do
		cd = cd - self._deltaTime
		self._timerFinishCds[key] = cd

		if cd <= 0 then
			GameUtil.callBack(self._timerFinishCallBacks[key])
			self:_clearTimerFinishHandler(key)
		end
	end

	self._txtScore.text = self._score
	self._txtLeftTime.text = string.format("%ss", Mathf.Floor(self._leftGameTime))

	if self._curDoubleTime > 0 then
		if not GameUtil.GetActive(self._doubleTimeGo) then
			GameUtil.SetActive(self._doubleTimeGo, true)
		end

		self._txtDoubleTime.text = string.format("%ss", Mathf.Floor(self._curDoubleTime))
	elseif GameUtil.GetActive(self._doubleTimeGo) then
		GameUtil.SetActive(self._doubleTimeGo, false)
	end

	if self._curCrazyTime > 0 then
		if not GameUtil.GetActive(self._crazyTimeGo) then
			GameUtil.SetActive(self._crazyTimeGo, true)
		end

		self._txtCrazyTime.text = string.format("%ss", Mathf.Floor(self._curCrazyTime))
	elseif GameUtil.GetActive(self._crazyTimeGo) then
		GameUtil.SetActive(self._crazyTimeGo, false)
	end

	if self._curCrazyTime <= 0 then
		if self._crazyStateEff then
			self:stopViewEffect(self._crazyStateEff)

			self._crazyStateEff = nil
		end
	elseif self._crazyStateEff == nil then
		self._crazyStateEff = self:playViewEffect("20250430/shuiguorenzhe/fx_ui_sgrz_red.prefab", self._bottomView, self.mainGO, true, 0, 0)
	end

	if self._curDoubleTime <= 0 then
		if self._doubleStateEff then
			self:stopViewEffect(self._doubleStateEff)

			self._doubleStateEff = nil
		end
	elseif self._doubleStateEff == nil then
		self._doubleStateEff = self:playViewEffect("20250430/shuiguorenzhe/fx_ui_sgrz_blue.prefab", self._bottomView, self.mainGO, true, 0, 0)
	end

	if self._maxGameTime > 0 and self._leftGameTime <= 0 or self._defaultHealth > 0 and self._curHealth <= 0 then
		self._stateMachine:gotoState(FruitNinjaEnum.State_Ended)
	end
end

function FruitNinjaSceneView:_shootFruits(fruitId, pipe, force, count)
	for idx = 1, count do
		local cell = self:_fetchFruitCell(fruitId)
		local x, y, z = Framework.TransformUtil.GetPos(pipe.transform, 0, 0, 0)
		local rigidBody = cell:getRigidBody()

		rigidBody.velocity = Vector2.zero

		local baseGravityScale = cell:getBaseGravityScale()
		local gravityScale = baseGravityScale + self._rhythmGravityScale

		cell:setGravityScale(gravityScale)
		cell:setActive(true)
		cell:setGoPos(x, y, z)
		cell:addForce(pipe.transform.up * force, FruitNinjaEnum.ForceMode2D.Impulse)
		cell:AddTorque(Mathf.Random(-3, 3), FruitNinjaEnum.ForceMode2D.Impulse)
		cell:startRunning()
	end
end

function FruitNinjaSceneView:_updateRhythm()
	local rhythmScore = 0

	if self._gainScore > 0 then
		rhythmScore = (self._gainScore - 1) % self._maxRhythmScore + 1
	end

	local info = MmUtil.binarySearchInSingleKey(self._specialFruitRateList, "score", rhythmScore)

	if info then
		self._specialFruitRate = info.rate or 0
	end

	local rhythmCfg = self._curCrazyTime <= 0 and FruitNinjaConfig.instance:getRhythmCfg(self._gamePlanId) or FruitNinjaConfig.instance:getCrazyRhythmCfg(self._gamePlanId)
	local data

	if rhythmCfg then
		data = MmUtil.binarySearchInSingleKey(rhythmCfg, "score", rhythmScore)
	end

	if data == nil then
		printError(string.format("配置缺失 gamePlanId:%s, score:%s ( export_节奏配置  in  xs-小游戏-水果忍者.xlsx  )", self._gamePlanId, rhythmScore))
	else
		if self._curRhythmPlanId == data.rhythmPlanId and self._curRhythmId == data.rhythmId then
			return
		end

		self._curRhythmId = data.rhythmId
		self._curRhythmPlanId = data.rhythmPlanId
	end

	if data then
		self._fruitCategory = data.fruitCategory or {}
	end

	if data then
		self._eachShootCount = data.eachShootCount or {
			0,
			0
		}
	end

	if data then
		self._shootDuration = data.shootDuration or 3
	end

	self._furuitPopCd = 0.5

	if data then
		self._shootForce = data.shootForce or 1.5
	end

	if data then
		self._rhythmGravityScale = data.gravityScale or 0
	end

	if self._curCrazyTime > 0 then
		self._shootForce = 1.5
		self._rhythmGravityScale = 0
	end

	self._specialFruitIdList = {}

	if data and data.specialFruits then
		for _, v in ipairs(data.specialFruits) do
			local fruitId = v[1]
			local count = v[2]

			for i = 1, count do
				table.insert(self._specialFruitIdList, fruitId)
			end
		end
	end

	local startScore = 0
	local endScore = 0

	if data then
		if not data.rhythmId then
			local curRhythmId = 0
			local nextData = rhythmCfg[curRhythmId + 1]

			if nextData then
				startScore = data.score
				endScore = nextData.score
			else
				local lastData = rhythmCfg[curRhythmId - 1]

				if lastData then
					startScore = lastData.score
					endScore = data.score
				end
			end

			local stepCount = 15
			local eachDiffScore = Mathf.Floor(Mathf.Max(endScore - startScore, 0) / stepCount)

			self._specialFruitRateList = {}

			for idx = 1, stepCount do
				local score = startScore + idx * eachDiffScore
				local rate = Mathf.SmoothStep(0, 1, idx / stepCount) * 100

				table.insert(self._specialFruitRateList, {
					score = score,
					rate = rate
				})
			end
		end
	end
end

function FruitNinjaSceneView:_getLeftGameTime()
	return self._leftGameTime
end

function FruitNinjaSceneView:_getCurState()
	return self._stateMachine.currStateName
end

function FruitNinjaSceneView:_resetGame()
	local planData = FruitNinjaConfig.instance:getGamePlanData(self._gamePlanId)

	self._maxGameTime = planData.gameTime
	self._defaultCriticalRate = self._gameParam:getDefaultCriticalRate()
	self._criticalRate = Mathf.Clamp(self._defaultCriticalRate * 100, 0, 100)
	self._curGameTime = 0
	self._leftGameTime = Mathf.Max(self._maxGameTime - self._curGameTime, 0)
	self._curDoubleTime = 0
	self._curCrazyTime = 0
	self._curShootDurationCd = 0
	self._score = 0
	self._gainScore = 0
	self._curSliceDuration = 0
	self._comboSliceTimes = 0
	self._curRhythmPlanId = 0
	self._curRhythmId = 0
	self._defaultHealth = planData.healthCount
	self._curHealth = self._defaultHealth
	self._isNeedClearScreen = false

	table.clear(self._draggingPointerIds)

	local rhythmCfg = FruitNinjaConfig.instance:getRhythmCfg(self._gamePlanId) or {}
	local lastOneRhythmData = rhythmCfg[#rhythmCfg]

	if not rhythmCfg[#rhythmCfg - 1] then
		local lastTwoRhythmData = lastOneRhythmData

		if lastOneRhythmData then
			if not lastOneRhythmData.score then
				local lastOneScore = 0

				if lastTwoRhythmData then
					if not lastTwoRhythmData.score then
						local lastTwoScore = 0

						self._maxRhythmScore = lastOneScore + (lastOneScore - lastTwoScore)

						self:_updateRhythm()
						self:_clearAllTimerFinishHandler()
						self:_clearAllCritEff()
						self:_clearAllSliceEff()

						if self._doubleStateEff then
							self:stopViewEffect(self._doubleStateEff)

							self._doubleStateEff = nil
						end

						if self._crazyStateEff then
							self:stopViewEffect(self._crazyStateEff)

							self._crazyStateEff = nil
						end

						self._txtLeftTime.text = self._leftGameTime

						GameUtil.SetActive(self._leftTimeGo, self._maxGameTime > 0)

						self._txtScore.text = self._score

						self:_hideCombo()
						self:_hideCritTips()
						self:_hideComboFinish()
						GameUtil.SetActive(self._doubleTimeGo, false)
						GameUtil.SetActive(self._crazyTimeGo, false)
						GameUtil.SetActive(self._healthGo, self._defaultHealth > 0)
						self:_updateHealthValue(self._curHealth)
						GameUtil.SetActive(self._startTips, true)
					end
				end
			end
		end
	end
end

function FruitNinjaSceneView:_continueGame()
	for _, cell in ipairs(self._fruitCellList) do
		cell:setActive(true)
		cell:recoverMotion()
	end
end

function FruitNinjaSceneView:_stopGame()
	for _, cell in ipairs(self._fruitCellList) do
		cell:setActive(false)
	end
end

function FruitNinjaSceneView:_endGame()
	self:_doGameEndCallBack(MmUtil.GameResult_GameOverOfSuccess)
end

function FruitNinjaSceneView:_exitGame()
	self._stateMachine:gotoState(FruitNinjaEnum.State_Stoping)
	self:_doGameEndCallBack(MmUtil.GameResult_GameOverOfDropOut)
end

function FruitNinjaSceneView:_closeGame()
	self:close()
end

function FruitNinjaSceneView:_doGameEndCallBack(gameEndRes)
	self._gameParam:doGameEndCallBack(gameEndRes, self)
end

function FruitNinjaSceneView:_addScore(value)
	self._score = self._maxTotalScoreLimit > 0 and Mathf.Clamp(self._score + value, 0, self._maxTotalScoreLimit) or Mathf.Max(self._score + value, 0)

	if value > 0 then
		self._gainScore = self._maxTotalScoreLimit > 0 and Mathf.Clamp(self._gainScore + value, 0, self._maxTotalScoreLimit) or Mathf.Max(self._gainScore + value, 0)

		self:_updateRhythm()
	end
end

function FruitNinjaSceneView:getScore()
	return self._score
end

function FruitNinjaSceneView:_addFruitToPipe(pipe, fruitId, force, cd)
	if self._fruitPipes[pipe] == nil then
		self._fruitPipes[pipe] = DeQueue.New()
	end

	local info = {
		fruitId = fruitId,
		force = force,
		cd = cd
	}

	self._fruitPipes[pipe]:pushBack(info)
end

function FruitNinjaSceneView:_clearPipe(pipe)
	if self._fruitPipes[pipe] then
		self._fruitPipes[pipe]:clear()
	end
end

function FruitNinjaSceneView:_clearAllPipe()
	for pipe, v in pairs(self._fruitPipes) do
		self._fruitPipes[pipe]:clear()
	end
end

function FruitNinjaSceneView:_showCombo(times, score, x, y, z)
	self:_addTimerFinishCallBack("comboTips", 2, GameUtil.handler(self._hideCombo, self))

	self._txtComboTips.text = string.format("%s连击！+%s", times, score)
	self._txtComboWin.text = times

	GameUtil.SetActive(self._comboTips, true)
	GameUtil.SetActive(self._comboWin, true)
	GameUtil.setPos(self._comboTips, x, y, z)
end

function FruitNinjaSceneView:_hideCombo()
	self:_clearTimerFinishHandler("comboTips")
	GameUtil.SetActive(self._comboTips, false)
	GameUtil.SetActive(self._comboWin, false)
end

function FruitNinjaSceneView:_showComboFinish(times, score)
	self:_addTimerFinishCallBack("comboFinish", 2, GameUtil.handler(self._hideComboFinish, self))

	self._txtComboFinish.text = times
	self._txtScoreComboFinish.text = string.format("额外得分：%s", score)

	GameUtil.SetActive(self._comboFinish, true)
	GameUtil.SetActive(self._comboWin, false)
end

function FruitNinjaSceneView:_hideComboFinish()
	self:_clearTimerFinishHandler("comboFinish")
	GameUtil.SetActive(self._comboFinish, false)
end

function FruitNinjaSceneView:_showCritTips(score, x, y, z)
	self:_addTimerFinishCallBack("critTips", 2, GameUtil.handler(self._hideCritTips, self))

	self._txtCritTips.text = score >= 0 and string.format("暴击！+%s", score) or string.format("暴击！%s", score)

	GameUtil.SetActive(self._critTips, true)
	GameUtil.setPos(self._critTips, x, y, z)

	local effPath = {
		"ui/views/fruitninja/cell/redcritboomeff.prefab"
	}

	if effPath then
		local function finishHandle(handlerTarget, eff)
			self:_clearCritEff(eff)
		end

		local function loadedHandler(handlerTarget, eff)
			GameUtil.SetActive(eff.effGo, true)
			GameUtil.setPos(eff.effGo, x, y, z)
		end

		local critEff = self:playViewEffect(effPath, self._bottomView, self._bottomView, false, 0, 0, finishHandle, loadedHandler)

		self._critEffPool[critEff] = critEff

		self:_addTimerFinishCallBack(critEff, 2, GameUtil.handler(self._clearCritEff, self, critEff))
	end
end

function FruitNinjaSceneView:_hideCritTips()
	self:_clearTimerFinishHandler("critTips")
	GameUtil.SetActive(self._critTips, false)
end

function FruitNinjaSceneView:_showCritEff(fruitId, x, y, z)
	local fruitData = FruitNinjaConfig.instance:getFruitData(fruitId) or {}

	if not string.nilorempty(fruitData.critEff) then
		local effPath = {
			fruitData.critEff
		}

		local function finishHandle(handlerTarget, eff)
			self:_clearCritEff(eff)
		end

		local function loadedHandler(handlerTarget, eff)
			GameUtil.SetActive(eff.effGo, true)
			GameUtil.setPos(eff.effGo, x, y, z)
		end

		local critEff = self:playViewEffect(effPath, self._bottomView, self._bottomView, false, 0, 0, finishHandle, loadedHandler)

		self._critEffPool[critEff] = critEff

		self:_addTimerFinishCallBack(critEff, 2, GameUtil.handler(self._clearCritEff, self, critEff))
	end
end

function FruitNinjaSceneView:_clearCritEff(critEff)
	if critEff == nil then
		return
	end

	self:_clearTimerFinishHandler(critEff)

	self._critEffPool[critEff] = nil

	self:stopViewEffect(critEff)
end

function FruitNinjaSceneView:_clearAllCritEff()
	for k, v in pairs(self._critEffPool) do
		self:_clearCritEff(v)
	end
end

function FruitNinjaSceneView:_showSliceEff(fruitId, x, y, z)
	local fruitData = FruitNinjaConfig.instance:getFruitData(fruitId) or {}

	if not string.nilorempty(fruitData.sliceEff) then
		local effPath = fruitData.sliceEff .. ".prefab"

		local function finishHandle(handlerTarget, eff)
			self:_clearSliceEff(eff)
		end

		local function loadedHandler(handlerTarget, eff)
			GameUtil.SetActive(eff.effGo, true)
			GameUtil.setPos(eff.effGo, x, y, z)
		end

		local eff = self:playViewEffect(effPath, self._topView, self._topView, false, 0, 0, finishHandle, loadedHandler)

		self._sliceEffPool[eff] = eff
	end
end

function FruitNinjaSceneView:_clearSliceEff(eff)
	if eff == nil then
		return
	end

	self._sliceEffPool[eff] = nil

	self:stopViewEffect(eff)
end

function FruitNinjaSceneView:_clearAllSliceEff()
	for k, v in pairs(self._sliceEffPool) do
		self:_clearSliceEff(v)
	end
end

function FruitNinjaSceneView:_updateHealthValue(value)
	self._curHealth = Mathf.Clamp(value, 0, self._defaultHealth)

	for idx = 1, #self._healthCells do
		local cell = self._healthCells[idx]

		GameUtil.SetActive(cell, not (idx > self._curHealth))
	end
end

function FruitNinjaSceneView:_addTimerFinishCallBack(key, cd, callBack)
	self._timerFinishCallBacks[key] = callBack
	self._timerFinishCds[key] = cd
end

function FruitNinjaSceneView:_clearTimerFinishHandler(key)
	if key then
		self._timerFinishCallBacks[key] = nil
		self._timerFinishCds[key] = nil
	end
end

function FruitNinjaSceneView:_clearAllTimerFinishHandler()
	table.clear(self._timerFinishCallBacks)
	table.clear(self._timerFinishCds)
end

function FruitNinjaSceneView:_onPointerDownHandler(go, eventData)
	if self:_getCurState() ~= FruitNinjaEnum.State_Runing then
		return
	end

	local pointerId = eventData.pointerId
	local pencilCell = self:_getPencilCell(pointerId)

	pencilCell._trajectory:clear()
end

function FruitNinjaSceneView:_onBeginDragHandler(go, eventData)
	if self:_getCurState() ~= FruitNinjaEnum.State_Runing then
		return
	end

	local pointerId = eventData.pointerId
	local localPos = goutil.screenToLocalPos(eventData.position, self._gameViewTran)
	local pencilCell = self:_getPencilCell(pointerId)

	self._draggingPointerIds[pointerId] = true

	pencilCell._direction:Set(0, 0, 0)
	pencilCell._trajectory:clear()
	GameUtil.setLocalPos(pencilCell._mainGo, localPos.x, localPos.y, 0)
	GameUtil.SetActive(pencilCell._mainGo, true)
end

function FruitNinjaSceneView:_onEndDragHandler(go, eventData)
	if self:_getCurState() ~= FruitNinjaEnum.State_Runing then
		return
	end

	local pointerId = eventData.pointerId
	local pencilCell = self:_getPencilCell(pointerId)

	self._draggingPointerIds[pointerId] = nil

	if next(self._draggingPointerIds) == nil then
		local data = FruitNinjaConfig.instance:getComboDataByCount(self._gamePlanId, self._comboSliceTimes)

		if data then
			self:_addScore(data.score)
			self:_showComboFinish(self._comboSliceTimes, data.score)
		end

		self._comboSliceTimes = 0
	end

	GameUtil.SetActive(pencilCell._mainGo, false)
end

function FruitNinjaSceneView:_onDragHandler(go, eventData)
	if self:_getCurState() ~= FruitNinjaEnum.State_Runing then
		return
	end

	if next(self._draggingPointerIds) == nil then
		return
	end

	local pointerId = eventData.pointerId
	local localPos = goutil.screenToLocalPos(eventData.position, self._gameViewTran)
	local pencilCell = self:_getPencilCell(pointerId)
	local worldPos = Framework.GeometryUtil.ScreenTo3DWorldPoint(eventData.position, self._uiCamera, pencilCell._mainGo.transform.position)

	GameUtil.setLocalPos(pencilCell._mainGo, localPos.x, localPos.y, 0)

	local trajectory = pencilCell._trajectory

	if trajectory:isFull() then
		local tempTra = trajectory:popFront()

		if tempTra then
			tempTra:Set(worldPos.x, worldPos.y, 0)
			trajectory:pushBack(tempTra)
		end
	else
		trajectory:pushBack(Vector2.New(worldPos.x, worldPos.y, 0))
	end

	local dX, dY = self:_getDirectionByTrajectory(trajectory)

	pencilCell._direction:Set(dX, dY, 0)
	pencilCell._boundBox2D:setCenter(Framework.TransformUtil.GetLocalPos(pencilCell._mainGo.transform, 0, 0, 0))

	for _, cell in ipairs(self._fruitCellList) do
		cell:tryTrickHit(pencilCell._boundBox2D, pointerId)
	end
end

function FruitNinjaSceneView:_getPencilCell(pointerId)
	local cell = self._pencilCellDic[pointerId]

	if cell == nil then
		local mainGo = goutil.cloneAndSetParent(self._pencilCell, self._pencilView.transform, self._pencilCell.name .. pointerId)

		self._pencilCellDic[pointerId] = {}
		cell = self._pencilCellDic[pointerId]
		cell._mainGo = mainGo
		cell._effRoot = goutil.findChild(mainGo, "effRoot")
		cell._colliderBox = goutil.findChild(mainGo, "colliderBox")
		cell._colliderBoxRectTran = cell._colliderBox:GetComponent(goutil.Type_RectTransform)
		cell._boundBox2D = BoundingBox2D.New()

		local scaleX = Framework.TransformUtil.GetLocalScale(cell._colliderBox.transform, 0, 0, 0)

		cell._boundBox2D:setSize(cell._colliderBoxRectTran.rect.width * scaleX, cell._colliderBoxRectTran.rect.height * scaleX)

		cell._direction = Vector3.zero
		cell._trajectory = CircularQueue.New(5)

		self:_initPencilCell(cell)
	end

	return cell
end

function FruitNinjaSceneView:_initAllPencilCell()
	for k, cell in pairs(self._pencilCellDic) do
		self:_initPencilCell(cell)
	end
end

function FruitNinjaSceneView:_initPencilCell(cell)
	self:playViewEffectUniGo("20250430/shuiguorenzhe/fx_ui_sgrz_dao.prefab", cell._effRoot, self.mainGO, true)
end

function FruitNinjaSceneView:_clearAllPencilCell()
	for k, cell in pairs(self._pencilCellDic) do
		self:_clearPencilCell(cell)
	end
end

function FruitNinjaSceneView:_clearPencilCell(cell)
	if cell == nil then
		return
	end

	self:stopViewEffectUniGo(cell._effRoot)
	cell._trajectory:clear()
end

function FruitNinjaSceneView:_getDirectionByTrajectory(trajectory)
	local x, y = 0, 0
	local tempX, tempY
	local count = trajectory:count()

	if count > 1 then
		trajectory:traverseReverse(function(index, value)
			if tempX and tempY then
				x = x + (value.x - tempX)
				y = y + (value.y - tempY)
			end

			tempX, tempY = value.x, value.y
		end)

		x = x / (count - 1)
		y = y / (count - 1)
	end

	return x, y
end

function FruitNinjaSceneView:_fetchFruitCell(fruitId)
	local cell = self:_fetchFruitComp(fruitId)
	local go = self:_fetchFruitGo(fruitId)

	goutil.addChildToParent(go, self._gameView)
	cell:onInit(go, fruitId, self)

	local entityId = cell:getEntityId()

	table.insert(self._fruitCellList, cell)

	self._fruitCellDic[entityId] = cell

	return cell
end

function FruitNinjaSceneView:_returnFruitCell(cell)
	local entityId = cell:getEntityId()
	local pos = 0

	for idx, v in ipairs(self._fruitCellList) do
		if v:getEntityId() == entityId then
			pos = idx

			break
		end
	end

	table.remove(self._fruitCellList, pos)

	self._fruitCellDic[entityId] = nil

	local fruitId = cell:getFruitId()
	local go = cell:getGameObject()

	cell:onUnInit()
	self:_returnFruitGo(fruitId, go)
	self:_returnFruitComp(fruitId, cell)
end

function FruitNinjaSceneView:_clearFruitCellPool()
	local list = {}

	table.insertto(list, self._fruitCellList)

	for _, cell in ipairs(list) do
		self:_returnFruitCell(cell)
	end

	table.clear(self._fruitCellDic)

	if self._fruitGoPools then
		for k, v in pairs(self._fruitGoPools) do
			self._fruitGoPools[k]:clear()

			self._fruitGoPools[k] = nil
		end
	end

	if self._fruitCompPools then
		for k, v in pairs(self._fruitCompPools) do
			self._fruitCompPools[k]:clear()

			self._fruitCompPools[k] = nil
		end
	end

	if self._clipGoPools then
		for key, info in pairs(self._animClipGoInfos) do
			self:_returnClipGo(info.fruitId, info.mainGo)

			self._animClipGoInfos[key] = nil
		end

		for k, v in pairs(self._clipGoPools) do
			self._clipGoPools[k]:clear()

			self._clipGoPools[k] = nil
		end
	end
end

function FruitNinjaSceneView:_fetchFruitGo(fruitId)
	local prefabName = FruitNinjaSceneViewPresentor.TempCellPrefabName

	if self._fruitGoPools[prefabName] == nil then
		self:_creatFruitGoPool(prefabName)
	end

	return self._fruitGoPools[prefabName]:fetchObject()
end

function FruitNinjaSceneView:_returnFruitGo(fruitId, go)
	local prefabName = FruitNinjaSceneViewPresentor.TempCellPrefabName

	if self._fruitGoPools[prefabName] then
		self._fruitGoPools[prefabName]:returnObject(go)
	end
end

function FruitNinjaSceneView:_creatFruitGoPool(prefabName)
	self._fruitGoPools = self._fruitGoPools or {}

	if self._fruitGoPools[prefabName] ~= nil then
		return
	end

	local assetPath = string.format(FruitNinjaSceneViewPresentor.PathPre, prefabName)

	local function createFunc()
		local res = rescache:GetResourceNoLoadIfNotExists(assetPath)

		if not res then
			return
		end

		local mainAsset = res:GetMainAsset()

		if not mainAsset then
			return
		end

		return (goutil.clone(mainAsset))
	end

	local function disposeFunc(go)
		goutil.destroy(go)
	end

	local function resetFunc(go)
		GameUtil.SetActive(go, false)
		goutil.addChildToParent(go, self._poolRoot)
	end

	self._fruitGoPools[prefabName] = ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

function FruitNinjaSceneView:_fetchFruitComp(fruitId)
	if self._fruitCompPools[1] == nil then
		self:_creatFruitCompPool(1)
	end

	return self._fruitCompPools[1]:fetchObject()
end

function FruitNinjaSceneView:_returnFruitComp(fruitId, cell)
	if self._fruitCompPools[1] then
		self._fruitCompPools[1]:returnObject(cell)
	end
end

function FruitNinjaSceneView:_creatFruitCompPool(fruitId)
	self._fruitCompPools = self._fruitCompPools or {}

	if self._fruitCompPools[fruitId] ~= nil then
		return
	end

	local comp = FruitNinjaBaseCell

	self._curMaxEntityId = 0
	self._recycleEntityIdList = {}

	local function createFunc()
		local entityId = self._recycleEntityIdList[#self._recycleEntityIdList]

		if entityId == nil then
			self._curMaxEntityId = self._curMaxEntityId + 1
			entityId = self._curMaxEntityId
		else
			self._recycleEntityIdList[#self._recycleEntityIdList] = nil
		end

		return comp.New(entityId)
	end

	local function disposeFunc(comp)
		table.insert(self._recycleEntityIdList, comp:getEntityId())
		comp:onDispose()
	end

	local function resetFunc(comp)
		comp:onReset()
	end

	self._fruitCompPools[fruitId] = ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

function FruitNinjaSceneView:_fetchClipGo(fruitId)
	local prefabName = FruitNinjaSceneViewPresentor.TempClipPrefabName

	if self._clipGoPools[prefabName] == nil then
		self:_creatClipGoPool(prefabName)
	end

	local go = self._clipGoPools[prefabName]:fetchObject()

	goutil.addChildToParent(go, self._gameView)

	return go
end

function FruitNinjaSceneView:_returnClipGo(fruitId, go)
	local prefabName = FruitNinjaSceneViewPresentor.TempClipPrefabName

	if self._clipGoPools[prefabName] then
		self._clipGoPools[prefabName]:returnObject(go)
	end
end

function FruitNinjaSceneView:_creatClipGoPool(prefabName)
	self._clipGoPools = self._clipGoPools or {}

	if self._clipGoPools[prefabName] ~= nil then
		return
	end

	local assetPath = string.format(FruitNinjaSceneViewPresentor.PathPre, prefabName)

	local function createFunc()
		local res = rescache:GetResourceNoLoadIfNotExists(assetPath)

		if not res then
			return
		end

		local mainAsset = res:GetMainAsset()

		if not mainAsset then
			return
		end

		return (goutil.clone(mainAsset))
	end

	local function disposeFunc(go)
		goutil.destroy(go)
	end

	local function resetFunc(go)
		GameUtil.SetActive(go, false)
		goutil.addChildToParent(go, self._poolRoot)
		uGuiUtil.clearImage(go)
		GameUtil.setLocalPos(go, 0, 0, 0)
		GameUtil.getLocalRotation(go, 0, 0, 0)
		GameUtil.setLocalScale(go, 1)
	end

	self._clipGoPools[prefabName] = ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

return FruitNinjaSceneView
