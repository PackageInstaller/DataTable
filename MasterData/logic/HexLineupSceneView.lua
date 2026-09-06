-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hexlineup/view/HexLineupSceneView.lua

module("logic.extensions.hexlineup.view.HexLineupSceneView", package.seeall)

local function hexToPixel(q, r, cellW, cellH)
	local px = (q + r * 0.5) * cellW
	local py = -r * cellH * 0.75

	return px, py
end

local function pixelToHex(px, py, cellW, cellH)
	local r_f = -py / (cellH * 0.75)
	local q_f = px / cellW - r_f * 0.5
	local s_f = -q_f - r_f
	local q_r = math.floor(q_f + 0.5)
	local r_r = math.floor(r_f + 0.5)
	local s_r = math.floor(s_f + 0.5)
	local dq = math.abs(q_r - q_f)
	local dr = math.abs(r_r - r_f)
	local ds = math.abs(s_r - s_f)

	if dr < dq and ds < dq then
		q_r = -r_r - s_r
	elseif ds < dr then
		r_r = -q_r - s_r
	end

	return q_r, r_r
end

local HEX_KEY_BIAS = 2048
local HEX_KEY_STRIDE = 4096

local function hexKey(q, r)
	return (q + HEX_KEY_BIAS) * HEX_KEY_STRIDE + (r + HEX_KEY_BIAS)
end

local PIECE_COLOR_EMPTY = 0
local PIECE_COLOR_MIN = 1
local PIECE_COLOR_MAX = 5
local TAG_MASK_PREVIEW_ALPHA = 0.5
local DEADLOCK_PROP_GUIDE_EFFECT_PATH = "common/fx_ui_zhiyin_quan_03.prefab"
local HexLineupSceneView = class("HexLineupSceneView", ViewComponent)

function HexLineupSceneView:ctor()
	HexLineupSceneView.super.ctor(self)

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

function HexLineupSceneView:buildUI()
	HexLineupSceneView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._gridView = self:getGo("gridView")
	self._gridCell = self:getGo("gridCell")

	local cellRt = self._gridCell:GetComponent(ComponentType.RectTransform)

	self._cellWidth = cellRt.sizeDelta.x
	self._cellHeight = cellRt.sizeDelta.y
	self._txtRule = self:getTxt("rule/scrView/Viewport/Content")
	self._txtScore = self:getTxt("score/txt")
	self._stepGo = self:getGo("step")
	self._txtStep = self:getTxt("step/txt")
	self._floatView = self:getGo("floatView")
	self._floatScore = self:getGo("floatScore")
	self._pieceView = self:getGo("pieceView")
	self._pieceChild = self:getGo("pieceChild")
	self._pieceSlot = self:getGo("pieceSlot")
	self._dragLayer = self:getGo("dragLayer")

	local pieceCell = self:getGo("pieceSlot/pieceCell")
	local pieceX, pieceY, pieceZ = Framework.TransformUtil.GetLocalScale(pieceCell.transform, 0, 0, 0)

	self._candidateScale = pieceX
	self._propCol = self:getGo("propCol")
	self._btnPropKnock = self:getGo("propCol/propKnock/btn")
	self._txtCountPropKnock = self:getTxt("propCol/propKnock/count/txt")
	self._btnPropShuffle = self:getGo("propCol/propShuffle/btn")
	self._txtCountPropShuffle = self:getTxt("propCol/propShuffle/count/txt")
	self._effRootKnock = self:getGo("propCol/propKnock/effRoot")
	self._effRootShuffle = self:getGo("propCol/propShuffle/effRoot")
	self._knockItem = self:getGo("knockItem")
end

function HexLineupSceneView:bindEvents()
	HexLineupSceneView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnPropShuffle, self._onClickBtnPropShuffle, self)

	self._knockDragHandlers = {}
	self._knockDragHandlers.begin = BeginDragHandler.Get(self._btnPropKnock):AddLuaHandler(function(_go, eventData)
		self:_onKnockBeginDrag(eventData)
	end)
	self._knockDragHandlers.drag = DragHandler.Get(self._btnPropKnock):AddLuaHandler(function(_go, eventData)
		self:_onKnockDrag(eventData)
	end)
	self._knockDragHandlers.endDrag = EndDragHandler.Get(self._btnPropKnock):AddLuaHandler(function(_go, eventData)
		self:_onKnockEndDrag(eventData)
	end)
end

function HexLineupSceneView:unbindEvents()
	HexLineupSceneView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnPropShuffle)

	if self._knockDragHandlers then
		BeginDragHandler.Get(self._btnPropKnock):RemoveLuaHandler(self._knockDragHandlers.begin)
		DragHandler.Get(self._btnPropKnock):RemoveLuaHandler(self._knockDragHandlers.drag)
		EndDragHandler.Get(self._btnPropKnock):RemoveLuaHandler(self._knockDragHandlers.endDrag)

		self._knockDragHandlers = nil
	end
end

function HexLineupSceneView:onEnter()
	HexLineupSceneView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._gameParam = params[1] or HexLineupParam.New()
	self._modeId = self._gameParam:getModeId()
	self._gamePlanId = self._gameParam:getGamePlanId()
	self._gameData = HexLineupConfig.instance:getGameData(self._gamePlanId)

	self.addGEvent(self, GlobalNotify.GameSureCloseView, self._gameSureCloseView, self)
	self.addGEvent(self, GlobalNotify.GameCancelCloseView, self._gameCancelCloseView, self)
	self.addGEvent(self, GlobalNotify.GameResetProcess, self._gameResetProcess, self)
	self._stateMachine:startTimer()
	self._stateMachine:gotoState(MmUtil.State_Preparing)
end

function HexLineupSceneView:onExit()
	HexLineupSceneView.super.onExit(self)
	self._stateMachine:stopTimer()
	self:_clearGameView()
	self:_disposeGridCellPool()
	self:_disposePieceChildPool()
end

function HexLineupSceneView:_gameSureCloseView()
	self:_closeGame()
end

function HexLineupSceneView:_gameCancelCloseView()
	self._stateMachine:gotoState(MmUtil.State_Runing)
end

function HexLineupSceneView:_gameResetProcess()
	self._stateMachine:gotoState(MmUtil.State_Preparing)
end

function HexLineupSceneView:_getCurState()
	return self._stateMachine.currStateName
end

function HexLineupSceneView:_onPreparingEnter()
	self:_resetGame()
	self._stateMachine:gotoState(MmUtil.State_Runing)
end

function HexLineupSceneView:_onRuningEnter()
	self:_continueGame()
end

function HexLineupSceneView:_onStopingEnter()
	self:_stopGame()
end

function HexLineupSceneView:_onEndedEnter()
	self:_stopGame()
end

function HexLineupSceneView:_onRuningUpdate()
	return
end

