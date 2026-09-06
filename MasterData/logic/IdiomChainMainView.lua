-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idiomchain/view/IdiomChainMainView.lua

module("logic.extensions.idiomchain.view.IdiomChainMainView", package.seeall)

local IdiomChainMainView = class("IdiomChainMainView", ViewComponent)
local WordLength = 4
local SEQUENCEKEY_MOTION = "motion"

function IdiomChainMainView:ctor()
	IdiomChainMainView.super.ctor(self)

	self._charCells = {}
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

	self._recordQueue = DeQueue.New()
	self._motionLists = {}
end

function IdiomChainMainView:buildUI()
	IdiomChainMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtCurTime = self:getTxt("curTime/txt")
	self._startTips = self:getGo("startTips")
	self._txtScore = self:getTxt("scoreCol/txtScore")
	self._trailEffEndPos = self:getGo("trailEffEndPos")
	self._trailEffRoot = self:getGo("trailEffRoot")

	local pairScrView = self:getGo("scoreCol/pairScrView")
	local pairScrCell = self:getGo("scoreCol/pairScrCell")

	self._pairScrollerList = ScrollerList.create(pairScrView, pairScrCell, GameUtil.handler(self._updatePairCell, self), GameUtil.handler(self._clearPairCell, self))
	self._charPool = self:getGo("chatCol/charPool")
	self._charView = self:getGo("chatCol/charView")
	self._charCell = self:getGo("chatCol/charCell")
	self._dragPlane = self:getGo("chatCol/dragPlane")

	GameUtil.SetActive(self._charCell, false)

	self._charCellSizes = {
		width = GameUtil.getWidth(self._charCell),
		height = GameUtil.getHeight(self._charCell)
	}

	local charViewSize = {
		width = GameUtil.getWidth(self._charView),
		height = GameUtil.getHeight(self._charView)
	}

	self._baseViewPos = {
		x = -charViewSize.width / 2,
		y = -charViewSize.height / 2
	}
end

function IdiomChainMainView:bindEvents()
	IdiomChainMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._startTips, self._onClickStartTips, self)

	local triggerGo = self._dragPlane

	if triggerGo then
		self._pointerDownHandler = PointerDownHandler.Get(triggerGo):AddLuaHandler(function(obj, eventData)
			self:_onBeginDragHandler(obj, eventData)
		end)
		self._pointerUpHandler = PointerUpHandler.Get(triggerGo):AddLuaHandler(function(obj, eventData)
			self:_onEndDragHandler(obj, eventData)
		end)
		self._beginDragHandler = BeginDragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			return
		end)
		self._endDragHandler = EndDragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			return
		end)
		self._dragHandler = DragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			self:_onDragHandler(_go, eventData)
		end)
	end
end

function IdiomChainMainView:unbindEvents()
	IdiomChainMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._startTips)

	local triggerGo = self._dragPlane

	if triggerGo then
		PointerUpHandler.Get(triggerGo):RemoveLuaHandler(self._pointerUpHandler)
		PointerDownHandler.Get(triggerGo):RemoveLuaHandler(self._pointerDownHandler)
		BeginDragHandler.Get(triggerGo):RemoveLuaHandler(self._beginDragHandler)
		EndDragHandler.Get(triggerGo):RemoveLuaHandler(self._endDragHandler)
		DragHandler.Get(triggerGo):RemoveLuaHandler(self._dragHandler)
	end
end

function IdiomChainMainView:onEnter()
	IdiomChainMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._gameParam = params[1] or IdiomChainParam.New()
	self._gamePlanId = self._gameParam:getGamePlanId()
	self._gameData = IdiomChainConfig.instance:getGameData(self._gamePlanId)
	self._wordDataList = IdiomChainConfig.instance:getWordDataList()
	self._charDic = {}
	self._charCompare = {}

	local checkMap = {}

	for _, data in ipairs(self._wordDataList) do
		local content = data.content
		local charList = StringUtil.utf8split(content)

		if checkMap[content] then
			printError(string.format("出现重复的词语 wordId:%s, content:%s", data.wordId, content))
		end

		checkMap[content] = true

		for idx = 1, #charList do
			local char = charList[idx]
			local charId = self:_getCharId(data.wordId, idx)

			self._charDic[charId] = char
			self._charCompare[charId] = {
				charIdx = idx,
				wordId = data.wordId
			}
		end
	end

	self.addGEvent(self, GlobalNotify.GameSureCloseView, self._gameSureCloseView, self)
	self.addGEvent(self, GlobalNotify.GameCancelCloseView, self._gameCancelCloseView, self)
	self.addGEvent(self, GlobalNotify.GameResetProcess, self._gameResetProcess, self)
	self._stateMachine:startTimer()
	self._stateMachine:gotoState(MmUtil.State_Preparing)
