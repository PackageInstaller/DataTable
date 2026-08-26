-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/controller/LengZhou6EliminateController.lua

module("modules.logic.versionactivity2_7.lengzhou6.controller.LengZhou6EliminateController", package.seeall)

local LengZhou6EliminateController = class("LengZhou6EliminateController", BaseController)

function LengZhou6EliminateController:onInit()
	return
end

function LengZhou6EliminateController:enterLevel(eliminateLevelId)
	self:initEliminateData(eliminateLevelId)
	self:resetCurEliminateCount()
end

function LengZhou6EliminateController:initEliminateData(eliminateLevelId)
	local recordData = LengZhou6GameModel.instance:getRecordServerData()
	local data = LengZhou6EliminateConfig.instance:getEliminateChessLevelConfig(eliminateLevelId)

	if recordData and recordData._data and recordData._data.chessData then
		local chessData = recordData._data.chessData

		if tabletool.len(chessData) > 0 then
			data = recordData._data.chessData
		end
	end

	LocalEliminateChessModel.instance:initByData(data)
end

function LengZhou6EliminateController:exchangeCell(posX, posY, targetX, targetY)
	self:recordExchangePos(posX, posY, targetX, targetY)
	LocalEliminateChessModel.instance:_exchangeCell(posX, posY, targetX, targetY)
	self:exchangeCellShow(posX, posY, targetX, targetY, EliminateEnum.AniTime.Move)

	local result = LocalEliminateChessModel.instance:exchangeCell(posX, posY, targetX, targetY, false)

	if not result then
		if #self._lastExchangePos > 0 then
			local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessRevert)

			self:buildSeqFlow(step)
		end
	else
		local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, true)

		self:buildSeqFlow(step)
	end

	return result
end

function LengZhou6EliminateController:revertRecord()
	local posX, posY, targetX, targetY = self:getRecordExchangePos()

	LocalEliminateChessModel.instance:_exchangeCell(posX, posY, targetX, targetY)
	self:exchangeCellShow(posX, posY, targetX, targetY, EliminateEnum.AniTime.MoveRevert)
	self:clearRecord()
	self:setFlowEndState(true)
end

function LengZhou6EliminateController:eliminateCheck(isRound)
	local haveEliminate = LocalEliminateChessModel.instance:check(true, false)

	if haveEliminate then
		LocalEliminateChessModel.instance:checkEliminate()
		self:handleEliminate()
		self:handleDrop()

		local showData = LocalEliminateChessModel.instance:getEliminateRecordShowData()

		showData:reset()

		local step

		if isDebugBuild then
			step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessDebug2_7)

			self:buildSeqFlow(step)
		end

		self:calCurEliminateCount()
		self:dispatchEvent(LengZhou6Event.ShowCombos, self._eliminateCount)
		LengZhou6GameController.instance:playerSettle()
		LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.addBuff)

		step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, isRound)

		self:buildSeqFlow(step)
	else
		LengZhou6GameController.instance:gameUpdateRound(isRound)

		local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessUpdateGameInfo)

		self:buildSeqFlow(step)
		self:setFlowEndState(true)
	end

	self:clearRecord()

	return haveEliminate
end

function LengZhou6EliminateController:calCurEliminateCount()
	local eliminateData = LocalEliminateChessModel.instance:getCurEliminateRecordData()
	local data = eliminateData:getEliminateTypeMap()
	local needAdd = true

	for _, _data in pairs(data) do
		local value = _data[1]

		if value ~= nil and value.eliminateType == EliminateEnum_2_7.eliminateType.base then
			needAdd = false

			break
		end

		if needAdd then
			self._eliminateCount = self._eliminateCount + #_data
		end
	end

	if not needAdd then
		self._eliminateCount = self._eliminateCount + 1
	end
end

function LengZhou6EliminateController:dispatchShowAssess()
	local assess

	for i = 1, #EliminateEnum_2_7.AssessLevel do
		local value = EliminateEnum_2_7.AssessLevel[i]

		if value <= self._eliminateCount then
			assess = i
		end
	end

	if assess ~= nil then
		self:dispatchEvent(LengZhou6Event.ShowAssess, assess)
	end

	return assess
end

function LengZhou6EliminateController:resetCurEliminateCount()
	self._eliminateCount = 0
end

function LengZhou6EliminateController:setDieType()
	return
