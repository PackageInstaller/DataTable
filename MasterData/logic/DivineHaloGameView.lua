-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehalogame/view/DivineHaloGameView.lua

module("logic.extensions.divinehalogame.view.DivineHaloGameView", package.seeall)

local DivineHaloGameView = class("DivineHaloGameView", ViewComponent)
local PLAYER_CHASE_LERP = 0.15
local PLAYER_CHASE_SNAP = 1
local PLAYER_MOVE_EPSILON = 0.001

function DivineHaloGameView:ctor()
	DivineHaloGameView.super.ctor(self)

	self._leftUpPos = Vector3.New(0, 0, 0)
	self._rightDownPos = Vector3.New(0, 0, 0)
	self._leftUpSpeedListenPos = Vector3.New(0, 0, 0)
	self._rightDownSpeedListenPos = Vector3.New(0, 0, 0)
	self._playerLocalPos = Vector3.New(0, 0, 0)
end

function DivineHaloGameView:bindEvents()
	DivineHaloGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	self._virtualJoystick:AddDownListener(self._onJoystickDown, self)
	self._virtualJoystick:AddUpListener(self._onJoystickUp, self)
	self._virtualJoystick:AddDragListener(self._onJoystickDrag, self)
end

function DivineHaloGameView:unbindEvents()
	DivineHaloGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	self._virtualJoystick:RemoveDownListener()
	self._virtualJoystick:RemoveUpListener()
	self._virtualJoystick:RemoveDragListener()
end

function DivineHaloGameView:buildUI()
	DivineHaloGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtGameTime = self:getTxt("gameTime/txtGameTime")
	self._countDownEffCon = self:getGo("countDownEffCon")
	self._cloneCell = self:getGo("map/cloneCell")
	self._cellRoot = self:getGo("map/cellRoot")
	self._wallRoot = self:getGo("map/wallRoot")
	self._bgRoot = self:getGo("map/bgRoot")
	self._map = self:getGo("map")
	self._playerLight = self:getGo("playerLight")
	self._playerLightColorChangeComp = self._playerLight:GetComponent(ComponentType.UIImageColorChange)
	self._rushWallBoundingBox = self:getGo("playerLight/rushWallBoundingBox")
	self._imgBg = self:getGo("map/bgRoot/imgBg")
	self._leftUpPoint = self:getGo("leftUpPoint")
	self._rightDownPoint = self:getGo("rightDownPoint")
	self._leftUpSpeedListenBox = self:getGo("map/speedListenBox/leftUpBox")
	self._rightDownSpeedListenBox = self:getGo("map/speedListenBox/rightDownBox")
	self._joystickBg = self:getGo("joystickview/joystickArea/joystickbackground")
	self._virtualJoystick = goutil.addComponentOnce(self._joystickBg, typeof(VirtualJoystick))
	self._initBgPos = Vector2.New(Framework.TransformUtil.GetLocalPos(self._joystickBg.transform, 0, 0, 0))
	self._joystickCtrl = goutil.findChildComponent(self.mainGO, "joystickview", typeof(ClickToShowJoystick))

	self._joystickCtrl.gameObject:SetActive(true)

	self._thunderEffRoot = self:getGo("thunderEffRoot")
end

function DivineHaloGameView:onEnter()
	DivineHaloGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineHaloPlayerEnterTrigCell, self._onPlayerEnterTrigCell, self)
	self.addGEvent(self, GlobalNotify.DivineHaloPlayerMoveEveryWhere, self._playerMoveEveryWhere, self)
	self.addGEvent(self, GlobalNotify.DivineHaloMapCanChaseHorizontal, self._mapCanChaseHorizontal, self)
	self.addGEvent(self, GlobalNotify.DivineHaloMapCanChaseVertical, self._mapCanChaseVertical, self)
	self.addGEvent(self, GlobalNotify.PM_DivineHaloGameEndGameRes, self._endGameRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])
	self._actCfg = DivineHaloGameConfig.instance:getActData(self._activityId)
	self._stageCfg = DivineHaloGameConfig.instance:getStageDataById(self._activityId, self._stageId)

	local jsonStr = self._stageCfg.map

	self._cellPools = self:_generalMapObjectPool()
	self._angle = 0
	self._inputDirectionX = 0
	self._inputDirectionY = 0
	self._wallList = {}
	self._wallCellColorDic = {}
	self._trigCellList = {}
	self._colorWallCellList = {}
	self._cellClsList = {}
	self._cellTypeDic = {}
	self._unLockKeyIdxList = {}
	self._canFreeMoveHorizontal = false
	self._canFreeMoveVertical = false
	self._canChase = true
	self._isPortalsing = false
	self._mapCanHorizontalChase = false
	self._mapCanVerticalChase = false
	self._firstEnter = true
	self._firstEnterHorizontal = true
	self._firstEnterVertical = true
	self._isFirstTrigExitDoor = true
	self._playerCanCtrlMove = true
	self._isPause = false
	self._gameTime = self._stageCfg.gameTime

	self:_setMapData(jsonStr)
	self:_setCellUI()
	self:_setMapMoveCtrlCls()
	self:_setMove()
	self:_setCountDownEffect()
	GameUtil.SetActive(self._cloneCell, false)
	settimer(1, self._tickTime, self)
	Framework.TransformUtil.SetLocalPos(self._joystickBg.transform, self._initBgPos.x, self._initBgPos.y, 0)

	self._txtGameTime.text = string.format("倒计时：%d秒", self._gameTime)

	self:_setThunderEffect()
	GameUtil.SetActive(self._thunderEffRoot, true)