end

function IdiomChainMainView:onExit()
	IdiomChainMainView.super.onExit(self)
	self._stateMachine:stopTimer()
	self:_clearGameView()
end

function IdiomChainMainView:destroyUI()
	IdiomChainMainView.super.destroyUI(self)
	self:_disposeCharCellPool()
end

function IdiomChainMainView:_gameSureCloseView()
	self:_closeGame()
end

function IdiomChainMainView:_gameCancelCloseView()
	self._stateMachine:gotoState(MmUtil.State_Runing)
end

function IdiomChainMainView:_gameResetProcess()
	self._stateMachine:gotoState(MmUtil.State_Preparing)
end

function IdiomChainMainView:_getCurState()
	return self._stateMachine.currStateName
end

function IdiomChainMainView:_onPreparingEnter()
	self:_resetGame()
end

function IdiomChainMainView:_onRuningEnter()
	self:_continueGame()
end

function IdiomChainMainView:_onStopingEnter()
	self:_stopGame()
end

function IdiomChainMainView:_onEndedEnter()
	self:_stopGame()
end

function IdiomChainMainView:_onRuningUpdate()
	self._deltaTime = UnityEngine.Time.deltaTime
	self._curGameTime = self._curGameTime + self._deltaTime
	self._txtCurTime.text = string.format("%d", self:getGameTime())
end

function IdiomChainMainView:_resetGame()
	self:_clearGameView()

	self._selectPosIndexList = {}
	self._erasedWordDic = {}
	self._earsedWordList = {}
	self._totalWordCount = self._gameData.wordCount
	self._curGameTime = 0
	self._curWordDataList = MmUtil.randomPick(self._wordDataList, self._totalWordCount, true)

	local m = math.sqrt(self._totalWordCount * WordLength)
	local n = Mathf.Ceil(m / WordLength) + 1

	self._mapWidth = WordLength * n - (n - 1)
	self._mapHeight = WordLength * n - (n - 1)
	self._charMap = {}
	self._positionMap = {}

	for x = 0, self._mapWidth - 1 do
		for y = 0, self._mapHeight - 1 do
			local posIndex = MmUtil.getPosIndex(x, y, self._mapWidth, self._mapHeight)
			local posX = self._baseViewPos.x + self._charCellSizes.width * (x + 1) - self._charCellSizes.width / 2
			local posY = self._baseViewPos.y + self._charCellSizes.height * (y + 1) - self._charCellSizes.height / 2

			self._positionMap[posIndex] = {
				x = posX,
				y = posY
			}
			self._charMap[posIndex] = 0
		end
	end

	local colHeightArray = {}

	for x = 0, self._mapWidth - 1 do
		colHeightArray[x] = 0
	end

	local randomHorXList = {}
	local eachLineHorCount = self._mapHeight % WordLength

	for lineIdx = 1, n - 1 do
		local leftX = Mathf.Max((lineIdx - 1) * (WordLength - 1), 0)
		local rightX = Mathf.Max(lineIdx * (WordLength - 1), 0)

		for idx = 1, eachLineHorCount do
			local random = Mathf.Random(1, 2)
			local isLeft = random == 1
			local posX = isLeft and leftX or rightX

			table.insert(randomHorXList, posX)

			for i = posX, posX + WordLength - 1 do
				colHeightArray[i] = colHeightArray[i] + 1
			end
		end
	end

	local randomVerXList = {}
	local verCount = self._totalWordCount - #randomHorXList

	for idx = 1, verCount do
		local fitPosX = {}

		for x = 0, self._mapWidth - 1 do
			local offset = self._mapHeight - colHeightArray[x]

			if offset >= WordLength then
				table.insert(fitPosX, {
					posX = x,
					weight = offset * 2
				})
			end
		end

		local list = {}

		if #fitPosX > 0 then
			local totalWeight = 0

			for i = 1, #fitPosX do
				totalWeight = totalWeight + fitPosX[i].weight
			end

			if totalWeight > 0 then
				local randomValue = math.random(1, totalWeight)
				local cumulativeWeight = 0

				for i = 1, #fitPosX do
					cumulativeWeight = cumulativeWeight + fitPosX[i].weight

					if randomValue <= cumulativeWeight then
						table.insert(list, fitPosX[i].posX)

						break
					end
				end
			end
		end

		if #list <= 0 then
			printError(string.format("错误，没有可选择的坐标置入纵向词汇( idx=%s )", idx))
		else
			local posX = list[1]

			table.insert(randomVerXList, posX)

			colHeightArray[posX] = colHeightArray[posX] + WordLength
		end
	end

	local wordPosXInfoList = {}

	for idx = 1, #randomHorXList do
		table.insert(wordPosXInfoList, {
			isHor = true,
			posX = randomHorXList[idx]
		})
	end

	for idx = 1, #randomVerXList do
		table.insert(wordPosXInfoList, {
			isHor = false,
			posX = randomVerXList[idx]
		})
	end

	MmUtil.shuffle(wordPosXInfoList)

	for wordIdx, wordData in ipairs(self._curWordDataList) do
		local wordId = wordData.wordId
		local info = wordPosXInfoList[wordIdx]

		if info then
			local isHor = info.isHor
			local posX = info.posX

			if isHor then
				self:_processHorizontalWord(wordId, posX)
			else
				self:_processVerticalWord(wordId, posX)
			end
		end
	end

	self:_compactMapVertical()
	self:_compactMapHorizontal()

	for posIndex, charId in pairs(self._charMap) do
		if charId > 0 then
			local cell = self:_fetchCharCell(charId)

			goutil.addChildToParent(cell._mainGo, self._charView)

			local pos = self._positionMap[posIndex]

			GameUtil.setLocalPos(cell._mainGo, pos.x, pos.y)
			GameUtil.SetActive(cell._mainGo, true)
			self:_unHightLightCell(cell)
		end
	end

	self._txtCurTime.text = string.format("%d", self:getGameTime())

	self:_onUpdatePairCol()
	self:_onUpdateScore()
	GameUtil.SetActive(self._startTips, true)