function HexLineupSceneView:_resetGame()
	self:_clearGameView()

	local gameData = self._gameData

	self._boardRadius = gameData.boardRadius
	self._pieceCount = gameData.pieceCount
	self._placeScore = gameData.placeScore
	self._clearScore = gameData.clearScore
	self._knockCount = gameData.knockCount
	self._leftKnockCount = gameData.knockCount
	self._shuffleCount = gameData.shuffleCount
	self._leftShuffleCount = gameData.shuffleCount
	self._stepCount = gameData.stepCount
	self._leftStepCount = gameData.stepCount
	self._rhythmPlanId = gameData.rhythmPlanId

	self:_parsePieceConfigs()
	self:_buildRhythmPieceRandomStages()
	self:_buildComboScoreMap()

	self._score = 0
	self._isDragging = false
	self._dragPieceColorState = PIECE_COLOR_EMPTY
	self._isKnockDragging = false
	self._knockHoverKey = nil

	GameUtil.SetActive(self._gridCell, false)
	GameUtil.SetActive(self._pieceCell, false)
	GameUtil.SetActive(self._pieceChild, false)
	GameUtil.SetActive(self._pieceSlot, false)
	GameUtil.SetActive(self._knockItem, false)
	GameUtil.SetActive(self._floatScore, false)
	self:_createGridCellPool()
	self:_createPieceChildPool()
	self:_generateBoard()
	self:_createSlots()
	self:_initAllCandidates()
	self:_updateRuleUI()
	self:_updateScoreUI()
	self:_updateStepUI()
	self:_updatePropUI()

	local isGameOver = self:_isGameOver()

	self:_refreshDeadlockPropGuideEffect(isGameOver)
end

function HexLineupSceneView:_clearGameView()
	self:_clearLineFlashAnim()
	self:_clearFloatScoreAnim()
	self:_stopDeadlockPropGuideEffect()

	if self._gridCellMap then
		for key, cell in pairs(self._gridCellMap) do
			if self._gridCellPool then
				self._gridCellPool:returnObject(cell)
			end
		end
	end

	self._gridCellMap = {}

	if self._candidatePieces then
		for i, cp in ipairs(self._candidatePieces) do
			if self._isDragging and i == self._dragPieceIndex then
				-- block empty
			else
				self:_returnPieceChildren(cp.pieceChildren)
				self:_resetPieceCellGo(cp.pieceCellGo, false)
			end
		end
	end

	self._candidatePieces = {}

	if self._isDragging then
		self:_returnPieceChildren(self._dragPieceChildren)
		self:_restorePieceCellToSlot(self._dragOriginSlotIndex, self._dragPieceCellGo, false)
	end

	self._isDragging = false
	self._dragPieceIndex = 0
	self._dragPieceId = 0
	self._dragPieceColorState = PIECE_COLOR_EMPTY
	self._dragPieceCellGo = nil
	self._dragPieceChildren = {}
	self._dragPreviewCoords = {}
	self._dragPreviewCount = 0
	self._dragValid = false
	self._dragOriginSlotIndex = 0
	self._dragCenterX = 0
	self._dragCenterY = 0

	if self._slotDragHandlers and self._slotGos then
		for i = 1, #self._slotGos do
			local slotGo = self._slotGos[i]
			local handlers = self._slotDragHandlers[i]

			if slotGo and handlers then
				BeginDragHandler.Get(slotGo):RemoveLuaHandler(handlers.begin)
				DragHandler.Get(slotGo):RemoveLuaHandler(handlers.drag)
				EndDragHandler.Get(slotGo):RemoveLuaHandler(handlers.endDrag)
			end
		end
	end

	self._slotDragHandlers = {}
	self._slotPieceCellGos = {}

	if self._slotGos then
		for i = 1, #self._slotGos do
			if self._slotGos[i] then
				goutil.destroy(self._slotGos[i])
			end
		end
	end

	self._slotGos = {}

	self:_exitKnockMode()

	self._boardMap = {}
	self._boardCoords = {}
	self._boardLines = {
		qLines = {},
		rLines = {},
		sLines = {}
	}
end

function HexLineupSceneView:_continueGame()
	return
end

function HexLineupSceneView:_stopGame()
	return
end

function HexLineupSceneView:_endGame(isSuccess)
	if self:_getCurState() ~= MmUtil.State_Runing then
		return
	end

	self._stateMachine:gotoState(MmUtil.State_Ended)

	if isSuccess then
		self:_doGameEndCallBack(MmUtil.GameResult_GameOverOfSuccess)
	else
		self:_doGameEndCallBack(MmUtil.GameResult_GameOverOfFail)
	end
end

function HexLineupSceneView:_tryExitGame()
	self._stateMachine:gotoState(MmUtil.State_Stoping)
	self:_doGameEndCallBack(MmUtil.GameResult_GameOverOfDropOut)
end

function HexLineupSceneView:_closeGame()
	self:close()
end

function HexLineupSceneView:_doGameEndCallBack(gameEndRes)
	self._gameParam:doGameEndCallBack(gameEndRes, self)
end

function HexLineupSceneView:_clearLineFlashAnim()
	if self._lineFlashSequence then
		self._lineFlashSequence:Kill(false)

		self._lineFlashSequence = nil
	end

	local flashCells = self._lineFlashCells

	if flashCells then
		for i = 1, #flashCells do
			local data = flashCells[i]
			local cell = data and data.cell

			if cell and cell.flashMask then
				local canvasGroup = cell.flashMask:GetComponent(ComponentType.CanvasGroup)

				if canvasGroup then
					canvasGroup.alpha = 1
				end

				GameUtil.SetActive(cell.flashMask, false)
			end

			flashCells[i] = nil
		end
	end
end

function HexLineupSceneView:_playClearLineFlashAnim(clearedKeys, clearedKeyCount)
	self:_clearLineFlashAnim()

	if clearedKeyCount <= 0 then
		return
	end

	local duration = 0.44
	local sequence = DG.Tweening.DOTween.Sequence()
	local hasTween = false

	if not self._lineFlashCells then
		local flashCells = {}

		self._lineFlashCells = self._lineFlashCells

		for i = 1, clearedKeyCount do
			local key = clearedKeys[i]
			local cell = self._gridCellMap[key]

			if cell and cell.flashMask then
				self._lineFlashCells[#self._lineFlashCells + 1] = {
					cell = cell
				}

				local canvasGroup = goutil.addComponentOnce(cell.flashMask, ComponentType.CanvasGroup)

				canvasGroup.alpha = 1

				GameUtil.SetActive(cell.flashMask, true)

				local fadeTweener = canvasGroup:DOFade(0, duration)

				fadeTweener:SetEase(DG.Tweening.Ease.OutQuad)
				sequence:Insert(0, fadeTweener)

				hasTween = true
			end
		end

		if hasTween then
			sequence:OnComplete(function()
				for i = 1, #flashCells do
					local data = flashCells[i]
					local cell = data and data.cell

					if cell and cell.flashMask then
						local canvasGroup = cell.flashMask:GetComponent(ComponentType.CanvasGroup)

						if canvasGroup then
							canvasGroup.alpha = 1
						end

						GameUtil.SetActive(cell.flashMask, false)
					end

					flashCells[i] = nil
				end

				self._lineFlashSequence = nil
			end)

			self._lineFlashSequence = sequence
		else
			sequence:Kill(false)
		end
	end
