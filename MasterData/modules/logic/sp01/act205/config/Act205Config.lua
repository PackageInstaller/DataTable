-- chunkname: @modules/logic/sp01/act205/config/Act205Config.lua

module("modules.logic.sp01.act205.config.Act205Config", package.seeall)

local Act205Config = class("Act205Config", BaseConfig)

function Act205Config:reqConfigNames()
	return {
		"activity205_const",
		"actvity205_stage",
		"activity205_dicegoal",
		"activity205_dicepool",
		"actvity205_mini_game_reward",
		"activity205_card",
		"activity205_card_settle"
	}
end

function Act205Config:onConfigLoaded(configName, configTable)
	if configName == "activity205_const" then
		self._constConfig = configTable
	elseif configName == "actvity205_stage" then
		self._stageConfig = configTable
	elseif configName == "activity205_dicegoal" then
		self._oceanDiceGoalConfig = configTable
	elseif configName == "activity205_dicepool" then
		self._oceanDicePoolConfig = configTable
	elseif configName == "actvity205_mini_game_reward" then
		self.miniGameRewardConfig = configTable
	elseif configName == "activity205_card" then
		self:_onCardConfigLoaded(configTable)
	end
end

function Act205Config:_onCardConfigLoaded(configTable)
	self._type2CardsDict = {}
	self._restrainedDict = {}
	self._beRestrainedDict = {}

	for _, cfg in ipairs(configTable.configList) do
		local type = cfg.type
		local cardList = self._type2CardsDict[type]

		if not cardList then
			cardList = {}
			self._type2CardsDict[type] = cardList
		end

		cardList[#cardList + 1] = cfg.id

		if not string.nilorempty(cfg.restrain) then
			local arr = string.splitToNumber(cfg.restrain, "#")

			self._restrainedDict[cfg.id] = {}

			for _, restrainedCardId in ipairs(arr) do
				self._restrainedDict[cfg.id][restrainedCardId] = true
				self._beRestrainedDict[restrainedCardId] = self._beRestrainedDict[restrainedCardId] or {}
				self._beRestrainedDict[restrainedCardId][cfg.id] = true
			end
		end
	end
end

function Act205Config:getConstConfig(id)
	return self._constConfig.configDict[id]
end

function Act205Config:getAct205Const(constId, isToNumber)
	local result
	local cfg = self:getConstConfig(constId)

	if cfg then
		result = cfg.value

		if isToNumber then
			result = tonumber(result)
		end
	end

	return result
end

function Act205Config:getStageConfig(actId, stageId)
	return self._stageConfig.configDict[actId] and self._stageConfig.configDict[actId][stageId]
end

function Act205Config:getGameStageOpenTimeStamp(actId, stageId)
	local result = 0
	local cfg = self:getStageConfig(actId, stageId)

	if cfg then
		local strDateTime = cfg.startTime

		result = TimeUtil.stringToTimestamp(strDateTime)
	end

	return result
end

function Act205Config:getGameStageEndTimeStamp(actId, stageId)
	local result = 0
	local cfg = self:getStageConfig(actId, stageId)

	if cfg then
		local strDateTime = cfg.endTime

		result = TimeUtil.stringToTimestamp(strDateTime)
	end

	return result
end

function Act205Config:getDiceGoalConfig(id)
	return self._oceanDiceGoalConfig.configDict[id]
end

function Act205Config:getDiceGoalConfigList()
	return self._oceanDiceGoalConfig.configList
end

function Act205Config:getDicePoolConfig(id)
	return self._oceanDicePoolConfig.configDict[id]
end

function Act205Config:getDicePoolConfigList()
	return self._oceanDicePoolConfig.configList
end

function Act205Config:getGameRewardConfig(stageId, rewardId)
	return self.miniGameRewardConfig.configDict[stageId] and self.miniGameRewardConfig.configDict[stageId][rewardId]
end

function Act205Config:getWinDiceConfig()
	for _, diceCo in ipairs(self:getDicePoolConfigList()) do
		if diceCo.winDice == 1 then
			return diceCo
		end
	end
end

function Act205Config:getAct205CardCfg(cardId, nilError)
	local cfg = lua_activity205_card.configDict[cardId]

	if not cfg and nilError then
		logError(string.format("Act205Config:getAct205CardCfg error, cfg is nil, cardId:%s", cardId))
	end

	return cfg
end

function Act205Config:getCardType(cardId)
	local cfg = self:getAct205CardCfg(cardId, true)

	return cfg and cfg.type
end

function Act205Config:getCardName(cardId)
	local cfg = self:getAct205CardCfg(cardId, true)

	return cfg and cfg.name
end

function Act205Config:getCardDesc(cardId)
	local cfg = self:getAct205CardCfg(cardId, true)

	return cfg and cfg.desc
end

function Act205Config:getCardImg(cardId)
	local cfg = self:getAct205CardCfg(cardId, true)

	return cfg and cfg.img
end

function Act205Config:getCardWeight(cardId, needSub)
	local result = 0
	local cfg = self:getAct205CardCfg(cardId, true)

	if cfg then
		result = cfg.weight

		if needSub then
			result = result - cfg.subWeight
			result = math.max(0, result)
		end
	end

	return result
end

function Act205Config:getSpEff(cardId)
	local cfg = self:getAct205CardCfg(cardId, true)

	return cfg and cfg.spEff
end

function Act205Config:isSpCard(cardId)
	local spEff = self:getSpEff(cardId)

	return spEff and spEff ~= 0
end

function Act205Config:getCardTypeDict()
	return self._type2CardsDict
end

function Act205Config:getAct205CardSettleCfg(point, nilError)
	local cfg = lua_activity205_card_settle.configDict[point]

	if not cfg and nilError then
		logError(string.format("Act205Config:getAct205CardSettleCfg error, cfg is nil, point:%s", point))
	end

	return cfg
end

function Act205Config:getPointList()
	local result = {}

	for i, cfg in ipairs(lua_activity205_card_settle.configList) do
		result[i] = cfg.point
	end

	return result
end

function Act205Config:getMaxPoint()
	if not self._cardGameMaxPoint then
		self._cardGameMaxPoint = 0

		for _, cfg in ipairs(lua_activity205_card_settle.configList) do
			self._cardGameMaxPoint = math.max(self._cardGameMaxPoint, cfg.point)
		end
	end

	return self._cardGameMaxPoint
end

function Act205Config:getPointByReward(rewardId)
	for _, cfg in ipairs(lua_activity205_card_settle.configList) do
		if cfg.rewardId == rewardId then
			return cfg.point
		end
	end
end

function Act205Config:getRewardId(point)
	local cfg = self:getAct205CardSettleCfg(point, true)

	return cfg and cfg.rewardId
end

function Act205Config:getIsCardRestrain(cardId, targetCardId)
	local isSP = self:isSpCard(cardId)

	if isSP then
		return
	end

	return self._restrainedDict[cardId] and self._restrainedDict[cardId][targetCardId]
end

function Act205Config:getIsCardBeRestrained(cardId, targetCardId)
	local isSP = self:isSpCard(cardId)

	if isSP then
		return
	end

	return self._beRestrainedDict[cardId] and self._beRestrainedDict[cardId][targetCardId]
end

function Act205Config:getBeRestrainedCard(cardId)
	local result

	if self._beRestrainedDict[cardId] then
		local list = {}

		for beRestrainedCardId, _ in pairs(self._beRestrainedDict[cardId]) do
			list[#list + 1] = beRestrainedCardId
		end

		local index = math.random(1, #list)

		result = list[index]
	end

	return result
end

Act205Config.instance = Act205Config.New()

return Act205Config