end

function IdiomChainMainView:_clearGameView()
	self:_clearRecordOfQueue()
	self:_clearAllSequence()
	self:_clearCharCells()
	self:_onClearPairCol()
end

function IdiomChainMainView:_continueGame()
	self:_resumeSequenceOfMainMotion()
end

function IdiomChainMainView:_stopGame()
	self:_pauseSequenceOfMainMotion()
end

function IdiomChainMainView:_endGame(isSuccess)
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

function IdiomChainMainView:_tryExitGame()
	self._stateMachine:gotoState(MmUtil.State_Stoping)
	self:_doGameEndCallBack(MmUtil.GameResult_GameOverOfDropOut)
end

function IdiomChainMainView:_closeGame()
	self:close()
end

function IdiomChainMainView:_doGameEndCallBack(gameEndRes)
	self._gameParam:doGameEndCallBack(gameEndRes, self)
end

function IdiomChainMainView:_checkGameOver()
	local curErasedWordCount = #self._earsedWordList
	local isEndGame = curErasedWordCount >= self._totalWordCount

	if isEndGame then
		return MmUtil.State_Ended
	end

	return MmUtil.State_Runing
end

function IdiomChainMainView:getGameTime()
	return Mathf.Floor(self._curGameTime)
end

function IdiomChainMainView:_createNextRecordId()
	self._maxRecordId = self._maxRecordId + 1
	self._motionLists[self._maxRecordId] = self._motionLists[self._maxRecordId] or {}

	self._recordQueue:pushBack(self._maxRecordId)

	return self._maxRecordId
end

function IdiomChainMainView:_addMotionToRecord(recordId, motionType, ...)
	local motion = {
		motionType = motionType,
		params = {
			...
		}
	}

	table.insert(self._motionLists[recordId], motion)
end

function IdiomChainMainView:_doNextRecord()
	local recordId = self._recordQueue:popFront() or 0

	if recordId <= 0 then
		return
	end

	self:_clearSequenceOfMainMotion()

	self._doingRecordId = recordId

	local motionList = self._motionLists[recordId]

	for _, motionMo in ipairs(motionList) do
		self:_doMotion(motionMo)
	end

	local mainSequence = self:_getSequenceOfMainMotion()

	mainSequence:OnComplete(function()
		self._motionLists[recordId] = nil
		self._doingRecordId = 0

		self:_onUpdateScore()

		local result = self:_checkGameOver()

		if result == MmUtil.State_Runing then
			-- block empty
		else
			self:_endGame(true)
		end
	end)
	mainSequence:OnKill(function()
		self:_clearSequenceOfMainMotion()
	end)
end

function IdiomChainMainView:_isDoingRecord()
	return self._doingRecordId > 0
end

