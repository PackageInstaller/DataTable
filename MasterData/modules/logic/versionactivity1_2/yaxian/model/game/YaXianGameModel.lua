-- chunkname: @modules/logic/versionactivity1_2/yaxian/model/game/YaXianGameModel.lua

module("modules.logic.versionactivity1_2.yaxian.model.game.YaXianGameModel", package.seeall)

local YaXianGameModel = class("YaXianGameModel", BaseModel)

function YaXianGameModel:onInit()
	return
end

function YaXianGameModel:reInit()
	return
end

function YaXianGameModel:release()
	self.actId = nil
	self.mapId = nil
	self.episodeId = nil
	self.episodeCo = nil
	self.width = nil
	self.height = nil
	self.round = nil
	self.result = nil
	self.mapTileBaseList = nil
	self.mapInteractMoList = nil
	self.playerInteractMo = nil
	self.finishInteract = nil
	self.baffleList = nil
	self.skillDict = nil
	self.mapOffsetX = nil
	self.mapOffsetY = nil
	self.canWalkTargetPosDict = nil
	self.gameLoadOne = nil
	self.currentDeleteInteractId = nil
end

function YaXianGameModel:initLocalConfig(actId, episodeId)
	self.episodeCo = YaXianConfig.instance:getEpisodeConfig(actId, episodeId)
	self.episodeId = episodeId
	self.actId = actId
	self.mapId = self.episodeCo.mapId
	self.mapCo = YaXianConfig.instance:getMapConfig(actId, self.mapId)
	self.width = self.mapCo.width
	self.height = self.mapCo.height

	if self.mapCo and not string.nilorempty(self.mapCo.offset) then
		local offsetArr = string.splitToNumber(self.mapCo.offset, ",")

		self.mapOffsetX = offsetArr[1]
		self.mapOffsetY = offsetArr[2]
	else
		self.mapOffsetX = YaXianGameEnum.ChessBoardOffsetX
		self.mapOffsetY = YaXianGameEnum.ChessBoardOffsetY
	end

	self.mapTileBaseList = string.splitToNumber(self.mapCo.tilebase, ",")

	self:initBaffleData()
end

function YaXianGameModel:initBaffleData()
	self.baffleList = {}

	local tileData, type

	for x = 0, self.width - 1 do
		for y = 0, self.height - 1 do
			tileData = self.mapTileBaseList[self:getIndex(x, y)]

			if tileData > 1 then
				if YaXianGameHelper.hasBaffle(tileData, YaXianGameEnum.BaffleDirectionPowerPos.Left) then
					type = YaXianGameHelper.getBaffleType(tileData, YaXianGameEnum.BaffleDirectionPowerPos.Left)

					table.insert(self.baffleList, self:buildBaffleData(x, y, YaXianGameEnum.BaffleDirection.Left, type))
				end

				if YaXianGameHelper.hasBaffle(tileData, YaXianGameEnum.BaffleDirectionPowerPos.Right) then
					type = YaXianGameHelper.getBaffleType(tileData, YaXianGameEnum.BaffleDirectionPowerPos.Right)

					table.insert(self.baffleList, self:buildBaffleData(x, y, YaXianGameEnum.BaffleDirection.Right, type))
				end

				if YaXianGameHelper.hasBaffle(tileData, YaXianGameEnum.BaffleDirectionPowerPos.Top) then
					type = YaXianGameHelper.getBaffleType(tileData, YaXianGameEnum.BaffleDirectionPowerPos.Top)

					table.insert(self.baffleList, self:buildBaffleData(x, y, YaXianGameEnum.BaffleDirection.Top, type))
				end

				if YaXianGameHelper.hasBaffle(tileData, YaXianGameEnum.BaffleDirectionPowerPos.Bottom) then
					type = YaXianGameHelper.getBaffleType(tileData, YaXianGameEnum.BaffleDirectionPowerPos.Bottom)

					table.insert(self.baffleList, self:buildBaffleData(x, y, YaXianGameEnum.BaffleDirection.Bottom, type))
				end
			end
		end
	end
end

function YaXianGameModel:initServerDataByServerData(mapServerData)
	self:setRound(mapServerData.currentRound)
	self:initObjects(mapServerData.interactObjects)
	self:updateFinishInteracts(mapServerData.finishInteracts)
