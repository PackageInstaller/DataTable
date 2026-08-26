-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/Activity201MaLiAnNaGameModel.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.Activity201MaLiAnNaGameModel", package.seeall)

local Activity201MaLiAnNaGameModel = class("Activity201MaLiAnNaGameModel", BaseModel)

function Activity201MaLiAnNaGameModel:onInit()
	self:reInit()
end

function Activity201MaLiAnNaGameModel:reInit()
	self._curGameId = nil
	self._disPatchId = 1
	self._disPatchSlotList = {}
	self._allDisPatchSolider = {}
	self._gameTime = 0
	self._maxGameTime = 0

	MaLiAnNaLaSoliderMoUtil.instance:init()

	self._allActiveSkill = {}
end

function Activity201MaLiAnNaGameModel:initGameData(gameId)
	self:clear()

	self._curGameId = gameId
	self._gameConfig = Activity201MaLiAnNaConfig.instance:getGameConfigById(gameId)
	self._winCondition = Activity201MaLiAnNaConfig.instance:getWinConditionById(gameId)
	self._loseCondition = Activity201MaLiAnNaConfig.instance:getLoseConditionById(gameId)

	local battleId = self._gameConfig.battleGroup

	self._gameMo = MaLiAnNaGameMo.create(battleId)

	local data = Activity201MaLiAnNaConfig.instance:getMaLiAnNaLevelDataByLevelId(battleId)

	self._gameMo:init(data)

	self._gameTime = 0
	self._maxGameTime = self._gameConfig.battleTime or 0
	self._dispatchHeroFirst = false

	self:_initActiveSkill()
end

function Activity201MaLiAnNaGameModel:getCurGameId()
	return self._curGameId
end

function Activity201MaLiAnNaGameModel:update(deltaTime)
	self._gameTime = self._gameTime + deltaTime

	if self._gameMo ~= nil then
		self._gameMo:update(deltaTime)
	end

	if self._allDisPatchSolider ~= nil then
		for _, solider in pairs(self._allDisPatchSolider) do
			if solider then
				solider:update(deltaTime)

				if isDebugBuild then
					-- block empty
				end
			end
		end
	end

	self:updateAllActive(deltaTime)
end

function Activity201MaLiAnNaGameModel:getGameMo()
	return self._gameMo
end

function Activity201MaLiAnNaGameModel:getDispatchHeroFirst()
	return self._dispatchHeroFirst
end

function Activity201MaLiAnNaGameModel:setDispatchHeroFirst(state)
	self._dispatchHeroFirst = state
end

function Activity201MaLiAnNaGameModel:getCurGameConfig()
	return self._gameConfig
end

function Activity201MaLiAnNaGameModel:getAllSlot()
	if self._gameMo == nil then
		return nil
	end

	return self._gameMo:getAllSlot()
end

function Activity201MaLiAnNaGameModel:allDisPatchSolider()
	return self._allDisPatchSolider
end

function Activity201MaLiAnNaGameModel:getSlotById(id)
	if self._gameMo == nil then
		return nil
	end

	return self._gameMo:getSlotById(id)
end

function Activity201MaLiAnNaGameModel:getSlotByConfigId(configId)
	if self._gameMo == nil then
		return nil
	end

	return self._gameMo:getSlotByConfigId(configId)
end

function Activity201MaLiAnNaGameModel:getAllRoad()
	if self._gameMo == nil then
		return nil
	end

	return self._gameMo.roads
end

function Activity201MaLiAnNaGameModel:getRoadGraph()
	if self._gameMo == nil then
		return nil
	end

	return self._gameMo:getRoadGraph()
end

function Activity201MaLiAnNaGameModel:addDisPatchSolider(solider)
	if self._allDisPatchSolider == nil then
		self._allDisPatchSolider = {}
	end

	if solider then
		self._allDisPatchSolider[solider:getId()] = solider
	end
end

function Activity201MaLiAnNaGameModel:isInAttackState(slot)
	if self._allDisPatchSolider == nil then
		return false
	end

	for _, solider in pairs(self._allDisPatchSolider) do
		if solider and solider:getCurState() == Activity201MaLiAnNaEnum.SoliderState.Moving then
			local targetSlotId = solider:getTargetSlotId()

			if targetSlotId == slot:getId() then
				return true
			end
		end
	end

	return false
end

function Activity201MaLiAnNaGameModel:soliderDead(soliderMo)
	local allSlot = self:getAllSlot()

	if allSlot then
		for _, slot in pairs(allSlot) do
			local finish = slot:soliderDead(soliderMo)

			if finish then
				return
			end
		end
	end