function IdiomChainMainView:_clearRecordOfQueue()
	self._doingRecordId = 0
	self._maxRecordId = 0

	self._recordQueue:clear()

	self._motionLists = {}
end

function IdiomChainMainView:_addMotionOfMove(recordId, charPaths)
	self:_addMotionToRecord(recordId, IdiomChainEnum.Motion_Move, charPaths)
end

function IdiomChainMainView:_addMotionOfErase(recordId, charId)
	self:_addMotionToRecord(recordId, IdiomChainEnum.Motion_Erase, charId)
end

function IdiomChainMainView:_addMotionOfLightScore(recordId, wordId, position)
	self:_addMotionToRecord(recordId, IdiomChainEnum.Motion_LightScore, wordId, position)
end

function IdiomChainMainView:_doMotion(motionMo)
	local motionType = motionMo.motionType
	local motionParam = motionMo.params

	if motionType == IdiomChainEnum.Motion_Move then
		self:_doMotionOfMove(GameUtil.unpack10(motionParam))
	elseif motionType == IdiomChainEnum.Motion_Erase then
		self:_doMotionOfErase(GameUtil.unpack10(motionParam))
	elseif motionType == IdiomChainEnum.Motion_LightScore then
		self:_doMotionOfLightScore(GameUtil.unpack10(motionParam))
	end
end

function IdiomChainMainView:_doMotionOfErase(charId)
	local cell = self._charCells[charId]

	self:_clearTweenerOfGo(cell._mainGo)
	GameUtil.SetActive(cell._mainGo, false)
end

function IdiomChainMainView:_doMotionOfMove(charPaths)
	if TableUtil.isTableEmpty(charPaths) then
		return
	end

	local sequence = DG.Tweening.DOTween.Sequence()

	for charId, charPath in pairs(charPaths) do
		local formPosIndex = charPath.fromPosIndex
		local toPosIndex = charPath.toPosIndex
		local cell = self._charCells[charId]
		local formPos = self._positionMap[formPosIndex]
		local toPos = self._positionMap[toPosIndex]
		local mainGo = cell._mainGo
		local toward = MmUtil.getToward(formPos.x, formPos.y, toPos.x, toPos.y)
		local distance = Vector2.Distance(formPos, toPos)
		local speedRatio = self._charCellSizes.width * 20
		local moveDuration = distance / speedRatio
		local tweenerMove = mainGo.transform:DOLocalMove(toPos, moveDuration)

		tweenerMove:SetEase(DG.Tweening.Ease.Linear)
		tweenerMove:OnStart(function()
			GameUtil.setLocalPos(mainGo, formPos.x, formPos.y)
			self:_unHightLightCell(cell)
		end)

		local punchRotation = Vector2.New()
		local fudu = 30

		if toward == MmUtil.Towards.Up then
			punchRotation:Set(fudu, 0)
		elseif toward == MmUtil.Towards.Down then
			punchRotation:Set(-fudu, 0)
		elseif toward == MmUtil.Towards.Left then
			punchRotation:Set(0, fudu)
		elseif toward == MmUtil.Towards.Right then
			punchRotation:Set(0, -fudu)
		end

		local punchDuration = moveDuration + 0.1
		local tweenerPunchRotation = mainGo.transform:DOPunchRotation(punchRotation, punchDuration, 1, 0)

		tweenerPunchRotation:SetEase(DG.Tweening.Ease.InElastic)
		sequence:Join(tweenerMove)
		sequence:Join(tweenerPunchRotation)
	end

	local mainSequence = self:_getSequenceOfMainMotion()

	mainSequence:Append(sequence)
end

function IdiomChainMainView:_doMotionOfLightScore(wordId, position)
	GameUtil.setPos(self._trailEffRoot, position.x, position.y, position.z)
	GameUtil.SetActive(self._trailEffRoot, false)

	local index = #self._earsedWordList - 1

	self._pairScrollerList:updateCellAtIndex(index)
	self._pairScrollerList:MoveCellInView(index, true)

	local trailEffEndPos = GameUtil.getPos(self._trailEffEndPos)
	local cell = self._pairScrollerList:getView():GetCellAtIndex(index)

	if cell then
		trailEffEndPos = GameUtil.getPos(cell.gameObject)
	end

	local effPath = "20251219/chengyujielong/fx_ui_chengyu_trail.prefab"

	local function loadedHandler(handlerTarget, eff)
		local trs = eff.effGo:GetComponentsInChildren(ComponentType.TrailRenderer)

		for i = 0, trs.Length - 1 do
			trs[i]:Clear()
		end

		GameUtil.SetActive(self._trailEffRoot, true)

		local formPos = GameUtil.getPos(eff.effGo)
		local toPos = trailEffEndPos
		local moveDuration = 0.6
		local tweenerMove = self._trailEffRoot.transform:DOMove(toPos, moveDuration)

		tweenerMove:SetEase(DG.Tweening.Ease.Linear)
		tweenerMove:OnComplete(function()
			self:stopViewEffectUniGo(self._trailEffRoot)

			self._lightWordId = wordId

			self._pairScrollerList:updateCellAtIndex(index)
		end)
	end

	self:playViewEffectUniGo(effPath, self._trailEffRoot, nil, true, nil, loadedHandler)
