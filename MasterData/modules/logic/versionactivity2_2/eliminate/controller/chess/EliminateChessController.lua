-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/chess/EliminateChessController.lua

module("modules.logic.versionactivity2_2.eliminate.controller.chess.EliminateChessController", package.seeall)

local EliminateChessController = class("EliminateChessController", BaseController)

function EliminateChessController:onInit()
	self._seqStepFlow = nil
	self._flowFullEnd = false
	self._lastExchangePos = {}
end

function EliminateChessController:reInit()
	self:clearFlow()

	self._lastExchangePos = {}
end

function EliminateChessController:sendGetMatch3WarChessInfoRequest(type, callback, callbackobj)
	EliminateRpc.instance:sendGetMatch3WarChessInfoRequest(type, callback, callbackobj)
end

function EliminateChessController:handleEliminateChessInfo(info)
	if not info then
		return
	end

	if info.match3ChessBoard then
		EliminateChessModel.instance:initChessInfo(info.match3ChessBoard)
	end

	if info.movePoint then
		EliminateChessModel.instance:updateMovePoint(info.movePoint)
	end
end

function EliminateChessController:handleMatch3Tips(tips)
	EliminateChessModel.instance:updateMatch3Tips(tips)

	if EliminateChessModel.instance:getTipEliminateCount() == 0 then
		EliminateRpc.instance:sendRefreshMatch3WarChessInfoRequest()
	end
end

function EliminateChessController:handleMovePoint(movePoint)
	EliminateChessModel.instance:updateMovePoint(movePoint)
end

function EliminateChessController:handleTurnInfo(turn, success)
	EliminateChessModel.instance:clearCurPlayAudioCount()
	EliminateChessModel.instance:clearTotalCount()

	if not success and #self._lastExchangePos > 0 then
		local posX, posY, targetX, targetY = self:getRecordExchangePos()

		self:exchangeCellShow(posX, posY, targetX, targetY, EliminateEnum.AniTime.MoveRevert)
	end

	for i = 1, #turn do
		self:cacheCurTurnInfo(turn[i])
	end

	local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.HandleData)
	local needStart = self:buildSeqFlow(step)

	if needStart then
		self:startSeqStepFlow()
	end

	self:clearRecord()
	self:setFlowEndState(true)
end

function EliminateChessController:cacheCurTurnInfo(turn)
	if self._turnInfo == nil then
		self._turnInfo = {}
	end

	self._turnInfo[#self._turnInfo + 1] = turn
end

function EliminateChessController:getCurTurn()
	if self._turnInfo == nil then
		return nil
	end

	return table.remove(self._turnInfo, 1)
end

function EliminateChessController:handleEliminate(eliminate)
	if not eliminate then
		return
	end

	local dieStepFlow = FlowParallel.New()

	for i = 1, #eliminate do
		local row = eliminate[i].coordinate
		local extraData = eliminate[i].extraData
		local source = eliminate[i].source
		local resourceIds = {}

		if not string.nilorempty(extraData) then
			local data = cjson.decode(extraData)

			if data then
				local diamondChangeMap = data.diamondChangeMap

				if diamondChangeMap then
					for key, value in pairs(diamondChangeMap) do
						table.insert(resourceIds, key)
						EliminateTeamChessModel.instance:updateResourceData(key, tonumber(value))
					end
				end

				local changePower = data.changePower

				if changePower then
					EliminateTeamChessModel.instance:updateMainCharacterPower(EliminateTeamChessEnum.TeamChessTeamType.player, tonumber(changePower))
				end
			end
		end

		local eliminateCount = #row

		EliminateChessModel.instance:addTotalEliminateCount(eliminateCount)

		for j = 1, eliminateCount do
			local chess = row[j]
			local chessX = chess.x + 1
			local chessY = chess.y + 1
			local chessMo = EliminateChessModel.instance:getChessMo(chessX, chessY)

			chessMo:setStatus(EliminateEnum.ChessState.Die)

			local data = {
				x = chessX,
				y = chessY,
				resourceIds = resourceIds,
				source = source
			}
			local dieWork = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Die, data)

			dieStepFlow:addWork(dieWork)
		end
	end

	local work = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.PlayEffect)

	dieStepFlow:addWork(work)

	local audioWork = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.PlayAudio)

	dieStepFlow:addWork(audioWork)
	self:buildSeqFlow(dieStepFlow)
