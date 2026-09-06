-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/NumberPuzzleGameSceneView.lua

module("logic.extensions.numberpuzzlegame.view.NumberPuzzleGameSceneView", package.seeall)

local NumberPuzzleGameSceneView = class("NumberPuzzleGameSceneView", ViewComponent)

function NumberPuzzleGameSceneView:buildUI()
	NumberPuzzleGameSceneView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._pointView = goutil.findChild(self.mainGO, "gridCol/pointView")
	self._pointCell = goutil.findChild(self.mainGO, "gridCol/pointCell")
	self._pointViewLayoutGroup = self._pointView:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._dragPlane = goutil.findChild(self.mainGO, "gridCol/dragPlane")

	GameUtil.SetActive(self._pointCell, false)

	self._createPointsRoot = goutil.findChild(self.mainGO, "gridCol/spPointCol/createPointsRoot")

	if self._createPointsRoot then
		self._createPointList = GameUtil.getChildren(self._createPointsRoot)
	end

	self._gridView = goutil.findChild(self.mainGO, "gridCol/gridView")
	self._gridCell = goutil.findChild(self.mainGO, "gridCol/gridCell")
	self._gridPool = goutil.findChild(self.mainGO, "gridCol/gridPool")

	GameUtil.SetActive(self._gridCell, false)

	self._normal = goutil.findChild(self.mainGO, "normal")
	self._normal_curScore = goutil.findChild(self.mainGO, "normal/curScore")
	self._normal_curScore_txt1 = goutil.findChildTextComponent(self.mainGO, "normal/curScore/txt1")
	self._normal_curScore_txt2 = goutil.findChildTextComponent(self.mainGO, "normal/curScore/txt2")
	self._normal_merge = goutil.findChild(self.mainGO, "normal/merge")
	self._normal_merge_txt1 = goutil.findChildTextComponent(self.mainGO, "normal/merge/txt1")
	self._normal_merge_txt2 = goutil.findChildTextComponent(self.mainGO, "normal/merge/txt2")
	self._normal_merge_txt3 = goutil.findChildTextComponent(self.mainGO, "normal/merge/txt3")
	self._normal_step = goutil.findChild(self.mainGO, "normal/step")
	self._normal_step_txt1 = goutil.findChildTextComponent(self.mainGO, "normal/step/txt1")
	self._normal_step_txt2 = goutil.findChildTextComponent(self.mainGO, "normal/step/txt2")
	self._extreme = goutil.findChild(self.mainGO, "extreme")
	self._extreme_curScore = goutil.findChild(self.mainGO, "extreme/curScore")
	self._extreme_curScore_txt1 = goutil.findChildTextComponent(self.mainGO, "extreme/curScore/txt1")
	self._extreme_curScore_txt2 = goutil.findChildTextComponent(self.mainGO, "extreme/curScore/txt2")
	self._extreme_maxScore = goutil.findChild(self.mainGO, "extreme/maxScore")
	self._extreme_maxScore_txt1 = goutil.findChildTextComponent(self.mainGO, "extreme/maxScore/txt1")
	self._extreme_maxScore_txt2 = goutil.findChildTextComponent(self.mainGO, "extreme/maxScore/txt2")
	self._extreme_bubble = goutil.findChild(self.mainGO, "extreme/bubble")
	self._extreme_bubble_txt = goutil.findChildTextComponent(self.mainGO, "extreme/bubble/txt")
	self._super = goutil.findChild(self.mainGO, "super")
	self._super_maxGrid_txt = goutil.findChildTextComponent(self.mainGO, "super/maxGrid/txt")
	self._super_energy_txt = goutil.findChildTextComponent(self.mainGO, "super/energy/txt")
	self._super_next_txt = goutil.findChildTextComponent(self.mainGO, "super/next/txt")
	self._propCol = goutil.findChild(self.mainGO, "propCol")
	self._btnPropQueue = goutil.findChild(self.mainGO, "propCol/btnPropQueue")
	self._btnPropQueue_txtNum = goutil.findChildTextComponent(self.mainGO, "propCol/btnPropQueue/txtNum")
	self._btnPropUniversalCard = goutil.findChild(self.mainGO, "propCol/btnPropUniversalCard")
	self._btnPropUniversalCard_txt = goutil.findChildTextComponent(self.mainGO, "propCol/btnPropUniversalCard/txt")
	self._btnPropUniversalCard_txtNum = goutil.findChildTextComponent(self.mainGO, "propCol/btnPropUniversalCard/txtNum")
	self._btnPropKnock = goutil.findChild(self.mainGO, "propCol/btnPropKnock")
	self._btnPropKnock_txtNum = goutil.findChildTextComponent(self.mainGO, "propCol/btnPropKnock/txtNum")
	self._btnReset = goutil.findChild(self.mainGO, "btnReset")
	self._testCol_mainGo = goutil.findChild(self.mainGO, "testCol")
	self._testCol_btnView = goutil.findChild(self.mainGO, "testCol/btnView")
	self._testCol_txtTest = goutil.findChildTextComponent(self.mainGO, "testCol/txtTest")
	self._testCol_dropdown = goutil.findChild(self.mainGO, "testCol/dropdown")
	self._testCol_dropdownComp = DropDownAdapter.Get(self._testCol_dropdown)
	self._btnTestList = GameUtil.getChildren(self._testCol_btnView)
end

function NumberPuzzleGameSceneView:bindEvents()
	NumberPuzzleGameSceneView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnPropQueue, self._onClickBtnQueue, self)
	GameUtil.addClickHandler(self._btnPropUniversalCard, self._onClickBtnUniversalCard, self)
	GameUtil.addClickHandler(self._btnPropKnock, self._onClickBtnKnock, self)

	local triggerGo = self._dragPlane

	if triggerGo then
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

	for idx, go in ipairs(self._btnTestList) do
		GameUtil.addClickHandler(go, GameUtil.handler(self._onClickBtnTest, self, idx))
	end
end

function NumberPuzzleGameSceneView:unbindEvents()
	NumberPuzzleGameSceneView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPropQueue)
	GameUtil.rmClickHandler(self._btnPropUniversalCard)
	GameUtil.rmClickHandler(self._btnPropKnock)

	local triggerGo = self._dragPlane

	if triggerGo then
		BeginDragHandler.Get(triggerGo):RemoveLuaHandler(self._beginDragHandler)
		EndDragHandler.Get(triggerGo):RemoveLuaHandler(self._endDragHandler)
		DragHandler.Get(triggerGo):RemoveLuaHandler(self._dragHandler)
	end

	for idx, go in ipairs(self._btnTestList) do
		GameUtil.rmClickHandler(go)
	end