end

function IdiomChainMainView:_doAnimOfRefuseOp(cell, toward)
	local mainGo = cell._mainGo
	local pos = GameUtil.getLocalPos(mainGo)
	local tweenerShakePosition = mainGo.transform:DOShakePosition(0.2, Vector3.New(1.2, 1.2, 1.2), 8, 90)

	tweenerShakePosition:OnComplete(function()
		self:_unHightLightCell(cell)
		GameUtil.setLocalPos(mainGo, pos.x, pos.y, pos.z)
	end)
end

function IdiomChainMainView:_getSequenceOfMainMotion()
	return self:_getSequence(SEQUENCEKEY_MOTION)
end

function IdiomChainMainView:_clearSequenceOfMainMotion()
	self:_clearSequence(SEQUENCEKEY_MOTION)
end

function IdiomChainMainView:_resumeSequenceOfMainMotion()
	self:_resumeSequence(SEQUENCEKEY_MOTION)
end

function IdiomChainMainView:_pauseSequenceOfMainMotion()
	self:_pauseSequence(SEQUENCEKEY_MOTION)
end

function IdiomChainMainView:_getSequence(key)
	if self._sequencePool == nil then
		self._sequencePool = {}
	end

	if self._sequencePool[key] == nil then
		self._sequencePool[key] = DG.Tweening.DOTween.Sequence()
	end

	return self._sequencePool[key]
end

function IdiomChainMainView:_clearAllSequence()
	if self._sequencePool then
		for key, sequence in pairs(self._sequencePool) do
			self:_clearSequence(key)
		end
	end
end

function IdiomChainMainView:_resumeAllSequence()
	if self._sequencePool then
		for key, sequence in pairs(self._sequencePool) do
			sequence:Play()
		end
	end
end

function IdiomChainMainView:_pauseAllSequence()
	if self._sequencePool then
		for key, sequence in pairs(self._sequencePool) do
			sequence:Pause()
		end
	end
end

function IdiomChainMainView:_clearSequence(key)
	if self._sequencePool and self._sequencePool[key] then
		self._sequencePool[key]:Kill(true)

		self._sequencePool[key] = nil
	end
end

function IdiomChainMainView:_resumeSequence(key)
	if self._sequencePool then
		if self._sequencePool then
			self._sequencePool:Play()
		end
	end
end

function IdiomChainMainView:_pauseSequence(key)
	if self._sequencePool then
		if self._sequencePool then
			self._sequencePool:Pause()
		end
	end
end

function IdiomChainMainView:_clearTweenerOfGo(mainGo)
	mainGo.transform:DOKill(true)
end

function IdiomChainMainView:_onBeginDragHandler(go, eventData)
	self:_clearSequenceOfMainMotion()
	table.clear(self._selectPosIndexList)

	self._dragWordState = 1

	self:_onDragHandler(go, eventData)
end