end

function DivineHaloGameView:onExit()
	DivineHaloGameView.super.onExit(self)
	removetimer(self._tick, self)
	removetimer(self._winGame, self)
	removetimer(self._tickTime, self)
	removetimer(self._playerMoveAgain, self)

	self._unLockKeyIdxList = nil

	self:_clearCellPools()

	if self._joystickCtrl then
		self._joystickCtrl:StopJoystickMove()
	end

	for i, wallGo in ipairs(self._wallList) do
		goutil.destroy(wallGo)
	end

	if self._thunderEffect then
		UIEffectManager.instance:stopEffect(self._thunderEffect)

		self._thunderEffect = nil
	end

	if self._changeColorEffect then
		UIEffectManager.instance:stopEffect(self._changeColorEffect)

		self._changeColorEffect = nil
	end

	if self._touchEndPointEffect then
		UIEffectManager.instance:stopEffect(self._touchEndPointEffect)

		self._touchEndPointEffect = nil
	end
end

function DivineHaloGameView:_setMapData(jsonStr)
	self._datas = GameUtil.jsonToTable(jsonStr)
	self._cellDataList = self._datas.list
	self._wallDataList = self._datas.wallList
	self._leftUpPos = DivineHaloGameController.instance:getLocalPos(self._leftUpPoint, self._leftUpPos)
	self._rightDownPos = DivineHaloGameController.instance:getLocalPos(self._rightDownPoint, self._rightDownPos)
	self._leftUpSpeedListenPos = DivineHaloGameController.instance:getLocalPos(self._leftUpSpeedListenBox, self._leftUpSpeedListenPos)
	self._rightDownSpeedListenPos = DivineHaloGameController.instance:getLocalPos(self._rightDownSpeedListenBox, self._rightDownSpeedListenPos)
end

function DivineHaloGameView:_setMapMoveCtrlCls()
	local totalWidth = self._datas.totalWidth
	local totalHeight = self._datas.totalHeight

	self._mapMoveCtrlCls = GameUtil.AddLuaOnce(self.mainGO, DivineHaloGameMapMoveCtrl)

	self._mapMoveCtrlCls:onInit(self.mainGO, self._playerCellGo, self._leftUpPoint, self._rightDownPoint, self._leftUpSpeedListenBox, self._rightDownSpeedListenBox, self._cellRoot, self._wallRoot, self._bgRoot, totalWidth, totalHeight)
end

function DivineHaloGameView:_generalMapObjectPool()
	local function createFunc()
		local go = goutil.cloneAndSetParent(self._cloneCell, self._cellRoot.transform, "cell")
		local cls = GameUtil.AddLuaOnce(go, DivineHaloGameCell)

		GameUtil.SetActive(go, true)

		return cls
	end

	local function disposeFunc(cls)
		cls:onDispose()
		goutil.destroy(cls:getGo())
	end

	local function resetFunc(cls)
		cls:onReset()

		local go = cls:getGo()

		go.name = "cell(recycle)"
	end

	return ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

function DivineHaloGameView:_clearCellPools()
	goutil.addChildToParent(self._playerLight, self.mainGO)

	for i, go in ipairs(self._cellClsList) do
		self._cellPools:returnObject(go)
	end

	if self._cellPools then
		self._cellPools:clear()

		self._cellPools = nil
	end
