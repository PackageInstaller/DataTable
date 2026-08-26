-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/model/TowerV3a7RoomMO.lua

module("modules.logic.versionactivity3_7.towerv3a7.model.TowerV3a7RoomMO", package.seeall)

local TowerV3a7RoomMO = class("TowerV3a7RoomMO")

function TowerV3a7RoomMO:init(id)
	self.id = id
	self.chessList = {}
	self.camp1List = {}
	self.camp2List = {}
	self.tempList = {}
	self._skillResult = {}
	self._recoverList = {}
	self._pathFindInfo = {}
	self._nextEnemyAttackTime = 0
	self._nextOwnAttackTime = 0
	self._nextRecoverTime = 0
	self._nextEnemyFindTime = 0
end

function TowerV3a7RoomMO:addChess(chess)
	if self:getChessNum() >= TowerV3a7Enum.MaxChessNum then
		logError("room chess num is max id:" .. self.id .. " checss id:" .. chess.id)

		return false
	end

	if chess.chessConfig.belong == TowerV3a7Enum.Camp.Own then
		table.insert(self.camp1List, chess)
	elseif chess.chessConfig.belong == TowerV3a7Enum.Camp.Enemy then
		table.insert(self.camp2List, chess)
	else
		logError("addChess error camp id:", chess.id)

		return false
	end

	table.insert(self.chessList, chess)

	return true
end

function TowerV3a7RoomMO:addTempChess(chess)
	table.insert(self.tempList, chess)
end

function TowerV3a7RoomMO:removeChess(chess)
	tabletool.removeValue(self.chessList, chess)
	tabletool.removeValue(self.camp1List, chess)
	tabletool.removeValue(self.camp2List, chess)
	tabletool.removeValue(self.tempList, chess)
end

function TowerV3a7RoomMO:getChessNum()
	return #self.chessList + #self.tempList
end

function TowerV3a7RoomMO:getCamp1Num()
	return #self.camp1List
end

function TowerV3a7RoomMO:getCamp2Num()
	return #self.camp2List
end

function TowerV3a7RoomMO:_getCamp1SkillResult()
	tabletool.clear(self._skillResult)

	for i, mo in ipairs(self.camp1List) do
		self:_fillSkillResult(mo, self._skillResult)
	end

	return self._skillResult
end

function TowerV3a7RoomMO:_fillSkillResult(mo, result)
	if mo.skillType == TowerV3a7Enum.SkillType.Type1 then
		if math.random(0, 1000) < mo.skillParam then
			result.recoverOne = true
		end
	elseif mo.skillType == TowerV3a7Enum.SkillType.Type2 then
		-- block empty
	elseif mo.skillType == TowerV3a7Enum.SkillType.Type3 then
		if math.random(0, 1000) < mo.skillParam then
			result.doubleHurt = true
		end
	elseif mo.skillType == TowerV3a7Enum.SkillType.Type4 then
		result.recoverAll = true
	elseif not string.nilorempty(mo.skillType) then
		logError("TowerV3a7RoomMO _fillSkillResult skillType error", mo.id)
	end
end

function TowerV3a7RoomMO:_prepareFight()
	for i, mo in ipairs(self.camp1List) do
		mo:prepareFight()
	end

	for i, mo in ipairs(self.camp2List) do
		mo:prepareFight()
	end
end

function TowerV3a7RoomMO:_endFight()
	for i, mo in ipairs(self.camp1List) do
		mo:endFight()
	end

	for i, mo in ipairs(self.camp2List) do
		mo:endFight()
	end
end

