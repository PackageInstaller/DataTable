-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiumumchallenge/view/XiuMumGameView.lua

module("logic.extensions.xiumumchallenge.view.XiuMumGameView", package.seeall)

local XiuMumGameView = class("XiuMumGameView", ViewComponent)

function XiuMumGameView:buildUI()
	XiuMumGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._itemShow = self:getGo("rule/item")
	self._txtRule = self:getTxt("rule/txtRule")
	self._btnBeginGame = self:getGo("beginGame")
	self._txtBeginDesc = goutil.findChildTextComponent(self._btnBeginGame, "txtDesc")
	self._btnGameOver = self:getGo("gameOver")
	self._btnReset = self:getGo("btnRest")
	self._txtTime = self:getTxt("countdown/txtTime")
	self._btnChallenge = self:getGo("btnChallenge")
	self._txtCurMonsterNum = self:getTxt("txtCurMonsterNum")
	self._rootPipe = self:getGo("root")
	self._cellPipe = goutil.findChild(self._rootPipe, "cell")

	goutil.setActive(self._cellPipe, false)

	self._gridLayoutGroup = self._rootPipe:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._posStart = self:getGo("posStart")
	self._player = goutil.findChild(self._posStart, "player")
end

function XiuMumGameView:bindEvents()
	XiuMumGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnBeginGame, self._onClickBeginGame, self)
	GameUtil.addClickHandler(self._btnGameOver, self.close, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function XiuMumGameView:unbindEvents()
	XiuMumGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBeginGame)
	GameUtil.rmClickHandler(self._btnGameOver)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function XiuMumGameView:onEnter()
	XiuMumGameView.super.onEnter(self)

	if XiuMumChallengeModel.instance:getDailyRefresh() then
		self:_onRefreshDaily()

		return
	end

	self._flagEnther = false
	self._isPlayEffing = false
	self._playEnterMove = false

	self:_setCfgAndInfo()
	self:_buildPipeMap()
	XiuMumChallengeModel.instance:ShowCI()

	if table.nums(self._curRoadIds) > 0 then
		self:_resetChallenge()
	else
		self:_resetGame()
	end

	self._txtRule.text = self._ruleCfg.rules

	MaterialMgr.setCellByCfg(self._stageCfg.prize, self._itemShow)
	GlobalDispatcher:addListener(GlobalNotify.XiuMumChallengePassGame, self._onPassGame, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onRefreshDaily, self)
end

function XiuMumGameView:onEnterFinished()
	XiuMumGameView.super.onEnterFinished(self)

	self._flagEnther = true

	if self._playEnterMove then
		self:_movePlayer()
	end
end

function XiuMumGameView:onExit()
	XiuMumGameView.super.onExit(self)
	self:_removeAllTimer()
	MaterialMgr.resetAll(self._itemShow)
	GlobalDispatcher:removeListener(GlobalNotify.XiuMumChallengePassGame, self._onPassGame, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._onRefreshDaily, self)

	if self._tweenList then
		for i, v in ipairs(self._tweenList) do
			v:Kill()
		end

		self._tweenList = nil
	end

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end
end

function XiuMumGameView:_onClickClose()
	if not self._isMoveing then
		UIStateManager.instance:push(self:_getMainView(), XiuMumChallengeModel.instance:getCurActId(), true)
		self:close()
	end
end

function XiuMumGameView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, self:_getRuleName())
end

function XiuMumGameView:_onClickBeginGame()
	if self._isGameReady then
		self:_readyStartPipeGame()
	end
end

function XiuMumGameView:_onClickReset()
	if self._isGameing and not self._isChallengeing and self._flagEnther then
		self:_resetGame()
	end
end

function XiuMumGameView:_onClickChallenge()
	if not self._isChallengeing then
		return
	end

	if self._isPlayEffing then
		return
	end

	local cell = self._pipeCellList[self._nextPlayerPlace]

	if checknumber(cell.formId) == 0 then
		FloatWordMgr.instance:show(lang("无可挑战关卡"))

		return
	end

	self._isPlayEffing = true

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end

	local path = "20230120/zaoyuqiangdi/fx_ui_zaoyuqiangdi.prefab"

	self._eff = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, false, nil, function()
		if cell then
			local mo = XiuMumChallengeModel.instance:getCustomFmtMo()

			mo:initParams(cell.id, cell.formId, self._viewPresentor.viewName)
			CustomFmtController.instance:showMissionView(mo)
		end

		self._isPlayEffing = false
	end, function(finishHandlerTarget, eff)
		eff:setParent(self.mainGO.transform)
		eff:setScale(1)
		eff:setLocalPos(0, 0, 0)
	end)