end

function DivineHaloGameView:_initCellUI()
	GameUtil.setLocalPos(self._cellRoot, 0, 0, 0)
	GameUtil.setLocalPos(self._wallRoot, 0, 0, 0)
	GameUtil.setLocalPos(self._bgRoot, 0, 0, 0)
end

function DivineHaloGameView:_setCellUI()
	self:_initCellUI()

	local totalWidth = self._datas.totalWidth
	local totalHeight = self._datas.totalHeight
	local curSideWallIdx = 0

	for i, data in ipairs(self._wallDataList) do
		local cellGo = goutil.cloneAndSetParent(self._cloneCell, self._wallRoot.transform, "wallCell" .. curSideWallIdx)
		local bgGo = goutil.findChild(cellGo, "bg")
		local colorChange = bgGo:GetComponent(ComponentType.UIImageColorChange)
		local spriteChange = bgGo:GetComponent(ComponentType.UIImageSpriteChange)
		local boxCollider = cellGo:AddComponent(typeof("UnityEngine.BoxCollider2D"))
		local rigidBody = cellGo:GetComponent(typeof(UnityEngine.Rigidbody2D))

		colorChange:SetState(0)
		spriteChange:SetState(DivineHaloGameModel.CellTypeEnum.MapSideWall)

		local vec2 = UnityEngine.Vector2.New(data.width, data.height)

		SystemReflexHelp.setBoxCollider2DSize(boxCollider, vec2)
		GameUtil.setWidth(cellGo, checknumber(data.width))
		GameUtil.setHeight(cellGo, checknumber(data.height))
		GameUtil.setAnchoredPos(cellGo, data.localX, data.localY)
		GameUtil.SetActive(cellGo, true)

		curSideWallIdx = curSideWallIdx + 1

		table.insert(self._wallList, cellGo)
	end

	for i, data in ipairs(self._cellDataList) do
		local cls = self._cellPools:fetchObject()

		cls:onInit(data)

		local abstractType = DivineHaloGameModel.instance:getCellAbstractType(data.cellType)

		if abstractType == DivineHaloGameModel.CellAbstarctTypeEnum.Trig then
			if not table.indexof(self._trigCellList, cls) then
				table.insert(self._trigCellList, cls)
			end
		elseif abstractType == DivineHaloGameModel.CellAbstarctTypeEnum.Wall then
			self._wallCellColorDic[data.colorType] = self._wallCellColorDic[data.colorType] or {}

			if not table.indexof(self._wallCellColorDic[data.colorType], cls) then
				table.insert(self._wallCellColorDic[data.colorType], cls)
				table.insert(self._colorWallCellList, cls)
				self:_updateColorWallCell(cls)
			end
		elseif abstractType == DivineHaloGameModel.CellAbstarctTypeEnum.Player then
			self._playerCellGo = cls:getGo()
			self._playerCellCls = cls

			self._playerCellCls:setPlayerHorizontalChangeState(DivineHaloGameModel.PlayerChangeState.ToInHorizontal)
			self._playerCellCls:setPlayerVerticalChangeState(DivineHaloGameModel.PlayerChangeState.ToInVertical)

			self._rigidBody = cls:getRigidbody2D()
			self._prePlayerLocalPos = Vector3.New(data.localX, data.localY, data.localZ)

			goutil.addChildToParent(self._playerCellGo, self._map)
			cls:addPlayerLight(self._playerLight)
			self._playerLightColorChangeComp:SetState(data.colorType)
		end

		table.insert(self._cellClsList, cls)
	end

	GameUtil.setWidth(self._imgBg, totalWidth)
	GameUtil.setHeight(self._imgBg, totalHeight)
end

function DivineHaloGameView:_onJoystickUp()
	self._inputDirectionX = 0
	self._inputDirectionY = 0
	self._canChase = true
	self._firstEnter = false
	self._firstEnterHorizontal = false
	self._firstEnterVertical = false
end

function DivineHaloGameView:_onJoystickDown()
	self._canChase = false
end

function DivineHaloGameView:_onJoystickDrag(x, y)
	self._inputDirectionX = x
	self._inputDirectionY = y
end

function DivineHaloGameView:_setMove()
	settimer(0, self._tick, self, true)
end