end

function NumberPuzzleGameSceneView:onEnter()
	NumberPuzzleGameSceneView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._npgViewParam = params[1] or NPGViewParam.New()
	self._mapId = self._npgViewParam:getMapId()
	self._isTestMode = self._npgViewParam:isTestMode()
	self._gameMode = self._npgViewParam:getGameMode()
	self._maxTotalScoreLimit = self._npgViewParam:getMaxTotalScoreLimit()
	self._startUpEnergy = self._npgViewParam:getStartUpEnergy()

	self:_onInitGameCtrl()
	self:_onSetUI()
	self:_onUpdateTestCol()
	self.addGEvent(self, GlobalNotify.NumberPuzzleGameUpdateUI, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.NumberPuzzleGameSureCloseView, self._handleSureCloseView, self)
	self.addGEvent(self, GlobalNotify.NumberPuzzleGameResetGame, self._handleResetGame, self)
	self.addGEvent(self, GlobalNotify.NumberPuzzleGameCancelCloseView, self._handleCancelCloseView, self)
	self.addGEvent(self, GlobalNotify.NumberPuzzleGameStartTestMode, self._handleStartTestMode, self)
	settimer(0, self._onTicking, self)
	self:_continueGame()
end

function NumberPuzzleGameSceneView:onExit()
	NumberPuzzleGameSceneView.super.onExit(self)
	removetimer(self._onTicking, self)
	self:_clearGameView()
end

function NumberPuzzleGameSceneView:destroyUI()
	NumberPuzzleGameSceneView.super.destroyUI(self)
	self:_onDestroyGridCellPool()
end

function NumberPuzzleGameSceneView:_handleSureCloseView()
	self:close()
end

function NumberPuzzleGameSceneView:_handleCancelCloseView()
	self:_continueGame()
end

function NumberPuzzleGameSceneView:_handleResetGame()
	self:_resetGame()
end

function NumberPuzzleGameSceneView:_handleStartTestMode()
	self._npgViewParam:setIsTestMode(not self._isTestMode)

	self._isTestMode = not self._isTestMode

	self:_onUpdateTestCol()
end

function NumberPuzzleGameSceneView:_onSetUI()
	GameUtil.SetActive(self._normal, self._gameMode == NPGEnum.GameMode_Nor)
	GameUtil.SetActive(self._extreme, self._gameMode == NPGEnum.GameMode_Ext)
	GameUtil.SetActive(self._super, self._gameMode == NPGEnum.GameMode_Sup)
end

function NumberPuzzleGameSceneView:_onUpdate()
	if self._gameMode == NPGEnum.GameMode_Nor then
		self:_onUpdateUINormal()
	elseif self._gameMode == NPGEnum.GameMode_Ext then
		self:_onUpdateUIExtreme()
	elseif self._gameMode == NPGEnum.GameMode_Sup then
		self:_onUpdateUISuper()
	end
end

function NumberPuzzleGameSceneView:_onUpdateUINormal()
	self._txtTitle.text = "闯关模式"

	self:_onUpdatePropUI(false)

	self._normal_curScore_txt2.text = self._gameCtrl._detailMo:getTotalScore()

	if self._gameCtrl:isNeedCheckCondOfNeedMergeCount() then
		if not self._gameCtrl._needMergeCount then
			local gridId = self._gameCtrl:getNeedMergeGridIdCond()
			local needCount = self._gameCtrl:getNeedMergeCountCond()
			local curCount = self._gameCtrl._detailMo:getGridMergeCount(gridId)
			local data = NumberPuzzleGameConfig.instance:getNpgGridLibData(self._mapId, gridId)

			self._normal_merge_txt2.text = string.format("成功合出<color=#a66f35>%s</color>次<color=#a66f35>%s</color>宝珠", needCount, (data or nil) and data.name)
			self._normal_merge_txt3.text = self._gameCtrl:isEnoughCondOfNeedMergeCount() and string.format("(<color=#20b376>%s</color>/%s)", curCount, needCount) or string.format("(%s/%s)", curCount, needCount)

			GameUtil.SetActive(self._normal_merge, true)
		end
	else
		GameUtil.SetActive(self._normal_merge, false)
	end

	if self._gameCtrl:isNeedCheckCondOfNotOverMaxStep() then
		local curStep = self._gameCtrl._detailMo:getCurStep()
		local maxStep = self._gameCtrl:getMaxCanStepCount()
		local leftStep = self._gameCtrl:getLeftStepCount()

		self._normal_step_txt2.text = self._gameCtrl:isEnoughCondOfNotOverMaxStep() and string.format("(%s/%s)", leftStep, maxStep) or string.format("(<color=#eb4624>%s</color>/%s)", leftStep, maxStep)

		GameUtil.SetActive(self._normal_step, true)
	else
		GameUtil.SetActive(self._normal_step, false)
	end
end

function NumberPuzzleGameSceneView:_onUpdateUIExtreme()
	self._txtTitle.text = "挑战模式"
	self._extreme_curScore_txt2.text = self._gameCtrl._detailMo:getTotalScore()

	self:_onUpdatePropUI(true)

	self._extreme_maxScore_txt2.text = self._gameCtrl._detailMo:getMaxTotalScore()
	self._extreme_bubble_txt.text = string.format("每达到%s积分可随机获得其中一个金手指哦！", self._gameCtrl._eachGetPropScore)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._bubble:GetComponent(goutil.Type_RectTransform))
end

function NumberPuzzleGameSceneView:_onUpdateUISuper()
	self._txtTitle.text = "合宝珠"

	self:_onUpdatePropUI(true)

	local gbId = self._gameCtrl._detailMo:getMaxGbId()
	local data = NumberPuzzleGameConfig.instance:getNpgGridLibDataById(gbId)

	if data then
		self._super_maxGrid_txt.text = data.name or "无"
	end

	local max = self._gameCtrl._detailMo:getStartUpEnergy()
	local cur = self._gameCtrl._detailMo:getLeftEnergy()

	self._super_energy_txt.text = string.format("%s/%s", cur, max)

	local targetGridId = self._gameCtrl:getNeedMergeGridIdCond()
	local gbData = NumberPuzzleGameConfig.instance:getNpgGridLibData(self._mapId, targetGridId)

	if gbData then
		self._super_next_txt.text = gbData.name or "无"
	end
end