end

function LengZhou6EliminateController:handleEliminate()
	local showData = LocalEliminateChessModel.instance:getEliminateRecordShowData()
	local changeType = showData:getChangeType()
	local eliminate = showData:getEliminate()
	local changeFlow = FlowParallel.New()
	local dieStepFlow = FlowParallel.New()
	local changeTypeCount = #changeType

	for i = 1, changeTypeCount / 3 do
		local x = changeType[i * 3 - 2]
		local y = changeType[i * 3 - 1]
		local fromState = changeType[i * 3]
		local data = {
			x = x,
			y = y,
			fromState = fromState
		}
		local updateStateWork = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ChangeState, data)

		changeFlow:addWork(updateStateWork)
	end

	local eliminateCount = #eliminate

	for i = 1, eliminateCount / 3 do
		local x = eliminate[i * 3 - 2]
		local y = eliminate[i * 3 - 1]
		local skillEffect = eliminate[i * 3]
		local data = {
			x = x,
			y = y,
			skillEffect = skillEffect
		}
		local dieWork = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.DieEffect, data)

		dieStepFlow:addWork(dieWork)
	end

	local effectType = LocalEliminateChessModel.instance:getEliminateDieEffect()
	local dieAudioId = AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_boom

	if effectType and effectType == LengZhou6Enum.SkillEffect.EliminationRange then
		dieAudioId = AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_explosion

		LocalEliminateChessModel.instance:setEliminateDieEffect(nil)
	end

	if effectType and effectType == LengZhou6Enum.SkillEffect.EliminationCross then
		dieAudioId = AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_combustion

		LocalEliminateChessModel.instance:setEliminateDieEffect(nil)
	end

	local playAudioStep = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.LengZhou6PlayAudio, dieAudioId)

	dieStepFlow:addWork(playAudioStep)
	self:buildSeqFlow(changeFlow)
	self:buildSeqFlow(dieStepFlow)
end

function LengZhou6EliminateController:handleDrop()
	local showData = LocalEliminateChessModel.instance:getEliminateRecordShowData()
	local moveList = showData:getMove()
	local newList = showData:getNew()

	if not moveList or not newList then
		return
	end

	local changeModel = {}
	local dropStepFlow = FlowParallel.New()
	local moveCount = #moveList

	for i = 1, moveCount / 4 do
		local fromX = moveList[i * 4 - 3]
		local fromY = moveList[i * 4 - 2]
		local toX = moveList[i * 4 - 1]
		local toY = moveList[i * 4]
		local item = LengZhou6EliminateChessItemController.instance:getChessItem(fromX, fromY)
		local moveData = EliminateStepUtil.createOrGetMoveStepTable(item, EliminateEnum.AniTime.Drop, EliminateEnum.AnimType.drop)
		local moveStep = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, moveData)

		dropStepFlow:addWork(moveStep)

		changeModel[#changeModel + 1] = {
			x = toX,
			y = toY,
			viewItem = item
		}
	end

	moveCount = #newList

	for i = 1, #newList / 2 do
		local x = newList[i * 2 - 1]
		local y = newList[i * 2]
		local chessMo = LocalEliminateChessModel.instance:getCell(x, y)
		local chessItem = LengZhou6EliminateChessItemController.instance:createChess(x, y)

		chessItem:initData(chessMo)

		local data = EliminateStepUtil.createOrGetMoveStepTable(chessItem, EliminateEnum.AniTime.Drop, EliminateEnum.AnimType.drop)
		local moveStep = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, data)

		dropStepFlow:addWork(moveStep)

		changeModel[#changeModel + 1] = {
			x = x,
			y = y,
			viewItem = chessItem
		}
	end

	local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Arrange_XY, changeModel)

	self:buildSeqFlow(dropStepFlow)
	self:buildSeqFlow(step)
end