end

function EliminateChessController:handleDrop(tidyUp, fillChessBoard)
	if not tidyUp or not fillChessBoard then
		return
	end

	local changeModel = {}
	local dropStepFlow = FlowParallel.New()

	if tidyUp.col then
		for _, data in ipairs(tidyUp.col) do
			local x = data.col + 1

			for index, oldValue in ipairs(data.oldX) do
				local oldY = oldValue + 1
				local newY = data.newX[index] + 1
				local oldChessMo = EliminateChessModel.instance:getChessMo(x, oldY)

				oldChessMo:setStartXY(x, oldY)
				oldChessMo:setXY(x, newY)
				EliminateChessModel.instance:updateChessMo(x, newY, oldChessMo)

				local moveData = EliminateStepUtil.createOrGetMoveStepTable(EliminateChessItemController.instance:getChessItemByModel(oldChessMo), oldChessMo:getMoveTime(), EliminateEnum.AnimType.drop)
				local moveStep = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, moveData)

				dropStepFlow:addWork(moveStep)

				changeModel[#changeModel + 1] = {
					model = oldChessMo,
					viewItem = EliminateChessItemController.instance:getChessItemByModel(oldChessMo)
				}
			end
		end
	end

	if tidyUp.row then
		for _, data in ipairs(tidyUp.row) do
			local y = data.row + 1

			for index, oldValue in ipairs(data.oldY) do
				local oldX = oldValue + 1
				local newX = data.newY[index] + 1
				local oldChessMo = EliminateChessModel.instance:getChessMo(oldX, y)

				oldChessMo:setStartXY(oldX, y)
				oldChessMo:setXY(newX, y)
				EliminateChessModel.instance:updateChessMo(newX, y, oldChessMo)

				local moveData = EliminateStepUtil.createOrGetMoveStepTable(EliminateChessItemController.instance:getChessItemByModel(oldChessMo), oldChessMo:getMoveTime(), EliminateEnum.AnimType.drop)
				local moveStep = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, moveData)

				dropStepFlow:addWork(moveStep)

				changeModel[#changeModel + 1] = {
					model = oldChessMo,
					viewItem = EliminateChessItemController.instance:getChessItemByModel(oldChessMo)
				}
			end
		end
	end

	local chessList = fillChessBoard.chess

	if chessList then
		local _, maxCol = EliminateChessModel.instance:getMaxRowAndCol()

		for i = 1, #chessList do
			local chess = chessList[i]
			local chessId = chess.id
			local coordinate = chess.coordinate
			local chessX = coordinate.x + 1
			local chessY = coordinate.y + 1
			local chessMo = EliminateChessMO.New()

			chessMo:setXY(chessX, chessY)
			chessMo:setStartXY(chessX, maxCol + 1)
			chessMo:setChessId(chessId)
			EliminateChessModel.instance:updateChessMo(chessX, chessY, chessMo)

			local chessItem = EliminateChessItemController.instance:createChess(chessX, chessY)

			chessItem:initData(chessMo)

			local data = EliminateStepUtil.createOrGetMoveStepTable(chessItem, chessMo:getMoveTime(), EliminateEnum.AnimType.drop)
			local moveStep = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, data)

			dropStepFlow:addWork(moveStep)

			changeModel[#changeModel + 1] = {
				model = chessMo,
				viewItem = chessItem
			}
		end
	end

	local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Arrange, changeModel)
	local handleDataStep = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.HandleData)

	self:buildSeqFlow(dropStepFlow)
	self:buildSeqFlow(step)
	self:buildSeqFlow(handleDataStep)

	if canLogNormal then
		-- block empty
	end
