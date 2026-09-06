-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/iceqibugame/view/IceQiBuGameSceneView.lua

module("logic.extensions.iceqibugame.view.IceQiBuGameSceneView", package.seeall)

local IceQiBuGameSceneView = class("IceQiBuGameSceneView", ViewComponent)

function IceQiBuGameSceneView:ctor()
	IceQiBuGameSceneView.super.ctor(self)

	self._multiLoader = MultiResLoader.New()
	self._stateMachine = SimpleFSM.New()

	self._stateMachine:addState(MmUtil.State_Preparing, GameUtil.handler(self._onPreparingEnter, self), nil, nil, nil)
	self._stateMachine:addState(MmUtil.State_Runing, GameUtil.handler(self._onRuningEnter, self), nil, GameUtil.handler(self._onRuningUpdate, self), nil)
	self._stateMachine:addState(MmUtil.State_Stoping, GameUtil.handler(self._onStopingEnter, self), nil, nil, nil)
	self._stateMachine:addState(MmUtil.State_Ended, GameUtil.handler(self._onEndedEnter, self), nil, nil, nil)

	local linkedList = {
		[MmUtil.State_Preparing] = {
			MmUtil.State_Runing
		},
		[MmUtil.State_Runing] = {
			MmUtil.State_Stoping,
			MmUtil.State_Ended
		},
		[MmUtil.State_Stoping] = {
			MmUtil.State_Runing,
			MmUtil.State_Ended
		},
		[MmUtil.State_Ended] = {
			MmUtil.State_Preparing
		}
	}

	self._stateMachine:addLinkByLinkedList(linkedList)
end

function IceQiBuGameSceneView:buildUI()
	IceQiBuGameSceneView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtCurTime = self:getTxt("curTime/txt")
	self._mapView = self:getGo("mapView")
	self._playerRoot = self:getGo("mapView/playerRoot")
	self._spineRoot = self:getGo("mapView/playerRoot/spineRoot")
	self._gridRoot = self:getGo("mapView/gridRoot")
	self._gridGo = self:getGo("mapView/gridGo")
	self._startTips = self:getGo("startTips")
	self._leftMove = self:getGo("move/left")
	self._upMove = self:getGo("move/up")
	self._rightMove = self:getGo("move/right")
	self._downMove = self:getGo("move/down")
	self._txtTipsInEditor = self:getTxt("txtTipsInEditor")

	GameUtil.SetActive(self._gridGo, false)
end

function IceQiBuGameSceneView:bindEvents()
	IceQiBuGameSceneView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._startTips, self._onClickStartTips, self)
	GameUtil.addClickHandler(self._leftMove, GameUtil.handler(self._onMoveHandle, self, MmUtil.Towards.Left))
	GameUtil.addClickHandler(self._upMove, GameUtil.handler(self._onMoveHandle, self, MmUtil.Towards.Up))
	GameUtil.addClickHandler(self._rightMove, GameUtil.handler(self._onMoveHandle, self, MmUtil.Towards.Right))
	GameUtil.addClickHandler(self._downMove, GameUtil.handler(self._onMoveHandle, self, MmUtil.Towards.Down))
end

function IceQiBuGameSceneView:unbindEvents()
	IceQiBuGameSceneView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._startTips)
	GameUtil.rmClickHandler(self._leftMove)
	GameUtil.rmClickHandler(self._upMove)
	GameUtil.rmClickHandler(self._rightMove)
	GameUtil.rmClickHandler(self._downMove)
end

function IceQiBuGameSceneView:onEnter()
	IceQiBuGameSceneView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._gameParam = params[1] or IceQibuGameParam.New()

	self.addGEvent(self, GlobalNotify.GameSureCloseView, self._gameSureCloseView, self)
	self.addGEvent(self, GlobalNotify.GameCancelCloseView, self._gameCancelCloseView, self)
	self.addGEvent(self, GlobalNotify.GameResetProcess, self._gameResetProcess, self)
	GameUtil.SetActive(self._txtTipsInEditor.gameObject, enableDebug)

	if enableDebug then
		self._txtTipsInEditor.text = string.format("mapId：%s(编辑器显示)", self._gameParam:getMapId())
	end

	self._stateMachine:startTimer()
	self._stateMachine:gotoState(MmUtil.State_Preparing)