end

function XiuMumGameView:_setCfgAndInfo()
	self._ruleCfg = RulesConfig.instance:getRuleCo(self:_getRuleName())
	self._stageCfg = XiuMumChallengeModel.instance:getCurLevelCfg()
	self._curRoadIds = XiuMumChallengeModel.instance:getCurRoadData()
	self._curMapInfos = XiuMumChallengeModel.instance:getCurMapData()
	self._pipeMapCfg = XiuMumChallengeConfig.instance:getMapCfg(self._stageCfg.mapId)
end

function XiuMumGameView:_getRuleName()
	return "motherXiuChallenge_rule"
end

function XiuMumGameView:_buildPipeMap()
	self._pipeCellList = self._pipeCellList or {}

	for k, v in pairs(self._pipeCellList) do
		goutil.setActive(v.go, false)
	end

	self._pipeCellList = {}
	self._pipeCellHash = {}
	self._startIdRoad = -1
	self._endIdRoad = -1

	local curColumCount = 0

	if self._pipeMapCfg then
		local mapData = self._pipeMapCfg.mapData

		self._startIdRoad = mapData.startPosIndex
		self._endIdRoad = mapData.endPosIndex

		for k, v in ipairs(mapData.list) do
			local cell = {}

			cell.id = v.index
			cell.row = v.row
			cell.column = v.column

			if curColumCount < cell.column then
				curColumCount = cell.column
			end

			cell.mapRotation = v.rotationType
			cell.rotation = v.rotationType
			cell.stateId = v.stateIdx
			cell.formId = 0

			local mapParamCfg = XiuMumChallengeConfig.instance:getMapParamCfg(v.addParam)

			cell.go = goutil.findChild(self._rootPipe, "cell_" .. cell.id) or goutil.cloneAndSetParent(self._cellPipe, self._rootPipe.transform, "cell_" .. cell.id)
			cell.pipe = goutil.findChild(cell.go, "pipe")

			local pipeChange = cell.pipe:GetComponent("UIImageSpriteChange")

			cell.head = goutil.findChild(cell.go, "head")
			cell.headBg = goutil.findChild(cell.go, "headBg")
			cell.icon = goutil.findChild(cell.head, "icon")

			goutil.setActive(cell.head, false)
			GameUtil.SetActive(cell.headBg, false)

			cell.posStart = goutil.findChild(cell.go, "posStart")
			cell.posEnd = goutil.findChild(cell.go, "posEnd")
			cell.txtShow = goutil.findChildTextComponent(cell.go, "txtShow")

			goutil.setActive(cell.posStart, cell.id == self._startIdRoad)
			goutil.setActive(cell.posEnd, cell.id == self._endIdRoad)

			if cell.stateId == XiuMumChallengeModel.PipeType.None then
				goutil.setActive(cell.pipe, false)
			elseif cell.stateId == XiuMumChallengeModel.PipeType.EndPos then
				pipeChange:SetState(0)
			else
				pipeChange:SetState(cell.stateId - 1)
			end

			if mapParamCfg then
				uGuiUtil.clearImage(cell.icon)

				if not string.nilorempty(mapParamCfg.showIconPath) then
					local path = string.format("ui/icon/%s.png", mapParamCfg.showIconPath)

					uGuiUtil.setSpriteToImage(cell.icon, uGuiUtil.SpriteType.BigBg, path)
				end

				cell.formId = mapParamCfg.creepsMasterId
			end

			cell.txtShow.text = cell.stateId .. "--" .. cell.mapRotation .. "--" .. v.addParam

			GameUtil.rmClickHandler(cell.go)
			GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickPipe, self, cell))

			self._pipeCellList[cell.id] = cell
			self._pipeCellHash[cell.row] = self._pipeCellHash[cell.row] or {}
			self._pipeCellHash[cell.row][cell.column] = cell

			goutil.setActive(cell.go, true)
		end
	end

	self._gridLayoutGroup.constraintCount = curColumCount + 1
end