function IdiomChainMainView:_onEndDragHandler(go, eventData)
	local isSuccess = false
	local firstWordId

	if #self._selectPosIndexList == WordLength then
		isSuccess = true

		for charIdx, posIndex in ipairs(self._selectPosIndexList) do
			local charId = self._charMap[posIndex]
			local info = self._charCompare[charId]

			if info == nil or info.charIdx ~= charIdx then
				isSuccess = false

				break
			end

			if firstWordId == nil then
				firstWordId = info.wordId
			elseif info.wordId ~= firstWordId then
				isSuccess = false

				break
			end
		end
	end

	if isSuccess then
		if firstWordId then
			self._erasedWordDic[firstWordId] = true

			table.insert(self._earsedWordList, firstWordId)
		end

		local erasedCharIdList = {}

		for _, posIndex in ipairs(self._selectPosIndexList) do
			local charId = self._charMap[posIndex]

			self._charMap[posIndex] = 0

			table.insert(erasedCharIdList, charId)
		end

		local verticalCharPaths = self:_compactMapVertical()
		local horizontalCharPaths = self:_compactMapHorizontal()
		local recordId = self:_createNextRecordId()

		for _, charId in ipairs(erasedCharIdList) do
			self:_addMotionOfErase(recordId, charId)
		end

		self:_addMotionOfMove(recordId, verticalCharPaths)
		self:_addMotionOfMove(recordId, horizontalCharPaths)

		local posIndexOfLight = self._selectPosIndexList[2]
		local localPosition = self._positionMap[posIndexOfLight]
		local localVec3 = Vector3.New(localPosition.x, localPosition.y, 0)
		local worldPosition = self._charView.transform:TransformPoint(localVec3)

		self:_addMotionOfLightScore(recordId, firstWordId, worldPosition)
		self:_doNextRecord()
	else
		for _, posIndex in ipairs(self._selectPosIndexList) do
			local charId = self._charMap[posIndex]
			local cell = self._charCells[charId]

			self:_doAnimOfRefuseOp(cell)
		end

		self._dragWordState = 1
	end

	table.clear(self._selectPosIndexList)
end