end

function IceQiBuGameSceneView:onExit()
	IceQiBuGameSceneView.super.onExit(self)
	self:_killPathMoveSequence()

	self._gridInfos = nil

	self:_clearGridGos()
	self._stateMachine:stopTimer()
end

function IceQiBuGameSceneView:destroyUI()
	IceQiBuGameSceneView.super.destroyUI(self)

	if self._multiLoader then
		GameUtil.unloadMultiResLoaderResource(self._multiLoader)

		self._multiLoader = nil
	end

	self:_disposeGridGoPool()
end

function IceQiBuGameSceneView:_gameSureCloseView()
	self:_closeGame()
end

function IceQiBuGameSceneView:_gameCancelCloseView()
	self._stateMachine:gotoState(MmUtil.State_Runing)
end

function IceQiBuGameSceneView:_gameResetProcess()
	self._stateMachine:gotoState(MmUtil.State_Preparing)
end

function IceQiBuGameSceneView:_getCurState()
	return self._stateMachine.currStateName
end

function IceQiBuGameSceneView:_onPreparingEnter()
	self:_resetGame()
end

function IceQiBuGameSceneView:_onRuningEnter()
	self:_continueGame()
end

function IceQiBuGameSceneView:_onStopingEnter()
	self:_stopGame()
end

function IceQiBuGameSceneView:_onEndedEnter()
	self:_stopGame()
	self:_killPathMoveSequence()
end

function IceQiBuGameSceneView:_onRuningUpdate()
	self._deltaTime = UnityEngine.Time.deltaTime
	self._curGameTime = self._curGameTime + self._deltaTime
	self._leftGameTime = Mathf.Max(self._maxGameTime - self._curGameTime, 0)
	self._txtCurTime.text = self:_formatRemainSeconds(self._leftGameTime)

	if self._leftGameTime <= 0 then
		self:_endGame(false)
	end
end

function IceQiBuGameSceneView:getLeftGameTime()
	return self._leftGameTime
end

function IceQiBuGameSceneView:getCostTime()
	return Mathf.Floor(self._curGameTime + 0.5)
end

function IceQiBuGameSceneView:_resetGame()
	self._isLoadFinish = false

	self:_killPathMoveSequence()
	self:_clearGridGos()

	self._mapId = self._gameParam:getMapId()

	local mapData = IceQibuGameConfig.instance:getMapData(self._mapId)

	self._maxGameTime = mapData.maxGameTime

	local jsonDataPath = mapData.jsonDataPath

	local function finishCallBack(loader)
		local res = self._multiLoader:getResource(jsonDataPath)

		if res then
			local main_asset = res:GetMainAsset()

			if main_asset then
				local asset = res:GetAsset(nil, nil)

				if enableDebug then
					print(string.format("进入冰奇布小游戏，mapId:%s", self._mapId))
					print(asset.text)
				end

				self._jsonData = GameUtil.jsonToTable(asset.text)

				self:_onCreateGame()
			else
				printError(string.format("冰奇布小游戏：资源加载失败( mapId:%s, path:%s )", self._mapId, jsonDataPath))
			end
		end
	end

	if self._multiLoader:getResource(jsonDataPath) then
		finishCallBack()
	else
		self._multiLoader:addResPath(jsonDataPath, true)
		self._multiLoader:load(finishCallBack, nil, self)
	end

	GameUtil.SetActive(self._playerRoot, true)
	GameUtil.SetActive(self._startTips, true)
end