function NumberPuzzleGameSceneView:_onUpdatePropUI(isShow)
	GameUtil.SetActive(self._propCol, isShow)

	if isShow then
		self._btnPropQueue_txtNum.text = self._gameCtrl:getPropCount(NPGEnum.Prop_Queue)
		self._btnPropUniversalCard_txtNum.text = self._gameCtrl:getPropCount(NPGEnum.Prop_UniversalCard)
		self._btnPropKnock_txtNum.text = self._gameCtrl:getPropCount(NPGEnum.Prop_Knock)

		local result = self._gameCtrl:getTryUsePropQueueResultAndTips()
		local isCanUsePropQueue = result == NPGEnum.ResultCode_Success

		GameUtil.setUIGroupIdx(self._btnPropQueue, isCanUsePropQueue and 0 or 1)

		result = self._gameCtrl:getTryUsePropUniversalCardResultAndTips()

		local isCanUseUsePropUniversalCard = result == NPGEnum.ResultCode_Success

		GameUtil.setUIGroupIdx(self._btnPropUniversalCard, isCanUseUsePropUniversalCard and 0 or 1)

		result = self._gameCtrl:getTryUsePropKnockResultAndTips()

		local isCanUseUsePropKnock = result == NPGEnum.ResultCode_Success

		GameUtil.setUIGroupIdx(self._btnPropKnock, isCanUseUsePropKnock and 0 or 1)
	end
end

function NumberPuzzleGameSceneView:_clearGameView()
	self._doingRecordId = 0

	self:_clearRecordOfQueue()
	self:_clearAllSequence()
	self:_onClearMap()
end

function NumberPuzzleGameSceneView:_doRecord(recordId)
	recordId = checknumber(recordId)

	if recordId <= 0 then
		return
	end

	self:_pushRecordOfQueue(recordId)
	self:_doNextRecord()
end

function NumberPuzzleGameSceneView:_doNextRecord()
	local recordId = self:_popRecordOfQueue() or 0

	if recordId <= 0 then
		return
	end

	self:_clearSequenceOfMotion()

	self._doingRecordId = recordId

	local motionRecord = self:_getMotionRecord(recordId)

	for _, motionMo in ipairs(motionRecord) do
		self:_doMotion(motionMo)
	end

	local sequence = self:_getSequenceOfMotion()

	sequence:AppendCallback(function()
		self:_doRecordEnd()
	end)
end

function NumberPuzzleGameSceneView:_doRecordEnd()
	self:_resumeAnimSpeed()

	self._doingRecordId = 0

	self:_onUpdate()

	local result = self:_checkGameOver()

	if result == NPGEnum.ResultCode_GameRuning then
		self:_doNextRecord()
	end
end

function NumberPuzzleGameSceneView:_isDoingRecord()
	return self._doingRecordId > 0
end

function NumberPuzzleGameSceneView:_pushRecordOfQueue(recordId)
	self._recordQueue:PushBack(recordId)
end

function NumberPuzzleGameSceneView:_popRecordOfQueue()
	return self._recordQueue:PopFront()
end

function NumberPuzzleGameSceneView:_clearRecordOfQueue()
	self._recordQueue:Clear()
end

function NumberPuzzleGameSceneView:_onTicking()
	self._deltaTime = UnityEngine.Time.deltaTime

	self._gameCtrl:onTicking(self._deltaTime)

	self._state = self._gameCtrl:getCurState()

	if self._state == NPGEnum.State_Runing then
		-- block empty
	elseif self._state == NPGEnum.State_Stoping then
		-- block empty
	elseif state == NPGEnum.State_Ended then
		-- block empty
	end

	self:_onTickingTestUI()
end

function NumberPuzzleGameSceneView:_onInitGameCtrl()
	self._doingRecordId = 0
	self._recordQueue = self._recordQueue or Array.New()

	self:_clearRecordOfQueue()

	self._gameCtrl = NumberPuzzleGameModel.instance:getNumberPuzzleGameCtrl(self._mapId)

	self._gameCtrl._detailMo:setMaxTotalScoreLimit(self._maxTotalScoreLimit)
	self._gameCtrl._detailMo:setGameMode(self._gameMode)
	self._gameCtrl._detailMo:setStartUpEnergy(self._startUpEnergy)

	local result = self._gameCtrl:getGameStateResultAndTips()

	if result ~= NPGEnum.ResultCode_GameRuning then
		self._gameCtrl:resetGame()
	end
end

function NumberPuzzleGameSceneView:_resetGame()
	self:_clearGameView()
	self._gameCtrl:resetGame()
	self:_onInitMapUI()
	self:_onUpdate()
end

function NumberPuzzleGameSceneView:_selectGame(mapId)
	self._mapId = mapId

	self:_clearGameView()
	self:_onInitGameCtrl()
	self:_continueGame()
end

function NumberPuzzleGameSceneView:_stopGame()
	self:_pauseSequenceOfMotion()
	self._gameCtrl:stopGame()
end

function NumberPuzzleGameSceneView:_continueGame()
	self._gameCtrl:continueGame()
	self:_onInitMapUI()
	self:_onUpdate()
	self:_resumeSequenceOfMotion()
end

function NumberPuzzleGameSceneView:_endGame(result)
	if result == NPGEnum.ResultCode_GameOverOfDropOut then
		self:_stopGame()
	else
		self._gameCtrl:endGame()
	end

	self._npgViewParam:doGameEndCallBack(result, self._gameCtrl)
end

function NumberPuzzleGameSceneView:_onInitMapUI()
	self:_onResetPointView()
	self:_onResetGridView()
	self:_setActiveOfDragPlane(true)
end

function NumberPuzzleGameSceneView:_onClearMap()
	self:_onClearPointView()
	self:_onClearGridView()
end

function NumberPuzzleGameSceneView:_doMotion(motionMo)
	local motionType = motionMo:getMotionType()
	local motionParam = motionMo:getParam()

	if motionType == NPGEnum.Motion_Move then
		self:_doMotionOfMove(GameUtil.unpack10(motionParam))
	elseif motionType == NPGEnum.Motion_Merge then
		self:_doMotionOfMerge(GameUtil.unpack10(motionParam))
	elseif motionType == NPGEnum.Motion_Create then
		self:_doMotionOfCreate(GameUtil.unpack10(motionParam))
	elseif motionType == NPGEnum.Motion_Destroy then
		self:_doMotionOfDestroy(GameUtil.unpack10(motionParam))
	elseif motionType == NPGEnum.Motion_Queue then
		self:_doMotionOfQueue(GameUtil.unpack10(motionParam))
	elseif motionType == NPGEnum.Motion_UniversalCard then
		self:_doMotionOfUniversalCard(GameUtil.unpack10(motionParam))
	elseif motionType == NPGEnum.Motion_Knock then
		self:_doMotionOfKnock(GameUtil.unpack10(motionParam))
	end
end