end

function EliminateChessController:exchangeCell(posX, posY, targetX, targetY)
	local diff_x = math.abs(posX - targetX)
	local diff_y = math.abs(posY - targetY)

	if diff_x > 1 or diff_y > 1 or diff_x == diff_y then
		return false
	end

	if self._turnInfo ~= nil and #self._turnInfo > 0 then
		return true
	end

	self:setFlowEndState(false)
	self:dispatchEvent(EliminateChessEvent.PerformBegin)
	self:recordExchangePos(posX, posY, targetX, targetY)
	self:exchangeCellShow(posX, posY, targetX, targetY, EliminateEnum.AniTime.Move)
	EliminateRpc.instance:sendMatch3ChessBoardSwapRequest(posX, posY, targetX, targetY, nil, nil)

	return true
end

function EliminateChessController:recordExchangePos(posX, posY, targetX, targetY)
	self._lastExchangePos = self._lastExchangePos or {}
	self._lastExchangePos[#self._lastExchangePos + 1] = posX
	self._lastExchangePos[#self._lastExchangePos + 1] = posY
	self._lastExchangePos[#self._lastExchangePos + 1] = targetX
	self._lastExchangePos[#self._lastExchangePos + 1] = targetY
end

function EliminateChessController:getRecordExchangePos()
	return self._lastExchangePos[1], self._lastExchangePos[2], self._lastExchangePos[3], self._lastExchangePos[4]
end

function EliminateChessController:clearRecord()
	tabletool.clear(self._lastExchangePos)
end

function EliminateChessController:exchangeCellShow(posX_1, posY_1, posX_2, posY_2, moveTime)
	local changeModel = {}
	local data = EliminateChessModel.instance:getChessMo(posX_1, posY_1)

	data:setXY(posX_2, posY_2)

	local data_2 = EliminateChessModel.instance:getChessMo(posX_2, posY_2)

	data_2:setXY(posX_1, posY_1)
	EliminateChessModel.instance:updateChessMo(posX_1, posY_1, data_2)
	EliminateChessModel.instance:updateChessMo(posX_2, posY_2, data)

	local moveData = EliminateStepUtil.createOrGetMoveStepTable(EliminateChessItemController.instance:getChessItemByModel(data), moveTime, EliminateEnum.AnimType.move)
	local moveData_2 = EliminateStepUtil.createOrGetMoveStepTable(EliminateChessItemController.instance:getChessItemByModel(data_2), moveTime, EliminateEnum.AnimType.move)
	local moveWork = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, moveData)
	local moveWork_2 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, moveData_2)
	local parallelStepFlow = self:buildParallelFlow(moveWork, moveWork_2)
	local needStart, _ = self:buildSeqFlow(parallelStepFlow)

	changeModel[#changeModel + 1] = {
		model = data,
		viewItem = EliminateChessItemController.instance:getChessItemByModel(data)
	}
	changeModel[#changeModel + 1] = {
		model = data_2,
		viewItem = EliminateChessItemController.instance:getChessItemByModel(data_2)
	}

	local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Arrange, changeModel)

	self:buildSeqFlow(step)

	if canLogNormal then
		local debugStep = EliminateChessDebugStep.New()

		self:buildSeqFlow(debugStep)
	end

	if needStart then
		self:startSeqStepFlow()
	end
end

function EliminateChessController:createInitMoveStepAndUpdatePos()
	EliminateChessModel.instance:createInitMoveState()

	local allItem = EliminateChessItemController.instance:getChess()

	for _, row in ipairs(allItem) do
		for _, item in pairs(row) do
			item.updatePos(item, item)
		end
	end
end

function EliminateChessController:createInitMoveStep()
	local allItem = EliminateChessItemController.instance:getChess()
	local moveParallelFlow = FlowParallel.New()

	for i, row in ipairs(allItem) do
		for j, item in pairs(row) do
			item.updatePos(item, item)

			local moveData = EliminateStepUtil.createOrGetMoveStepTable(item, item:getData():getInitMoveTime(), EliminateEnum.AnimType.init)
			local moveStep = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, moveData)

			moveParallelFlow:addWork(moveStep)
		end
	end

	return self:buildSeqFlow(moveParallelFlow)