function DivineHaloGameView:_tick()
	self:_movePlayer()
	self._playerCellCls:updateBoundingBox2D()

	for i, cls in ipairs(self._trigCellList) do
		cls:updateBoundingBox2D()
		cls:tryTrig(self._playerCellCls:getBoundingBox2D(), self._playerCellCls:getColorType())
	end

	for i, cls in ipairs(self._colorWallCellList) do
		cls:updateBoundingBox2D()
	end
end

function DivineHaloGameView:_movePlayer()
	if self:_movePlayerStable() then
		return
	end

	self._playerLocalPos = DivineHaloGameController.instance:getLocalPos(self._playerCellGo, self._playerLocalPos)

	if self._rigidBody then
		if (checknumber(self._inputDirectionX) ~= 0 or checknumber(self._inputDirectionY) ~= 0) and not self._isPortalsing and self._playerCanCtrlMove then
			local targetPosX = self._playerLocalPos.x
			local targetPosY = self._playerLocalPos.y
			local moveVelocityX = self._inputDirectionX
			local moveVelocityY = self._inputDirectionY

			self._angle = math.atan2(checknumber(self._inputDirectionY), checknumber(self._inputDirectionX)) * Mathf.Rad2Deg
			self._rigidBody.rotation = self._angle

			self._playerCellCls:setPlayerPosType(DivineHaloGameModel.PlayerPosType.Middle)

			if not self._canFreeMoveHorizontal and not self._firstEnterHorizontal and not self._rushingWallHorizontal then
				if targetPosX <= self._leftUpSpeedListenPos.x then
					targetPosX = self._leftUpSpeedListenPos.x
					moveVelocityX = 0

					self._playerCellCls:setPlayerPosType(DivineHaloGameModel.PlayerPosType.Side)
				end

				if targetPosX >= self._rightDownSpeedListenPos.x then
					targetPosX = self._rightDownSpeedListenPos.x
					moveVelocityX = 0

					self._playerCellCls:setPlayerPosType(DivineHaloGameModel.PlayerPosType.Side)
				end
			elseif targetPosX >= self._leftUpSpeedListenPos.x and targetPosX <= self._rightDownSpeedListenPos.x then
				self._playerCellCls:setPlayerHorizontalChangeState(DivineHaloGameModel.PlayerChangeState.ToInHorizontal)
				self._playerCellCls:setPlayerPosType(DivineHaloGameModel.PlayerPosType.Middle)

				self._canFreeMoveHorizontal = false
				self._firstEnterHorizontal = false
			end

			if not self._canFreeMoveVertical and not self._firstEnterVertical and not self._rushingWallVertical then
				if targetPosY >= self._leftUpSpeedListenPos.y then
					targetPosY = self._leftUpSpeedListenPos.y
					moveVelocityY = 0
				end

				if targetPosY <= self._rightDownSpeedListenPos.y then
					targetPosY = self._rightDownSpeedListenPos.y
					moveVelocityY = 0
				end

				if moveVelocityY == 0 then
					self._playerCellCls:setPlayerPosType(DivineHaloGameModel.PlayerPosType.Side)
				end
			elseif targetPosY <= self._leftUpSpeedListenPos.y and targetPosY >= self._rightDownSpeedListenPos.y then
				self._playerCellCls:setPlayerVerticalChangeState(DivineHaloGameModel.PlayerChangeState.ToInVertical)
				self._playerCellCls:setPlayerPosType(DivineHaloGameModel.PlayerPosType.Middle)

				self._canFreeMoveVertical = false
				self._firstEnterVertical = false
			end

			self._rushingWallHorizontal = self._inputDirectionX < 0 and self._playerLocalPos.x >= 10 or self._inputDirectionX > 0 and self._playerLocalPos.x <= -10
			self._rushingWallVertical = self._inputDirectionY < 0 and self._playerLocalPos.y >= 10 or self._inputDirectionY > 0 and self._playerLocalPos.y <= -10
		else
			self._rigidBody.velocity = UnityEngine.Vector2.zero
			self._rigidBody.rotation = self._angle
			self._rushingWallVertical = false
			self._rushingWallHorizontal = false
			self._canChase = true
		end

		local stillNeedChase = self._mapMoveCtrlCls:getStillNeedChase()

		if self._isPortalsing and not stillNeedChase then
			self._isPortalsing = false
		end

		self._mapMoveCtrlCls:tryTrig(self._inputDirectionX, self._inputDirectionY, self._playerCellCls:getPlayerPosType(), self._playerCellCls:getPlayerHorizontalChangeState(), self._playerCellCls:getPlayerVerticalChangeState(), self._rushingWallHorizontal, self._rushingWallVertical)

		if self._canChase then
			self:_playerChase()
		end
	end

	self._prePlayerLocalPos = self._playerLocalPos