end

function Activity201MaLiAnNaGameModel:removeDisPatchSolider(soliderId)
	if soliderId == nil or self._allDisPatchSolider == nil then
		return false
	end

	if self._allDisPatchSolider[soliderId] then
		self._allDisPatchSolider[soliderId] = nil

		return true
	end

	return false
end

function Activity201MaLiAnNaGameModel:getShowTime()
	return math.max(0, math.floor(self._maxGameTime - self._gameTime))
end

function Activity201MaLiAnNaGameModel:getGameTime()
	return self._gameTime
end

function Activity201MaLiAnNaGameModel:isLoseByTime()
	return self._gameTime >= self._maxGameTime
end

function Activity201MaLiAnNaGameModel:isLoseByTarget()
	if self._loseCondition == nil then
		return false
	end

	local isLose = false
	local loseData

	for i = 1, #self._loseCondition do
		local data = self._loseCondition[i]

		if self:checkCondition(data) then
			isLose = true
			loseData = data

			break
		end
	end

	return isLose, loseData
end

function Activity201MaLiAnNaGameModel:isWin()
	if self._winCondition == nil then
		return false
	end

	local isWin = true

	for i = 1, #self._winCondition do
		local data = self._winCondition[i]

		if not self:checkCondition(data) then
			isWin = false

			break
		end
	end

	return isWin
end

function Activity201MaLiAnNaGameModel:gameIsOver()
	local isWin = self:isWin()
	local isLose = self:isLoseByTime() or self:isLoseByTarget()

	return isWin or isLose, isWin, isLose
end

function Activity201MaLiAnNaGameModel:canDisPatch(slotIdA, slotIdB)
	if slotIdA == nil and slotIdB == nil then
		return false
	end

	if slotIdB == nil then
		return true
	end

	local slotA = self:getSlotById(slotIdA)
	local slotB = self:getSlotById(slotIdB)

	if slotA and slotB then
		return (self._gameMo:haveRoad(slotIdA, slotIdB))
	end

	return false
end

function Activity201MaLiAnNaGameModel:checkPosAndDisPatch(posX, posY)
	local slotId
	local allSlots = self:getAllSlot()

	for _, slot in pairs(allSlots) do
		if slot and slot:isInCanSelectRange(posX, posY) then
			slotId = slot:getId()

			break
		end
	end

	if slotId ~= nil then
		self:_addDisPatch(slotId)
	end
end

function Activity201MaLiAnNaGameModel:inSlotCanSelectRange(posX, posY)
	local slotId
	local allSlots = self:getAllSlot()

	for _, slot in pairs(allSlots) do
		if slot and slot:isInCanSelectRange(posX, posY) then
			slotId = slot:getId()

			break
		end
	end

	return slotId ~= nil, slotId
end

