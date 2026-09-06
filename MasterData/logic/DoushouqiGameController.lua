-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/controller/DoushouqiGameController.lua

module("logic.extensions.doushouqi.controller.DoushouqiGameController", package.seeall)

local DoushouqiGameController = class("DoushouqiGameController", BaseController)

DoushouqiGameController.Row = 4
DoushouqiGameController.Col = 4
DoushouqiGameController.SkillType = {
	Gedang = 1,
	Fanji = 5,
	Zhuanhuo = 6,
	Lianji = 4,
	Yinshen = 3,
	Xianzhi = 2
}

function DoushouqiGameController:ctor()
	return
end

function DoushouqiGameController:onInit()
	self:onReset()
end

function DoushouqiGameController:onReset()
	self._counterAttackPointId = -1

	removetimer(self._delayRobotChessAction, self)
	removetimer(self._delayEndGame, self)

	self._delayRobotChessActionMsg = nil
	self._delayEndGameMsg = nil
	self._isEnterTuoguan = false
	self._cacheEndGameMsg = false
	self._actionId2EndTimeMap = {}
end

function DoushouqiGameController:enterTutorial(activityId)
	DoushouqiModel.instance:setMySkillId(2)

	local mapInfo = {
		rows = 4,
		cols = 4,
		typeId = DoushouqiController.ChessType.Doushouqi,
		chess = {},
		players = {
			{
				leftStep = 99,
				side = 1,
				usedSkill = false,
				userId = checknumber(RoleModel.instance:getUserId())
			},
			{
				leftStep = 99,
				userId = -1,
				side = 2,
				usedSkill = false
			}
		},
		curRoundUserId = RoleModel.instance:getUserId()
	}
	local pointId1 = self:getPointId(3, 1)
	local pointId2 = self:getPointId(3, 3)

	table.insert(mapInfo.chess, {
		chessType = 0,
		pointId = pointId2,
		state = {
			"clientKnow#108"
		}
	})
	table.insert(mapInfo.chess, {
		chessType = 202,
		pointId = pointId1,
		state = {}
	})

	local gameStartInfo = {
		opSkillId = 1,
		actionId = 0,
		isRobot = true,
		typeId = DoushouqiController.ChessType.Doushouqi,
		map = mapInfo
	}

	DoushouqiModel.instance:resetBeforeStartGame()
	DoushouqiModel.instance:setGameStartInfo(gameStartInfo)
	self:startGame(activityId, true)
end

function DoushouqiGameController:endTutorial()
	TipsFacade.instance:openTipWindowNoX("提示", "完成教程", function()
		BeastFightingChessAgent.instance:sendBeastFightingChessFinishNewHandReq(self._activityId, DoushouqiController.ChessType.Doushouqi)
		UIStateManager.instance:popByName(ViewName.DoushouqigameView)
	end)
end

function DoushouqiGameController:startGame(activityId, islearn)
	self._activityId = activityId

	self:_clear()
	self:_init()
	self:_creatCellMos()
	self:_updateMosData()
	self:_setIsLearn(islearn)
	self:_calActionId2EndTimeWithMapInfo()
	UIStateManager.instance:push(ViewName.DoushouqigameView, self._activityId)
end

function DoushouqiGameController:endGame(msg)
	if self._isEnterTuoguan then
		self._cacheEndGameMsg = msg

		return
	end

	UIStateManager.instance:push(ViewName.DoushouqiendgameView, msg)
end

function DoushouqiGameController:clearGameDatas()
	self:_clear()
end

function DoushouqiGameController:isCanMove(srcPointId, destPointId)
	local srcMo = self:getMo(srcPointId)
	local destMo = self:getMo(destPointId)

	if not destMo then
		return false
	end

	local sRow = srcMo:getRow()
	local sCol = srcMo:getCol()
	local dRow = destMo:getRow()
	local dCol = destMo:getCol()
	local deltaX = math.abs(sRow - dRow)
	local deltaY = math.abs(sCol - dCol)

	if deltaX + deltaY ~= 1 then
		return false
	end

	if destMo then
		if destMo:isEmpty() then
			return true
		end

		if destMo:isUnlock() and srcMo:getSideId() ~= destMo:getSideId() then
			return true
		end

		if not destMo:isUnlock() and destMo:isInvisibility() then
			return true
		end
	end

	return false