end

function YaXianGameModel:initServerDataByMapMo(mapMo)
	self:setRound(mapMo.currentRound)
	self:setObjects(mapMo.interactObjs)
	self:updateFinishInteracts(mapMo.finishInteracts)
end

function YaXianGameModel:getBaffleList()
	return self.baffleList
end

function YaXianGameModel:addInteractMo(data)
	table.insert(self.mapInteractMoList, data)
end

function YaXianGameModel:removeInteractMo(data)
	tabletool.removeValue(self.mapInteractMoList, data)
end

function YaXianGameModel:getPlayerInteractMo()
	return self.playerInteractMo
end

function YaXianGameModel:setPlayerInteractMo()
	for _, interactMo in ipairs(self.mapInteractMoList) do
		if interactMo.config.interactType == YaXianGameEnum.InteractType.Player then
			self.playerInteractMo = interactMo

			return
		end
	end

	logError("not found Player InteractMo")
end

function YaXianGameModel:getExitInteractMo()
	return self.exitInteractMo
end

function YaXianGameModel:setExitInteractMo()
	for _, interactMo in ipairs(self.mapInteractMoList) do
		if interactMo.config.interactType == YaXianGameEnum.InteractType.TriggerVictory then
			self.exitInteractMo = interactMo

			return
		end
	end

	logError("not found Exit InteractMo")
end

function YaXianGameModel:initObjects(serverObjList)
	self.mapInteractMoList = {}

	local len = #serverObjList

	for i = 1, len do
		local serverObj = serverObjList[i]
		local mo = YaXianGameInteractMO.New()

		mo:init(self.actId, serverObj)
		table.insert(self.mapInteractMoList, mo)
	end

	self:setPlayerInteractMo()
	self:setExitInteractMo()
	self:initInteractData()
end

function YaXianGameModel:setObjects(interactMoList)
	self.mapInteractMoList = interactMoList

	self:setPlayerInteractMo()
	self:setExitInteractMo()
	self:initInteractData()
end

function YaXianGameModel:addObject(serverData)
	local mo = YaXianGameInteractMO.New()

	mo:init(self.actId, serverData)
	table.insert(self.mapInteractMoList, mo)

	return mo
end

function YaXianGameModel:removeObjectById(id)
	for i = 1, #self.mapInteractMoList do
		if self.mapInteractMoList[i].id == id then
			local oldObj = self.mapInteractMoList[i]

			table.remove(self.mapInteractMoList, i)

			return oldObj
		end
	end
end

function YaXianGameModel:initInteractData()
	for _, interactMo in ipairs(self.mapInteractMoList) do
		if interactMo.config.interactType == YaXianGameEnum.InteractType.Player then
			if self:updateSkillInfoAndCheckHasChange(interactMo.data and interactMo.data.skills) then
				YaXianGameController.instance:dispatchEvent(YaXianEvent.OnUpdateSkillInfo)
			end

			if self:updateEffectsAndCheckHasChange(interactMo.data and interactMo.data.effects) then
				YaXianGameController.instance:dispatchEvent(YaXianEvent.OnUpdateEffectInfo)
			end
		end
	end
end

function YaXianGameModel:updateFinishInteracts(idList)
	self.finishInteract = {}

	if idList then
		for i = 1, #idList do
			self.finishInteract[idList[i]] = true
		end
	end
end

function YaXianGameModel:setFinishInteracts(finishInteracts)
	self.finishInteract = finishInteracts
end

function YaXianGameModel:isAlertArea(posX, posY)
	for _, interactMo in ipairs(self.mapInteractMoList) do
		if interactMo.alertPosList then
			for _, area in ipairs(interactMo.alertPosList) do
				if posX == area.posX and posY == area.posY then
					return true
				end
			end
		end
	end

	return false
end

function YaXianGameModel:hasInteract(posX, posY)
	for _, interactMo in ipairs(self.mapInteractMoList) do
		if posX == interactMo.posX and posY == interactMo.posY and interactMo.config.interactType ~= YaXianGameEnum.InteractType.Player then
			return true
		end
	end

	return false
end