function XiuMumGameView:_resetGame()
	goutil.setActive(self._btnReset, true)
	goutil.setActive(self._btnGameOver, false)
	goutil.setActive(self._btnBeginGame, true)
	goutil.setActive(self._btnChallenge, false)
	goutil.setActive(self._txtCurMonsterNum.gameObject, false)
	goutil.setActive(self._posStart, false)
	self:_removeAllTimer()

	if self._pipeMapCfg then
		self._gameTimer = self._pipeMapCfg.countdown or 30
	end

	self._gameReadyTimer = 3
	self._txtBeginDesc.text = lang("点击任意位置开始游戏")
	self._txtTime.text = langPara("本关剩余时间：%s秒", self._gameTimer)
	self._isGameReady = true
	self._isGameing = false
	self._isChallengeing = false

	for k, cell in pairs(self._pipeCellList) do
		cell.rotation = cell.mapRotation

		self:_roratePipeCell(cell)
	end

	self._player.transform:SetParent(self._posStart.transform)
	GameUtil.setLocalPos(self._player, 0, 0, 0)
end

function XiuMumGameView:_resetChallenge()
	goutil.setActive(self._btnReset, false)
	goutil.setActive(self._posStart, true)

	self._isGameReady = false
	self._isGameing = false

	goutil.setActive(self._btnBeginGame, false)

	for k, cell in pairs(self._pipeCellList) do
		cell.rotation = self._curMapInfos[cell.id] or 0

		self:_roratePipeCell(cell)

		if table.keyof(self._curRoadIds, cell.id) and cell.formId > 0 then
			goutil.setActive(cell.head, true)
			GameUtil.SetActive(cell.headBg, true)
		end
	end

	self._curPlayerPlace = XiuMumChallengeModel.instance:getCurPlace()
	self._nextPlayerPlace = -1

	local cell = self._pipeCellList[self._curPlayerPlace]
	local curPlaceId = table.indexof(self._curRoadIds, self._curPlayerPlace) or table.indexof(self._curRoadIds, self._startIdRoad)

	for i = curPlaceId + 1, #self._curRoadIds do
		local checkCell = self._pipeCellList[self._curRoadIds[i]]

		if checkCell and checkCell.formId > 0 and self._nextPlayerPlace < 0 then
			self._nextPlayerPlace = checkCell.id
		end
	end

	if self._nextPlayerPlace < 0 then
		self._nextPlayerPlace = self._endIdRoad
	end

	local nextCell = self._pipeCellList[self._nextPlayerPlace]

	if self._nextPlayerPlace == self._curPlayerPlace then
		self._player.transform:SetParent(nextCell.go.transform)
		GameUtil.setLocalPos(self._player, 0, 0, 0)

		self._isChallengeing = true

		goutil.setActive(self._btnChallenge, true)

		if self._nextPlayerPlace == self._endIdRoad and (nextCell.formId == 0 or XiuMumChallengeModel.instance:getIsPassStage() == true) then
			UIStateManager.instance:push(self:_getMainView(), XiuMumChallengeModel.instance:getCurActId(), true)
			XiuMumChallengeModel.instance:setIsPassStage(false)

			if self._getLevelView then
				UIStateManager.instance:push(self:_getLevelView())
			end

			self:close()
		end
	elseif XiuMumChallengeModel.instance:getIsTimeToMove() then
		self._player.transform:SetParent(cell.go.transform)
		GameUtil.setLocalPos(self._player, 0, 0, 0)
		self:_movePlayer()
	else
		self._player.transform:SetParent(nextCell.go.transform)
		GameUtil.setLocalPos(self._player, 0, 0, 0)

		self._isChallengeing = true

		goutil.setActive(self._btnChallenge, true)

		if self._nextPlayerPlace == self._endIdRoad and nextCell.formId == 0 then
			UIStateManager.instance:push(self:_getMainView(), XiuMumChallengeModel.instance:getCurActId())
			self:close()
		end
	end

	local curMonsterNum = 0
	local temCurPlaceId = table.indexof(self._curRoadIds, self._curPlayerPlace) or table.indexof(self._curRoadIds, self._startIdRoad)

	for i = temCurPlaceId + 1, #self._curRoadIds do
		local checkCell = self._pipeCellList[self._curRoadIds[i]]

		if checkCell and checkCell.formId > 0 then
			curMonsterNum = curMonsterNum + 1
		end
	end

	self._txtTime.text = lang("击败所有怪物即可通关")
	self._txtCurMonsterNum.text = langPara("剩余敌阵：%s", curMonsterNum)

	goutil.setActive(self._txtCurMonsterNum.gameObject, true)
end

function XiuMumGameView:_readyStartPipeGame()
	self._txtBeginDesc.text = self._gameReadyTimer

	settimer(1, self._onReadyCountdown, self)

	self._isGameReady = false
end