end

function DoushouqiGameController:moveTo(srcPointId, destPointId, onlyMove)
	self:clearSelectMo()

	local srcMo = self:getMo(srcPointId)
	local destMo = self:getMo(destPointId)

	self._moveData = {
		srcMo = srcMo,
		destMo = destMo,
		onlyMove = onlyMove
	}
	self._isMoving = true

	GlobalDispatcher:dispatch(GlobalNotify.DoushouqiStartMoveTo, srcPointId, destPointId)
end

function DoushouqiGameController:_changePos(srcPointId, destPointId)
	self._isMoving = true

	GlobalDispatcher:dispatch(GlobalNotify.DoushouqiStartChangePos, srcPointId, destPointId)
end

function DoushouqiGameController:isMoving()
	return self._isMoving
end

function DoushouqiGameController:moveFinish()
	if self:isLearn() then
		local srcChess
		local newChess = {}
		local mapInfo = DoushouqiModel.instance:getMapInfo()

		for i, chess in ipairs(mapInfo.chess) do
			if chess.pointId == self._moveData.srcMo:getPointId() then
				srcChess = chess
			elseif chess.pointId == self._moveData.destMo:getPointId() then
				-- block empty
			else
				table.insert(newChess, chess)
			end
		end

		local chess = {
			pointId = self._moveData.destMo:getPointId(),
			chessType = self._moveData.srcMo:getChess().chessType,
			state = self._moveData.srcMo:getChess().state
		}

		table.insert(newChess, chess)

		mapInfo.chess = newChess

		self:_reduceMyStepNumInLearn(mapInfo)
		self:_refreshNewMap()

		mapInfo = DoushouqiModel.instance:getMapInfo()

		for i, v in ipairs(mapInfo.players) do
			if checknumber(v.userId) == checknumber(RoleModel.instance:getUserId()) then
				if v.leftStep <= 0 then
					FloatWordMgr.instance:show("新手教程结束")
					UIStateManager.instance:popByName(ViewName.DoushouqigameView)
				end

				break
			end
		end
	elseif not self._moveData.onlyMove then
		local srcMo = self._moveData.srcMo
		local destMo = self._moveData.destMo
		local originPointId, targetPointId = srcMo:getPointId(), destMo:getPointId()
		local actionId = DoushouqiModel.instance:getCurActionId()

		BeastFightingChessAgent.instance:sendBeastFightingChessMoveReq(self._activityId, originPointId, targetPointId, actionId)
	else
		self:_refreshNewMap()
	end

	self._isMoving = false
end

function DoushouqiGameController:changePosFinish()
	self:_refreshNewMap()

	self._isMoving = false
end

function DoushouqiGameController:isRobot()
	return DoushouqiModel.instance:getIsRobot()
end

function DoushouqiGameController:getCanMovePointIds(pointId)
	local curMo = self:getMo(pointId)
	local row = curMo:getRow()
	local col = curMo:getCol()
	local directions = {
		{
			dx = 0,
			dy = 1
		},
		{
			dx = 0,
			dy = -1
		},
		{
			dx = 1,
			dy = 0
		},
		{
			dx = -1,
			dy = 0
		}
	}
	local ids = {}

	for _, direction in ipairs(directions) do
		local newRow = row + direction.dx
		local newCol = col + direction.dy
		local destPointId = self:getPointId(newRow, newCol)

		if self:isCanMove(pointId, destPointId) then
			table.insert(ids, destPointId)
		end
	end

	return ids
end

function DoushouqiGameController:getMo(pointId)
	for i, v in ipairs(self._cellMos) do
		if v:getPointId() == pointId then
			return v
		end
	end
end

function DoushouqiGameController:setCellEmpty(row, col)
	local mo = self:getMo(row, col)

	mo:setEmpty()
end

