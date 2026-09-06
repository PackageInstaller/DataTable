-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/controller/DoushouqiTigerGameController.lua

module("logic.extensions.doushouqi.controller.DoushouqiTigerGameController", package.seeall)

local DoushouqiTigerGameController = class("DoushouqiTigerGameController")

DoushouqiTigerGameController.Row = 5
DoushouqiTigerGameController.Col = 5
DoushouqiTigerGameController.Side = {
	Blue = 2,
	Red = 1
}

function DoushouqiTigerGameController:ctor()
	return
end

function DoushouqiTigerGameController:getMapPosDataList()
	local posDataList = {}

	for row = 1, DoushouqiTigerGameController.Row do
		for col = 1, DoushouqiTigerGameController.Col do
			local posData = {
				posId = (row - 1) * DoushouqiTigerGameController.Col + col - 1,
				col = col - 1,
				row = row - 1
			}

			table.insert(posDataList, posData)
		end
	end

	return posDataList
end

function DoushouqiTigerGameController:getPointRow(posId)
	return math.floor(posId / DoushouqiTigerGameController.Col)
end

function DoushouqiTigerGameController:getPointCol(posId)
	return posId % DoushouqiTigerGameController.Col
end

function DoushouqiTigerGameController:checkConnectedBetweenPos(posIdA, posIdB)
	local rowA = self:getPointRow(posIdA)
	local colA = self:getPointCol(posIdA)
	local rowB = self:getPointRow(posIdB)
	local colB = self:getPointCol(posIdB)
	local deltaY = math.abs(rowA - rowB)
	local deltaX = math.abs(colA - colB)

	if deltaX + deltaY == 1 then
		return true
	elseif deltaX + deltaY < 1 then
		return false
	elseif deltaX == 1 and deltaY == 1 then
		if (rowA + colA) % 2 == 0 and (rowB + colB) % 2 == 0 then
			return true
		else
			return false
		end
	else
		return false
	end
end

function DoushouqiTigerGameController:getPointIdByRowCol(row, col)
	return (row >= 0 and row < DoushouqiTigerGameController.Row and col >= 0 and col < DoushouqiTigerGameController.Col or nil) and DoushouqiTigerGameController.Col * row + col
end

function DoushouqiTigerGameController:trySelectChess(posId)
	if self:isGuideMode() then
		self._curSelectPosId = posId

		GlobalDispatcher:dispatch(GlobalNotify.DoushouqiTigerSelectChess)

		return
	end

	if self._isFinishGame then
		self:_endGame()

		return
	end

	if self._isChessMoving then
		FloatWordMgr.instance:show("移动中")

		return
	end

	if self:getCurRoundSide() ~= self:getMyRoundSide() then
		FloatWordMgr.instance:show("当前为对手回合")

		return
	end

	local trySelectId = self._curSelectPosId
	local chessInfo = self._curChessInfoMap[posId]

	if not chessInfo then
		trySelectId = -1

		GlobalDispatcher:dispatch(GlobalNotify.DoushouqiTigerUpdateChessInfo)
	elseif chessInfo.chessType == self:getCurRoundSide() then
		trySelectId = posId
	else
		FloatWordMgr.instance:show("请点击己方棋子")
	end

	if trySelectId ~= self._curSelectPosId then
		self._curSelectPosId = trySelectId

		GlobalDispatcher:dispatch(GlobalNotify.DoushouqiTigerSelectChess)
	end
end