function YaXianGameModel:updateSkillInfo(skillList)
	if not skillList then
		self.skillDict = nil

		return
	end

	self.skillDict = self.skillDict or {}

	for _, skillInfo in ipairs(skillList) do
		local skillMo = self.skillDict[skillInfo.skillId]

		if not skillMo then
			skillMo = YaXianGameSkillMo.New()

			skillMo:init(self.actId, skillInfo)

			self.skillDict[skillInfo.skillId] = skillMo
		else
			skillMo:updateMO(skillInfo)
		end
	end
end

function YaXianGameModel:updateSkillInfoAndCheckHasChange(skillList)
	if not skillList then
		if not self.skillDict then
			return false
		else
			self:updateSkillInfo(skillList)

			return true
		end
	end

	self.skillDict = self.skillDict or {}

	for _, skillInfo in ipairs(skillList) do
		local skillMo = self.skillDict[skillInfo.skillId]

		if not skillMo then
			self:updateSkillInfo(skillList)

			return true
		elseif skillMo.canUseCount ~= skillInfo.canUseCount then
			self:updateSkillInfo(skillList)

			return true
		end
	end

	return false
end

function YaXianGameModel:getSkillMo(skillId)
	return self.skillDict and self.skillDict[skillId]
end

function YaXianGameModel:hasSkill()
	return self.skillDict ~= nil
end

function YaXianGameModel:updateEffects(effects)
	if not effects then
		self._effectsDict = nil

		return
	end

	self.effectsPool = self.effectsPool or {}

	if self._effectsDict then
		for effectType, effectMo in pairs(self._effectsDict) do
			self.effectsPool[effectType] = effectMo
		end
	end

	self._effectsDict = {}

	for _, effect in ipairs(effects) do
		local skillEffectMo = self.effectsPool[effect.effectType]

		if not skillEffectMo then
			skillEffectMo = YaXianGameSkillEffectMo.New()

			skillEffectMo:init(self.actId, effect)
		else
			skillEffectMo:updateMO(effect)
		end

		self._effectsDict[skillEffectMo.effectType] = skillEffectMo
	end
end

function YaXianGameModel:updateEffectsAndCheckHasChange(effects)
	if not effects and not self._effectsDict then
		self._effectsDict = nil

		return false
	end

	if not effects then
		self._effectsDict = nil

		return true
	end

	if not self._effectsDict then
		self:updateEffects(effects)

		return true
	end

	if #effects ~= tabletool.len(self._effectsDict) then
		self:updateEffects(effects)

		return true
	end

	for _, effect in ipairs(effects) do
		local skillEffectMo = self._effectsDict[effect.effectType]

		if not skillEffectMo then
			self:updateEffects(effects)

			return true
		elseif skillEffectMo.remainRound ~= effects.remainRound then
			self:updateEffects(effects)

			return true
		end
	end
end

function YaXianGameModel:getEffectByType(skillType)
	return self._effectsDict and self._effectsDict[skillType]
end

function YaXianGameModel:isShowVisibleStatus()
	return self._effectsDict and self._effectsDict[YaXianGameEnum.SkillType.InVisible] and self._effectsDict[YaXianGameEnum.SkillType.InVisible].remainRound > 0
end

function YaXianGameModel:isShowThroughStatus()
	return self._effectsDict and self._effectsDict[YaXianGameEnum.SkillType.ThroughWall] and self._effectsDict[YaXianGameEnum.SkillType.ThroughWall].remainRound > 0
end

function YaXianGameModel:hasInVisibleEffect()
	return self._effectsDict and self._effectsDict[YaXianGameEnum.SkillType.InVisible] and self._effectsDict[YaXianGameEnum.SkillType.InVisible].remainRound > 1
end

function YaXianGameModel:hasThroughWallEffect()
	return self._effectsDict and self._effectsDict[YaXianGameEnum.SkillType.ThroughWall] and self._effectsDict[YaXianGameEnum.SkillType.ThroughWall].remainRound > 0
end

function YaXianGameModel:addFinishInteract(id)
	self.finishInteract[id] = true
end

function YaXianGameModel:isInteractFinish(id)
	if self.finishInteract then
		return self.finishInteract[id]
	end
end

function YaXianGameModel:getBaseTile(x, y)
	local index = self:getIndex(x, y)

	return self.mapTileBaseList[index]
end

function YaXianGameModel:setBaseTile(x, y, tileType)
	local index = self:getIndex(x, y)

	self.mapTileBaseList[index] = tileType
end