end

function DivineHaloGameView:_movePlayerStable()
	self._playerLocalPos = DivineHaloGameController.instance:getLocalPos(self._playerCellGo, self._playerLocalPos)

	if not self._rigidBody then
		self._prePlayerLocalPos = self._playerLocalPos

		return true
	end

	local canMove = (checknumber(self._inputDirectionX) ~= 0 or checknumber(self._inputDirectionY) ~= 0) and not self._isPortalsing and self._playerCanCtrlMove

	if canMove then
		local targetPosX = self._playerLocalPos.x
		local targetPosY = self._playerLocalPos.y
		local moveVelocityX = self._inputDirectionX
		local moveVelocityY = self._inputDirectionY

		self._angle = math.atan2(checknumber(self._inputDirectionY), checknumber(self._inputDirectionX)) * Mathf.Rad2Deg
		self._rigidBody.rotation = self._angle

		self._playerCellCls:setPlayerPosType(DivineHaloGameModel.PlayerPosType.Middle)

		if not self._canFreeMoveHorizontal and not self._firstEnterHorizontal and not self._rushingWallHorizontal then
			if targetPosX <= self._leftUpSpeedListenPos.x then
				targetPosX = self._leftUpSpeedListenPos.x
				moveVelocityX = 0

				self._playerCellCls:setPlayerPosType(DivineHaloGameModel.PlayerPosType.Side)
			end

			if targetPosX >= self._rightDownSpeedListenPos.x then
				targetPosX = self._rightDownSpeedListenPos.x
				moveVelocityX = 0

				self._playerCellCls:setPlayerPosType(DivineHaloGameModel.PlayerPosType.Side)
			end
		elseif targetPosX >= self._leftUpSpeedListenPos.x and targetPosX <= self._rightDownSpeedListenPos.x then
			self._playerCellCls:setPlayerHorizontalChangeState(DivineHaloGameModel.PlayerChangeState.ToInHorizontal)
			self._playerCellCls:setPlayerPosType(DivineHaloGameModel.PlayerPosType.Middle)

			self._canFreeMoveHorizontal = false
			self._firstEnterHorizontal = false
		end

		if not self._canFreeMoveVertical and not self._firstEnterVertical and not self._rushingWallVertical then
			if targetPosY >= self._leftUpSpeedListenPos.y then
				targetPosY = self._leftUpSpeedListenPos.y
				moveVelocityY = 0
			end

			if targetPosY <= self._rightDownSpeedListenPos.y then
				targetPosY = self._rightDownSpeedListenPos.y
				moveVelocityY = 0
			end

			if moveVelocityY == 0 then
				self._playerCellCls:setPlayerPosType(DivineHaloGameModel.PlayerPosType.Side)
			end
		elseif targetPosY <= self._leftUpSpeedListenPos.y and targetPosY >= self._rightDownSpeedListenPos.y then
			self._playerCellCls:setPlayerVerticalChangeState(DivineHaloGameModel.PlayerChangeState.ToInVertical)
			self._playerCellCls:setPlayerPosType(DivineHaloGameModel.PlayerPosType.Middle)

			self._canFreeMoveVertical = false
			self._firstEnterVertical = false
		end

		self._rigidBody.velocity = UnityEngine.Vector2.New(moveVelocityX, moveVelocityY)

		if Mathf.Abs(targetPosX - self._playerLocalPos.x) > PLAYER_MOVE_EPSILON or Mathf.Abs(targetPosY - self._playerLocalPos.y) > PLAYER_MOVE_EPSILON then
			GameUtil.setLocalPos(self._playerCellGo, targetPosX, targetPosY, self._playerLocalPos.z)
			self._playerLocalPos:Set(targetPosX, targetPosY, self._playerLocalPos.z)
		end

		self._rushingWallHorizontal = self._inputDirectionX < 0 and self._playerLocalPos.x >= 10 or self._inputDirectionX > 0 and self._playerLocalPos.x <= -10
		self._rushingWallVertical = self._inputDirectionY < 0 and self._playerLocalPos.y >= 10 or self._inputDirectionY > 0 and self._playerLocalPos.y <= -10
	else
		self._rigidBody.velocity = UnityEngine.Vector2.zero
		self._rigidBody.rotation = self._angle
		self._rushingWallVertical = false
		self._rushingWallHorizontal = false
		self._canChase = true
	end

	local stillNeedChase = self._mapMoveCtrlCls:getStillNeedChase()

	if self._isPortalsing and not stillNeedChase then
		self._isPortalsing = false
	end

	self._mapMoveCtrlCls:tryTrig(self._inputDirectionX, self._inputDirectionY, self._playerCellCls:getPlayerPosType(), self._playerCellCls:getPlayerHorizontalChangeState(), self._playerCellCls:getPlayerVerticalChangeState(), self._rushingWallHorizontal, self._rushingWallVertical)

	if self._canChase then
		self:_playerChase()
	end

	self._prePlayerLocalPos = self._playerLocalPos

	return true