function Activity201MaLiAnNaGameModel:_addDisPatch(slotId)
	if self._disPatchSlotList == nil then
		self._disPatchSlotList = {}
	end

	local count = #self._disPatchSlotList
	local slotIdA = count == 0 and slotId or self._disPatchSlotList[#self._disPatchSlotList]
	local slotIdB = count > 0 and slotId or nil
	local canAdd = true

	for i = 1, count do
		if self._disPatchSlotList[i] == slotId then
			canAdd = false
		end
	end

	if canAdd and self:canDisPatch(slotIdA, slotIdB) then
		table.insert(self._disPatchSlotList, slotId)

		return true
	end

	return false
end

function Activity201MaLiAnNaGameModel:disPatch(disPatchId)
	if self._disPatchSlotList == nil or #self._disPatchSlotList <= 1 then
		self:clearDisPatch()

		return
	end

	local beginSlotId = self._disPatchSlotList[1]
	local slotMo = self._gameMo:getSlotById(beginSlotId)

	if slotMo then
		slotMo:setDispatchSoldierInfo(disPatchId, self._disPatchSlotList, self:getDispatchHeroFirst())
	end

	self:clearDisPatch()
end

function Activity201MaLiAnNaGameModel:getDisPatchSlotList()
	return self._disPatchSlotList
end

function Activity201MaLiAnNaGameModel:clearDisPatch()
	if self._disPatchSlotList then
		tabletool.clear(self._disPatchSlotList)
	end
end

function Activity201MaLiAnNaGameModel:getNextDisPatchId()
	if self._disPatchId == nil then
		self._disPatchId = 0
	end

	self._disPatchId = self._disPatchId + 1

	return self._disPatchId
end

function Activity201MaLiAnNaGameModel:checkCondition(conditionData, otherParam)
	local isFinish = false

	if conditionData == nil then
		return isFinish, nil
	end

	local conditionType = conditionData[1]

	if Activity201MaLiAnNaEnum.ConditionType.occupySlot == conditionType then
		local slotId = conditionData[2]
		local camp = conditionData[3]
		local slot = self:getSlotByConfigId(slotId)

		if slot and camp and slot:getSlotCamp() == camp then
			isFinish = true
		end
	end

	if Activity201MaLiAnNaEnum.ConditionType.soldierHeroDead == conditionType then
		local soliderConfigId = conditionData[2]

		if soliderConfigId then
			local soliderMo = MaLiAnNaLaSoliderMoUtil.instance:getSoliderMoByConfigId(soliderConfigId)

			if soliderMo == nil or soliderMo:getCurState() == Activity201MaLiAnNaEnum.SoliderState.Dead then
				isFinish = true
			end
		end
	end

	if Activity201MaLiAnNaEnum.ConditionType.gameStart == conditionType or Activity201MaLiAnNaEnum.ConditionType.gameOverAndWin == conditionType then
		isFinish = true
	end

	if Activity201MaLiAnNaEnum.ConditionType.useSkill == conditionType then
		local needUseSkillId = conditionData[2]

		if otherParam then
			local useSkillId = otherParam.skillId

			if useSkillId and needUseSkillId == useSkillId then
				isFinish = true
			end
		end
	end

	return isFinish, conditionType
end

function Activity201MaLiAnNaGameModel:_initActiveSkill()
	local skillStr = self._gameConfig.skill

	if not string.nilorempty(skillStr) then
		local allSkill = string.splitToNumber(skillStr, "#")

		for _, skillConfigId in ipairs(allSkill) do
			local skillMo = MaLiAnNaSkillUtils.instance.createSkill(skillConfigId)

			if skillMo then
				self._allActiveSkill[#self._allActiveSkill + 1] = skillMo
			end
		end
	end
end

function Activity201MaLiAnNaGameModel:getAllActiveSkill()
	return self._allActiveSkill
end

function Activity201MaLiAnNaGameModel:updateAllActive(deltaTime)
	if self._allActiveSkill == nil or #self._allActiveSkill <= 0 then
		return
	end

	for _, skill in ipairs(self._allActiveSkill) do
		if skill then
			skill:update(deltaTime)
		end
	end
end

function Activity201MaLiAnNaGameModel:isMyCampBase(slotId)
	if self._loseCondition == nil or slotId == nil then
		return false
	end

	if self._loseCondition then
		for i = 1, #self._loseCondition do
			local data = self._loseCondition[i]

			if data then
				local conditionType = data[1]

				if Activity201MaLiAnNaEnum.ConditionType.occupySlot == conditionType then
					local id = data[2]

					if id == slotId then
						return true
					end
				end
			end
		end
	end

	return false
end

function Activity201MaLiAnNaGameModel:isEnemyBase(slotId)
	if self._winCondition == nil or slotId == nil then
		return false
	end

	if self._winCondition then
		for i = 1, #self._winCondition do
			local data = self._winCondition[i]

			if data then
				local conditionType = data[1]

				if Activity201MaLiAnNaEnum.ConditionType.occupySlot == conditionType then
					local id = data[2]

					if id == slotId then
						return true
					end
				end
			end
		end
	end

	return false
end

function Activity201MaLiAnNaGameModel:clear()
	if self._allDisPatchSolider ~= nil then
		tabletool.clear(self._allDisPatchSolider)

		self._allDisPatchSolider = nil
	end

	MaLiAnNaLaSoliderMoUtil.instance:clear()
	self:reInit()
end

function Activity201MaLiAnNaGameModel:destroy()
	self:clear()

	if self._gameMo then
		self._gameMo:destroy()

		self._gameMo = nil
	end

	self._allDisPatchSolider = nil
	self._disPatchSlotList = nil

	if self._allActiveSkill then
		for _, skill in ipairs(self._allActiveSkill) do
			if skill then
				skill:destroy()
			end
		end
	end

	self._allActiveSkill = nil
end

Activity201MaLiAnNaGameModel.instance = Activity201MaLiAnNaGameModel.New()

return Activity201MaLiAnNaGameModel