function LengZhou6EliminateController:updateAllItemPos(moveList)
	if moveList == nil then
		return
	end

	local changeModel = {}
	local dropStepFlow = FlowParallel.New()
	local moveCount = #moveList

	for i = 1, moveCount / 4 do
		local fromX = moveList[i * 4 - 3]
		local fromY = moveList[i * 4 - 2]
		local toX = moveList[i * 4 - 1]
		local toY = moveList[i * 4]
		local fromItem = LengZhou6EliminateChessItemController.instance:getChessItem(fromX, fromY)
		local toItem = LengZhou6EliminateChessItemController.instance:getChessItem(toX, toY)
		local moveData = EliminateStepUtil.createOrGetMoveStepTable(fromItem, EliminateEnum.AniTime.Move, EliminateEnum.AnimType.move)
		local moveStep = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, moveData)

		dropStepFlow:addWork(moveStep)

		local moveData2 = EliminateStepUtil.createOrGetMoveStepTable(toItem, EliminateEnum.AniTime.Move, EliminateEnum.AnimType.move)
		local moveStep2 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, moveData2)

		dropStepFlow:addWork(moveStep2)
		table.insert(changeModel, {
			x = toX,
			y = toY
		})
	end

	self:buildSeqFlow(dropStepFlow)

	local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Arrange_XY, changeModel)

	self:buildSeqFlow(step)

	if isDebugBuild then
		step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessDebug2_7)

		self:buildSeqFlow(step)
	end

	step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, false)

	self:buildSeqFlow(step)
end

function LengZhou6EliminateController:recordExchangePos(posX, posY, targetX, targetY)
	self._lastExchangePos = self._lastExchangePos or {}
	self._lastExchangePos[#self._lastExchangePos + 1] = posX
	self._lastExchangePos[#self._lastExchangePos + 1] = posY
	self._lastExchangePos[#self._lastExchangePos + 1] = targetX
	self._lastExchangePos[#self._lastExchangePos + 1] = targetY
end

function LengZhou6EliminateController:getRecordExchangePos()
	return self._lastExchangePos[1], self._lastExchangePos[2], self._lastExchangePos[3], self._lastExchangePos[4]
end

function LengZhou6EliminateController:clearRecord()
	if self._lastExchangePos == nil then
		return
	end

	tabletool.clear(self._lastExchangePos)
end

function LengZhou6EliminateController:exchangeCellShow(posX_1, posY_1, posX_2, posY_2, moveTime)
	local changeModel = {}
	local moveData = EliminateStepUtil.createOrGetMoveStepTable(LengZhou6EliminateChessItemController.instance:getChessItem(posX_1, posY_1), moveTime, EliminateEnum.AnimType.move)
	local moveData_2 = EliminateStepUtil.createOrGetMoveStepTable(LengZhou6EliminateChessItemController.instance:getChessItem(posX_2, posY_2), moveTime, EliminateEnum.AnimType.move)
	local moveWork = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, moveData)
	local moveWork_2 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, moveData_2)
	local parallelStepFlow = self:buildParallelFlow(moveWork, moveWork_2)

	self:buildSeqFlow(parallelStepFlow)

	changeModel[#changeModel + 1] = {
		x = posX_2,
		y = posY_2,
		viewItem = LengZhou6EliminateChessItemController.instance:getChessItem(posX_1, posY_1)
	}
	changeModel[#changeModel + 1] = {
		x = posX_1,
		y = posY_1,
		viewItem = LengZhou6EliminateChessItemController.instance:getChessItem(posX_2, posY_2)
	}

	local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Arrange_XY, changeModel)

	self:buildSeqFlow(step)

	if isDebugBuild then
		step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessDebug2_7)

		self:buildSeqFlow(step)
	end
end

function LengZhou6EliminateController:createInitMoveStepAndUpdatePos()
	LengZhou6EliminateChessItemController.instance:tempClearAllChess()
	LengZhou6EliminateChessItemController.instance:InitChess()
	self:createInitMoveStep()
end

function LengZhou6EliminateController:createInitMoveStep()
	local allItem = LengZhou6EliminateChessItemController.instance:getChess()
	local moveParallelFlow = FlowParallel.New()

	for _, row in ipairs(allItem) do
		for j, item in pairs(row) do
			local time = EliminateEnum_2_7.InitDropTime * j
			local moveData = EliminateStepUtil.createOrGetMoveStepTable(item, time, EliminateEnum.AnimType.init)
			local moveStep = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, moveData)

			moveParallelFlow:addWork(moveStep)
		end
	end

	self:buildSeqFlow(moveParallelFlow)
	self:setFlowEndState(true)
end