function DoushouqiGameController:_updateMoData(pointId, row, col, chess)
	local mo = self:getMo(pointId)

	mo:setRowCol(row, col)
	mo:setChess(chess)
end

function DoushouqiGameController:_init()
	self._cellMos = {}
	self._prepareUseSkillId = 0
	self._isEnterLearning = false

	local mapInfo = DoushouqiModel.instance:getMapInfo()

	DoushouqiGameController.Row = mapInfo.rows
	DoushouqiGameController.Col = mapInfo.cols
	self._chessMap = {}

	for i, v in ipairs(mapInfo.chess) do
		self._chessMap[v.pointId] = v
	end

	self:setCurRoundUserId(mapInfo.curRoundUserId)
end

function DoushouqiGameController:_clear()
	if self._cellMos then
		for _, cell in ipairs(self._cellMos) do
			cell:destroy()
		end

		self._cellMos = nil
	end

	self._curSelectMo = nil
	self._isEnterLearning = false
	self._curRoundUserId = false
	self._isMoving = false
	self._isGameEnd = false
	self._delayRobotChessActionMsg = nil
	self._isEnterTuoguan = false
end

function DoushouqiGameController:_setIsLearn(flag)
	self._isEnterLearning = flag
end

function DoushouqiGameController:isLearn()
	return self._isEnterLearning
end

function DoushouqiGameController:_updateMosData()
	local info = DoushouqiModel.instance:getMapInfo()
	local chessMap = {}

	for i, chess in ipairs(info.chess) do
		chessMap[chess.pointId] = chess
	end

	for row = 1, DoushouqiGameController.Row do
		for col = 1, DoushouqiGameController.Col do
			local pointId = self:getPointId(row, col)
			local chess = chessMap[pointId]

			if not chess then
				printInfo("doushouqi pointId对应的数据空了", pointId)
			end

			self:_updateMoData(pointId, row, col, chess)
		end
	end
end

function DoushouqiGameController:setCurRoundUserId(userId)
	self._curRoundUserId = checknumber(userId)

	GlobalDispatcher:dispatch(GlobalNotify.DoushouqiSetCurRoundUser)
end

function DoushouqiGameController:getCurRoundUserId()
	return self._curRoundUserId
end

function DoushouqiGameController:isMyRound()
	if self:isLearn() then
		return true
	end

	return self._curRoundUserId == checknumber(RoleModel.instance:getUserId())
end

function DoushouqiGameController:setCurSelectMo(mo)
	self._curSelectMo = mo
end

function DoushouqiGameController:getSelectMo()
	return self._curSelectMo
end

function DoushouqiGameController:_creatCellMos()
	self._cellMos = {}

	for row = 1, DoushouqiGameController.Row do
		for col = 1, DoushouqiGameController.Col do
			local pointId = self:getPointId(row, col)
			local chess = self._chessMap[pointId]
			local mo = DoushouqiCellMo.New()

			mo:setPointId(pointId)
			mo:setRowCol(row, col)
			mo:setChess(chess)
			table.insert(self._cellMos, mo)
		end
	end
end

function DoushouqiGameController:unlockCell(pointId)
	if self:isLearn() then
		self:_tryUnlockCellInLearn(pointId)
	else
		local actionId = DoushouqiModel.instance:getCurActionId()

		BeastFightingChessAgent.instance:sendBeastFightingChessOpenChessReq(self._activityId, pointId, actionId)
	end
end

function DoushouqiGameController:_tryUnlockCellInLearn(pointId)
	local mapInfo = DoushouqiModel.instance:getMapInfo()

	for i, v in ipairs(mapInfo.chess) do
		if v.pointId == pointId then
			v.chessType = 108
		end
	end

	self:_reduceMyStepNumInLearn(mapInfo)
	self:_refreshNewMap()
end

function DoushouqiGameController:_reduceMyStepNumInLearn(mapInfo)
	for i, v in ipairs(mapInfo.players) do
		if checknumber(v.userId) == checknumber(RoleModel.instance:getUserId()) then
			v.leftStep = v.leftStep - 1

			break
		end
	end
end