function NumberPuzzleGameSceneView:_doMotionOfMove(formGridIndex, toGridIndex)
	local formCell = self:_getGridCell(formGridIndex)

	self:_setGridCell(formGridIndex, nil)
	self:_setGridCell(toGridIndex, formCell)

	local formPos = self:_getPointPos(formGridIndex)
	local toPos = self:_getPointPos(toGridIndex)

	self:_doAnimOfMove(formCell, formPos, toPos)
end

function NumberPuzzleGameSceneView:_doMotionOfMerge(formGridIndex, toGridIndex, beforeMergeGridId, afterMergeGridId)
	local formCell = self:_getGridCell(formGridIndex)
	local toCell = self:_getGridCell(toGridIndex)

	self:_setGridCell(formGridIndex, nil)
	self:_setGridCell(toGridIndex, nil)

	local newCell = self:_addGridCellByIndex(toGridIndex)

	self:_updateGridCellUI(newCell, afterMergeGridId)

	local formPos = self:_getPointPos(formGridIndex)
	local toPos = self:_getPointPos(toGridIndex)
	local toward = self:_getToWard(formPos, toPos)
	local distance = Vector2.Distance(formPos, toPos)
	local speedRatio = 3
	local moveDuration = distance / speedRatio

	formCell:setPos(formPos.x, formPos.y, formPos.z)
	newCell:setActive(false)

	local tweenerMove = formCell:getGameObject().transform:DOMove(toPos, moveDuration)

	tweenerMove:SetEase(DG.Tweening.Ease.Linear)
	tweenerMove:OnComplete(function()
		self:_removeGridCell(toCell)
	end)

	local punchRotation = Vector2.New()
	local fudu = 30

	if toward == NPGEnum.ToUp then
		punchRotation:Set(fudu, 0)
	elseif toward == NPGEnum.ToDown then
		punchRotation:Set(-fudu, 0)
	elseif toward == NPGEnum.ToLeft then
		punchRotation:Set(0, fudu)
	elseif toward == NPGEnum.ToRight then
		punchRotation:Set(0, -fudu)
	end

	local punchDuration = moveDuration + 0.1
	local tweenerPunchRotation = formCell:getGameObject().transform:DOPunchRotation(punchRotation, punchDuration, 1, 0)

	tweenerPunchRotation:SetEase(DG.Tweening.Ease.InElastic)
	tweenerPunchRotation:OnComplete(function()
		self:_removeGridCell(formCell)
		newCell:setActive(true)
	end)

	local sequence = self:_getSequenceOfMotion()

	sequence:Join(tweenerMove)
	sequence:Join(tweenerPunchRotation)
end

function NumberPuzzleGameSceneView:_doMotionOfCreate(gridIndex, gridId)
	local cell = self:_addGridCellByIndex(gridIndex)

	self:_updateGridCellUI(cell, gridId)
	cell:setActive(false)

	local mainGo = cell:getGameObject()
	local toPos = self:_getPointPos(gridIndex)
	local finishCallback

	self:_doAnimOfCreate(cell, toPos)
end

function NumberPuzzleGameSceneView:_doMotionOfDestroy(gridIndex, gridId)
	local cell = self:_getGridCell(gridIndex)

	self:_setGridCell(gridIndex, nil)

	local startCallback

	local function finishCallback()
		cell:setActive(false)
		self:_removeGridCell(cell)
	end

	self:_doAnimOfDestroy(cell, 0, startCallback, finishCallback)
end

function NumberPuzzleGameSceneView:_doMotionOfQueue(beforeQueue, afterQueue, isReverse)
	local sequence = self:_getSequenceOfMotion()

	for gridIndex, gridId in ipairs(beforeQueue) do
		if not self._gameCtrl._mapCtrl:isEmptyGridById(gridId) then
			local cell = self:_getGridCell(gridIndex)

			self:_setGridCell(gridIndex, nil)

			local startCallback

			local function finishCallback()
				cell:setActive(false)
				self:_removeGridCell(cell)
			end

			self:_doAnimOfDestroy(cell, 0, startCallback, finishCallback)
		end
	end

	sequence:AppendInterval(0)

	local gridCount = self:_getGridCount()
	local rowCount = self:_getRowCount()
	local colCount = self:_getColCount()
	local startY, endY, deltaY = 0, 0, 0
	local startX, endX, deltaX = 0, 0, 0

	if isReverse then
		deltaY = -1
		endY = 1
		startY = rowCount
	else
		deltaY = 1
		endY = rowCount
		startY = 1
	end

	for y = startY, endY, deltaY do
		if isReverse then
			if y % 2 == 1 then
				deltaX = -1
				endX = 1
				startX = colCount
			else
				deltaX = 1
				endX = colCount
				startX = 1
			end
		elseif y % 2 == 1 then
			deltaX = 1
			endX = colCount
			startX = 1
		else
			deltaX = -1
			endX = 1
			startX = colCount
		end

		for x = startX, endX, deltaX do
			local gridIndex = self:_getGridIndex(x, y)
			local gridId = afterQueue[gridIndex]

			if not self._gameCtrl._mapCtrl:isEmptyGridById(gridId) then
				local cell = self:_addGridCellByIndex(gridIndex)

				self:_updateGridCellUI(cell, gridId)

				local mainGo = cell:getGameObject()
				local toPos = self:_getPointPos(gridIndex)
				local finishCallback

				self:_doAnimOfCreate(cell, toPos)
				sequence:AppendInterval(0)
			end
		end
	end
end

function NumberPuzzleGameSceneView:_doMotionOfUniversalCard(gridIndex, gridId)
	local cell = self:_addGridCellByIndex(gridIndex)

	self:_updateGridCellUI(cell, gridId)
	cell:setActive(false)

	local mainGo = cell:getGameObject()
	local toPos = self:_getPointPos(gridIndex)
	local finishCallback

	self:_doAnimOfCreate(cell, toPos)
end

