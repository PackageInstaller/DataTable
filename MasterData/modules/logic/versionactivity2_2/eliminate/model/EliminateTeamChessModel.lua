-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/EliminateTeamChessModel.lua

module("modules.logic.versionactivity2_2.eliminate.model.EliminateTeamChessModel", package.seeall)

local EliminateTeamChessModel = class("EliminateTeamChessModel", BaseModel)

function EliminateTeamChessModel:onInit()
	self.curTeamChessWar = nil
	self.serverTeamChessWar = nil
	self.warFightResult = nil
	self.teamChessStepList = {}
	self._curTeamRoundStepState = EliminateTeamChessEnum.TeamChessRoundType.enemy
end

function EliminateTeamChessModel:reInit()
	self.curTeamChessWar = nil
	self.serverTeamChessWar = nil
	self.warFightResult = nil
	self._teamChessSkillState = nil
	self.teamChessStepList = {}
end

function EliminateTeamChessModel:initTeamChess(warChessId)
	self._warChessId = warChessId
end

function EliminateTeamChessModel:getCurWarChessEpisodeConfig()
	return EliminateConfig.instance:getWarChessEpisodeConfig(self._warChessId)
end

function EliminateTeamChessModel:handleCurTeamChessWarFightInfo(info)
	if self.curTeamChessWar == nil then
		self.curTeamChessWar = EliminateTeamChessWarMO.New()

		self.curTeamChessWar:init(info)
	end

	self.curTeamChessWar:updateInfo(info)
end

function EliminateTeamChessModel:handleServerTeamChessWarFightInfo(info)
	if self.serverTeamChessWar == nil then
		self.serverTeamChessWar = EliminateTeamChessWarMO.New()

		self.serverTeamChessWar:init(info)
	end

	self.serverTeamChessWar:updateInfo(info)
end

function EliminateTeamChessModel:handleTeamFightResult(result)
	self.warFightResult = self.warFightResult or WarChessFightResultMO.New()

	self.warFightResult:updateInfo(result)
end