function IdiomChainMainView:_onDragHandler(go, eventData)
	if self._dragWordState == 3 then
		return
	end

	local localPos = goutil.screenToLocalPos(eventData.position, self._charView.transform)
	local x = math.floor(math.abs(localPos.x - self._baseViewPos.x) / self._charCellSizes.width)
	local y = math.floor(math.abs(localPos.y - self._baseViewPos.y) / self._charCellSizes.height)
	local posIndex = MmUtil.getPosIndex(x, y, self._mapWidth, self._mapHeight)
	local charId = posIndex and self._charMap[posIndex]

	if charId and charId > 0 and table.indexof(self._selectPosIndexList, posIndex) == false and #self._selectPosIndexList < WordLength then
		local isStraightLine = true

		if #self._selectPosIndexList == 1 then
			isStraightLine = false

			local firstPosIndex = self._selectPosIndexList[1]
			local x1, y1 = MmUtil.getPos(firstPosIndex, self._mapWidth, self._mapHeight)

			for _, toward in pairs(MmUtil.Towards) do
				local nextX, nextY = MmUtil.getNeighborPos(x1, y1, self._mapWidth, self._mapHeight, toward)

				if nextX == x and nextY == y then
					isStraightLine = true

					break
				end
			end
		elseif #self._selectPosIndexList >= 2 then
			isStraightLine = false

			local firstPosIndex = self._selectPosIndexList[#self._selectPosIndexList - 1]
			local lastPosIndex = self._selectPosIndexList[#self._selectPosIndexList]
			local x1, y1 = MmUtil.getPos(firstPosIndex, self._mapWidth, self._mapHeight)
			local x2, y2 = MmUtil.getPos(lastPosIndex, self._mapWidth, self._mapHeight)
			local toward = MmUtil.getToward(x1, y1, x2, y2)

			if toward then
				local nextX, nextY = MmUtil.getNeighborPos(x2, y2, self._mapWidth, self._mapHeight, toward)

				if nextX == x and nextY == y then
					isStraightLine = true
				end
			end
		end

		if isStraightLine then
			local cell = self._charCells[charId]

			self:_doHightLightCell(cell)
			table.insert(self._selectPosIndexList, posIndex)

			self._dragWordState = 2

			if #self._selectPosIndexList >= WordLength then
				self._dragWordState = 3
			end
		end
	end
end

function IdiomChainMainView:_doHightLightCell(cell)
	cell._changeGroup:SetState(1)
end

function IdiomChainMainView:_unHightLightCell(cell)
	cell._changeGroup:SetState(0)
end

function IdiomChainMainView:_onUpdateScore()
	local total = #self._curWordDataList
	local cur = #self._earsedWordList

	self._txtScore.text = string.format("本关组合 %s/%s", cur, total)
end

function IdiomChainMainView:_onUpdatePairCol()
	local length = #self._curWordDataList

	self._pairIndexList = {}

	for index = 1, length do
		table.insert(self._pairIndexList, index)
	end

	self._pairScrollerList:reloadData(self._pairIndexList)
	self._pairScrollerList:MoveCellToBegin(0, true)
end

function IdiomChainMainView:_onClearPairCol()
	self._pairScrollerList:dispose()
end

function IdiomChainMainView:_updatePairCell(view, cell, pairIndex, tag)
	if not self._earsedWordList[pairIndex] then
		local wordId = 0
		local isHasErase = self._erasedWordDic[wordId] == true
		local isLightWord = wordId == self._lightWordId
		local mainGo = cell.gameObject

		for wordIdx = 1, WordLength do
			local unitGo = mainGo.transform:GetChild(wordIdx - 1).gameObject
			local txtName = goutil.findChildTextComponent(unitGo, "txtName")
			local eraseEffRoot = goutil.findChild(unitGo, "eraseEffRoot")

			if isLightWord then
				local effPath = "20251219/chengyujielong/fx_ui_chengyu_xiaochu.prefab"

				self:playViewEffectUniGo(effPath, eraseEffRoot, nil, false, nil, nil)
			else
				self:stopViewEffectUniGo(eraseEffRoot)
			end

			if isHasErase then
				local charId = self:_getCharId(wordId, wordIdx)

				txtName.text = self._charDic[charId]
			else
				txtName.text = ""
			end
		end
	end
end

function IdiomChainMainView:_clearPairCell(cell)
	return
end

function IdiomChainMainView:_getCharId(wordId, charIdx)
	return (wordId - 1) * WordLength + charIdx
end

function IdiomChainMainView:_fetchCharCell(charId)
	if self._charCellPoll == nil then
		self:_creatCharCellPool()
	end

	local cell = self._charCellPoll:fetchObject()

	cell._txtName.text = self._charDic[charId]
	cell._charId = charId
	self._charCells[cell._charId] = cell

	return cell
end

function IdiomChainMainView:_returnCharCell(cell)
	self:stopViewEffectUniGo(cell._eraseEffRoot)
	self:_clearTweenerOfGo(cell._mainGo)

	self._charCells[cell._charId] = nil

	self._charCellPoll:returnObject(cell)
end

function IdiomChainMainView:_creatCharCellPool()
	if self._charCellPoll ~= nil then
		return
	end

	local function createFunc()
		local mainGo = goutil.clone(self._charCell)
		local cell = {}

		cell._mainGo = mainGo
		cell._txtName = goutil.findChildTextComponent(mainGo, "txtName")
		cell._eraseEffRoot = goutil.findChild(mainGo, "eraseEffRoot")
		cell._changeGroup = GameUtil.getUIChangeGroup(mainGo)
		cell._wordId = 0
		cell._charId = 0

		return cell
	end

	local function disposeFunc(cell)
		local mainGo = cell._mainGo

		cell._mainGo = nil

		goutil.destroy(mainGo)

		cell = nil
	end

	local function resetFunc(cell)
		GameUtil.SetActive(cell._mainGo, false)
		goutil.addChildToParent(cell._mainGo, self._charPool)
	end

	self._charCellPoll = ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

function IdiomChainMainView:_clearCharCells()
	if self._charCells == nil then
		return
	end

	for _, cell in pairs(self._charCells) do
		self:_returnCharCell(cell)
	end

	table.clear(self._charCells)
end

function IdiomChainMainView:_disposeCharCellPool()
	self:_clearCharCells()

	if self._charCellPoll ~= nil then
		self._charCellPoll:clear()

		self._charCellPoll = nil
	end
end

function IdiomChainMainView:_onClickStartTips()
	if self:_getCurState() ~= MmUtil.State_Preparing then
		return
	end

	GameUtil.SetActive(self._startTips, false)
	self._stateMachine:gotoState(MmUtil.State_Runing)
end

function IdiomChainMainView:_onClickBtnClose()
	self:_tryExitGame()
end

function IdiomChainMainView:_compactMapVertical()
	local charPaths = {}

	for y = 0, self._mapHeight - 1 do
		for x = 0, self._mapWidth - 1 do
			local fromPosIndex = MmUtil.getPosIndex(x, y, self._mapWidth, self._mapHeight)
			local charId = self._charMap[fromPosIndex]

			if charId > 0 then
				local curX, curY = x, y

				while true do
					local nbrX, nbrY = MmUtil.getNeighborPos(curX, curY, self._mapWidth, self._mapHeight, MmUtil.Towards.Down)

					if nbrX and nbrY then
						local nbrPosIndex = MmUtil.getPosIndex(nbrX, nbrY, self._mapWidth, self._mapHeight)
						local nbrCharId = self._charMap[nbrPosIndex]

						if nbrCharId <= 0 then
							curY = nbrY
							curX = nbrX
						else
							break
						end
					else
						break
					end
				end

				self._charMap[fromPosIndex] = 0

				local toPosIndex = MmUtil.getPosIndex(curX, curY, self._mapWidth, self._mapHeight)

				self._charMap[toPosIndex] = charId
				charPaths[charId] = {
					fromPosIndex = fromPosIndex,
					toPosIndex = toPosIndex
				}
			end
		end
	end

	return charPaths
end

function IdiomChainMainView:_compactMapHorizontal()
	local function isColumnEmpty(x)
		for y = 0, self._mapHeight - 1 do
			local posIndex = MmUtil.getPosIndex(x, y, self._mapWidth, self._mapHeight)
			local charId = self._charMap[posIndex]

			if charId > 0 then
				return false
			end
		end

		return true
	end

	local charPaths = {}
	local middleX = 4
	local middleY = 0
	local middlePosIndex = MmUtil.getPosIndex(middleX, middleY, self._mapWidth, self._mapHeight)
	local mergeConfigs = {
		{
			stepX = -1,
			moveDelta = 1,
			endX = 0,
			startX = middleX - 1
		},
		{
			stepX = 1,
			moveDelta = -1,
			startX = middleX + 1,
			endX = self._mapWidth - 1
		}
	}

	for _, config in ipairs(mergeConfigs) do
		for fromX = config.startX, config.endX, config.stepX do
			local toX = fromX

			while true do
				local nextX = toX + config.moveDelta

				if isColumnEmpty(nextX) then
					toX = nextX
				else
					break
				end

				if nextX == middleX then
					break
				end
			end

			if fromX ~= toX then
				for y = 0, self._mapHeight - 1 do
					local fromPosIndex = MmUtil.getPosIndex(fromX, y, self._mapWidth, self._mapHeight)
					local charId = self._charMap[fromPosIndex]

					if charId > 0 then
						self._charMap[fromPosIndex] = 0

						local toPosIndex = MmUtil.getPosIndex(toX, y, self._mapWidth, self._mapHeight)

						self._charMap[toPosIndex] = charId
						charPaths[charId] = {
							fromPosIndex = fromPosIndex,
							toPosIndex = toPosIndex
						}
					end
				end
			end
		end
	end

	return charPaths
end

function IdiomChainMainView:_isForwardDirection()
	return Mathf.Random(1, 2) == 1
end

function IdiomChainMainView:_moveColumnCharsUp(columnX, moveSteps)
	for y = self._mapHeight - 1, 0, -1 do
		local posIndex = MmUtil.getPosIndex(columnX, y, self._mapWidth, self._mapHeight)
		local charId = self._charMap[posIndex]

		if charId > 0 then
			local newY = y + moveSteps

			if not MmUtil.isInRange(columnX, newY, self._mapWidth, self._mapHeight) then
				printError(string.format("字符移动越界: x=%s, y=%s, newY=%s", columnX, y, newY))
			else
				local newPosIndex = MmUtil.getPosIndex(columnX, newY, self._mapWidth, self._mapHeight)

				self._charMap[newPosIndex] = charId
				self._charMap[posIndex] = 0
			end
		end
	end
end

function IdiomChainMainView:_fillWordChars(wordId, positions, isForward)
	if isForward then
		for charIndex = 1, WordLength do
			local pos = positions[charIndex]
			local posIndex = MmUtil.getPosIndex(pos.x, pos.y, self._mapWidth, self._mapHeight)

			self._charMap[posIndex] = self:_getCharId(wordId, charIndex)
		end
	else
		for charIndex = 1, WordLength do
			local pos = positions[WordLength - charIndex + 1]
			local posIndex = MmUtil.getPosIndex(pos.x, pos.y, self._mapWidth, self._mapHeight)

			self._charMap[posIndex] = self:_getCharId(wordId, charIndex)
		end
	end
end

function IdiomChainMainView:_processHorizontalWord(wordId, posX)
	for colOffset = 0, WordLength - 1 do
		local columnX = posX + colOffset

		self:_moveColumnCharsUp(columnX, 1)
	end

	local positions = {}

	for charIndex = 1, WordLength do
		local charX = posX + charIndex - 1

		table.insert(positions, {
			y = 0,
			x = charX
		})
	end

	local isForward = self:_isForwardDirection()

	self:_fillWordChars(wordId, positions, isForward)
end

function IdiomChainMainView:_processVerticalWord(wordId, posX)
	self:_moveColumnCharsUp(posX, WordLength)

	local positions = {}

	for charIndex = 1, WordLength do
		local charY = charIndex - 1

		table.insert(positions, {
			x = posX,
			y = charY
		})
	end

	local isForward = self:_isForwardDirection()

	self:_fillWordChars(wordId, positions, isForward)
end

return IdiomChainMainView