function DoushouqiGameController:_getMaxLevel()
	return 8
end

function DoushouqiGameController:_getMinLevel()
	return 1
end

function DoushouqiGameController:tryShowCanMoveCells(mo)
	local pointIds = self:getCanMovePointIds(mo:getPointId())

	if #pointIds > 0 then
		DoushouqiGameController.instance:setCurSelectMo(mo)
		GlobalDispatcher:dispatch(GlobalNotify.DoushouqiShowCanMoveCells, pointIds)
	else
		FloatWordMgr.instance:show("暂时无法移动")
	end
end

function DoushouqiGameController:getMySideId()
	return DoushouqiModel.instance:getMySideId()
end

function DoushouqiGameController:_refreshNewMap()
	DoushouqiModel.instance:setNextMapInfoToCur()

	local mapInfo = DoushouqiModel.instance:getMapInfo()

	self:_calCounterAttack(mapInfo.chess)
	self:_updateMosData()
	self:setCurRoundUserId(mapInfo.curRoundUserId)

	if #mapInfo.chess > 1 and not self:isLearn() then
		if self._curRoundUserId == checknumber(RoleModel.instance:getUserId()) then
			FloatWordMgr.instance:show("你的回合")
		else
			FloatWordMgr.instance:show("对手回合")
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.DoushouqiRefreshMap)
end

function DoushouqiGameController:_calCounterAttack(chess)
	self._counterAttackPointId = -1

	for i, v in ipairs(chess) do
		for _, state in ipairs(v.state) do
			if string.find(state, "counterAttack") then
				self._counterAttackPointId = v.pointId

				break
			end
		end
	end
end

function DoushouqiGameController:getCounterAttackPointId()
	return self._counterAttackPointId
end

function DoushouqiGameController:getPointId(row, col)
	return (row - 1) * DoushouqiGameController.Col + (col - 1)
end

function DoushouqiGameController:onNotifyBeastFightingChessGameEndRes(msg)
	self._isGameEnd = true

	GlobalDispatcher:dispatch(GlobalNotify.DoushouqiWaitforEndGame)
	settimer(1, self._delayEndGame, self, false)

	self._delayEndGameMsg = msg
end

function DoushouqiGameController:_delayEndGame()
	GlobalDispatcher:dispatch(GlobalNotify.DoushouqiRealEndGame)
	self:endGame(self._delayEndGameMsg)

	self._delayEndGameMsg = nil
end

function DoushouqiGameController:_delayRobotChessAction()
	self:onNotifyBeastFightingChessActionRes(self._delayRobotChessActionMsg, true)

	self._delayRobotChessActionMsg = nil
end

function DoushouqiGameController:onNotifyBeastFightingChessActionRes(msg, notCheckRobot)
	self:_calActionId2EndTime(msg)

	local isMyAction = checknumber(msg.actionUserId) == checknumber(RoleModel.instance:getUserId())

	if not notCheckRobot and DoushouqiModel.instance:getIsRobot() then
		if isMyAction then
			removetimer(self._delayRobotChessAction, self)
		else
			if self._delayRobotChessActionMsg then
				self:onNotifyBeastFightingChessActionRes(self._delayRobotChessActionMsg, true)
			end

			self._delayRobotChessActionMsg = msg

			settimer(1, self._delayRobotChessAction, self, false)

			return
		end
	end

	if self:getIsBeforeUseSkill() then
		self._prepareUseSkillId = 0
	end

	local skillEffect = msg.skillEffect

	self._isMoving = false

	self:clearSelectMo()
	self:_clearUseSkillParams()
	DoushouqiModel.instance:setNextMapInfo(msg.map)
	DoushouqiModel.instance:setCurActionId(msg.actionId)

	local moveAction, skillAction

	if msg.action:HasField("move") then
		moveAction = msg.action.move
	end

	if msg.action:HasField("skill") then
		skillAction = msg.action.skill
	end

	if msg.action:HasField("open") then
		self:_refreshNewMap()
		GlobalDispatcher:dispatch(GlobalNotify.DoushouqiPlayShanguangEffect, msg.action.open.targetPointId)
	elseif moveAction then
		if not isMyAction then
			local hasGedang = false

			if skillEffect then
				for i, v in ipairs(skillEffect) do
					if v.skillId == DoushouqiGameController.SkillType.Gedang then
						hasGedang = true

						break
					end
				end
			end

			if hasGedang then
				self:_refreshNewMap()
				GlobalDispatcher:dispatch(GlobalNotify.DoushouqiPlayGedangEffect, moveAction.targetPointId)
			else
				self:moveTo(moveAction.originPointId, moveAction.targetPointId, true)
			end
		else
			self:_refreshNewMap()
		end
	elseif skillAction then
		self:_playSkillAction(skillAction, msg.actionUserId)
	else
		self:_refreshNewMap()
	end

	if skillEffect then
		self:_playSkillEffect(skillEffect, msg.actionUserId)
	end