function DoushouqiTigerGameController:tryMoveChess(targetPosId)
	local posInfo = self._curChessInfoMap[targetPosId]

	if self._isFinishGame then
		self:_endGame()

		return
	end

	if self:isGuideMode() then
		local selectChessInfo = self._curChessInfoMap[self._curSelectPosId]

		self._curChessInfoMap[self._curSelectPosId] = nil
		selectChessInfo.pointId = targetPosId
		self._curChessInfoMap[targetPosId] = selectChessInfo

		if self._curSelectPosId == 12 and targetPosId == 6 then
			self._curChessInfoMap[2] = nil
			self._curChessInfoMap[10] = nil
		elseif self._curSelectPosId == 1 and targetPosId == 6 then
			self:endTutorial()
		end

		GlobalDispatcher:dispatch(GlobalNotify.DoushouqiTigerUpdateChessInfo)

		self._curSelectPosId = -1

		GlobalDispatcher:dispatch(GlobalNotify.DoushouqiTigerSelectChess)

		return
	end

	if posInfo then
		GlobalDispatcher:dispatch(GlobalNotify.DoushouqiTigerSelectChess)

		return
	end

	local selectChessInfo = self._curChessInfoMap[self._curSelectPosId]

	if not selectChessInfo then
		return
	end

	if not self:checkConnectedBetweenPos(targetPosId, self._curSelectPosId) then
		return
	end

	if self._isChessMoving then
		FloatWordMgr.instance:show("移动中")

		return
	end

	if self:getIsLearnMode() then
		self._isChessMoving = true
		self._lastMove = {
			originPointId = self._curSelectPosId,
			targetPointId = targetPosId
		}
		self._curSelectPosId = -1

		GlobalDispatcher:dispatch(GlobalNotify.DoushouqiTigerSelectChess)
		GlobalDispatcher:dispatch(GlobalNotify.DoushouqiTigerDoMoveChess)
	else
		local actionId = DoushouqiModel.instance:getCurActionId()

		BeastFightingChessAgent.instance:sendBeastFightingChessMoveReq(self._activityId, self._curSelectPosId, targetPosId, actionId)
	end
end

function DoushouqiTigerGameController:getLastMove()
	return self._lastMove
end

function DoushouqiTigerGameController:finishMove()
	if self:getIsLearnMode() then
		local selectChessInfo = self._curChessInfoMap[self._lastMove.originPointId]

		self._curChessInfoMap[self._lastMove.originPointId] = nil
		selectChessInfo.pointId = self._lastMove.targetPointId
		self._curChessInfoMap[selectChessInfo.pointId] = selectChessInfo

		local players = self:getTutorialPlayInfos()

		for _, player in ipairs(players) do
			if player.side == self._curRoundSide then
				player.leftStep = player.leftStep - 1
				player.leftStep = math.max(player.leftStep, 0)

				if player.leftStep <= 0 then
					self:endTutorial()

					return
				end

				break
			end
		end

		if self._curRoundSide == DoushouqiTigerGameController.Side.Red then
			self._curLearningTigerPosId = self._lastMove.targetPointId
		end

		self:_dealEatChess()
	end

	GlobalDispatcher:dispatch(GlobalNotify.DoushouqiTigerFinishMoveChess)
end

function DoushouqiTigerGameController:switchRound()
	if self:getIsLearnMode() then
		local winnerSide = self:_getWinnerSide()

		if winnerSide == DoushouqiTigerGameController.Side.Red then
			TipsFacade.instance:openTipWindowNoX("提示", "红方胜利！本次练习结束", function()
				UIStateManager.instance:popByName(ViewName.DoushouqitigergameView)
			end)

			return
		elseif winnerSide == DoushouqiTigerGameController.Side.Blue then
			TipsFacade.instance:openTipWindowNoX("提示", "蓝方胜利！本次练习结束", function()
				UIStateManager.instance:popByName(ViewName.DoushouqitigergameView)
			end)

			return
		end

		if self._curRoundSide == DoushouqiTigerGameController.Side.Red then
			self._curRoundSide = DoushouqiTigerGameController.Side.Blue
			self._mySide = DoushouqiTigerGameController.Side.Blue
		else
			self._curRoundSide = DoushouqiTigerGameController.Side.Red
			self._mySide = DoushouqiTigerGameController.Side.Red
		end
	else
		local mapInfo = DoushouqiModel.instance:getNextMapInfo()
		local myUserId = checknumber(RoleModel.instance:getUserId())

		self._curRoundSide = checknumber(mapInfo.curRoundUserId) == myUserId and self:getMyRoundSide() or self:getOpRoundSide()
	end

	self._isChessMoving = false
	self._lastMove = nil

	if self._isFinishGame then
		self:_endGame()
	else
		GlobalDispatcher:dispatch(GlobalNotify.DoushouqiTigerSwitchRound)
	end
end

function DoushouqiTigerGameController:_getWinnerSide()
	local winerSide
	local redCanMove = false
	local buleLiveNum = 0
	local posList = self:getMapPosDataList()

	for _, posData in ipairs(posList) do
		local posId = posData.posId
		local chessInfo = self._curChessInfoMap[posId]

		if chessInfo then
			if chessInfo.chessType == DoushouqiTigerGameController.Side.Blue then
				buleLiveNum = buleLiveNum + 1
			end
		elseif self:checkConnectedBetweenPos(self._curLearningTigerPosId, posId) then
			redCanMove = true
		end
	end

	if self._curRoundSide == DoushouqiTigerGameController.Side.Blue and not redCanMove then
		winerSide = DoushouqiTigerGameController.Side.Blue
	end

	if not winerSide and buleLiveNum <= 8 then
		winerSide = DoushouqiTigerGameController.Side.Red
	end

	return winerSide