function TowerV3a7RoomMO:_campListAddHurt(campList, hurt, isOne)
	if isOne then
		for i = 1, #campList do
			local index = math.random(1, #campList)
			local mo = campList[index]

			if not mo:deadInFight() then
				mo:addHurt(hurt)

				return
			end
		end

		for i, mo in ipairs(campList) do
			if not mo:deadInFight() then
				mo:addHurt(hurt)

				return
			end
		end

		return
	end

	for i, mo in ipairs(campList) do
		if not mo:deadInFight() then
			mo:addHurt(hurt)
		end
	end
end

function TowerV3a7RoomMO.setFight(value)
	TowerV3a7RoomMO.isFighting = value
end

function TowerV3a7RoomMO.isFight()
	if TowerV3a7Model.instance:getWin() then
		return false
	end

	return TowerV3a7RoomMO.isFighting
end

function TowerV3a7RoomMO:update()
	if TowerV3a7Model.instance:getPause() then
		return
	end

	local time = TowerV3a7Model.instance:getTime()
	local constParams = TowerV3a7Config.instance:getConstParams()
	local camp1Num = self:getCamp1Num()
	local camp2Num = self:getCamp2Num()

	self:_prepareFight()

	local camp1Result = 0
	local camp2Result = 0

	if camp1Num > 0 and camp2Num > 0 then
		TowerV3a7RoomMO.setFight(true)

		for _, mo in ipairs(self.camp1List) do
			local alive = not mo:deadInFight()

			if alive and (mo.attackTime == 0 or time >= mo.attackTime) then
				mo.attackTime = time + 1 / constParams.attackPerSecond

				tabletool.clear(self._skillResult)
				self:_fillSkillResult(mo, self._skillResult)

				camp2Result = -1

				if self._skillResult.doubleHurt then
					camp2Result = camp2Result * 2
				end

				self:_campListAddHurt(self.camp2List, camp2Result, true)

				if self._skillResult.recoverOne or self._skillResult.recoverAll then
					mo:addHurt(1)
				end
			end
		end

		for _, mo in ipairs(self.camp2List) do
			if not mo:deadInFight() and (mo.attackTime == 0 or time >= mo.attackTime) then
				mo.attackTime = time + 1 / constParams.attackPerSecond

				if (camp2Num < camp1Num and constParams.enemyAttackProb2 or camp1Num < camp2Num and constParams.enemyAttackProb3 or constParams.enemyAttackProb1) > math.random(0, 1000) then
					camp1Result = -1

					self:_campListAddHurt(self.camp1List, -1, true)
				end
			end
		end
	elseif camp1Num > 0 and (self._nextRecoverTime == 0 or time >= self._nextRecoverTime) then
		self._nextRecoverTime = time + constParams.recoverPerSecond

		self:_campListAddHurt(self.camp1List, TowerV3a7Enum.RecoverHpValue)
	end

	self:_endFight()
end

function TowerV3a7RoomMO:updateChessPathfinding()
	self:_updateEnemyFind()
	self:_updateOwnFind()
end

function TowerV3a7RoomMO:_updateOwnFind()
	local time = TowerV3a7Model.instance:getTime()

	for i, mo in ipairs(self.camp1List) do
		local targetRoomId = mo:getTargetRoomId()

		if targetRoomId > 0 then
			tabletool.clear(self._pathFindInfo)

			local roomConnectMap = TowerV3a7RoomModel.instance:getRoomConnectList()
			local result = self:_findTargetRoom(self._pathFindInfo, self.id, roomConnectMap, targetRoomId)
			local nextRoomId = result and self._pathFindInfo[1]

			if nextRoomId then
				::label_17_0::

				local nextRoomMo = TowerV3a7RoomModel.instance:getRoomMo(nextRoomId)

				if nextRoomMo and self.id ~= targetRoomId and nextRoomMo:getChessNum() < TowerV3a7Enum.MaxChessNum and (mo.pathfindingTime == 0 or time >= mo.pathfindingTime) then
					mo.pathfindingTime = time + TowerV3a7Enum.ChessFindTime

					if not mo:isDead() and mo:getState() == TowerV3a7Enum.ChessState.Normal then
						TowerV3a7ChessManModel.instance:autoMoveChess(mo, nextRoomMo)
					end
				end
			end
		end
	end
end

function TowerV3a7RoomMO:_updateEnemyFind()
	local camp1Num = self:getCamp1Num()
	local camp2Num = self:getCamp2Num()

	if camp2Num > 0 and camp1Num <= 0 then
		local time = TowerV3a7Model.instance:getTime()
		local index = 1

		for i = 1, #self.camp2List do
			local mo = self.camp2List[index]

			if mo.pathfindingTime ~= 0 and time >= mo.pathfindingTime then
				if not mo:isDead() and mo:getState() == TowerV3a7Enum.ChessState.Normal then
					self:_moveEnemyToOtherRoom()

					break
				else
					index = index + 1
				end
			else
				if mo.pathfindingTime == 0 then
					mo.pathfindingTime = time + TowerV3a7Enum.ChessFindTime
				end

				index = index + 1
			end
		end
	end
end

function TowerV3a7RoomMO:_moveEnemyToOtherRoom()
	local roomConnectMap = TowerV3a7RoomModel.instance:getRoomConnectList()
	local result = self:_findNearestAttackRoom(self.id, roomConnectMap)

	if not result then
		return
	end

	local nextRoomId = result[1]
	local nextRoomMo = TowerV3a7RoomModel.instance:getRoomMo(nextRoomId)

	if not nextRoomMo then
		return
	end

	local time = TowerV3a7Model.instance:getTime()
	local index = 1

	for i = 1, #self.camp2List do
		if nextRoomMo:getChessNum() < TowerV3a7Enum.MaxChessNum then
			local mo = self.camp2List[index]

			if mo.pathfindingTime ~= 0 and time >= mo.pathfindingTime then
				if not mo:isDead() and mo:getState() == TowerV3a7Enum.ChessState.Normal then
					mo.pathfindingTime = time + TowerV3a7Enum.ChessFindTime

					TowerV3a7ChessManModel.instance:autoMoveChess(mo, nextRoomMo)
				else
					index = index + 1
				end
			else
				if mo.pathfindingTime == 0 then
					mo.pathfindingTime = time + TowerV3a7Enum.ChessFindTime
				end

				index = index + 1
			end
		else
			break
		end
	end
end

function TowerV3a7RoomMO:_findTargetRoom(findInfo, fromId, roomConnectMap, targetId)
	local key = "room" .. fromId

	if findInfo[key] then
		return
	end

	findInfo[key] = true

	local roomMo = TowerV3a7RoomModel.instance:getRoomMo(fromId)

	if not roomMo then
		return
	end

	if fromId == targetId and roomMo:getChessNum() < TowerV3a7Enum.MaxChessNum then
		return true
	end

	local list = roomConnectMap[fromId]

	if not list then
		return
	end

	for _, roomId in ipairs(list) do
		if self:_findTargetRoom(findInfo, roomId, roomConnectMap, targetId) then
			table.insert(self._pathFindInfo, 1, roomId)

			return true
		end
	end
end

function TowerV3a7RoomMO:_findNearestAttackRoom(fromId, roomConnectMap)
	local neighbors = roomConnectMap[fromId]

	if not neighbors then
		return nil
	end

	local visited = {
		[fromId] = true
	}
	local parentMap = {}
	local queue = {}
	local head = 1

	for _, roomId in ipairs(neighbors) do
		if not visited[roomId] then
			visited[roomId] = true
			parentMap[roomId] = fromId
			queue[#queue + 1] = roomId
		end
	end

	while head <= #queue do
		local curId = queue[head]

		head = head + 1

		if self:_canAttack(curId) then
			local path = {}
			local id = curId

			while id and id ~= fromId do
				path[#path + 1] = id
				id = parentMap[id]
			end

			local n = #path

			for i = 1, n / 2 do
				path[n - i + 1] = path[i]
				path[i] = path[n - i + 1]
			end

			return path
		end

		local curNeighbors = roomConnectMap[curId]

		if curNeighbors then
			for _, neighborId in ipairs(curNeighbors) do
				if not visited[neighborId] then
					visited[neighborId] = true
					parentMap[neighborId] = curId
					queue[#queue + 1] = neighborId
				end
			end
		end
	end

	return nil
end

function TowerV3a7RoomMO:_canAttack(roomId)
	local roomMo = TowerV3a7RoomModel.instance:getRoomMo(roomId)

	if not roomMo then
		return false
	end

	return roomMo:getCamp1Num() > 0 and roomMo:getChessNum() < TowerV3a7Enum.MaxChessNum
end

return TowerV3a7RoomMO