function IceQiBuGameSceneView:_onCreateGame()
	self._curGameTime = 0
	self._leftGameTime = 0
	self._curPlayerGridId = 0
	self._isMoveing = false
	self._row = self._jsonData.row
	self._column = self._jsonData.column
	self._cellSize = self._jsonData.cellSize

	local cellDatas = {}

	for _, v in ipairs(self._jsonData.cells) do
		local gridId = MmUtil.getPosIndex(v.x, v.y, self._column, self._row)

		cellDatas[gridId] = v
	end

	local iconPaths = {}

	for _, v in ipairs(self._jsonData.cellTypeSpritePaths) do
		iconPaths[v.cellType] = string.match(v.spritePath, "^Assets/GameAssets/(.+)$")
	end

	self._gridInfos = {}

	local totalCount = self._row * self._column

	for gridId = 1, totalCount do
		local cellData = cellDatas[gridId]

		if cellData then
			if not cellData.cellType then
				local cellType = IceQibuGameEnum.CellType_Normal
				local exParams
				local info = {}
				local x, y = MmUtil.getPos(gridId, self._column, self._row)

				info.x = x
				info.y = y
				info.cellType = cellType
				info.mainGo = nil
				info.posX, info.posY = self:_getLocalPos(gridId)
				info.isActive = true
				info.exParams = (cellData and not string.nilorempty(cellData.extraParamsJson) or nil) and GameUtil.jsonToTable(cellData.extraParamsJson)

				if info.cellType ~= IceQibuGameEnum.CellType_Normal then
					local mainGo = self:_fetchGridGo()

					info.mainGo = mainGo

					local icon = goutil.findChild(mainGo, "icon")

					GameUtil.setLocalPos(mainGo, info.posX, info.posY)
					GameUtil.SetActive(mainGo, true)

					if info.exParams then
						if not info.exParams.direction then
							local direction = MmUtil.Towards.Up
							local rotationAngle = MmUtil.RotationAngles[direction]

							GameUtil.setLocalRotation(icon, 0, 0, rotationAngle)

							local iconPath = iconPaths[info.cellType]

							if not string.nilorempty(iconPath) then
								uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, iconPath, function()
									return
								end)
							else
								uGuiUtil.clearImage(icon)
							end
						end
					end
				end

				if info.cellType == IceQibuGameEnum.CellType_SpawnPoint then
					self._curPlayerGridId = gridId
				end

				self._gridInfos[gridId] = info
			end
		end
	end

	local totalWidth = self._column * self._cellSize
	local totalHeight = self._row * self._cellSize

	GameUtil.setWidth(self._mapView, totalWidth)
	GameUtil.setHeight(self._mapView, totalHeight)

	if self._curPlayerGridId == 0 or self._gridInfos[self._curPlayerGridId] == nil then
		printError(string.format("冰奇布小游戏：未找到出生点(SpawnPoint)，mapId:%s", self._mapId))

		if enableDebug then
			print(string.format("地图数据异常 - mapId:%s, row:%s, column:%s", self._mapId, self._row, self._column))
		end

		self._isLoadFinish = false
		self._txtCurTime.text = "地图数据错误"

		return
	end

	local gridInfo = self._gridInfos[self._curPlayerGridId]

	if gridInfo then
		GameUtil.setLocalPos(self._playerRoot, gridInfo.posX, gridInfo.posY)
	else
		printError(string.format("出生点不存在， curPlayerGridId:%s", self._curPlayerGridId))
	end

	self._txtCurTime.text = self:_formatRemainSeconds(self._maxGameTime)
	self._isLoadFinish = true
end

function IceQiBuGameSceneView:_continueGame()
	self:_resumePathMoveAnim()
end

function IceQiBuGameSceneView:_stopGame()
	self:_pausePathMoveAnim()
end

function IceQiBuGameSceneView:_endGame(isSuccess)
	self._stateMachine:gotoState(MmUtil.State_Ended)

	if isSuccess then
		self:_doGameEndCallBack(MmUtil.GameResult_GameOverOfSuccess)
	else
		self:_doGameEndCallBack(MmUtil.GameResult_GameOverOfFail)
	end
end

function IceQiBuGameSceneView:_tryExitGame()
	self._stateMachine:gotoState(MmUtil.State_Stoping)
	self:_doGameEndCallBack(MmUtil.GameResult_GameOverOfDropOut)