end

function DoushouqiTigerGameController:_dealEatChess()
	if self:getIsLearnMode() then
		local rowTiger = self:getPointRow(self._curLearningTigerPosId)
		local colTiger = self:getPointCol(self._curLearningTigerPosId)
		local eatPosList = {}
		local startPos, endPos

		for i = 1, DoushouqiTigerGameController.Col do
			local testPos = self:getPointIdByRowCol(rowTiger, i - 1)
			local beforePos = self:getPointIdByRowCol(rowTiger, i - 2)
			local nextPos = self:getPointIdByRowCol(rowTiger, i)
			local nextSecondPos = self:getPointIdByRowCol(rowTiger, i + 1)

			if self._curChessInfoMap[testPos] then
				if not startPos then
					if self._curLearningTigerPosId == nextPos and not self._curChessInfoMap[beforePos] then
						startPos = testPos
					end
				elseif self._curLearningTigerPosId == testPos then
					if self._curChessInfoMap[nextPos] and not self._curChessInfoMap[nextSecondPos] then
						endPos = nextPos
					end
				elseif endPos then
					-- block empty
				else
					startPos = nil
				end
			end
		end

		if startPos and endPos then
			table.insert(eatPosList, startPos)
			table.insert(eatPosList, endPos)
		end

		startPos = nil
		endPos = nil

		for i = 1, DoushouqiTigerGameController.Row do
			local testPos = self:getPointIdByRowCol(i - 1, colTiger)
			local beforePos = self:getPointIdByRowCol(i - 2, colTiger)
			local nextPos = self:getPointIdByRowCol(i, colTiger)
			local nextSecondPos = self:getPointIdByRowCol(i + 1, colTiger)

			if self._curChessInfoMap[testPos] then
				if not startPos then
					if self._curLearningTigerPosId == nextPos and not self._curChessInfoMap[beforePos] then
						startPos = testPos
					end
				elseif self._curLearningTigerPosId == testPos then
					if self._curChessInfoMap[nextPos] and not self._curChessInfoMap[nextSecondPos] then
						endPos = nextPos
					end
				elseif endPos then
					-- block empty
				else
					startPos = nil
				end
			end
		end

		if startPos and endPos then
			table.insert(eatPosList, startPos)
			table.insert(eatPosList, endPos)
		end

		if (rowTiger + colTiger) % 2 == 0 then
			startPos = nil
			endPos = nil

			for i = -2, 2 do
				local testPos = self:getPointIdByRowCol(rowTiger + i, colTiger + i)
				local beforePos = self:getPointIdByRowCol(rowTiger + i - 1, colTiger + i - 1)
				local nextPos = self:getPointIdByRowCol(rowTiger + i + 1, colTiger + i + 1)
				local nextSecondPos = self:getPointIdByRowCol(rowTiger + i + 2, colTiger + i + 2)

				if self._curChessInfoMap[testPos] then
					if not startPos then
						if self._curLearningTigerPosId == nextPos and not self._curChessInfoMap[beforePos] then
							startPos = testPos
						end
					elseif self._curLearningTigerPosId == testPos then
						if self._curChessInfoMap[nextPos] and not self._curChessInfoMap[nextSecondPos] then
							endPos = nextPos
						end
					elseif endPos then
						-- block empty
					else
						startPos = nil
					end
				end
			end

			if startPos and endPos then
				table.insert(eatPosList, startPos)
				table.insert(eatPosList, endPos)
			end

			startPos = nil
			endPos = nil

			for i = -2, 2 do
				local testPos = self:getPointIdByRowCol(rowTiger + i, colTiger - i)
				local beforePos = self:getPointIdByRowCol(rowTiger + i - 1, colTiger - i + 1)
				local nextPos = self:getPointIdByRowCol(rowTiger + i + 1, colTiger - i - 1)
				local nextSecondPos = self:getPointIdByRowCol(rowTiger + i + 2, colTiger - i - 2)

				if self._curChessInfoMap[testPos] then
					if not startPos then
						if self._curLearningTigerPosId == nextPos and not self._curChessInfoMap[beforePos] then
							startPos = testPos
						end
					elseif self._curLearningTigerPosId == testPos then
						if self._curChessInfoMap[nextPos] and not self._curChessInfoMap[nextSecondPos] then
							endPos = nextPos
						end
					elseif endPos then
						-- block empty
					else
						startPos = nil
					end
				end
			end

			if startPos and endPos then
				table.insert(eatPosList, startPos)
				table.insert(eatPosList, endPos)
			end
		end

		for i, posId in ipairs(eatPosList) do
			self._curChessInfoMap[posId] = nil
		end
	end