function XiuMumGameView:_startPipeGame()
	goutil.setActive(self._btnBeginGame, false)
	removetimer(self._onReadyCountdown, self)
	settimer(1, self._onGameCountDown, self)

	self._isGameing = true
end

function XiuMumGameView:_overPipeGame()
	self:_removeAllTimer()

	self._isGameing = false

	goutil.setActive(self._btnGameOver, true)
end

function XiuMumGameView:_passPipeGame()
	self:_removeAllTimer()

	self._isGameing = false
	self._curMapInfos = {}

	local temMapInfos = {}

	for k, v in pairs(self._pipeCellList) do
		local data = {}

		data.id = v.id
		data.time = v.rotation

		table.insert(temMapInfos, data)

		self._curMapInfos[data.id] = data.time
	end

	self._curRoadIds = self._curPipeRoadIds

	XiuMumChallengeController.instance:passGame(temMapInfos, self._curRoadIds, self._stageCfg.stageId)
end

function XiuMumGameView:_onPassGame()
	self._isChallengeing = true

	XiuMumChallengeModel.instance:setCurPlace(self._startIdRoad)
	XiuMumChallengeModel.instance:saveRoadData(self._curRoadIds)
	XiuMumChallengeModel.instance:saveMapData(self._curMapInfos)
	self:_resetChallenge()
end

function XiuMumGameView:_movePlayer()
	self._moveStartId = table.indexof(self._curRoadIds, self._curPlayerPlace) or table.indexof(self._curRoadIds, self._startIdRoad)
	self._moveEndId = table.indexof(self._curRoadIds, self._nextPlayerPlace)
	self._curStep = self._moveEndId - self._moveStartId + 1

	self:_onMovePlayer()
end

function XiuMumGameView:_onMovePlayer()
	if self._flagEnther then
		self._player.transform:SetParent(self._posStart.transform)

		self._curStep = self._curStep - 1
		self._moveStartId = self._moveStartId + 1

		if self._curStep > 0 then
			self._isMoveing = true

			settimer(1.2, self._onMovePlayer, self, false)

			local cell = self._pipeCellList[self._curRoadIds[self._moveStartId]]
			local tween = self._player.transform:DOMove(cell.go.transform.position, 1):SetEase(DG.Tweening.Ease.Linear)

			self._tweenList = self._tweenList or {}

			table.insert(self._tweenList, tween)
		else
			self:_onFinishMove()
		end

		self._playEnterMove = false
	else
		self._playEnterMove = true
	end
end

function XiuMumGameView:_onFinishMove()
	self._isMoveing = false
	self._isChallengeing = true

	local cell = self._pipeCellList[self._nextPlayerPlace]

	if cell.id == self._endIdRoad and (checknumber(cell.formId) == 0 or XiuMumChallengeModel.instance:getIsPassStage() == true) then
		UIStateManager.instance:push(self:_getMainView(), XiuMumChallengeModel.instance:getCurActId())
		XiuMumChallengeModel.instance:setIsPassStage(false)

		if self._getLevelView then
			UIStateManager.instance:push(self:_getLevelView())
		end

		self:close()
	else
		self:_onClickChallenge()
	end

	XiuMumChallengeModel.instance:setIsTimeToMove(false)
end

function XiuMumGameView:_roratePipeCell(cell)
	if cell then
		if cell.stateId == XiuMumChallengeModel.PipeType.BrokenLine then
			GameUtil.setLocalRotation(cell.pipe, 0, 0, -(cell.rotation + 2) * 90)
		else
			GameUtil.setLocalRotation(cell.pipe, 0, 0, -cell.rotation * 90)
		end
	end
end

function XiuMumGameView:_onClickPipe(cell)
	if cell and self._isGameing then
		cell.rotation = cell.rotation + 1

		if cell.rotation > 3 then
			cell.rotation = cell.rotation - 4
		end

		self:_roratePipeCell(cell)
		self:_checkGamePass()
	end
end

function XiuMumGameView:_checkGamePass()
	self._isCurGamePass = false
	self._curPipeRoadIds = {}

	self:_getNextPipeCell(self._pipeCellList[self._startIdRoad])

	if self._isCurGamePass then
		self:_passPipeGame()
	end
end