end

function HexLineupSceneView:_fetchFloatScoreItem()
	local pool = self._floatScorePool

	if pool == nil then
		pool = {}
		self._floatScorePool = pool
	end

	local itemCount = #pool
	local item

	if itemCount > 0 then
		item = pool[itemCount]
		pool[itemCount] = nil

		return item
	end

	local mainGo = goutil.clone(self._floatScore)

	goutil.addChildToParent(mainGo, self._floatView)

	local txt = goutil.findChildTextComponent(mainGo, "txt")

	item = {
		inUse = false,
		mainGo = mainGo,
		txt = txt
	}

	local allItems = self._floatScoreAllItems

	if allItems == nil then
		allItems = {}
		self._floatScoreAllItems = allItems
	end

	allItems[#allItems + 1] = item

	return item
end

function HexLineupSceneView:_recycleFloatScoreItem(item)
	if not item or not item.inUse then
		return
	end

	if item.sequence then
		item.sequence:Kill(false)

		item.sequence = nil
	end

	item.inUse = false

	GameUtil.SetActive(item.mainGo, false)

	local pool = self._floatScorePool

	if pool == nil then
		pool = {}
		self._floatScorePool = pool
	end

	pool[#pool + 1] = item
end

function HexLineupSceneView:_clearFloatScoreAnim()
	local allItems = self._floatScoreAllItems

	if not allItems then
		return
	end

	for i = 1, #allItems do
		local item = allItems[i]

		if item then
			if item.sequence then
				item.sequence:Kill(false)

				item.sequence = nil
			end

			item.inUse = false

			GameUtil.SetActive(item.mainGo, false)
		end
	end

	if not self._floatScorePool then
		self._floatScorePool = self._floatScorePool

		for i = 1, #self._floatScorePool do
			self._floatScorePool[i] = nil
		end

		for i = 1, #allItems do
			self._floatScorePool[#self._floatScorePool + 1] = allItems[i]
		end
	end
end

function HexLineupSceneView:_playClearLineFloatScoreAnim(hitLines, lineScores, lineCount)
	if lineCount <= 0 then
		return
	end

	if self._floatView then
		local floatViewTrans = self._floatView.transform

		if floatViewTrans == nil then
			return
		end

		local moveDuration = 0.22
		local holdDuration = 0.28
		local moveOffsetY = 34

		for i = 1, lineCount do
			local line = hitLines[i]
			local keys = line and line.keys

			if keys then
				if not #keys then
					local keyCount = 0

					if keyCount > 0 then
						local worldX = 0
						local worldY = 0
						local worldZ = 0
						local validCount = 0

						for j = 1, keyCount do
							local cell = self._gridCellMap[keys[j]]

							if cell and cell.mainGo then
								local worldPos = cell.mainGo.transform.position

								worldX = worldX + worldPos.x
								worldY = worldY + worldPos.y
								worldZ = worldZ + worldPos.z
								validCount = validCount + 1
							end
						end

						if validCount > 0 then
							local centerWorld = UnityEngine.Vector3(worldX / validCount, worldY / validCount, worldZ / validCount)
							local localPos = floatViewTrans:InverseTransformPoint(centerWorld)
							local item = self:_fetchFloatScoreItem()

							item.inUse = true

							if item.txt then
								item.txt.text = string.format("+%s", lineScores[i] or 0)
							end

							GameUtil.setLocalPos(item.mainGo, localPos.x, localPos.y, localPos.z)
							GameUtil.SetActive(item.mainGo, true)

							local sequence = DG.Tweening.DOTween.Sequence()

							sequence:Append(item.mainGo.transform:DOLocalMoveY(localPos.y + moveOffsetY, moveDuration))
							sequence:AppendInterval(holdDuration)
							sequence:OnComplete(function()
								self:_recycleFloatScoreItem(item)
							end)

							item.sequence = sequence
						end
					end
				end
			end
		end
	end
end

function HexLineupSceneView:_parsePieceConfigs()
	self._allPieceOffsets = {}
	self._allPieceIds = {}

	local pieceDataList = HexLineupConfig.instance:getPieceDataList() or {}

	for _, pieceData in ipairs(pieceDataList) do
		local pieceId = pieceData.pieceId
		local offsets = {}

		if not pieceData.offsets then
			for part in string.gmatch(pieceData.offsets, "[^#]+") do
				local qStr, rStr = string.match(part, "(-?%d+):(-?%d+)")

				if qStr and rStr then
					local q = checknumber(qStr)
					local r = checknumber(rStr)
					local s = -q - r

					table.insert(offsets, {
						q = q,
						r = r,
						s = s
					})
				end
			end

			self._allPieceOffsets[pieceId] = offsets

			table.insert(self._allPieceIds, pieceId)
		end
	end
end

function HexLineupSceneView:_buildRhythmPieceRandomStages()
	self._pieceRandomStages = {}

	local rhythmPlanId = self._rhythmPlanId
	local rhythmDatas = HexLineupConfig.instance:getRhythmDatas(rhythmPlanId) or {}

	for _, rhythmData in ipairs(rhythmDatas) do
		local stageScore = rhythmData.score

		if not self._pieceRandomStages[#self._pieceRandomStages] then
			local stage = {}

			if stage.score ~= stageScore then
				stage = {
					score = stageScore,
					groups = {},
					groupEdges = {}
				}

				table.insert(self._pieceRandomStages, stage)
			end

			if not rhythmData.pieceIdArray then
				local pieceIdArray = {}
				local groupWeight = checknumber(rhythmData.weight)

				if #pieceIdArray > 0 and groupWeight > 0 then
					local groupIndex = #stage.groups + 1

					stage.groups[groupIndex] = {
						weight = groupWeight,
						pieceIdArray = pieceIdArray
					}

					table.insert(stage.groupEdges, {
						x = groupIndex,
						y = groupWeight
					})
				end
			end
		end
	end

	for _, stage in ipairs(self._pieceRandomStages) do
		if stage.groupEdges == nil or #stage.groupEdges <= 0 then
			printError(string.format("[HexLineupSceneView] 节奏分段没有可用棋子权重(rhythmPlanId:%s, score:%s)", rhythmPlanId, stage.score))
		end
	end
end

function HexLineupSceneView:_getCurrentPieceRandomStage()
	local stages = self._pieceRandomStages

	if stages == nil or #stages <= 0 then
		return nil
	end

	local score = self._score

	return MmUtil.binarySearchInSingleKey(stages, "score", score)
end

function HexLineupSceneView:_buildComboScoreMap()
	self._comboScoreMap = {}

	local dataList = HexLineupConfig.instance:getComboDataList()

	for _, data in ipairs(dataList) do
		local count = data.count

		self._comboScoreMap[count] = data.score
	end
end

function HexLineupSceneView:_createGridCellPool()
	if self._gridCellPool then
		return
	end

	local templateGo = self._gridCell

	local function createFunc()
		local mainGo = goutil.clone(templateGo)
		local iconGo = goutil.findChild(mainGo, "icon")
		local flashMaskGo = goutil.findChild(mainGo, "flashMask")
		local tagMaskGo = goutil.findChild(mainGo, "tagMask")
		local tagSelectedGo = goutil.findChild(mainGo, "tagSelected")

		GameUtil.SetActive(iconGo, false)

		if flashMaskGo then
			GameUtil.SetActive(flashMaskGo, false)
		end

		GameUtil.SetActive(tagMaskGo, false)
		GameUtil.SetActive(tagSelectedGo, false)

		return {
			mainGo = mainGo,
			icon = iconGo,
			flashMask = flashMaskGo,
			tagMask = tagMaskGo,
			tagSelected = tagSelectedGo
		}
	end

	local function disposeFunc(cell)
		if cell.mainGo then
			goutil.destroy(cell.mainGo)

			cell.mainGo = nil
		end
	end

	local function resetFunc(cell)
		GameUtil.SetActive(cell.mainGo, false)
		GameUtil.SetActive(cell.icon, false)

		local iconCanvasGroup = cell.icon:GetComponent(ComponentType.CanvasGroup)

		if iconCanvasGroup then
			iconCanvasGroup.alpha = 1
		end

		if cell.flashMask then
			GameUtil.SetActive(cell.flashMask, false)

			local flashMaskCanvasGroup = cell.flashMask:GetComponent(ComponentType.CanvasGroup)

			if flashMaskCanvasGroup then
				flashMaskCanvasGroup.alpha = 1
			end
		end

		GameUtil.SetActive(cell.tagMask, false)
		GameUtil.SetActive(cell.tagSelected, false)
	end

	self._gridCellPool = ObjectPool.New(100, createFunc, disposeFunc, resetFunc)
end

function HexLineupSceneView:_disposeGridCellPool()
	if self._gridCellPool then
		self._gridCellPool:clear()

		self._gridCellPool = nil
	end
end

function HexLineupSceneView:_createPieceChildPool()
	if self._pieceChildPool then
		return
	end

	local templateGo = self._pieceChild

	local function createFunc()
		local mainGo = goutil.clone(templateGo)

		return {
			mainGo = mainGo
		}
	end

	local function disposeFunc(child)
		if child.mainGo then
			goutil.destroy(child.mainGo)

			child.mainGo = nil
		end
	end

	local function resetFunc(child)
		GameUtil.SetActive(child.mainGo, false)
	end

	self._pieceChildPool = ObjectPool.New(30, createFunc, disposeFunc, resetFunc)
end

function HexLineupSceneView:_disposePieceChildPool()
	if self._pieceChildPool then
		self._pieceChildPool:clear()

		self._pieceChildPool = nil
	end
end

function HexLineupSceneView:_generateBoard()
	local R = self._boardRadius - 1

	self._boardCoords = {}
	self._boardMap = {}
	self._gridCellMap = {}
	self._boardLines = {
		qLines = {},
		rLines = {},
		sLines = {}
	}

	for q = -R, R do
		local r1 = math.max(-R, -q - R)
		local r2 = math.min(R, -q + R)

		for r = r1, r2 do
			local s = -q - r
			local coord = {
				q = q,
				r = r,
				s = s
			}

			table.insert(self._boardCoords, coord)

			local key = hexKey(q, r)

			self._boardMap[key] = {
				isOccupied = false,
				colorState = PIECE_COLOR_EMPTY
			}
			self._boardLines.qLines[q] = self._boardLines.qLines[q] or {}

			table.insert(self._boardLines.qLines[q], coord)

			self._boardLines.rLines[r] = self._boardLines.rLines[r] or {}

			table.insert(self._boardLines.rLines[r], coord)

			self._boardLines.sLines[s] = self._boardLines.sLines[s] or {}

			table.insert(self._boardLines.sLines[s], coord)

			local cell = self._gridCellPool:fetchObject()

			goutil.addChildToParent(cell.mainGo, self._gridView)

			local px, py = hexToPixel(q, r, self._cellWidth, self._cellHeight)

			GameUtil.setLocalPos(cell.mainGo, px, py)
			GameUtil.SetActive(cell.mainGo, true)
			GameUtil.SetActive(cell.icon, false)

			local iconCanvasGroup = cell.icon:GetComponent(ComponentType.CanvasGroup)

			if iconCanvasGroup then
				iconCanvasGroup.alpha = 1
			end

			if cell.flashMask then
				GameUtil.SetActive(cell.flashMask, false)

				local flashMaskCanvasGroup = cell.flashMask:GetComponent(ComponentType.CanvasGroup)

				if flashMaskCanvasGroup then
					flashMaskCanvasGroup.alpha = 1
				end
			end

			GameUtil.SetActive(cell.tagMask, false)
			GameUtil.SetActive(cell.tagSelected, false)

			self._gridCellMap[key] = cell
		end
	end
end

function HexLineupSceneView:_createSlots()
	self._slotGos = {}
	self._slotDragHandlers = {}
	self._slotPieceCellGos = {}

	if not self._pieceCount then
		for i = 1, self._pieceCount do
			local slotGo = goutil.clone(self._pieceSlot)

			goutil.addChildToParent(slotGo, self._pieceView)
			GameUtil.SetActive(slotGo, true)

			self._slotGos[i] = slotGo

			local slotPieceCellGo = goutil.findChild(slotGo, "pieceCell")

			if slotPieceCellGo == nil then
				printError(string.format("[HexLineupSceneView] pieceSlot[%s] 缺少子节点 pieceCell", i))
			else
				self:_resetPieceCellGo(slotPieceCellGo, false)
			end

			self._slotPieceCellGos[i] = slotPieceCellGo

			local slotIndex = i
			local beginHandler = BeginDragHandler.Get(slotGo):AddLuaHandler(function(_go, eventData)
				self:_onPieceBeginDrag(slotIndex, eventData)
			end)
			local dragHandler = DragHandler.Get(slotGo):AddLuaHandler(function(_go, eventData)
				self:_onPieceDrag(slotIndex, eventData)
			end)
			local endDragHandler = EndDragHandler.Get(slotGo):AddLuaHandler(function(_go, eventData)
				self:_onPieceEndDrag(slotIndex, eventData)
			end)

			self._slotDragHandlers[i] = {
				begin = beginHandler,
				drag = dragHandler,
				endDrag = endDragHandler
			}
		end
	end
end

function HexLineupSceneView:_randomPieceId()
	local fallbackPieceId
	local allPieceIds = self._allPieceIds

	if allPieceIds and #allPieceIds > 0 then
		fallbackPieceId = allPieceIds[math.random(1, #allPieceIds)]
	end

	if fallbackPieceId == nil then
		local allPieceOffsets = self._allPieceOffsets

		if allPieceOffsets then
			for pieceId, _ in pairs(allPieceOffsets) do
				fallbackPieceId = pieceId

				break
			end
		end
	end

	if fallbackPieceId == nil then
		printError("[HexLineupSceneView] 随机失败：没有可用 pieceId 配置，回退到1")

		fallbackPieceId = 1
	end

	local stage = self:_getCurrentPieceRandomStage()

	if stage == nil then
		printError(string.format("[HexLineupSceneView] 随机失败：未命中节奏分段(rhythmPlanId:%s, score:%s)", self._rhythmPlanId, self._score))

		return fallbackPieceId
	end

	local groupEdges = stage.groupEdges

	if groupEdges == nil or #groupEdges <= 0 then
		printError(string.format("[HexLineupSceneView] 随机失败：分段没有可用组权重(rhythmPlanId:%s, stageScore:%s)", self._rhythmPlanId, stage.score))

		return fallbackPieceId
	end

	local groupIndex = GameUtil.getRandomEdge(groupEdges)

	if stage.groups then
		local groupData = stage.groups[groupIndex]
		local pieceIdArray = groupData and groupData.pieceIdArray

		if pieceIdArray == nil or #pieceIdArray <= 0 then
			printError(string.format("[HexLineupSceneView] 随机失败：分段组缺少 pieceIdArray(rhythmPlanId:%s, stageScore:%s, groupIndex:%s)", self._rhythmPlanId, stage.score, groupIndex))

			return fallbackPieceId
		end

		return pieceIdArray[math.random(1, #pieceIdArray)]
	end
end

function HexLineupSceneView:_randomPieceColorState(excludeSet)
	if excludeSet then
		local available = {}

		for c = PIECE_COLOR_MIN, PIECE_COLOR_MAX do
			if not excludeSet[c] then
				table.insert(available, c)
			end
		end

		if #available > 0 then
			return available[math.random(1, #available)]
		end
	end

	return math.random(PIECE_COLOR_MIN, PIECE_COLOR_MAX)
end

function HexLineupSceneView:_getCandidateColorSet()
	if not self._candidateColorSet then
		self._candidateColorSet = self._candidateColorSet

		for c = PIECE_COLOR_MIN, PIECE_COLOR_MAX do
			self._candidateColorSet[c] = nil
		end

		if self._candidatePieces then
			for _, cp in ipairs(self._candidatePieces) do
				local colorState = cp.colorState

				self._candidateColorSet[colorState] = true
			end
		end

		return self._candidateColorSet
	end
end

function HexLineupSceneView:_layoutPieceChildren(pieceId, pieceChildren, extraX, extraY)
	if pieceChildren == nil then
		return
	end

	if not self._allPieceOffsets[pieceId] then
		local offsets = {}

		extraX = extraX or 0
		extraY = extraY or 0

		for i, child in ipairs(pieceChildren) do
			local offset = offsets[i]

			if offset ~= nil then
				local px, py = hexToPixel(offset.q, offset.r, self._cellWidth, self._cellHeight)

				GameUtil.setLocalPos(child.mainGo, px + extraX, py + extraY)
			end
		end
	end
end

function HexLineupSceneView:_resetPieceCellGo(pieceCellGo, isActive)
	if pieceCellGo == nil then
		return
	end

	GameUtil.setLocalPos(pieceCellGo, 0, 0)

	pieceCellGo.transform.localScale = Vector3(self._candidateScale, self._candidateScale, 1)

	GameUtil.SetActive(pieceCellGo, isActive and true or false)
end

function HexLineupSceneView:_restorePieceCellToSlot(slotIndex, pieceCellGo, isActive)
	if pieceCellGo == nil then
		return
	end

	if self._slotGos then
		local slotGo = self._slotGos[slotIndex]

		if slotGo then
			goutil.addChildToParent(pieceCellGo, slotGo)
		end

		self:_resetPieceCellGo(pieceCellGo, isActive)
	end
end

function HexLineupSceneView:_createPieceInSlot(slotIndex, pieceId, colorState)
	if self._slotPieceCellGos then
		local pieceCellGo = self._slotPieceCellGos[slotIndex]

		self:_resetPieceCellGo(pieceCellGo, true)

		local offsets = self._allPieceOffsets[pieceId]
		local pieceChildren = {}
		local centerX, centerY = 0, 0

		for _, offset in ipairs(offsets) do
			local px, py = hexToPixel(offset.q, offset.r, self._cellWidth, self._cellHeight)

			centerX = centerX + px
			centerY = centerY + py
		end

		local count = #offsets

		if count > 0 then
			centerX = centerX / count
			centerY = centerY / count
		end

		for _, offset in ipairs(offsets) do
			local child = self._pieceChildPool:fetchObject()

			goutil.addChildToParent(child.mainGo, pieceCellGo)
			GameUtil.setUIImageColorIdx(child.mainGo, colorState)
			GameUtil.SetActive(child.mainGo, true)
			table.insert(pieceChildren, child)
		end

		self:_layoutPieceChildren(pieceId, pieceChildren, -centerX, -centerY)
		GameUtil.setLocalPos(pieceCellGo, 0, 0)

		local candidateData = {
			pieceId = pieceId,
			colorState = colorState,
			pieceCellGo = pieceCellGo,
			pieceChildren = pieceChildren,
			slotIndex = slotIndex,
			centerX = centerX,
			centerY = centerY
		}

		table.insert(self._candidatePieces, candidateData)
	end
end

function HexLineupSceneView:_initAllCandidates()
	self._candidatePieces = {}

	if not self._pieceCount then
		for i = 1, self._pieceCount do
			local pieceId = self:_randomPieceId()
			local colorState = self:_randomPieceColorState(self:_getCandidateColorSet())

			self:_createPieceInSlot(i, pieceId, colorState)
		end
	end
end

function HexLineupSceneView:_returnPieceChildren(pieceChildren)
	if pieceChildren == nil then
		return
	end

	for _, child in ipairs(pieceChildren) do
		if self._pieceChildPool then
			goutil.addChildToParent(child.mainGo, self._pieceView)
			self._pieceChildPool:returnObject(child)
		end
	end
end

function HexLineupSceneView:_shiftCandidatesForward()
	for i, cp in ipairs(self._candidatePieces) do
		if cp.slotIndex ~= i then
			local oldSlotIndex = cp.slotIndex
			local oldPieceCellGo = cp.pieceCellGo

			if self._slotPieceCellGos then
				if self._slotPieceCellGos == nil then
					printError(string.format("[HexLineupSceneView] slot[%s] 的 pieceCell 不存在，前移失败", i))

					return
				end

				self:_resetPieceCellGo(self._slotPieceCellGos, true)

				for _, child in ipairs(cp.pieceChildren) do
					goutil.addChildToParent(child.mainGo, self._slotPieceCellGos)
				end

				self:_layoutPieceChildren(cp.pieceId, cp.pieceChildren, -(cp.centerX or 0), -(cp.centerY or 0))

				cp.slotIndex = i
				cp.pieceCellGo = self._slotPieceCellGos

				if oldPieceCellGo ~= self._slotPieceCellGos then
					self:_restorePieceCellToSlot(oldSlotIndex, oldPieceCellGo, false)
				end
			end
		end
	end
end

function HexLineupSceneView:_refillTailSlot()
	local nextSlotIndex = #self._candidatePieces + 1

	if not self._pieceCount then
		if self._pieceCount < nextSlotIndex then
			return
		end

		local pieceId = self:_randomPieceId()
		local colorState = self:_randomPieceColorState(self:_getCandidateColorSet())

		self:_createPieceInSlot(nextSlotIndex, pieceId, colorState)
	end
end

function HexLineupSceneView:_previewReset()
	self._dragPreviewCoords = self._dragPreviewCoords or {}
	self._dragPreviewCount = 0
end

function HexLineupSceneView:_previewPushKey(key)
	local previewCount = (self._dragPreviewCount or 0) + 1

	self._dragPreviewCount = previewCount

	local previewCoords = self._dragPreviewCoords
	local coord = previewCoords[previewCount]

	if coord == nil then
		coord = {}
		previewCoords[previewCount] = coord
	end

	coord.key = key
end

function HexLineupSceneView:_previewTrimTail()
	local previewCoords = self._dragPreviewCoords

	if previewCoords then
		previewCoords[(self._dragPreviewCount or 0) + 1] = nil
	end
end

function HexLineupSceneView:_onPieceBeginDrag(slotIndex, eventData)
	if self:_getCurState() ~= MmUtil.State_Runing then
		return
	end

	if self._isKnockDragging then
		return
	end

	local pieceData
	local pieceIndex = 0

	for i, cp in ipairs(self._candidatePieces) do
		if cp.slotIndex == slotIndex then
			pieceData = cp
			pieceIndex = i

			break
		end
	end

	if pieceData == nil then
		return
	end

	self._isDragging = true
	self._dragPieceIndex = pieceIndex
	self._dragPieceId = pieceData.pieceId
	self._dragPieceColorState = pieceData.colorState
	self._dragPieceCellGo = pieceData.pieceCellGo
	self._dragPieceChildren = pieceData.pieceChildren
	self._dragOriginSlotIndex = slotIndex
	self._dragCenterX = pieceData.centerX or 0
	self._dragCenterY = pieceData.centerY or 0

	self:_previewReset()

	self._dragValid = false

	goutil.addChildToParent(self._dragPieceCellGo, self._dragLayer)

	self._dragPieceCellGo.transform.localScale = Vector3(1, 1, 1)

	local worldPos = uGuiUtil.GetTouchWorldPosition()

	GameUtil.setPos(self._dragPieceCellGo, worldPos.x, worldPos.y, worldPos.z)
end

function HexLineupSceneView:_onPieceDrag(slotIndex, eventData)
	if not self._isDragging then
		return
	end

	local worldPos = uGuiUtil.GetTouchWorldPosition()

	GameUtil.setPos(self._dragPieceCellGo, worldPos.x, worldPos.y, worldPos.z)
	self:_clearDragPreview()

	local localPos = goutil.screenToLocalPos(eventData.position, self._gridView.transform)
	local anchorQ, anchorR = pixelToHex(localPos.x - self._dragCenterX, localPos.y - self._dragCenterY, self._cellWidth, self._cellHeight)
	local offsets = self._allPieceOffsets[self._dragPieceId]

	if offsets == nil then
		return
	end

	local canPlace = true
	local boardMap = self._boardMap

	for _, offset in ipairs(offsets) do
		local q = anchorQ + offset.q
		local r = anchorR + offset.r
		local key = hexKey(q, r)
		local boardData = boardMap[key]

		if boardData ~= nil then
			self:_previewPushKey(key)

			if boardData.isOccupied then
				canPlace = false
			end
		else
			canPlace = false
		end
	end

	local previewCoords = self._dragPreviewCoords

	if not self._dragPreviewCount then
		local gridCellMap = self._gridCellMap

		if canPlace then
			for i = 1, self._dragPreviewCount do
				local coord = previewCoords[i]
				local key = coord.key
				local cell = gridCellMap[key]
				local boardData = boardMap[key]

				if cell and boardData and not boardData.isOccupied then
					GameUtil.SetActive(cell.tagMask, true)
					GameUtil.setUIImageColorIdx(cell.tagMask, self._dragPieceColorState)

					local tagMaskCanvasGroup = goutil.addComponentOnce(cell.tagMask, ComponentType.CanvasGroup)

					tagMaskCanvasGroup.alpha = TAG_MASK_PREVIEW_ALPHA
				end
			end
		end

		self:_previewTrimTail()

		self._dragValid = canPlace
	end
end

function HexLineupSceneView:_onPieceEndDrag(slotIndex, eventData)
	if not self._isDragging then
		return
	end

	if not self._dragPreviewCount then
		local coordCount = 0
		local valid = self._dragValid

		if valid and coordCount > 0 then
			local placeOk = self:_placePieceOnBoardFromPreview()

			if placeOk then
				self:_returnPieceChildren(self._dragPieceChildren)
				self:_restorePieceCellToSlot(self._dragOriginSlotIndex, self._dragPieceCellGo, false)
				table.remove(self._candidatePieces, self._dragPieceIndex)
				self:_checkAndClearLines()
				self:_shiftCandidatesForward()
				self:_refillTailSlot()
				self:_checkGameFlow()
			else
				self:_restorePieceCellToSlot(self._dragOriginSlotIndex, self._dragPieceCellGo, true)
			end
		else
			self:_restorePieceCellToSlot(self._dragOriginSlotIndex, self._dragPieceCellGo, true)
		end

		self:_clearDragPreview()

		self._isDragging = false
		self._dragPieceIndex = 0
		self._dragPieceId = 0
		self._dragPieceColorState = PIECE_COLOR_EMPTY
		self._dragPieceCellGo = nil
		self._dragPieceChildren = {}

		self:_previewReset()

		self._dragValid = false
		self._dragOriginSlotIndex = 0
		self._dragCenterX = 0
		self._dragCenterY = 0
	end
end

function HexLineupSceneView:_clearDragPreview()
	local previewCoords = self._dragPreviewCoords

	if not self._dragPreviewCount then
		for i = 1, self._dragPreviewCount do
			local coord = previewCoords[i]

			if coord and coord.key then
				local cell = self._gridCellMap[coord.key]

				if cell then
					GameUtil.SetActive(cell.tagMask, false)
				end

				coord.key = nil
			end
		end

		self._dragPreviewCount = 0
	end
end

function HexLineupSceneView:_canPlacePieceAt(pieceId, anchorQ, anchorR)
	local offsets = self._allPieceOffsets[pieceId]

	if offsets == nil then
		return false, nil
	end

	local coords = {}

	for _, offset in ipairs(offsets) do
		local q = anchorQ + offset.q
		local r = anchorR + offset.r
		local key = hexKey(q, r)
		local boardData = self._boardMap[key]

		if boardData == nil or boardData.isOccupied then
			return false, nil
		end

		table.insert(coords, {
			q = q,
			r = r,
			key = key
		})
	end

	return true, coords
end

function HexLineupSceneView:_canPlacePieceFast(pieceId, anchorQ, anchorR)
	local offsets = self._allPieceOffsets[pieceId]

	if offsets == nil then
		return false
	end

	local boardMap = self._boardMap

	for _, offset in ipairs(offsets) do
		local key = hexKey(anchorQ + offset.q, anchorR + offset.r)
		local boardData = boardMap[key]

		if boardData == nil or boardData.isOccupied then
			return false
		end
	end

	return true
end

function HexLineupSceneView:_placePieceOnBoardFromPreview()
	local pieceColorState = self._dragPieceColorState
	local boardMap = self._boardMap
	local gridCellMap = self._gridCellMap
	local previewCoords = self._dragPreviewCoords

	if not self._dragPreviewCount then
		for i = 1, self._dragPreviewCount do
			local coord = previewCoords[i]
			local key = coord and coord.key

			if key == nil then
				printError(string.format("[HexLineupSceneView] 放置失败：预览坐标缺失 key(index=%s)", i))

				return false
			end

			local boardData = boardMap[key]
			local cell = gridCellMap[key]

			if boardData == nil or cell == nil then
				printError(string.format("[HexLineupSceneView] 放置失败：格子数据缺失(key=%s)", key))

				return false
			end
		end

		for i = 1, self._dragPreviewCount do
			local key = previewCoords[i].key
			local boardData = boardMap[key]

			boardData.isOccupied = true
			boardData.colorState = pieceColorState

			local cell = gridCellMap[key]

			GameUtil.SetActive(cell.icon, true)

			local iconCanvasGroup = cell.icon:GetComponent(ComponentType.CanvasGroup)

			if iconCanvasGroup then
				iconCanvasGroup.alpha = 1
			end

			GameUtil.setUIImageColorIdx(cell.icon, pieceColorState)
			GameUtil.SetActive(cell.tagMask, false)
		end

		self._score = self._score + self._placeScore

		if self._modeId == HexLineupEnum.ModeId_Limit then
			self._leftStepCount = self._leftStepCount - 1

			self:_updateStepUI()
		end

		self:_updateScoreUI()

		return true
	end
end

function HexLineupSceneView:_checkAndClearLines()
	if not self._clearCellSet then
		if not self._clearCellKeys then
			local clearedKeys = {}

			if not self._hitLines then
				local hitLines = {}

				if not self._lineScores then
					local lineScores = {}

					if not self._lineOwnerMap then
						local lineOwnerMap = {}

						self._clearCellSet = self._clearCellSet
						self._clearCellKeys = clearedKeys
						self._hitLines = hitLines
						self._lineScores = lineScores
						self._lineOwnerMap = lineOwnerMap

						local clearedKeyCount = 0
						local lineCount = 0
						local boardMap = self._boardMap

						for i = 1, #hitLines do
							local line = hitLines[i]

							if line and line.keys then
								for j = 1, #line.keys do
									line.keys[j] = nil
								end
							end

							hitLines[i] = nil
							lineScores[i] = nil
						end

						local axisNames = {
							"qLines",
							"rLines",
							"sLines"
						}

						for axisIndex = 1, #axisNames do
							local axisName = axisNames[axisIndex]
							local lines = self._boardLines[axisName]
							local axisValues = {}

							for axisValue, _ in pairs(lines) do
								axisValues[#axisValues + 1] = axisValue
							end

							table.sort(axisValues)

							for idx = 1, #axisValues do
								local lineCoords = lines[axisValues[idx]]
								local isFull = true

								for _, coord in ipairs(lineCoords) do
									local key = hexKey(coord.q, coord.r)

									if not boardMap[key].isOccupied then
										isFull = false

										break
									end
								end

								if isFull then
									lineCount = lineCount + 1

									local hitLine = {
										keys = {}
									}

									hitLines[lineCount] = hitLine

									for _, coord in ipairs(lineCoords) do
										local key = hexKey(coord.q, coord.r)

										hitLine.keys[#hitLine.keys + 1] = key

										if not self._clearCellSet[key] then
											self._clearCellSet[key] = true
											clearedKeyCount = clearedKeyCount + 1
											clearedKeys[clearedKeyCount] = key
										end
									end
								end
							end
						end

						if lineCount > 0 then
							if not self._comboScoreMap[lineCount] then
								local comboScore = 0
								local comboAvg = math.floor(comboScore / lineCount)
								local comboRemainder = comboScore % lineCount
								local clearTotalScore = 0

								for i = 1, lineCount do
									local keys = hitLines[i].keys
									local baseCount = 0

									for j = 1, #keys do
										local key = keys[j]

										if lineOwnerMap[key] == nil then
											lineOwnerMap[key] = i
											baseCount = baseCount + 1
										end
									end

									local lineComboScore = comboAvg + (i <= comboRemainder and 1 or 0)
									local lineScore = baseCount * self._clearScore + lineComboScore

									lineScores[i] = lineScore
									clearTotalScore = clearTotalScore + lineScore
								end

								self:_playClearLineFlashAnim(clearedKeys, clearedKeyCount)
								self:_playClearLineFloatScoreAnim(hitLines, lineScores, lineCount)

								for i = 1, clearedKeyCount do
									local key = clearedKeys[i]

									boardMap[key].isOccupied = false
									boardMap[key].colorState = PIECE_COLOR_EMPTY

									local cell = self._gridCellMap[key]

									GameUtil.SetActive(cell.icon, false)
									GameUtil.SetActive(cell.tagMask, false)
								end

								self._score = self._score + clearTotalScore

								self:_updateScoreUI()
							end
						end

						for key, _ in pairs(lineOwnerMap) do
							lineOwnerMap[key] = nil
						end

						for i = 1, clearedKeyCount do
							local key = clearedKeys[i]

							self._clearCellSet[key] = nil
							clearedKeys[i] = nil
						end

						return lineCount
					end
				end
			end
		end
	end
end

function HexLineupSceneView:_checkGameFlow()
	if self._modeId == HexLineupEnum.ModeId_Limit and self._leftStepCount <= 0 then
		self:_stopDeadlockPropGuideEffect()
		self:_endGame(true)

		return
	end

	local isGameOver = self:_isGameOver()
	local canUsePropToSave = self:_canUsePropToSaveDeadlock()

	self:_refreshDeadlockPropGuideEffect(isGameOver)

	if isGameOver and not canUsePropToSave then
		self:_endGame(false)

		return
	end
end

function HexLineupSceneView:_refreshDeadlockPropGuideEffect(isGameOver)
	if isGameOver then
		::label_80_0::

		local guideKnock = true
		local guideKnock

		if (self._leftKnockCount or 0) <= 0 then
			guideKnock = false
		end

		if isGameOver then
			::label_80_1::

			if not guideKnock then
				local guideShuffle = true

				if (self._leftShuffleCount or 0) <= 0 then
					-- block empty
				end

				if guideKnock then
					if not self._effRootKnock then
						if guideShuffle then
							::label_80_3::

							local effGo = self._effRootShuffle

							self:_stopDeadlockPropGuideEffect()

							if effGo then
								self:playViewEffectUniGo(DEADLOCK_PROP_GUIDE_EFFECT_PATH, effGo, nil, true, nil, nil)
							end
						end
					end
				end
			end
		end
	end
end

function HexLineupSceneView:_stopDeadlockPropGuideEffect()
	self:stopViewEffectUniGo(self._effRootKnock)
	self:stopViewEffectUniGo(self._effRootShuffle)
end

function HexLineupSceneView:_canUsePropToSaveDeadlock()
	local var_82_2

	if (self._leftShuffleCount or 0) <= 0 then
		if (self._leftKnockCount or 0) <= 0 then
			var_82_2 = false

			goto label_82_0
		end
	end

	::label_82_0::

	return true
end

function HexLineupSceneView:_isGameOver()
	for _, cp in ipairs(self._candidatePieces) do
		for _, coord in ipairs(self._boardCoords) do
			local canPlace = self:_canPlacePieceFast(cp.pieceId, coord.q, coord.r)

			if canPlace then
				return false
			end
		end
	end

	return true
end

function HexLineupSceneView:_onClickBtnClose()
	self:_tryExitGame()
end

function HexLineupSceneView:_onKnockBeginDrag(eventData)
	if self:_getCurState() ~= MmUtil.State_Runing then
		return
	end

	if self._leftKnockCount <= 0 then
		return
	end

	if self._isDragging then
		return
	end

	self._isKnockDragging = true
	self._knockHoverKey = nil

	goutil.addChildToParent(self._knockItem, self._dragLayer)
	GameUtil.SetActive(self._knockItem, true)

	local worldPos = uGuiUtil.GetTouchWorldPosition()

	GameUtil.setPos(self._knockItem, worldPos.x, worldPos.y, worldPos.z)
end

function HexLineupSceneView:_onKnockDrag(eventData)
	if not self._isKnockDragging then
		return
	end

	local worldPos = uGuiUtil.GetTouchWorldPosition()

	GameUtil.setPos(self._knockItem, worldPos.x, worldPos.y, worldPos.z)

	local localPos = goutil.screenToLocalPos(eventData.position, self._gridView.transform)
	local q, r = pixelToHex(localPos.x, localPos.y, self._cellWidth, self._cellHeight)
	local key = hexKey(q, r)

	if key == self._knockHoverKey then
		return
	end

	self:_clearKnockHover()

	if self._boardMap[key] and self._boardMap[key].isOccupied then
		local cell = self._gridCellMap[key]

		GameUtil.SetActive(cell.tagSelected, true)

		self._knockHoverKey = key
	end
end

function HexLineupSceneView:_onKnockEndDrag(eventData)
	if not self._isKnockDragging then
		return
	end

	local isKnockUsed = false

	if self._knockHoverKey then
		local key = self._knockHoverKey

		self._boardMap[key].isOccupied = false
		self._boardMap[key].colorState = PIECE_COLOR_EMPTY

		local cell = self._gridCellMap[key]

		GameUtil.SetActive(cell.icon, false)
		GameUtil.SetActive(cell.tagMask, false)

		self._leftKnockCount = self._leftKnockCount - 1

		self:_updatePropUI()

		isKnockUsed = true
	end

	self:_clearKnockHover()

	self._isKnockDragging = false

	GameUtil.SetActive(self._knockItem, false)

	if isKnockUsed then
		self:_checkGameFlow()
	end
end

function HexLineupSceneView:_clearKnockHover()
	if self._knockHoverKey then
		local cell = self._gridCellMap[self._knockHoverKey]

		if cell then
			GameUtil.SetActive(cell.tagSelected, false)
		end

		self._knockHoverKey = nil
	end
end

function HexLineupSceneView:_exitKnockMode()
	self:_clearKnockHover()

	self._isKnockDragging = false

	GameUtil.SetActive(self._knockItem, false)
end

function HexLineupSceneView:_onClickBtnPropShuffle()
	if self:_getCurState() ~= MmUtil.State_Runing then
		return
	end

	if self._leftShuffleCount <= 0 then
		return
	end

	if self._isDragging then
		return
	end

	for _, cp in ipairs(self._candidatePieces) do
		self:_returnPieceChildren(cp.pieceChildren)
		self:_resetPieceCellGo(cp.pieceCellGo, false)
	end

	self._candidatePieces = {}

	if not self._pieceCount then
		for i = 1, self._pieceCount do
			local pieceId = self:_randomPieceId()
			local colorState = self:_randomPieceColorState(self:_getCandidateColorSet())

			self:_createPieceInSlot(i, pieceId, colorState)
		end

		self._leftShuffleCount = self._leftShuffleCount - 1

		self:_updatePropUI()
		self:_checkGameFlow()
	end
end

function HexLineupSceneView:_updateRuleUI()
	local var_91_0 = {}

	var_91_0[1] = string.format("每放置1个棋子+%s分", self._placeScore or 0)
	var_91_0[2] = string.format("每消除1个方块+%s分", self._clearScore or 0)

	local ruleList = var_91_0
	local comboDataList = HexLineupConfig.instance:getComboDataList() or {}

	for _, data in ipairs(comboDataList) do
		ruleList[#ruleList + 1] = string.format("连续消除%s行+%s分", data.count, data.score)
	end

	self._txtRule.text = table.concat(ruleList, "\n")
end

function HexLineupSceneView:_updateScoreUI()
	self._txtScore.text = tostring(self._score or 0)
end

function HexLineupSceneView:_updateStepUI()
	if self._modeId == HexLineupEnum.ModeId_Limit then
		GameUtil.SetActive(self._stepGo, true)

		self._txtStep.text = string.format("剩余步数：%s", self._leftStepCount)
	else
		GameUtil.SetActive(self._stepGo, false)
	end
end

function HexLineupSceneView:_updatePropUI()
	self._txtCountPropKnock.text = string.format("%s/%s", self._leftKnockCount, self._knockCount)
	self._txtCountPropShuffle.text = string.format("%s/%s", self._leftShuffleCount, self._shuffleCount)
end

function HexLineupSceneView:getScore()
	return self._score or 0
end

return HexLineupSceneView