function EliminateTeamChessModel:handleTeamFightTurn(turn)
	if turn == nil or turn.step == nil then
		return
	end

	for _, data in ipairs(turn.step) do
		local step = WarChessStepMO.New()

		step:init(data)

		self.teamChessStepList[#self.teamChessStepList + 1] = step
	end
end

function EliminateTeamChessModel:getTeamChessStepList()
	return self.teamChessStepList
end

function EliminateTeamChessModel:getCurTeamChessWar()
	return self.curTeamChessWar
end

function EliminateTeamChessModel:getServerTeamChessWar()
	return self.serverTeamChessWar
end

function EliminateTeamChessModel:getSlotIds()
	return self.curTeamChessWar and self.curTeamChessWar:getSlotIds() or {}
end

function EliminateTeamChessModel:getStrongholds()
	return self.curTeamChessWar and self.curTeamChessWar:getStrongholds() or {}
end

function EliminateTeamChessModel:getStronghold(id)
	return self.curTeamChessWar and self.curTeamChessWar:getStronghold(id) or nil
end

function EliminateTeamChessModel:getCurTeamMyInfo()
	return (self.curTeamChessWar or nil) and (self.curTeamChessWar.myCharacter or nil)
end

function EliminateTeamChessModel:getCurTeamEnemyInfo()
	return (self.curTeamChessWar or nil) and (self.curTeamChessWar.enemyCharacter or nil)
end

function EliminateTeamChessModel:getEnemyForecastChess()
	local enemyInfo = EliminateTeamChessModel.instance:getCurTeamEnemyInfo()

	if enemyInfo then
		local forecastChess = enemyInfo.forecastBehavior

		if #forecastChess ~= 0 then
			return forecastChess
		end
	end

	return nil
end

function EliminateTeamChessModel:getAllPlayerSoliderCount()
	local strongholds = self:getStrongholds()
	local playerSoliderCount = 0

	for _, stronghold in pairs(strongholds) do
		playerSoliderCount = playerSoliderCount + stronghold:getPlayerSoliderCount()
	end

	return playerSoliderCount
end

function EliminateTeamChessModel:getCurTeamResource()
	local curTeamMyInfo = self:getCurTeamMyInfo()

	return (curTeamMyInfo or nil) and (curTeamMyInfo.diamonds or {})
end

function EliminateTeamChessModel:getResourceNumber(resourceId)
	local curTeamMyInfo = self:getCurTeamMyInfo()

	return (curTeamMyInfo and curTeamMyInfo.diamonds or nil) and (curTeamMyInfo.diamonds[resourceId] or 0)
end

function EliminateTeamChessModel:getWarFightResult()
	return self.warFightResult
end

function EliminateTeamChessModel:updateChessPower(uid, diffValue)
	if self.curTeamChessWar then
		self.curTeamChessWar:updateChessPower(uid, diffValue)
	end
end

function EliminateTeamChessModel:updateDisplacementState(uid, displacementState)
	if self.curTeamChessWar then
		self.curTeamChessWar:updateDisplacementState(uid, displacementState)
	end
end

function EliminateTeamChessModel:updateStrongholdsScore(strongholdId, teamType, diffValue)
	if self.curTeamChessWar then
		self.curTeamChessWar:updateStrongholdsScore(strongholdId, teamType, diffValue)
	end
end

function EliminateTeamChessModel:updateMainCharacterHp(teamType, diffValue)
	if self.curTeamChessWar then
		self.curTeamChessWar:updateMainCharacterHp(teamType, diffValue)
	end
end

function EliminateTeamChessModel:updateMainCharacterPower(teamType, diffValue)
	if self.curTeamChessWar then
		self.curTeamChessWar:updateMainCharacterPower(teamType, diffValue)
	end
end

function EliminateTeamChessModel:updateResourceData(resourceId, diffValue)
	if self.curTeamChessWar then
		self.curTeamChessWar:updateResourceData(resourceId, diffValue)
	end
end

function EliminateTeamChessModel:removeStrongholdChess(strongholdId, uid)
	if self.curTeamChessWar then
		self.curTeamChessWar:removeStrongholdChess(strongholdId, uid)
	end
end

function EliminateTeamChessModel:getChess(uid)
	if self.curTeamChessWar then
		return self.curTeamChessWar:getChess(uid)
	end

	return nil
end

function EliminateTeamChessModel:strongHoldSettle(strongHoldId, state)
	if self.curTeamChessWar then
		self.curTeamChessWar:strongHoldSettle(strongHoldId, state)
	end
end

function EliminateTeamChessModel:updateSkillGrowUp(uid, skillId, upValue)
	if self.curTeamChessWar then
		self.curTeamChessWar:updateSkillGrowUp(uid, skillId, upValue)
	end
end

function EliminateTeamChessModel:diamondsIsEnough(diamondId, needCount)
	if not self.curTeamChessWar then
		return false
	end

	return self.curTeamChessWar:diamondsIsEnough(diamondId, needCount)
end

function EliminateTeamChessModel:getViewCanvas()
	return self._canvas
end

function EliminateTeamChessModel:setViewCanvas(canvas)
	self._canvas = canvas
end

function EliminateTeamChessModel:getTipViewParent()
	return self._tipViewParent
end

function EliminateTeamChessModel:setTipViewParent(parent)
	self._tipViewParent = parent
end

function EliminateTeamChessModel:setCurTeamRoundStepState(state)
	self._curTeamRoundStepState = state
end

function EliminateTeamChessModel:getCurTeamRoundStepState()
	return self._curTeamRoundStepState
end

function EliminateTeamChessModel:clear()
	self._canvas = nil
	self._tipViewParent = nil
	self.curTeamChessWar = nil
	self.serverTeamChessWar = nil
	self.warFightResult = nil
	self.teamChessStepList = {}

	if self._cacheRuleLimit ~= nil then
		self._cacheRuleLimit = nil
	end

	self._curTeamRoundStepState = EliminateTeamChessEnum.TeamChessRoundType.enemy
end

function EliminateTeamChessModel:getSellResourceData(costList)
	local costData = {}
	local sellSoliderPermillage = EliminateConfig.instance:getSellSoliderPermillage()

	for i = 1, #costList do
		local cost = costList[i]
		local num = math.floor(cost[2] * sellSoliderPermillage / 1000)

		table.insert(costData, {
			cost[1],
			num
		})
	end

	return costData
end

function EliminateTeamChessModel:canUseChess(soliderId)
	local costList = EliminateConfig.instance:getSoldierChessConfigConst(soliderId)
	local canUse = true

	if costList then
		for _, cost in ipairs(costList) do
			local resourceId = cost[1]
			local num = tonumber(cost[2])
			local haveNum = self:getResourceNumber(resourceId)

			if haveNum < num then
				canUse = false

				break
			end
		end
	else
		canUse = true
	end

	return canUse
end

function EliminateTeamChessModel:getSoliderIdEffectParam(soliderId)
	local config = EliminateConfig.instance:getSoldierChessConfig(soliderId)

	if config then
		if not config.skillId then
			local skillIds = ""

			for _, skillId in ipairs(string.splitToNumber(skillIds, "#")) do
				local skillConfig = EliminateConfig.instance:getSoldierSkillConfig(skillId)

				if skillConfig then
					local effects = string.split(skillConfig.effect or "", "#")
					local effectType = effects[1]

					if EliminateTeamChessEnum.placeSkillEffectParamConfigEnum[effectType] then
						local effectParam = effects[2]
						local effectParamConfig = EliminateTeamChessEnum.placeSkillEffectParamConfigEnum[effectType][effectParam]

						if effectParamConfig then
							return effectParamConfig.teamType, effectParamConfig.count, effectParamConfig.limitStrongHold
						end
					end
				end
			end

			return nil, nil, false
		end
	end
end

function EliminateTeamChessModel:createPlaceMo(soliderId, soliderUid, strongholdId)
	local soliderSkillMoBase = SoliderSkillMOBase.New()

	soliderSkillMoBase:init(soliderId, soliderUid, strongholdId)

	return soliderSkillMoBase
end

function EliminateTeamChessModel:haveSoliderByTeamTypeAndStrongholdId(teamType, strongholdId)
	local strongholds = self:getStrongholds()
	local isHave = false

	for i = 1, #strongholds do
		local stronghold = strongholds[i]

		if strongholdId == nil or strongholdId == strongholdId then
			if not isHave then
				if teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
					isHave = #stronghold.mySidePiece > 0
				end

				if teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
					isHave = #stronghold.enemySidePiece > 0
				end
			else
				break
			end
		end
	end

	return isHave
end

function EliminateTeamChessModel:sourceStrongHoldInRight(sourceId, targetId)
	local allStrongholds = self:getStrongholds()
	local targetIndex = 0
	local sourceIndex = 0

	for i = 1, #allStrongholds do
		local stronghold = allStrongholds[i]

		if stronghold.id == targetId then
			targetIndex = i
		end

		if stronghold.id == sourceId then
			sourceIndex = i
		end
	end

	return sourceIndex < targetIndex
end

function EliminateTeamChessModel:strongHoldIsFull(strongHoldId)
	local strongholds = self:getStrongholds()

	for i = 1, #strongholds do
		local stronghold = strongholds[i]

		if strongHoldId == stronghold.id then
			return stronghold:isFull(EliminateTeamChessEnum.TeamChessTeamType.player)
		end
	end

	return false
end

function EliminateTeamChessModel:allStrongHoldIsIsFull()
	local isFull = false
	local strongholds = self:getStrongholds()

	for i = 1, #strongholds do
		local stronghold = strongholds[i]

		if stronghold:isFull(EliminateTeamChessEnum.TeamChessTeamType.player) then
			isFull = true
		end
	end

	return isFull
end

function EliminateTeamChessModel:haveEnoughResource()
	local pieceIds = EliminateLevelModel.instance:getCurLevelPieceIds()

	if pieceIds ~= nil then
		for i = 1, #pieceIds do
			local pieceId = pieceIds[i]

			if self:canUseChess(pieceId) then
				return true
			end
		end
	end

	return false
end

function EliminateTeamChessModel:canReleaseSkillAddResource()
	if not EliminateLevelModel.instance:mainCharacterSkillIsUnLock() then
		return false
	end

	local myInfo = EliminateTeamChessModel.instance:getCurTeamMyInfo()
	local canUse = false

	if myInfo then
		local skillMo
		local characterConfig = EliminateConfig.instance:getTeamChessCharacterConfig(myInfo.id)
		local skillConfig = EliminateConfig.instance:getMainCharacterSkillConfig(characterConfig.activeSkillIds)

		canUse = EliminateLevelController.instance:canReleaseByRound((EliminateLevelController.instance:getTempSkillMo(skillConfig.id, skillConfig.effect))) and myInfo.power >= skillConfig.cost
	end

	return canUse
end

function EliminateTeamChessModel:strongHoldTotalScoreWin()
	local totalEnemyScore = 0
	local totalPlayerScore = 0
	local strongholds = self:getStrongholds()

	for i = 1, #strongholds do
		local stronghold = strongholds[i]

		totalEnemyScore = totalEnemyScore + stronghold.enemyScore
		totalPlayerScore = totalPlayerScore + stronghold.myScore
	end

	return totalEnemyScore < totalPlayerScore
end

function EliminateTeamChessModel:calDamageGear(damage)
	local gear = EliminateConfig.instance:getCharacterDamageGear()
	local gearLevel = 1

	if gear and #gear == 2 and damage then
		gearLevel = damage < gear[2] and (damage >= gear[1] and 2 or 1) or 3
	end

	return gearLevel
end

function EliminateTeamChessModel:isCanPlaceByStrongHoldRule(strongHoldId, soliderId)
	local strongHoldConfig = EliminateConfig.instance:getStrongHoldConfig(strongHoldId)
	local ruleConfig = EliminateConfig.instance:getStrongHoldRuleRuleConfig(strongHoldConfig.ruleId)
	local curRound = EliminateLevelModel.instance:getRoundNumber()

	if ruleConfig then
		if not ruleConfig.putLimit then
			local putLimit = 0

			if self._cacheRuleLimit == nil then
				self._cacheRuleLimit = {}
			end

			local ruleLimit = self._cacheRuleLimit[ruleConfig.id]

			if ruleLimit == nil then
				self._cacheRuleLimit[ruleConfig.id] = string.splitToNumber(putLimit, "#")
				ruleLimit = self._cacheRuleLimit[ruleConfig.id]
			end

			if curRound >= ruleConfig.startEffectRound and curRound <= ruleConfig.endEffectRound and tabletool.len(ruleLimit) > 0 then
				local soliderConfig = EliminateConfig.instance:getSoldierChessConfig(soliderId)

				for i = 1, #ruleLimit do
					local limit = ruleLimit[i]

					if tonumber(limit) == soliderConfig.level then
						return false
					end
				end
			end

			return true
		end
	end
end

function EliminateTeamChessModel:setTeamChessSkillState(state)
	self._teamChessSkillState = state
end

function EliminateTeamChessModel:getTeamChessSkillState()
	if self._teamChessSkillState == nil then
		-- block empty
	end

	return self._teamChessSkillState
end

function EliminateTeamChessModel.chessSkillIsGrowUp(chessSkillId)
	local skillConfig = EliminateConfig.instance:getSoliderSkillConfig(chessSkillId)

	return skillConfig and skillConfig.type == EliminateTeamChessEnum.SoliderSkillType.GrowUp
end

EliminateTeamChessModel.instance = EliminateTeamChessModel.New()

return EliminateTeamChessModel