end

function DoushouqiGameController:_playSkillAction(skillAction, userId)
	if skillAction.skillId == DoushouqiGameController.SkillType.Zhuanhuo then
		local param = GameUtil.jsonToTable(skillAction.param)

		self:_changePos(param.a, param.b)
	else
		self:_refreshNewMap()
	end

	GlobalDispatcher:dispatch(GlobalNotify.DoushouqiPlaySkillAction, skillAction, userId)
end

function DoushouqiGameController:_playSkillEffect(skillEffects, userId)
	for i, v in ipairs(skillEffects) do
		GlobalDispatcher:dispatch(GlobalNotify.DoushouqiPlaySkillEffect, v, userId)
	end
end

function DoushouqiGameController:clearSelectMo()
	if self:getSelectMo() then
		self:setCurSelectMo(nil)
		GlobalDispatcher:dispatch(GlobalNotify.DoushouqiRefreshMap)
	end
end

function DoushouqiGameController:_clearZhuanhuoIds(needDispatch)
	self._zhuanhuoIds = {}

	if needDispatch == nil or needDispatch then
		GlobalDispatcher:dispatch(GlobalNotify.DoushouqiRefreshMap)
	end
end

function DoushouqiGameController:_clearUseSkillParams()
	self:_clearZhuanhuoIds()

	self._prepareUseSkillId = 0
end

function DoushouqiGameController:insertZhuanhuoPointId(pointId)
	table.insert(self._zhuanhuoIds, pointId)
end

function DoushouqiGameController:getIsZhuanhuoPointIdsEnough(pointId)
	return #self._zhuanhuoIds == 2
end

function DoushouqiGameController:getZhuanhuoPointIdsParamStr()
	local t = {
		a = self._zhuanhuoIds[1],
		b = self._zhuanhuoIds[2]
	}

	return GameUtil.jsonToString(t)
end

function DoushouqiGameController:checkSkillNeedSelectChess(skillId)
	return skillId == DoushouqiGameController.SkillType.Lianji or skillId == DoushouqiGameController.SkillType.Zhuanhuo
end

function DoushouqiGameController:beforeUseSkill(skillId)
	self:clearSelectMo()

	self._prepareUseSkillId = skillId
end

function DoushouqiGameController:getIsBeforeUseSkill()
	return self._prepareUseSkillId > 0
end

function DoushouqiGameController:checkSelectChessEnough(skillId)
	if skillId == DoushouqiGameController.SkillType.Zhuanhuo then
		local count = 0

		for row = 1, DoushouqiGameController.Row do
			for col = 1, DoushouqiGameController.Col do
				local pointId = self:getPointId(row, col)
				local mo = self:getMo(pointId)

				if mo:isUnlock() and not mo:isEmpty() and mo:getSideId() == self:getMySideId() then
					count = count + 1

					if count == 2 then
						return true
					end
				end
			end
		end
	elseif skillId == DoushouqiGameController.SkillType.Lianji then
		for row = 1, DoushouqiGameController.Row do
			for col = 1, DoushouqiGameController.Col do
				local pointId = self:getPointId(row, col)
				local mo = self:getMo(pointId)

				if mo:isUnlock() and not mo:isEmpty() and mo:getSideId() == self:getMySideId() then
					local pointIds = self:getCanMovePointIds(mo:getPointId())

					if #pointIds > 0 then
						return true
					end
				end
			end
		end
	else
		return true
	end

	return false