end

function IceQiBuGameSceneView:_closeGame()
	self:close()
end

function IceQiBuGameSceneView:_doGameEndCallBack(gameEndRes)
	self._gameParam:doGameEndCallBack(gameEndRes, self)
end

function IceQiBuGameSceneView:_fetchGridGo()
	if self._gridGoPool == nil then
		self:_creatGridGoPool()
	end

	local go = self._gridGoPool:fetchObject()

	self._gridGos[go] = go

	return go
end

function IceQiBuGameSceneView:_returnGridGo(go)
	if self._gridGoPool then
		self._gridGos[go] = nil

		self._gridGoPool:returnObject(go)
	end
end

function IceQiBuGameSceneView:_creatGridGoPool()
	local function createFunc()
		return (goutil.cloneAndSetParent(self._gridGo, self._gridRoot.transform, self._gridGo.name))
	end

	local function disposeFunc(go)
		goutil.destroy(go)
	end

	local function resetFunc(go)
		local icon = goutil.findChild(go, "icon")

		uGuiUtil.clearImage(icon)
		GameUtil.SetActive(go, false)
	end

	self._gridGos = {}
	self._gridGoPool = ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

function IceQiBuGameSceneView:_disposeGridGoPool()
	if self._gridGoPool then
		self:_clearGridGos()
		self._gridGoPool:clear()

		self._gridGoPool = nil
	end
end

function IceQiBuGameSceneView:_clearGridGos()
	if self._gridGos == nil then
		return
	end

	for k, v in pairs(self._gridGos) do
		self:_returnGridGo(v)
	end

	table.clear(self._gridGos)
end

function IceQiBuGameSceneView:_onMoveHandle(toward)
	if self:_getCurState() ~= MmUtil.State_Runing then
		return
	end

	if self._isMoveing then
		return
	end

	self:_tryMovePlayer(toward)
end

function IceQiBuGameSceneView:_tryMovePlayer(toward)
	local startGridId = self._curPlayerGridId
	local endGridId = self._curPlayerGridId
	local startToward = toward
	local endToward = toward
	local triggerCellType, motionParams
	local curX, curY = MmUtil.getPos(endGridId, self._column, self._row)
	local nextX, nextY = MmUtil.getNeighborPos(curX, curY, self._column, self._row, startToward)
	local lastGridId = self._curPlayerGridId
	local nextGridId = MmUtil.getPosIndex(nextX, nextY, self._column, self._row)

	endGridId = nextGridId

	while true do
		curX, curY = MmUtil.getPos(endGridId, self._column, self._row)
		nextX, nextY = MmUtil.getNeighborPos(curX, curY, self._column, self._row, endToward)
		nextGridId = MmUtil.getPosIndex(nextX, nextY, self._column, self._row)

		local curInfo = self._gridInfos[endGridId]

		if curInfo then
			local cellType = curInfo.cellType
			local exParams = curInfo.exParams
			local isActive = curInfo.isActive

			if not isActive or cellType == IceQibuGameEnum.CellType_Normal then
				lastGridId = endGridId
				endGridId = nextGridId
			elseif cellType == IceQibuGameEnum.CellType_SpawnPoint then
				lastGridId = endGridId
				endGridId = nextGridId
			elseif cellType == IceQibuGameEnum.CellType_Wall then
				endGridId = lastGridId
				triggerCellType = cellType

				break
			elseif cellType == IceQibuGameEnum.CellType_Conveyor then
				endToward = exParams.direction
				triggerCellType = cellType

				break
			elseif cellType == IceQibuGameEnum.CellType_SlowZone then
				local direction = exParams.direction

				if direction == endToward then
					triggerCellType = cellType
					endGridId = nextGridId

					break
				else
					endGridId = lastGridId

					break
				end
			elseif cellType == IceQibuGameEnum.CellType_Fragile then
				motionParams = {
					gridId = endGridId
				}
				endGridId = lastGridId
				triggerCellType = cellType

				break
			elseif cellType == IceQibuGameEnum.CellType_Exit then
				triggerCellType = cellType

				break
			end
		else
			break
		end
	end

	local totalCount = self._row * self._column

	if endGridId == nil or endGridId <= 0 or totalCount < endGridId or self._gridInfos[endGridId] == nil then
		endGridId = lastGridId
		self._curPlayerGridId = lastGridId
		self._isMoveing = false

		return
	end

	self._curPlayerGridId = endGridId

	local sequence = self:_newPlayerSequence()

	self._isMoveing = true

	local startPosX, startPosY = self:_getLocalPos(startGridId)
	local endPosX, endPosY = self:_getLocalPos(endGridId)
	local startVec = Vector3.New(startPosX, startPosY, 0)
	local endVec = Vector3.New(endPosX, endPosY, 0)
	local distance = Vector3.Distance(startVec, endVec)
	local duration = distance / 200
	local tweener = self._playerRoot.transform:DOLocalMove(endVec, duration)

	tweener:SetEase(DG.Tweening.Ease.Linear)
	tweener:OnPlay(function()
		self:_setPlayerToward(startToward)
	end)
	tweener:OnComplete(function()
		self:_setPlayerToward(endToward)
	end)
	sequence:Append(tweener)
	sequence:OnComplete(function()
		self._isMoveing = false

		if triggerCellType == IceQibuGameEnum.CellType_Conveyor then
			self:_tryMovePlayer(endToward)
		elseif triggerCellType == IceQibuGameEnum.CellType_SlowZone then
			-- block empty
		elseif triggerCellType == IceQibuGameEnum.CellType_Fragile then
			local fragileGridId = motionParams.gridId
			local fragileInfo = self._gridInfos[fragileGridId]

			fragileInfo.isActive = false

			GameUtil.SetActive(fragileInfo.mainGo, false)
		elseif triggerCellType == IceQibuGameEnum.CellType_Exit then
			self:_endGame(true)
		end
	end)