end

function DoushouqiTigerGameController:_addEatPosList(sameColPosList, eatPosList)
	local isAbleToEat = false

	if #sameColPosList == 2 then
		isAbleToEat = true

		for _, posId in ipairs(sameColPosList) do
			if not self:checkConnectedBetweenPos(self._curLearningTigerPosId, posId) then
				isAbleToEat = false
			end
		end
	end

	if isAbleToEat then
		for _, posId in ipairs(sameColPosList) do
			table.insert(eatPosList, posId)
		end
	end

	return eatPosList
end

function DoushouqiTigerGameController:onNotifyBeastFightingChessActionRes(msg)
	self._curSelectPosId = -1

	GlobalDispatcher:dispatch(GlobalNotify.DoushouqiTigerSelectChess)
	DoushouqiModel.instance:setNextMapInfo(msg.map)
	DoushouqiModel.instance:setCurActionId(msg.actionId)

	self._curChessInfoMap = {}

	local mapInfo = DoushouqiModel.instance:getNextMapInfo()

	for _, chessInfo in ipairs(mapInfo.chess) do
		self._curChessInfoMap[chessInfo.pointId] = chessInfo
	end

	self._playerInfos = {}

	for _, player in ipairs(mapInfo.players) do
		self._playerInfos[player.side] = player
	end

	self._lastMove = nil

	if msg.action:HasField("move") then
		self._lastMove = msg.action.move
		self._isChessMoving = true

		GlobalDispatcher:dispatch(GlobalNotify.DoushouqiTigerDoMoveChess)
	else
		self:finishMove()
	end
end

function DoushouqiTigerGameController:onNotifyBeastFightingChessGameEndRes(msg)
	self._isFinishGame = true
	self._resultMsg = msg
end

function DoushouqiTigerGameController:getIsLearnMode()
	return self._isLearnMode
end

function DoushouqiTigerGameController:_setIsLearnMode(isMode)
	self._isLearnMode = isMode
end

function DoushouqiTigerGameController:getCurChessInfoMap()
	return self._curChessInfoMap
end

function DoushouqiTigerGameController:getCurSelectPosId()
	return self._curSelectPosId
end

function DoushouqiTigerGameController:getCurRoundSide()
	return self._curRoundSide
end

function DoushouqiTigerGameController:getMyRoundSide()
	return self._mySide
end

function DoushouqiTigerGameController:getOpRoundSide()
	if self:getMyRoundSide() == DoushouqiTigerGameController.Side.Red then
		return DoushouqiTigerGameController.Side.Blue
	else
		return DoushouqiTigerGameController.Side.Red
	end
end

function DoushouqiTigerGameController:startGame(activityId, isLearnMode)
	self:_resetGameStatus()

	self._activityId = activityId

	self:_setIsLearnMode(isLearnMode)
	self:_initGame()
	UIStateManager.instance:push(ViewName.DoushouqitigergameView, self._activityId)
end

function DoushouqiTigerGameController:_resetGameStatus()
	self._activityId = nil
	self._isLearnMode = false
	self._curSelectPosId = -1
	self._curRoundSide = DoushouqiTigerGameController.Side.Red
	self._isChessMoving = false
	self._isFinishGame = false
	self._curChessInfoMap = {}
	self._mySide = 1
	self._resultMsg = nil
	self._isEnterTuoguan = false
end