end

function EliminateChessController:buildSeqFlow(work)
	local needStart = self._seqStepFlow == nil

	self._seqStepFlow = self._seqStepFlow or FlowSequence.New()

	if work then
		self._seqStepFlow:addWork(work)
	end

	return needStart, self._seqStepFlow
end

function EliminateChessController:buildParallelFlow(...)
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

function EliminateChessController:getCurSeqStepFlow()
	return self._seqStepFlow
end

function EliminateChessController:startSeqStepFlow()
	if self._seqStepFlow then
		self._seqStepFlow:registerDoneListener(self.seqFlowDone, self)
		self._seqStepFlow:start()
	end
end

function EliminateChessController:checkPerformEndState()
	if self._flowFullEnd and self._seqStepFlow == nil then
		self:dispatchEvent(EliminateChessEvent.PerformEnd)
	end
end

function EliminateChessController:setFlowEndState(state)
	self._flowFullEnd = state

	self:checkPerformEndState()
end

function EliminateChessController:seqFlowDone()
	self._seqStepFlow = nil

	self:checkPerformEndState()
end

function EliminateChessController:clearFlow()
	if self._seqStepFlow then
		self._seqStepFlow:onDestroyInternal()

		self._seqStepFlow = nil
	end
end

function EliminateChessController:checkAndSetNeedResetData(msg)
	EliminateChessModel.instance:setNeedResetData(msg)

	if self._turnInfo == nil or #self._turnInfo == 0 then
		local cacheData = EliminateChessModel.instance:getNeedResetData()

		if cacheData ~= nil then
			local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.RefreshEliminate)
			local needStart = EliminateChessController.instance:buildSeqFlow(step)

			if needStart then
				EliminateChessController.instance:startSeqStepFlow()
			end
		end
	end
end

function EliminateChessController:checkState()
	local movePoint = EliminateChessModel.instance:getMovePoint()

	if movePoint <= 0 then
		local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EndShowView, {
			time = EliminateEnum.ShowEndTime,
			cb = function()
				EliminateLevelController.instance:changeRoundToTeamChess()
			end,
			needShowEnd = EliminateLevelModel.instance:needPlayShowView()
		})

		EliminateChessController.instance:clearFlow()

		local needPlay = EliminateChessController.instance:buildSeqFlow(step)

		if needPlay then
			EliminateChessController.instance:startSeqStepFlow()
		end

		return true
	end

	return false
end

function EliminateChessController:openNoticeView(isStart, isFinish, isTeamChess, isShowEvaluate, evaluateLevel, closeTime, closeCallback, closeCallbackTarget)
	local viewSetting = ViewMgr.instance:getSetting(ViewName.EliminateNoticeView)

	if viewSetting then
		viewSetting.bgBlur = (isShowEvaluate or isFinish) and 0 or 1
	end

	local data = {
		isStart = isStart,
		isFinish = isFinish,
		isTeamChess = isTeamChess,
		isShowEvaluate = isShowEvaluate,
		evaluateLevel = evaluateLevel,
		closeTime = closeTime,
		closeCallback = closeCallback,
		closeCallbackTarget = closeCallbackTarget
	}

	ViewMgr.instance:openView(ViewName.EliminateNoticeView, data)
end

function EliminateChessController:clear()
	self:clearFlow()

	self._flowFullEnd = false

	EliminateStepUtil.releaseMoveStepTable()

	self._lastExchangePos = {}

	EliminateChessModel.instance:reInit()
	EliminateChessItemController.instance:clear()
end

EliminateChessController.instance = EliminateChessController.New()

return EliminateChessController