function NumberPuzzleGameSceneView:_doMotionOfKnock(gridIndexList)
	local list = {}

	table.insertto(list, gridIndexList)

	for i = 1, #list do
		local ranIdx = Mathf.Random(i, #list)

		list[i] = list[ranIdx]
		list[ranIdx] = list[i]
	end

	local delay = 0

	for _, gridIndex in ipairs(list) do
		local cell = self:_getGridCell(gridIndex)

		self:_setGridCell(gridIndex, nil)

		local startCallback

		local function finishCallback()
			cell:setActive(false)
			self:_removeGridCell(cell)
		end

		local delay = Mathf.Min(delay + 0.03, 0.2)

		self:_doAnimOfDestroy(cell, delay, startCallback, finishCallback)
	end
end

function NumberPuzzleGameSceneView:_doMotionOfRefuseOp(toward)
	local rowCount = self:_getRowCount()
	local colCount = self:_getColCount()

	for x = 1, colCount do
		for y = 1, rowCount do
			local gridIndex = self:_getGridIndex(x, y)
			local gridId = self:_getGridId(x, y)

			if not self._gameCtrl._mapCtrl:isEmptyGridById(gridId) then
				local cell = self:_getGridCell(gridIndex)

				self:_doAnimOfRefuseOp(cell, toward)
			end
		end
	end
end

function NumberPuzzleGameSceneView:_setActiveOfDragPlane(isActive)
	GameUtil.SetActive(self._dragPlane, isActive)
end

function NumberPuzzleGameSceneView:_onResetPointView()
	local rowCount = self:_getRowCount()
	local colCount = self:_getColCount()
	local gridCount = self:_getGridCount()
	local partentTran = self._pointView.transform
	local childGo = self._pointCell
	local pointPrefabSize = Vector2.New(GameUtil.getWidth(self._pointCell), GameUtil.getHeight(self._pointCell))
	local boardSize = Vector2.New(GameUtil.getWidth(partentTran), GameUtil.getHeight(partentTran))
	local pointSpacing = Vector2.New(pointPrefabSize.x * (0.25 / colCount), pointPrefabSize.y * (0.25 / rowCount))
	local tempPointSizeX = (boardSize.x - (colCount - 1) * pointSpacing.x) / colCount
	local tempPointSizeY = (boardSize.y - (rowCount - 1) * pointSpacing.y) / rowCount
	local pointSize = pointPrefabSize:Clone()

	if tempPointSizeX < pointPrefabSize.x or tempPointSizeY < pointPrefabSize.y then
		local ratX = tempPointSizeX / pointPrefabSize.x
		local ratY = tempPointSizeY / pointPrefabSize.y
		local rat = Mathf.Min(ratX, ratY)

		pointSize:Set(pointPrefabSize.x * rat, pointPrefabSize.y * rat)
	end

	local gridPrefabSize = Vector2.New(GameUtil.getWidth(self._gridCell), GameUtil.getHeight(self._gridCell))
	local gridSize = Vector2.New(pointSize.x / (pointPrefabSize.x / gridPrefabSize.x), pointSize.y / (pointPrefabSize.y / gridPrefabSize.y))

	self._defaultGridCellScale = Vector3.New(gridSize.x / gridPrefabSize.x, gridSize.y / gridPrefabSize.y, 1)

	local children = GameUtil.getChildren(partentTran)

	for idx, go in ipairs(children) do
		GameUtil.SetActive(go, false)
	end

	self._pointCellMap = self._pointCellMap or {}

	self:_onClearPointView()

	local x, y = 0, 0

	for gridIndex = 1, gridCount do
		x, y = self:_getGridCoord(gridIndex)

		if not children[gridIndex] then
			local mainGo = goutil.cloneAndSetParent(childGo, partentTran, string.format("%s_%s_(%s,%s)", childGo.name, gridIndex, x, y))

			if not self._pointCellMap[children[gridIndex]] then
				local cell = {}

				if cell._mainGo == nil then
					cell._mainGo = children[gridIndex]
				end

				self._pointCellMap[gridIndex] = cell

				GameUtil.SetActive(cell._mainGo, true)
			end
		end
	end

	self._pointViewLayoutGroup.constraintCount = rowCount
	self._pointViewLayoutGroup.cellSize = pointSize
	self._pointViewLayoutGroup.spacing = pointSpacing

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(partentTran:GetComponent(goutil.Type_RectTransform))
end

function NumberPuzzleGameSceneView:_onClearPointView()
	if self._pointCellMap then
		for gridIndex, cell in pairs(self._pointCellMap) do
			self:_clearPointCell(cell)

			self._pointCellMap[gridIndex] = nil
		end
	end
end

function NumberPuzzleGameSceneView:_updatePointCell(cell, gridIndex)
	return
end

function NumberPuzzleGameSceneView:_clearPointCell(cell)
	return
end

function NumberPuzzleGameSceneView:_getPointCell(gridIndex)
	return self._pointCellMap[gridIndex]
end

function NumberPuzzleGameSceneView:_getPointScale(gridIndex)
	return GameUtil.getLocalScale(self:_getPointCell(gridIndex)._mainGo)
end

function NumberPuzzleGameSceneView:_getPointPos(gridIndex)
	return GameUtil.getPos(self:_getPointCell(gridIndex)._mainGo)
end

function NumberPuzzleGameSceneView:_onResetGridView()
	self._gridCellMap = self._gridCellMap or {}

	self:_onClearGridView()

	local x, y = 0, 0
	local gridId = 0
	local gridCount = self:_getGridCount()
	local cell

	for gridIndex = 1, gridCount do
		local var_60_0, var_60_1 = self:_getGridCoord(gridIndex)

		gridId = self:_getGridId(var_60_0, var_60_1)

		if not self._gameCtrl._mapCtrl:isEmptyGridById(gridId) then
			self:_updateGridCellUI(self:_addGridCellByIndex(gridIndex), gridId)
		end
	end
end

function NumberPuzzleGameSceneView:_onClearGridView()
	if self._gridCellMap then
		for gridIndex, cell in pairs(self._gridCellMap) do
			self:_removeGridCellByIndex(gridIndex)
		end
	end

	self:_onClearGridCellPool()
end

function NumberPuzzleGameSceneView:_updateGridCellUI(cell, gridId)
	local data = NumberPuzzleGameConfig.instance:getNpgGridLibData(self._mapId, gridId)

	if data == nil then
		printError(string.format("缺失配置( mapId=%s, gridId=%s | export_格子库 )", self._mapId, gridId))
		self:_clearGridCellUI(cell)

		return
	end

	cell:_loadIcon(data.iconPath)
	cell:setName(data.name)
end

function NumberPuzzleGameSceneView:_clearGridCellUI(cell)
	cell:_unLoadIcon()
	GameUtil.rmClickHandler(cell:getGameObject())
end

function NumberPuzzleGameSceneView:_addGridCellByIndex(gridIndex)
	local cell = self:_getGridCell(gridIndex)

	if cell == nil then
		cell = self:_fetchGridCell(gridIndex)
	end

	local mainGo = cell:getGameObject()

	goutil.addChildToParent(mainGo, self._gridView)

	local pos = self:_getPointPos(gridIndex)

	cell:setPos(pos.x, pos.y, pos.z)
	cell:setActive(true)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickGridCell, self, cell, gridIndex))
	self:_setGridCell(gridIndex, cell)
	cell:initDefaultLocalScale(self._defaultGridCellScale:Get())
	cell:resetLocalScale()

	return cell