function DoushouqiTigerGameController:_initGame()
	if self:getIsLearnMode() then
		self._isCurFinishGuide = self:_isFinishGuide()
		self._curChessInfoMap = self:_createInitMap()
		self._mySide = DoushouqiTigerGameController.Side.Red
		self._curRoundSide = DoushouqiTigerGameController.Side.Red
		self._tutorialPlayInfos = self:_createInitPlayInfos()
	else
		self._curChessInfoMap = {}
		self._playerInfos = {}

		local mapInfo = DoushouqiModel.instance:getMapInfo()

		for _, chessInfo in ipairs(mapInfo.chess) do
			self._curChessInfoMap[chessInfo.pointId] = chessInfo
		end

		for _, player in ipairs(mapInfo.players) do
			self._playerInfos[player.side] = player
		end

		local firstRoundUserId = checknumber(mapInfo.curRoundUserId)
		local myUserId = checknumber(RoleModel.instance:getUserId())

		self._mySide = firstRoundUserId == myUserId and DoushouqiTigerGameController.Side.Red or DoushouqiTigerGameController.Side.Blue
		self._curRoundSide = DoushouqiTigerGameController.Side.Red
	end
end

function DoushouqiTigerGameController:_endGame()
	if self._isEnterTuoguan then
		return
	end

	if self._resultMsg then
		UIStateManager.instance:push(ViewName.DoushouqiendgameView, self._resultMsg)
	else
		UIStateManager.instance:popByName(ViewName.DoushouqitigergameView)
	end
end

function DoushouqiTigerGameController:_createInitMap()
	local chessInfoMap = {}
	local posList = self:getMapPosDataList()

	for _, posData in ipairs(posList) do
		local posId = posData.posId
		local col = posData.col
		local row = posData.row

		if row == DoushouqiTigerGameController.Row - 1 or row == 0 or col == DoushouqiTigerGameController.Col - 1 or col == 0 then
			local chessInfo = {}

			chessInfo.pointId = posId
			chessInfo.chessType = 2
			chessInfoMap[posId] = chessInfo
		end
	end

	local midCol = (DoushouqiTigerGameController.Col - 1) / 2
	local midRow = (DoushouqiTigerGameController.Row - 1) / 2
	local chessInfo = {}

	chessInfo.pointId = self:getPointIdByRowCol(midRow, midCol)
	self._curLearningTigerPosId = chessInfo.pointId
	chessInfo.chessType = 1
	chessInfoMap[chessInfo.pointId] = chessInfo

	return chessInfoMap
end

function DoushouqiTigerGameController:endTutorial()
	TipsFacade.instance:openTipWindowNoX("提示", "恭喜你已经完成教程！\n后续仍可进入教程来钻研围虎棋喔！", function()
		BeastFightingChessAgent.instance:sendBeastFightingChessFinishNewHandReq(self._activityId, DoushouqiController.ChessType.Weihuqi)
		UIStateManager.instance:popByName(ViewName.DoushouqitigergameView)
	end)
end

function DoushouqiTigerGameController:isGuideMode()
	if self:getIsLearnMode() then
		local branch = GuideModel.instance:getGuideBranch(122)

		if branch then
			if branch:isFinished() then
				if not self._isCurFinishGuide then
					self._isCurFinishGuide = true

					return true
				end

				return false
			else
				return true
			end
		end
	end

	return false
end

function DoushouqiTigerGameController:_isFinishGuide()
	local branch = GuideModel.instance:getGuideBranch(122)

	return branch and branch:isFinished()
end

function DoushouqiTigerGameController:openTuoguan()
	if self._isEnterTuoguan then
		return
	end

	self._isEnterTuoguan = true

	local text = "由于长时间未操作，系统托管中"

	TipsFacade.instance:openTipWindowNoX("提示", text, function()
		self._isEnterTuoguan = false

		GlobalDispatcher:dispatch(GlobalNotify.DoushouqiSetMyOperation)

		if self._isFinishGame then
			self:_endGame()
		end
	end, "回到游戏")
end

function DoushouqiTigerGameController:_createInitPlayInfos()
	local actCfg = DoushouqiConfig.instance:getActivityCfg(self._activityId)
	local playInfos = {}

	for i = 1, 2 do
		local info = {
			side = -1,
			leftStep = actCfg.stepLimit
		}

		info.side = i == DoushouqiController.Dir.Left and self:getMyRoundSide() or self:getOpRoundSide()

		table.insert(playInfos, info)
	end

	return playInfos
end

function DoushouqiTigerGameController:getTutorialPlayInfos()
	return self._tutorialPlayInfos
end

function DoushouqiTigerGameController:getPlayInfos()
	return self._playerInfos or {}
end

DoushouqiTigerGameController.instance = DoushouqiTigerGameController.New()

return DoushouqiTigerGameController