end

function DivineHaloGameView:_onPlayerEnterTrigCell(cellType, colorType, index)
	if cellType == DivineHaloGameModel.CellTypeEnum.ChangeColor then
		self:_trigChangeColor(colorType)
	elseif cellType == DivineHaloGameModel.CellTypeEnum.KeyCell then
		self:_trigKeyCell(colorType, index)
	elseif cellType == DivineHaloGameModel.CellTypeEnum.PortalsDoor then
		self:_trigPortalsDoor(cellType, colorType, index)
	elseif cellType == DivineHaloGameModel.CellTypeEnum.ExitDoor then
		self:_trigExitDoor()
	end
end

function DivineHaloGameView:_trigChangeColor(colorType)
	local playerColorType = self._playerCellCls:getColorType()

	if playerColorType == colorType then
		return
	end

	self._playerLightColorChangeComp:SetState(colorType)
	self._playerCellCls:setColorType(colorType)

	for _, colorWallList in pairs(self._wallCellColorDic) do
		for i, cls in ipairs(colorWallList) do
			self:_updateColorWallCell(cls)
		end
	end

	self:_playChangeColorEff()
end

function DivineHaloGameView:_trigKeyCell(colorType, index)
	local colorWallList = self._wallCellColorDic[colorType]
	local playerColorType = self._playerCellCls:getColorType()

	if playerColorType == colorType then
		for i, cls in ipairs(self._trigCellList) do
			local clsData = cls:getData()
			local hasKeyUnLock = table.indexof(self._unLockKeyIdxList, clsData.index)

			GameUtil.SetActive(cls:getGo(), clsData.index ~= index and not hasKeyUnLock)
		end

		for i, cls in ipairs(colorWallList) do
			local clsData = cls:getData()

			if clsData.colorType == colorType and clsData.cellType == DivineHaloGameModel.CellTypeEnum.LockWall then
				GameUtil.SetActive(cls:getGo(), false)
			end
		end

		table.insert(self._unLockKeyIdxList, index)
	end
end

function DivineHaloGameView:_trigPortalsDoor(cellType, colorType, index)
	if colorType == self._playerCellCls:getColorType() then
		for i, cls in ipairs(self._trigCellList) do
			local data = cls:getData()

			if data.colorType == colorType and data.cellType == cellType and index ~= data.index then
				local afterOffsetLocalPos = cls:getAfterOffsetLocalPos()

				self._rigidBody.velocity = UnityEngine.Vector2.zero

				GameUtil.setLocalPos(self._playerCellGo, afterOffsetLocalPos.x, afterOffsetLocalPos.y + data.addParam, 0)
				self._playerLocalPos:Set(afterOffsetLocalPos.x, afterOffsetLocalPos.y + data.addParam, 0)

				self._isPortalsing = true
				self._canChase = true
			end
		end

		settimer(0.5, self._playerMoveAgain, self, false)
	end
end

function DivineHaloGameView:_trigExitDoor()
	if self._isFirstTrigExitDoor then
		settimer(0.5, self._winGame, self)

		self._isFirstTrigExitDoor = false

		self:_playEndPointEff()
	end
end

function DivineHaloGameView:_winGame()
	removetimer(self._winGame, self)
	removetimer(self._tickTime, self)

	self._isPause = true
	self._playerCanCtrlMove = false

	TipsFacade.instance:openTipWindowNoX("提示", "到达出口，闯关成功!", function()
		DivineHaloGameController.instance:sendPM_DivineHaloGameEndGameReq(self._activityId, self._stageId, 1)

		self._isFirstTrigExitDoor = false
	end, "确定", nil)
end