end

function NumberPuzzleGameSceneView:_removeGridCellByIndex(gridIndex)
	local cell = self:_getGridCell(gridIndex)

	self:_removeGridCell(cell)
	self:_setGridCell(gridIndex, nil)
end

function NumberPuzzleGameSceneView:_removeGridCell(cell)
	if cell == nil then
		return
	end

	self:_clearTweenerOfGo(cell._mainGo)
	self:_clearGridCellUI(cell)
	cell:resetLocalScale()
	self:_returnGridCell(cell)
end

function NumberPuzzleGameSceneView:_onClickGridCell(cell, gridIndex)
	return
end

function NumberPuzzleGameSceneView:_getGridCellIndex(cell)
	local gridIndex = 0

	for k, v in pairs(self._gridCellMap) do
		if v == cell then
			gridIndex = k

			break
		end
	end

	return gridIndex
end

function NumberPuzzleGameSceneView:_getGridCell(gridIndex)
	return self._gridCellMap[gridIndex]
end

function NumberPuzzleGameSceneView:_setGridCell(gridIndex, cell)
	self._gridCellMap[gridIndex] = cell
end

function NumberPuzzleGameSceneView:_fetchGridCell()
	if self._gridCellObjPoolCtrl == nil then
		self._gridCellObjPoolCtrl = self:_creatGridCellPoolCtrl()
	end

	return self._gridCellObjPoolCtrl:fetchGridCell()
end

function NumberPuzzleGameSceneView:_returnGridCell(cell)
	self._gridCellObjPoolCtrl:returnGridCell(cell)
end

function NumberPuzzleGameSceneView:_creatGridCellPoolCtrl()
	return NPGGridCellObjPoolCtrl.New(self._gridCell, self._gridPool)
end

function NumberPuzzleGameSceneView:_onClearGridCellPool()
	if self._gridCellObjPoolCtrl then
		self._gridCellObjPoolCtrl:clear()
	end
end

function NumberPuzzleGameSceneView:_onDestroyGridCellPool()
	if self._gridCellObjPoolCtrl then
		self._gridCellObjPoolCtrl:destroy()

		self._gridCellObjPoolCtrl = nil
	end
end

function NumberPuzzleGameSceneView:_doMergetMap(toward)
	local result, tips = self._gameCtrl:getTryMergeMapResultAndTips()

	if result ~= NPGEnum.ResultCode_Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	result = self._gameCtrl:doMergeMap(toward)

	if result == NPGEnum.ResultCode_Success then
		local recordId = self:_getCurRecordId()

		self:_doRecord(recordId)
	else
		self:_doMotionOfRefuseOp(toward)
	end
end

function NumberPuzzleGameSceneView:_doAddRadomGrid(count)
	local result, tips = self._gameCtrl:getTryAddRadomGridResultAndTips()

	if result ~= NPGEnum.ResultCode_Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	result = self._gameCtrl:doAddRadomGrid(count)

	if result == NPGEnum.ResultCode_Success then
		local recordId = self:_getCurRecordId()

		self:_doRecord(recordId)
	end
end

function NumberPuzzleGameSceneView:_onClickBtnQueue()
	local result, tips = self:_getDoPlayResultAndTips()

	if result ~= GameEnum.ResultCode.Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	local result, tips = self._gameCtrl:getTryUsePropQueueResultAndTips()

	if result ~= NPGEnum.ResultCode_Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	self._isRev = not self._isRev
	result = self._gameCtrl:usePropQueue(self._isRev)

	if result == NPGEnum.ResultCode_Success then
		local recordId = self:_getCurRecordId()

		self:_doRecord(recordId)
	end
end

function NumberPuzzleGameSceneView:_onClickBtnUniversalCard()
	local result, tips = self:_getDoPlayResultAndTips()

	if result ~= GameEnum.ResultCode.Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	local result, tips = self._gameCtrl:getTryUsePropUniversalCardResultAndTips()

	if result ~= NPGEnum.ResultCode_Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	result = self._gameCtrl:usePropUniversalCard()

	if result == NPGEnum.ResultCode_Success then
		local recordId = self:_getCurRecordId()

		self:_doRecord(recordId)
	end
end

function NumberPuzzleGameSceneView:_onClickBtnKnock()
	local result, tips = self:_getDoPlayResultAndTips()

	if result ~= GameEnum.ResultCode.Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	local result, tips = self._gameCtrl:getTryUsePropKnockResultAndTips()

	if result ~= NPGEnum.ResultCode_Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	result = self._gameCtrl:usePropKnock()

	if result == NPGEnum.ResultCode_Success then
		local recordId = self:_getCurRecordId()

		self:_doRecord(recordId)
	end
end

function NumberPuzzleGameSceneView:_checkGameOver()
	local result = self._gameCtrl:getGameStateResultAndTips()

	if result == NPGEnum.ResultCode_GameRuning then
		-- block empty
	elseif result == NPGEnum.ResultCode_GameOverOfSuccess then
		self:_endGame(NPGEnum.ResultCode_GameOverOfSuccess)
	elseif result == NPGEnum.ResultCode_GameOverOfFail then
		self:_endGame(NPGEnum.ResultCode_GameOverOfFail)
	end

	return result
end

function NumberPuzzleGameSceneView:_getGridId(x, y)
	return self._gameCtrl._mapCtrl:getGridId(x, y)
end

function NumberPuzzleGameSceneView:_getGridCount()
	return self._gameCtrl._mapCtrl._mapMoOfRun:getGridCount()
end

function NumberPuzzleGameSceneView:_getRowCount()
	return self._gameCtrl._mapCtrl._mapMoOfRun:getRowCount()
end

function NumberPuzzleGameSceneView:_getColCount()
	return self._gameCtrl._mapCtrl._mapMoOfRun:getColCount()
end

function NumberPuzzleGameSceneView:_getGridCoord(gridIndex)
	return self._gameCtrl._mapCtrl._mapMoOfRun:getGridCoord(gridIndex)
end

function NumberPuzzleGameSceneView:_getGridIndex(x, y)
	return self._gameCtrl._mapCtrl._mapMoOfRun:getGridIndex(x, y)
end

function NumberPuzzleGameSceneView:_getCurRecordId()
	return self._gameCtrl._mapCtrl:getCurRecordId()
end

function NumberPuzzleGameSceneView:_getMotionRecord(recordId)
	return self._gameCtrl._mapCtrl:getMotionRecord(recordId)
end