function YaXianGameModel:setRound(round)
	self.round = round
end

function YaXianGameModel:setResult(result)
	self.result = result
end

function YaXianGameModel:getResult()
	return self.result
end

function YaXianGameModel:getInteractMoList()
	return self.mapInteractMoList
end

function YaXianGameModel:getInteractMo(interactId)
	for _, interactMo in ipairs(self.mapInteractMoList) do
		if interactMo.id == interactId then
			return interactMo
		end
	end
end

function YaXianGameModel:getIndex(x, y)
	return y * self.width + x + 1
end

function YaXianGameModel:getGameSize()
	return self.width, self.height
end

function YaXianGameModel:getMapId()
	return self.mapId
end

function YaXianGameModel:getActId()
	return self.actId
end

function YaXianGameModel:getRound()
	return math.max(self.round or 1, 1)
end

function YaXianGameModel:isRoundUseUp()
	return self:getRound() == self.episodeCo.maxRound
end

function YaXianGameModel:getEpisodeId()
	return self.episodeId
end

function YaXianGameModel:getEpisodeCo()
	return self.episodeCo
end

function YaXianGameModel:isPosInChessBoard(x, y)
	return x >= 0 and x < self.width and y >= 0 and y < self.height
end

function YaXianGameModel:buildBaffleData(x, y, direction, type)
	return {
		x = x,
		y = y,
		direction = direction,
		type = type
	}
end

function YaXianGameModel:setCanWalkTargetPosDict(posDict)
	self.canWalkDirection2Pos = posDict
	self.canWalkPos2Direction = {}

	for direction, pos in pairs(self.canWalkDirection2Pos) do
		self.canWalkPos2Direction[YaXianGameHelper.getPosHashKey(pos.x, pos.y)] = direction
	end
end

function YaXianGameModel:getCanWalkTargetPosDict()
	return self.canWalkDirection2Pos
end

function YaXianGameModel:getCanWalkPos2Direction()
	return self.canWalkPos2Direction
end

function YaXianGameModel:setGameLoadDone(loadDone)
	self.gameLoadOne = loadDone
end

function YaXianGameModel:gameIsLoadDone()
	return self.gameLoadOne
end

function YaXianGameModel:setNeedFeatureInteractMo(interactMo)
	self.needFeatureInteractMo = interactMo
	self.featurePrePosX = self.needFeatureInteractMo.prePosX
	self.featurePrePosY = self.needFeatureInteractMo.prePosY
	self.featurePreDirection = self.needFeatureInteractMo.preDirection
end

function YaXianGameModel:clearFeatureInteract()
	self.needFeatureInteractMo = nil
	self.featurePrePosX = nil
	self.featurePrePosY = nil
	self.featurePreDirection = nil
end

function YaXianGameModel:getNeedFeatureInteractMo()
	return self.needFeatureInteractMo
end

function YaXianGameModel:checkFinishCondition(conditionType, conditionParam)
	if conditionType == YaXianGameEnum.ConditionType.PassEpisode then
		return self.result
	elseif conditionType == YaXianGameEnum.ConditionType.Round then
		return self.result and conditionParam >= self.round
	elseif conditionType == YaXianGameEnum.ConditionType.FinishInteract then
		return self:isInteractFinish(conditionParam)
	elseif conditionType == YaXianGameEnum.ConditionType.FinishAllInteract then
		if conditionParam > 0 and conditionParam < self.round then
			return false
		end

		local finishCount = 0

		if self.finishInteract then
			for interactId, _ in pairs(self.finishInteract) do
				if YaXianConfig.instance:checkInteractCanFinish(YaXianConfig.instance:getInteractObjectCo(self.actId, interactId)) then
					finishCount = finishCount + 1
				end
			end
		end

		return finishCount == YaXianConfig.instance:getEpisodeCanFinishInteractCount(self.episodeCo)
	else
		logError("un support condition type")

		return false
	end
end

function YaXianGameModel:getFinishConditionCount()
	local conditionList = YaXianConfig.instance:getConditionList(self.episodeCo)
	local count = 0

	for _, condition in ipairs(conditionList) do
		if self:checkFinishCondition(condition[1], condition[2]) then
			count = count + 1
		end
	end

	return count
end

YaXianGameModel.instance = YaXianGameModel.New()

return YaXianGameModel