function DivineHaloGameView:_playerMoveEveryWhere(playerChangeMode)
	self._playerCellCls:setPlayerPosType(DivineHaloGameModel.PlayerPosType.Free)

	if playerChangeMode == DivineHaloGameModel.PlayerChangeState.ToOutHorizontal then
		self._playerCellCls:setPlayerHorizontalChangeState(playerChangeMode)

		self._canFreeMoveHorizontal = true
	elseif playerChangeMode == DivineHaloGameModel.PlayerChangeState.ToOutVertical then
		self._playerCellCls:setPlayerVerticalChangeState(playerChangeMode)

		self._canFreeMoveVertical = true
	end
end

function DivineHaloGameView:_playerChase()
	if self:_playerChaseStable() then
		return
	end

	self._playerLocalPos = DivineHaloGameController.instance:getLocalPos(self._playerCellGo, self._playerLocalPos)

	local middlePos = Vector3.zero
	local finalPos = Vector3.Lerp(self._playerLocalPos, middlePos, 0.05)
	local diffPos = self._playerLocalPos - finalPos

	self._mapMoveCtrlCls:trigMapChase(diffPos)

	if self._mapCanHorizontalChase and self._playerLocalPos ~= 0 then
		GameUtil.setLocalPos(self._playerCellGo, finalPos.x, self._playerLocalPos.y, finalPos.z)
	end

	self._playerLocalPos = DivineHaloGameController.instance:getLocalPos(self._playerCellGo, self._playerLocalPos)

	if self._mapCanVerticalChase then
		GameUtil.setLocalPos(self._playerCellGo, self._playerLocalPos.x, finalPos.y, finalPos.z)
	end
end

function DivineHaloGameView:_playerChaseStable()
	self._playerLocalPos = DivineHaloGameController.instance:getLocalPos(self._playerCellGo, self._playerLocalPos)

	local middlePos = Vector3.zero
	local finalPos = Vector3.Lerp(self._playerLocalPos, middlePos, PLAYER_CHASE_LERP)
	local diffPos = self._playerLocalPos - finalPos

	if Mathf.Abs(finalPos.x) <= PLAYER_CHASE_SNAP then
		finalPos.x = 0
		diffPos.x = self._playerLocalPos.x
	end

	if Mathf.Abs(finalPos.y) <= PLAYER_CHASE_SNAP then
		finalPos.y = 0
		diffPos.y = self._playerLocalPos.y
	end

	self._mapMoveCtrlCls:trigMapChase(diffPos)

	local targetPosX = self._playerLocalPos.x
	local targetPosY = self._playerLocalPos.y

	if self._mapCanHorizontalChase and Mathf.Abs(self._playerLocalPos.x) > PLAYER_MOVE_EPSILON then
		targetPosX = finalPos.x
	end

	if self._mapCanVerticalChase and Mathf.Abs(self._playerLocalPos.y) > PLAYER_MOVE_EPSILON then
		targetPosY = finalPos.y
	end

	if Mathf.Abs(targetPosX - self._playerLocalPos.x) > PLAYER_MOVE_EPSILON or Mathf.Abs(targetPosY - self._playerLocalPos.y) > PLAYER_MOVE_EPSILON then
		GameUtil.setLocalPos(self._playerCellGo, targetPosX, targetPosY, finalPos.z)
		self._playerLocalPos:Set(targetPosX, targetPosY, finalPos.z)
	end

	return true
end

function DivineHaloGameView:_mapCanChaseHorizontal(canChase)
	self._mapCanHorizontalChase = canChase
end

function DivineHaloGameView:_mapCanChaseVertical(canChase)
	self._mapCanVerticalChase = canChase
end

function DivineHaloGameView:_onClickBtnClose()
	self._playerCanCtrlMove = false
	self._isPause = true

	local function sureFunc()
		DivineHaloGameController.instance:sendPM_DivineHaloGameEndGameReq(self._activityId, self._stageId, 0)
	end

	local function cancelFunc()
		self._playerCanCtrlMove = true
		self._isPause = false
	end

	TipsFacade.instance:openPopupWindow("提示", "是否确认退出游戏\n<color=#FF0000FF>退出不保存关卡进度，不消耗闯关次数</color>", sureFunc, cancelFunc, "退出", "取消")
end

function DivineHaloGameView:_onClickBtnTip()
	self._isPause = true

	local ruleCfg = DivineHaloGameConfig.instance:getRuleDataById(self._actCfg.ruleId)
	local ruleList = {}

	for i, v in ipairs(ruleCfg) do
		local obj = {}

		obj.url = v.resPath
		obj.desc = v.desc

		table.insert(ruleList, obj)
	end

	TipsFacade.instance:openImageRuleView(ruleList, "游戏规则", function()
		self._isPause = false
	end)