end

function IceQiBuGameSceneView:_newPlayerSequence()
	self:_killPathMoveSequence()

	self._playerSequence = DG.Tweening.DOTween.Sequence()

	return self._playerSequence
end

function IceQiBuGameSceneView:_killPathMoveSequence()
	self._isMoveing = false

	if self._playerSequence then
		self._playerSequence:Kill(true)

		self._playerSequence = nil
	end
end

function IceQiBuGameSceneView:_resumePathMoveAnim()
	if self._playerSequence then
		self._playerSequence:Play()
	end
end

function IceQiBuGameSceneView:_pausePathMoveAnim()
	if self._playerSequence then
		self._playerSequence:Pause()
	end
end

function IceQiBuGameSceneView:_formatRemainSeconds(seconds)
	return string.format("%d秒", Mathf.Floor(seconds + 0.5))
end

function IceQiBuGameSceneView:_getLocalPos(gridId)
	local cellSize = self._cellSize
	local x, y = MmUtil.getPos(gridId, self._column, self._row)
	local posX = (x - self._column * 0.5) * cellSize + cellSize * 0.5
	local posY = (y - self._row * 0.5) * cellSize + cellSize * 0.5

	return posX, posY
end

function IceQiBuGameSceneView:_setPlayerToward(toward)
	if toward == MmUtil.Towards.Left then
		GameUtil.setLocalScale(self._playerRoot, -1, 1, 1)
	elseif toward == MmUtil.Towards.Right then
		GameUtil.setLocalScale(self._playerRoot, 1, 1, 1)
	end
end

function IceQiBuGameSceneView:_onClickStartTips()
	if self:_getCurState() ~= MmUtil.State_Preparing then
		return
	end

	if not self._isLoadFinish then
		return
	end

	GameUtil.SetActive(self._startTips, false)
	self._stateMachine:gotoState(MmUtil.State_Runing)
end

function IceQiBuGameSceneView:_onClickBtnClose()
	self:_tryExitGame()
end

return IceQiBuGameSceneView