function LengZhou6EliminateController:buildSeqFlow(work)
	local needStart = self._seqStepFlow == nil

	self._seqStepFlow = self._seqStepFlow or FlowSequence.New()

	if work then
		self._seqStepFlow:addWork(work)
	end

	if needStart and self._seqStepFlow ~= nil then
		self:startSeqStepFlow()
	end

	return self._seqStepFlow
end

function LengZhou6EliminateController:buildParallelFlow(...)
	local parallelStepFlow = FlowParallel.New()
	local args = ...
	local len = args ~= nil and select("#", ...) or 0

	if len > 0 then
		for i = 1, len do
			parallelStepFlow:addWork(select(i, ...))
		end
	end

	return parallelStepFlow
end

function LengZhou6EliminateController:getCurSeqStepFlow()
	return self._seqStepFlow
end

function LengZhou6EliminateController:startSeqStepFlow()
	if self._seqStepFlow ~= nil then
		self._seqStepFlow:registerDoneListener(self.seqFlowDone, self)
		self:dispatchEvent(LengZhou6Event.PerformBegin)
		self:setPerformIsFinish(false)
		self._seqStepFlow:start()
	end
end

function LengZhou6EliminateController:checkPerformEndState()
	if self._flowFullEnd and self._seqStepFlow == nil then
		self:dispatchEvent(LengZhou6Event.PerformEnd)
		self:setPerformIsFinish(true)
	end
end

function LengZhou6EliminateController:getPerformIsFinish()
	return self._performIsFinish
end

function LengZhou6EliminateController:setPerformIsFinish(isFinish)
	self._performIsFinish = isFinish
end

function LengZhou6EliminateController:setFlowEndState(state)
	self._flowFullEnd = state

	self:checkPerformEndState()
end

function LengZhou6EliminateController:seqFlowDone()
	self._seqStepFlow = nil

	self:checkPerformEndState()
end

function LengZhou6EliminateController:clearFlow()
	if self._seqStepFlow then
		self._seqStepFlow:onDestroyInternal()

		self._seqStepFlow = nil
	end
end

function LengZhou6EliminateController:checkAndSetNeedResetData(msg)
	EliminateChessModel.instance:setNeedResetData(msg)

	if self._turnInfo == nil or #self._turnInfo == 0 then
		local cacheData = EliminateChessModel.instance:getNeedResetData()

		if cacheData ~= nil then
			local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.RefreshEliminate)

			LengZhou6EliminateController.instance:buildSeqFlow(step)
		end
	end
end

function LengZhou6EliminateController:checkState()
	local movePoint = EliminateChessModel.instance:getMovePoint()

	if movePoint <= 0 then
		local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EndShowView, {
			time = EliminateEnum.ShowEndTime,
			cb = function()
				EliminateLevelController.instance:changeRoundToTeamChess()
			end,
			needShowEnd = EliminateLevelModel.instance:needPlayShowView()
		})

		LengZhou6EliminateController.instance:clearFlow()
		LengZhou6EliminateController.instance:buildSeqFlow(step)

		return true
	end

	return false
end

function LengZhou6EliminateController:clear()
	self:clearFlow()

	self._flowFullEnd = false

	EliminateStepUtil.releaseMoveStepTable()

	self._lastExchangePos = nil

	LocalEliminateChessModel.instance:clear()
	LengZhou6EliminateChessItemController.instance:clear()
end

function LengZhou6EliminateController:changeCellType(x, y, type)
	if x == nil or y == nil or type == nil then
		return
	end

	local chessMo = LocalEliminateChessModel.instance:changeCellId(x, y, EliminateEnum_2_7.ChessTypeToIndex[type])

	if chessMo ~= nil then
		local chessItem = LengZhou6EliminateChessItemController.instance:getChessItem(x, y)

		chessItem:initData(chessMo)
		LocalEliminateChessModel.instance:addChangePoints(x, y)

		local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, true)

		self:buildSeqFlow(step)
	end
end

function LengZhou6EliminateController:changeCellState(x, y, type)
	if x == nil or y == nil or type == nil then
		return
	end

	LocalEliminateChessModel.instance:changeCellState(x, y, type)

	local data = {
		x = x,
		y = y
	}
	local step1 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ChangeState, data)
	local step2 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, true)

	self:buildSeqFlow(step1)
	self:buildSeqFlow(step2)
end

LengZhou6EliminateController.instance = LengZhou6EliminateController.New()

return LengZhou6EliminateController