function NumberPuzzleGameSceneView:_doAnimOfMove(cell, formPos, toPos)
	local mainGo = cell:getGameObject()
	local toward = self:_getToWard(formPos, toPos)
	local distance = Vector2.Distance(formPos, toPos)
	local speedRatio = 3
	local moveDuration = distance / speedRatio

	cell:setPos(formPos.x, formPos.y, formPos.z)

	local tweenerMove = mainGo.transform:DOMove(toPos, moveDuration)

	tweenerMove:SetEase(DG.Tweening.Ease.Linear)

	local punchRotation = Vector2.New()
	local fudu = 30

	if toward == NPGEnum.ToUp then
		punchRotation:Set(fudu, 0)
	elseif toward == NPGEnum.ToDown then
		punchRotation:Set(-fudu, 0)
	elseif toward == NPGEnum.ToLeft then
		punchRotation:Set(0, fudu)
	elseif toward == NPGEnum.ToRight then
		punchRotation:Set(0, -fudu)
	end

	local punchDuration = moveDuration + 0.1
	local tweenerPunchRotation = cell:getGameObject().transform:DOPunchRotation(punchRotation, punchDuration, 1, 0)

	tweenerPunchRotation:SetEase(DG.Tweening.Ease.InElastic)

	local sequence = self:_getSequenceOfMotion()

	sequence:Join(tweenerMove)
	sequence:Join(tweenerPunchRotation)
end

function NumberPuzzleGameSceneView:_getToWard(formPos, toPos)
	local offsetX = toPos.x - formPos.x
	local offsetY = toPos.y - formPos.y
	local toward

	return Mathf.Abs(offsetY) > Mathf.Abs(offsetX) and (offsetY > 0 and NPGEnum.ToUp or NPGEnum.ToDown) or offsetX > 0 and NPGEnum.ToRight or NPGEnum.ToLeft
end

function NumberPuzzleGameSceneView:_doAnimOfCreate(cell, toPos)
	local mainGo = cell:getGameObject()
	local scaleRatio = 2
	local toScale = Vector3.New(cell:getDefaultLocalScale())
	local formScale = toScale:Clone():Mul(scaleRatio)
	local formPos = self:_getFromPosOfCreate(toPos)
	local distance = Vector2.Distance(formPos, toPos)
	local speedRatio = 2
	local duration = distance / speedRatio

	cell:setPos(formPos:Get())
	cell:setLocalScale(formScale:Get())
	cell:setActive(true)

	local tweenerOfMove = mainGo.transform:DOMove(toPos, duration)

	tweenerOfMove:SetEase(DG.Tweening.Ease.Linear)

	local tweenerOfScale = mainGo.transform:DOScale(toScale, duration)

	tweenerOfScale:SetEase(DG.Tweening.Ease.OutQuad)

	local sequence = self:_getSequenceOfMotion()

	sequence:Join(tweenerOfMove)
	sequence:Join(tweenerOfScale)
end

function NumberPuzzleGameSceneView:_getFromPosOfCreate(toPos)
	local formPos = Vector2.New(0, 0)
	local tempPos = Vector2.New(0, 0)
	local minDistance, tempDistance = nil, 0

	for _, pointGo in ipairs(self._createPointList) do
		tempPos:Set(Framework.TransformUtil.GetPos(pointGo.transform, 0, 0, 0))

		tempDistance = Vector2.Distance(tempPos, toPos)

		if minDistance == nil or tempDistance < minDistance then
			minDistance = tempDistance

			formPos:Set(tempPos.x, tempPos.y)
		end
	end

	return formPos
end

function NumberPuzzleGameSceneView:_doAnimOfDestroy(cell, delay, startCallback, finishCallback)
	local mainGo = cell:getGameObject()

	cell:setActive(true)

	local duration = 0.3
	local punchX, punchY = Mathf.Random(1, 5), Mathf.Random(1, 5)
	local tweenerPunchPos = mainGo.transform:DOPunchPosition(Vector2.New(punchX, punchY, 0), duration, 4, 0)

	tweenerPunchPos:SetDelay(delay)

	local originScale = cell:getLocalScale()
	local tweenerScale = mainGo.transform:DOScale(originScale:Clone():Mul(1.1), duration)

	tweenerScale:OnStart(function()
		GameUtil.callBack(startCallback)
	end)
	tweenerScale:OnComplete(function()
		cell:setLocalScale(originScale:Get())
		GameUtil.callBack(finishCallback)
	end)
	tweenerScale:SetEase(DG.Tweening.Ease.OutQuad)
	tweenerScale:SetDelay(delay)

	local sequence = self:_getSequenceOfMotion()

	sequence:Join(tweenerPunchPos)
	sequence:Join(tweenerScale)
end

function NumberPuzzleGameSceneView:_doAnimOfRefuseOp(cell, toward)
	local mainGo = cell:getGameObject()
	local punchRotation = Vector2.New()
	local fudu = 15

	if toward == NPGEnum.ToUp then
		punchRotation:Set(fudu, 0)
	elseif toward == NPGEnum.ToDown then
		punchRotation:Set(-fudu, 0)
	elseif toward == NPGEnum.ToLeft then
		punchRotation:Set(0, fudu)
	elseif toward == NPGEnum.ToRight then
		punchRotation:Set(0, -fudu)
	end

	local punchDuration = 0.3
	local tweenerPunchRotation = cell:getGameObject().transform:DOPunchRotation(punchRotation, punchDuration, 1, 0)

	tweenerPunchRotation:SetEase(DG.Tweening.Ease.InElastic)
	tweenerPunchRotation:OnComplete(function()
		GameUtil.setLocalRotation(cell:getGameObject(), 0, 0, 0)
	end)

	local sequence = self:_getSequenceOfMotion()

	sequence:Join(tweenerPunchRotation)
end

function NumberPuzzleGameSceneView:_getSequenceOfMotion()
	return self:_getSequence(NPGEnum.SequenceKey_Motion)
end

function NumberPuzzleGameSceneView:_clearSequenceOfMotion()
	self:_clearSequence(NPGEnum.SequenceKey_Motion)
end

function NumberPuzzleGameSceneView:_resumeSequenceOfMotion()
	self:_resumeSequence(NPGEnum.SequenceKey_Motion)
end

function NumberPuzzleGameSceneView:_pauseSequenceOfMotion()
	self:_pauseSequence(NPGEnum.SequenceKey_Motion)
end

function NumberPuzzleGameSceneView:_getSequence(key)
	if self._sequencePool == nil then
		self._sequencePool = {}
	end

	if self._sequencePool[key] == nil then
		self._sequencePool[key] = DG.Tweening.DOTween.Sequence()
	end

	return self._sequencePool[key]