function XiuMumGameView:_getNextPipeCell(cell, lastFaceType)
	if cell then
		table.insert(self._curPipeRoadIds, cell.id)

		local pipeType = cell.stateId
		local rotate = cell.rotation
		local curFaceType = XiuMumChallengeModel.FaceType.None
		local nextCell

		if pipeType == XiuMumChallengeModel.PipeType.StartPos then
			if not lastFaceType then
				curFaceType = cell.rotation + 1
			end
		elseif pipeType == XiuMumChallengeModel.PipeType.StraigntLine then
			if lastFaceType == XiuMumChallengeModel.FaceType.Right or lastFaceType == XiuMumChallengeModel.FaceType.Left then
				if rotate == 0 or rotate == 2 then
					curFaceType = lastFaceType
				end
			elseif (lastFaceType == XiuMumChallengeModel.FaceType.Bottom or lastFaceType == XiuMumChallengeModel.FaceType.Top) and (rotate == 1 or rotate == 3) then
				curFaceType = lastFaceType
			end
		elseif pipeType == XiuMumChallengeModel.PipeType.BrokenLine then
			if lastFaceType == XiuMumChallengeModel.FaceType.Right then
				if rotate == 2 then
					curFaceType = XiuMumChallengeModel.FaceType.Bottom
				elseif rotate == 3 then
					curFaceType = XiuMumChallengeModel.FaceType.Top
				end
			elseif lastFaceType == XiuMumChallengeModel.FaceType.Bottom then
				if rotate == 0 then
					curFaceType = XiuMumChallengeModel.FaceType.Right
				elseif rotate == 3 then
					curFaceType = XiuMumChallengeModel.FaceType.Left
				end
			elseif lastFaceType == XiuMumChallengeModel.FaceType.Top then
				if rotate == 1 then
					curFaceType = XiuMumChallengeModel.FaceType.Right
				elseif rotate == 2 then
					curFaceType = XiuMumChallengeModel.FaceType.Left
				end
			elseif lastFaceType == XiuMumChallengeModel.FaceType.Left then
				if rotate == 0 then
					curFaceType = XiuMumChallengeModel.FaceType.Top
				elseif rotate == 1 then
					curFaceType = XiuMumChallengeModel.FaceType.Bottom
				end
			end
		elseif pipeType == XiuMumChallengeModel.PipeType.EndPos then
			if lastFaceType == XiuMumChallengeModel.FaceType.Right and rotate == 2 then
				self._isCurGamePass = true
			elseif lastFaceType == XiuMumChallengeModel.FaceType.Bottom and rotate == 3 then
				self._isCurGamePass = true
			elseif lastFaceType == XiuMumChallengeModel.FaceType.Left and rotate == 0 then
				self._isCurGamePass = true
			elseif lastFaceType == XiuMumChallengeModel.FaceType.Top and rotate == 1 then
				self._isCurGamePass = true
			end

			if self._isCurGamePass then
				return
			end
		end

		nextCell = curFaceType == XiuMumChallengeModel.FaceType.Right and self._pipeCellHash[cell.row] and self._pipeCellHash[cell.row][cell.column + 1] or curFaceType == XiuMumChallengeModel.FaceType.Bottom and self._pipeCellHash[cell.row + 1] and self._pipeCellHash[cell.row + 1][cell.column] or curFaceType == XiuMumChallengeModel.FaceType.Left and self._pipeCellHash[cell.row] and self._pipeCellHash[cell.row][cell.column - 1] or curFaceType == XiuMumChallengeModel.FaceType.Top and self._pipeCellHash[cell.row - 1] and self._pipeCellHash[cell.row - 1][cell.column] or nil

		self:_getNextPipeCell(nextCell, curFaceType)
	end
end

function XiuMumGameView:_onReadyCountdown()
	self._gameReadyTimer = self._gameReadyTimer - 1
	self._txtBeginDesc.text = self._gameReadyTimer

	if self._gameReadyTimer <= 0 then
		self:_startPipeGame()
	end
end

function XiuMumGameView:_onGameCountDown()
	self._gameTimer = self._gameTimer - 1
	self._txtTime.text = langPara("本关剩余时间：%s秒", self._gameTimer)

	if self._gameTimer <= 0 then
		self:_overPipeGame()
	end
end

function XiuMumGameView:_removeAllTimer()
	removetimer(self._onReadyCountdown, self)
	removetimer(self._onGameCountDown, self)
	removetimer(self._onMovePlayer, self)
end

function XiuMumGameView:_onRefreshDaily()
	ViewAutoShowController.instance:clearAllSaveModal()
	UIStateManager.instance:push(self:_getMainView(), XiuMumChallengeModel.instance:getCurActId())
	self:close()
end

function XiuMumGameView:_getMainView()
	return ViewName.XiuMumMainView
end

return XiuMumGameView