end

function DoushouqiGameController:sendBeastFightingChessReleaseSkillReq(activityId, skillId, targetPointId, param, actionId)
	self:_clearUseSkillParams()

	if self:isLearn() then
		if skillId ~= 2 then
			printError("只能用先知")

			return
		end

		self:_tryUseSkillInLearn()
	else
		BeastFightingChessAgent.instance:sendBeastFightingChessReleaseSkillReq(activityId, skillId, targetPointId, param, actionId)
	end
end

function DoushouqiGameController:isCanEat(srcPointId, destPointId)
	local srcMo = self:getMo(srcPointId)
	local destMo = self:getMo(destPointId)

	if srcMo:getLevel() == self:_getMinLevel() and destMo:getLevel() == self:_getMaxLevel() or srcMo:getLevel() > destMo:getLevel() then
		return true
	end

	return false
end

function DoushouqiGameController:_tryUseSkillInLearn()
	local mapInfo = DoushouqiModel.instance:getMapInfo()

	for _, chess in ipairs(mapInfo.chess) do
		for _, v in ipairs(chess.state) do
			if string.find(v, "clientKnow") then
				local str = string.gsub(v, "clientKnow", "know")

				table.insert(chess.state, str)

				for _, player in ipairs(mapInfo.players) do
					if checknumber(player.userId) == checknumber(RoleModel.instance:getUserId()) then
						player.usedSkill = true

						break
					end
				end

				self:_refreshNewMap()

				return
			end
		end
	end
end

function DoushouqiGameController:isGameEnding()
	return self._isGameEnd
end

function DoushouqiGameController:openTuoguan()
	if self._isEnterTuoguan then
		return
	end

	self._isEnterTuoguan = true

	local text = "由于长时间未操作，系统托管中"

	TipsFacade.instance:openTipWindowNoX("提示", text, function()
		self._isEnterTuoguan = false

		GlobalDispatcher:dispatch(GlobalNotify.DoushouqiSetMyOperation)

		if self._cacheEndGameMsg then
			local msg = self._cacheEndGameMsg

			self._cacheEndGameMsg = nil

			self:endGame(msg)
		end
	end, "回到游戏")
end

function DoushouqiGameController:_calActionId2EndTimeWithMapInfo()
	local actionId = DoushouqiModel.instance:getCurActionId()
	local mapInfo = DoushouqiModel.instance:getMapInfo()
	local curRoundUserId = checknumber(mapInfo.curRoundUserId)
	local time = 0

	for i, v in ipairs(mapInfo.players) do
		if checknumber(v.userId) == curRoundUserId then
			local hadHangUp = v.hadHangUp

			if hadHangUp then
				time = DoushouqiConfig.instance:getRoundSecAfterHangUp(self._activityId)

				break
			end

			time = DoushouqiConfig.instance:getRoundSec(self._activityId)

			break
		end
	end

	time = time or 20
	self._actionId2EndTimeMap[actionId] = ServerTime.now() + time
end

function DoushouqiGameController:_calActionId2EndTime(msg)
	local curRoundUserId = checknumber(msg.map.curRoundUserId)
	local time = 0

	for i, v in ipairs(msg.map.players) do
		if checknumber(v.userId) == curRoundUserId then
			local hadHangUp = v.hadHangUp

			if hadHangUp then
				time = DoushouqiConfig.instance:getRoundSecAfterHangUp(self._activityId)

				break
			end

			time = DoushouqiConfig.instance:getRoundSec(self._activityId)

			break
		end
	end

	time = time or 20
	self._actionId2EndTimeMap[msg.actionId] = ServerTime.now() + time
end

function DoushouqiGameController:getActionEndTime(actionId)
	return self._actionId2EndTimeMap[actionId]
end

DoushouqiGameController.instance = DoushouqiGameController.New()

return DoushouqiGameController