end

function DivineHaloGameView:_updateColorWallCell(cls)
	local go = cls:getGo()
	local clsData = cls:getData()
	local bgGo = goutil.findChild(go, "bg")
	local imgComp = bgGo:GetComponent(goutil.Type_UIImage)
	local playerColorType = self._playerCellCls:getColorType()

	if clsData.colorType == playerColorType and clsData.cellType == DivineHaloGameModel.CellTypeEnum.ColorWall then
		local boxCollider = cls:getBoxCollider2D()

		Game.ImageUtil.SetImageAlpha(imgComp, 0.3)

		boxCollider.enabled = false
	else
		local boxCollider = cls:getBoxCollider2D()

		Game.ImageUtil.SetImageAlpha(imgComp, 1)

		boxCollider.enabled = true
	end
end

function DivineHaloGameView:_tickTime()
	if not self._isPause then
		self._gameTime = self._gameTime - 1
	end

	self._txtGameTime.text = string.format("倒计时：%d秒", self._gameTime)

	GameUtil.SetActive(self._countDownEffCon, self._gameTime <= 5)

	if self._gameTime <= 0 then
		self._playerCanCtrlMove = false

		removetimer(self._tickTime, self)
		TipsFacade.instance:openTipWindowNoX("提示", "倒计时用尽，闯关失败!", function()
			DivineHaloGameController.instance:sendPM_DivineHaloGameEndGameReq(self._activityId, self._stageId, 0)
		end, "确定")
	end
end

function DivineHaloGameView:_setCountDownEffect()
	local timeOutEffect = "fx_ui_zhanqianzhunbei/fx_ui_zhanqianzhunbei_shanshuo.prefab"

	self:playViewEffect(timeOutEffect, self._countDownEffCon, nil, true)
	GameUtil.SetActive(self._countDownEffCon, false)
end

function DivineHaloGameView:_setThunderEffect()
	local thunderEffect = "20250530/shikongmigong/fx_ui_sygl_fw.prefab"

	self:playViewEffect(thunderEffect, self._thunderEffRoot, nil, true)
	GameUtil.SetActive(self._thunderEffRoot, false)
end

local effPath = "20250530/shikongmigong/fx_ui_sygl_huanse.prefab"

function DivineHaloGameView:_playChangeColorEff()
	if self._changeColorEffect then
		UIEffectManager.instance:stopEffect(self._changeColorEffect)

		self._changeColorEffect = nil
	end

	self._changeColorEffect = UIEffectManager.instance:playEffect(self, effPath, self._playerCellGo.transform, 0, 0, false, false, nil, function(target, eff)
		eff:setClipping(self.mainGO.transform)
	end)

	self._changeColorEffect:setParent(self._playerCellGo.transform)
	self._changeColorEffect:setLocalPos(0, 0, 0)
	self._changeColorEffect:setScale(1)
end

local effPath = "20250530/shikongmigong/fx_ui_sygl_chuansong.prefab"

function DivineHaloGameView:_playEndPointEff()
	if self._touchEndPointEffect then
		UIEffectManager.instance:stopEffect(self._touchEndPointEffect)

		self._touchEndPointEffect = nil
	end

	self._touchEndPointEffect = UIEffectManager.instance:playEffect(self, effPath, self._playerCellGo.transform, 0, 0, false, false, nil, function(target, eff)
		eff:setClipping(self.mainGO.transform)
	end)

	self._touchEndPointEffect:setParent(self._playerCellGo.transform)
	self._touchEndPointEffect:setLocalPos(0, 0, 0)
	self._touchEndPointEffect:setScale(1)
end

function DivineHaloGameView:_endGameRes()
	self._isFirstTrigExitDoor = false

	self:close()
end

function DivineHaloGameView:_hasBeenStuck()
	local isDraging = self._inputDirectionX ~= 0 or self._inputDirectionY ~= 0
	local playerDontMove = self._playerLocalPos.x - self._prePlayerLocalPos.x ~= 0 or self._playerLocalPos.y - self._prePlayerLocalPos.y ~= 0

	return isDraging and not playerDontMove
end

function DivineHaloGameView:_playerMoveAgain()
	self._isPortalsing = false

	removetimer(self._playerMoveAgain, self)
end

return DivineHaloGameView