end

function NumberPuzzleGameSceneView:_clearAllSequence()
	if self._sequencePool then
		for key, sequence in pairs(self._sequencePool) do
			self:_clearSequence(key)
		end
	end
end

function NumberPuzzleGameSceneView:_resumeAllSequence()
	if self._sequencePool then
		for key, sequence in pairs(self._sequencePool) do
			sequence:Play()
		end
	end
end

function NumberPuzzleGameSceneView:_pauseAllSequence()
	if self._sequencePool then
		for key, sequence in pairs(self._sequencePool) do
			sequence:Pause()
		end
	end
end

function NumberPuzzleGameSceneView:_clearSequence(key)
	if self._sequencePool and self._sequencePool[key] then
		self._sequencePool[key]:Kill(true)

		self._sequencePool[key] = nil
	end
end

function NumberPuzzleGameSceneView:_resumeSequence(key)
	if self._sequencePool then
		if self._sequencePool then
			self._sequencePool:Play()
		end
	end
end

function NumberPuzzleGameSceneView:_pauseSequence(key)
	if self._sequencePool then
		if self._sequencePool then
			self._sequencePool:Pause()
		end
	end
end

function NumberPuzzleGameSceneView:_clearTweenerOfGo(mainGo)
	mainGo.transform:DOKill(true)
end

function NumberPuzzleGameSceneView:_changeAnimSpeed(speed)
	DG.Tweening.DOTween.timeScale = speed
end

function NumberPuzzleGameSceneView:_resumeAnimSpeed()
	self:_changeAnimSpeed(1)
end

function NumberPuzzleGameSceneView:_getDoPlayResultAndTips()
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local state = self._gameCtrl:getCurState()

	if self:_isDoingRecord() then
		result = GameEnum.ResultCode.Success
	elseif state == NPGEnum.State_Runing then
		-- block empty
	elseif state == NPGEnum.State_Stoping then
		result = GameEnum.ResultCode.Error
		tips = "游戏已暂停"
	elseif state == NPGEnum.State_Ended then
		result = GameEnum.ResultCode.Error
		tips = "游戏已结束"
	end

	return result, tips
end

function NumberPuzzleGameSceneView:_onBeginDragHandler(go, eventData)
	self._isDragging = true
	self._beginDragPos = eventData.position
end

function NumberPuzzleGameSceneView:_onEndDragHandler(go, eventData)
	local result, tips = self:_getDoPlayResultAndTips()

	if result ~= GameEnum.ResultCode.Success then
		if result == GameEnum.ResultCode.IsDoingAnim then
			self:_changeAnimSpeed(2)
		end

		FloatWordMgr.instance:show(tips)

		return
	end

	local endBeginDragPos = eventData.position
	local toward = self:_getToWard(self._beginDragPos, endBeginDragPos)

	self:_doMergetMap(toward)
end

function NumberPuzzleGameSceneView:_onDragHandler(go, eventData)
	return
end

function NumberPuzzleGameSceneView:_onClickBtnTip()
	local key = DivineKingDragonChallengeConfig.instance:getDkdCommonValue(self._activityId, "GODKINGDRAGONCHALLENGE_RULE_MAIN_KEY", false)

	TipsFacade.instance:openRulesView(key)
end

function NumberPuzzleGameSceneView:_onClickBtnClose()
	self:_stopGame()
	self:_endGame(NPGEnum.ResultCode_GameOverOfDropOut)
end

function NumberPuzzleGameSceneView:_onClickBtnReset()
	self:_endGame(NPGEnum.ResultCode_GameOverFailAndReset)
end

function NumberPuzzleGameSceneView:_onUpdateTestCol()
	GameUtil.SetActive(self._testCol_mainGo, self._isTestMode)

	if not self._isTestMode then
		return
	end

	local comp = self._testCol_dropdownComp

	comp:RemoveOnValueChanged()
	comp:ClearOptions()

	local options = {}

	options[0] = "选择地图"

	local dataList = NumberPuzzleGameConfig.instance:getNpgMapDataList()

	if dataList then
		for i = 0, #dataList do
			local data = dataList[i]

			if data then
				table.insert(options, data.mapId)
			end
		end
	end

	for i = 0, #options do
		comp:AddOptions(options[i])
	end

	comp:AddOnValueChanged(function(handler, index)
		local value = checknumber(options[index])
		local data = NumberPuzzleGameConfig.instance:getNpgMapData(value)

		if data then
			self:_selectGame(value)
		end
	end, self)
	comp:SetValue(0)
end

function NumberPuzzleGameSceneView:_onTickingTestUI()
	if not self._isTestMode then
		return
	end

	local str = {}

	str[1] = "测试："
	str[2] = string.format("\n当前地图Id：%s", self._mapId)
	str[3] = string.format("\n当前游戏时间：%.1fs", self._gameCtrl:getCurGameTime())
	str[4] = string.format("\n当前State：%s", self._gameCtrl:getCurState())

	local fs = ""

	for i = 1, #str do
		fs = fs .. str[i]
	end

	self._testCol_txtTest.text = fs
end

function NumberPuzzleGameSceneView:_onClickBtnTest(idx)
	if not self._isTestMode then
		FloatWordMgr.instance:show("非测试模式无法使用")

		return
	end

	if idx == 1 then
		self:_resetGame()
	elseif idx == 2 then
		self:_continueGame()
	elseif idx == 3 then
		self:_stopGame()
	elseif idx == 4 then
		self:_endGame(NPGEnum.ResultCode_GameOverOfSuccess)
	elseif idx == 5 then
		self._gameCtrl:randomAddProp(10)
		self:_onUpdate()
	elseif idx == 6 then
		self._isIgnoreUsePropLimitInRecord = not self._isIgnoreUsePropLimitInRecord

		self._gameCtrl:setIgnoreUsePropLimitInRecord(self._isIgnoreUsePropLimitInRecord)
		self:_onUpdate()
	elseif idx == 7 then
		local result, tips = self:_getDoPlayResultAndTips()

		if result ~= GameEnum.ResultCode.Success then
			if result == GameEnum.ResultCode.IsDoingAnim then
				self:_changeAnimSpeed(2)
			end

			FloatWordMgr.instance:show(tips)

			return
		end

		self:_doAddRadomGrid(4)
	elseif idx == 8 then
		local score = self._gameCtrl._detailMo:getTotalScore()

		self._gameCtrl._detailMo:addTotalScore(score)
		self:_onUpdate()
	elseif idx == 9 then
		self._gameCtrl._detailMo:updateLeftEnergy(20)
		self:_onUpdate()
	end
end

return NumberPuzzleGameSceneView
