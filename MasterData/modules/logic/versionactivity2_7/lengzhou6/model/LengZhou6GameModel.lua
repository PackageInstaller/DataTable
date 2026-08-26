-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/LengZhou6GameModel.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.LengZhou6GameModel", package.seeall)

local LengZhou6GameModel = class("LengZhou6GameModel", BaseModel)

function LengZhou6GameModel:ctor()
	self._round = 0
	self._enemySettleCount = 1
	self._battleModel = LengZhou6Enum.BattleModel.normal
	self._recordServerData = nil
	self._endlessBattleProgress = nil
	self._isFirstEnterLayer = true
end

function LengZhou6GameModel:enterLevel(config)
	self._isFirstEnterLayer = true
	self._episodeConfig = config
	self._levelId = config.episodeId

	self:setBattleModel(config.type)

	if config.type == LengZhou6Enum.BattleModel.infinite then
		self:initSelectSkillId()

		if self._recordServerData == nil then
			self._recordServerData = RecordServerDataMO.New()
		end
	end

	local info = LengZhou6Model.instance:getEpisodeInfoMo(config.episodeId)

	if info ~= nil and not string.nilorempty(info.progress) then
		self._recordServerData:initFormJson(info.progress)
		self:initByServerData()
	else
		self:initByConfig(config)

		if config.type == LengZhou6Enum.BattleModel.infinite then
			self:setEndLessBattleProgress(LengZhou6Enum.BattleProgress.selectSkill)
		end
	end

	self._lineEliminateRate = 0

	self:setCurGameStep(LengZhou6Enum.BattleStep.gameBegin)
end

function LengZhou6GameModel:initByConfig(config)
	self._playerEntity = PlayerEntity.New()

	local playerConfigId = config.masterId

	if playerConfigId then
		self:initPlayer(playerConfigId)
	end

	self:_initEnemyByConfig(config)

	self._round = config.maxRound

	if self:getBattleModel() == LengZhou6Enum.BattleModel.infinite then
		self._round = self:calRound()
	end
end

function LengZhou6GameModel:_initEnemyByConfig(config)
	self._enemyEntity = EnemyEntity.New()

	local data = string.splitToNumber(config.enemyId, "#")

	if data[1] == 1 then
		if not data[2] then
			local enemyConfigId = self:calEnemyId()

			if enemyConfigId then
				self:initEnemy(enemyConfigId)

				local hpUp = self:calEnemyHpUp()

				self._enemyEntity:setHp(hpUp + self._enemyEntity:getHp())
			end
		end
	end
end

function LengZhou6GameModel:initByServerData()
	if self._recordServerData ~= nil then
		local data = self._recordServerData:getData()

		self._round = data.round
		self._playerEntity = PlayerEntity.New()

		local playerConfigId = data.playerId

		if playerConfigId then
			self:initPlayer(playerConfigId, data.playerSkillList)

			if data.playerSkillList ~= nil then
				for i = 1, #data.playerSkillList do
					self:setPlayerSelectSkillId(i, data.playerSkillList[i])
				end
			end

			self._playerEntity:setHp(data.playerHp)
		end

		local enemyConfigId = data.enemyConfigId

		if enemyConfigId then
			LengZhou6Config.instance:recordEnemyLastRandomId(data.endLessLayer)
			LengZhou6Config.instance:setSelectEnemyRandomId(data.endLessLayer, enemyConfigId)

			self._enemyEntity = EnemyEntity.New()

			self:initEnemy(enemyConfigId)
			self._enemyEntity:setHp(data.enemyHp)
			self._enemyEntity:setActionStepIndexAndRound(data.curActionStepIndex, data.skillRound)
		end

		self._round = data.round

		self:setEndLessModelLayer(data.endLessLayer)
		self:setEndLessBattleProgress(data.endLessBattleProgress)

		if data.endLessLayer ~= LengZhou6Enum.DefaultEndLessBeginRound or data.endLessBattleProgress ~= LengZhou6Enum.BattleProgress.selectSkill then
			self._isFirstEnterLayer = false
		end
	end
end

function LengZhou6GameModel:getRecordServerData()
	return self._recordServerData
end

function LengZhou6GameModel:initPlayer(configId, skillList, buffList)
	self._playerEntity:init(configId)

	if skillList ~= nil then
		self._playerEntity:resetData(skillList)
	end
end

function LengZhou6GameModel:initEnemy(configId, skillList, buffList)
	self._enemyEntity:init(configId)
end

function LengZhou6GameModel:getBattleModel()
	return self._battleModel
end

function LengZhou6GameModel:setBattleModel(battleModel)
	self._battleModel = battleModel
end

function LengZhou6GameModel:getEpisodeConfig()
	return self._episodeConfig
end

function LengZhou6GameModel:getPlayer()
	return self._playerEntity
end

function LengZhou6GameModel:getEnemy()
	return self._enemyEntity
end

function LengZhou6GameModel:changeRound(diff)
	self._round = math.max(self._round + diff, 0)

	LengZhou6StatHelper.instance:updateRound()
end

function LengZhou6GameModel:getCurRound()
	return self._round
end

function LengZhou6GameModel:gameIsOver()
	if self._enemyEntity == nil or self._playerEntity == nil then
		return false
	end

	return self._round == 0 or self._enemyEntity:getHp() <= 0 or self._playerEntity:getHp() <= 0
end

function LengZhou6GameModel:playerIsWin()
	if self._enemyEntity == nil then
		return false
	end

	return self._enemyEntity:getHp() <= 0 and self._playerEntity:getHp() > 0 and self._round > 0
end

function LengZhou6GameModel:enemySettle()
	return
end

local tempStr = "\n"

function LengZhou6GameModel:getTotalPlayerSettle()
	local damage = 0
	local hp = 0

	if self._playerTempDamages ~= nil then
		for i = 1, #self._playerTempDamages do
			local rate = 1 + self._lineEliminateRate * (i - 1)
			local value = self._playerTempDamages[i] * rate

			damage = damage + value

			if isDebugBuild then
				tempStr = tempStr .. "消除第 " .. i .. " 次 连消伤害：" .. value .. " = " .. self._playerTempDamages[i] .. " * " .. rate .. "\n"
			end
		end
	end

	if self._playerTempHps ~= nil then
		for i = 1, #self._playerTempHps do
			hp = hp + self._playerTempHps[i]
		end
	end

	if isDebugBuild then
		tempStr = tempStr .. "消除伤害总值：" .. math.floor(damage) .. "\n"

		logNormal(tempStr)

		tempStr = "\n"

		logNormal("消除治疗总值：" .. math.floor(hp))
	end

	return math.floor(damage), math.floor(hp)
end

function LengZhou6GameModel:setLineEliminateRate(rate)
	self._lineEliminateRate = rate
end

function LengZhou6GameModel:clearTempData()
	if self._playerTempDamages == nil or self._playerTempHps == nil then
		return
	end

	tabletool.clear(self._playerTempDamages)
	tabletool.clear(self._playerTempHps)
end

function LengZhou6GameModel:_playerSettle()
	local eliminateData = LocalEliminateChessModel.instance:getCurEliminateRecordData()
	local damage = self._playerEntity:calDamage(eliminateData)
	local hp = self._playerEntity:calTreatment(eliminateData)

	return damage, hp
end

function LengZhou6GameModel:playerSettle()
	LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.calHpBefore)

	local damage, hp = self:_playerSettle()

	LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.calHpAfter)

	if self._playerTempDamages == nil then
		self._playerTempDamages = {}
	end

	table.insert(self._playerTempDamages, damage)

	if self._playerTempHps == nil then
		self._playerTempHps = {}
	end

	table.insert(self._playerTempHps, hp)
end

function LengZhou6GameModel:addBuffIdToEntity()
	return
end

function LengZhou6GameModel:setEnemySettleCount(count)
	self._enemySettleCount = count
end

function LengZhou6GameModel:getEnemySettleCount()
	return self._enemySettleCount
end

function LengZhou6GameModel:resetEnemySettleCount()
	self:setEnemySettleCount(1)
end

function LengZhou6GameModel:triggerPlayerBuffOrSkill()
	if self._playerEntity then
		self._playerEntity:triggerBuffAndSkill()
	end

	if self._enemyEntity then
		self._enemyEntity:triggerBuffAndSkill()
	end
end

function LengZhou6GameModel:setCurGameStep(step)
	self._curGameStep = step

	self:triggerPlayerBuffOrSkill()
end

function LengZhou6GameModel:getCurGameStep()
	return self._curGameStep
end

function LengZhou6GameModel:getCurEliminateSpEliminateCount(eliminateType)
	local eliminateData = LocalEliminateChessModel.instance:getCurEliminateRecordData()
	local eliminateMap = eliminateData:getEliminateTypeMap()
	local totalCount = 0

	for _eliminateType, data in pairs(eliminateMap) do
		if _eliminateType == eliminateType then
			for i = 1, #data do
				local eliminateData = data[i]
				local spEliminateCount = eliminateData.spEliminateCount

				if spEliminateCount ~= nil then
					totalCount = totalCount + spEliminateCount
				end
			end
		end
	end

	return totalCount
end

function LengZhou6GameModel:clear()
	self._endLessModelLayer = nil
	self._isFirstEnterLayer = true
	self._episodeConfig = nil
	self._playerEntity = nil
	self._enemyEntity = nil
	self._round = 0
	self._enemySettleCount = 1
	self._playerTempDamages = nil
	self._playerTempHps = nil
	self._recordServerData = nil
	self._recordLayerId = nil
	self._playerSelectSkillIds = nil

	LengZhou6Config.instance:clearLevelCache()
end

function LengZhou6GameModel:setEndLessModelLayer(layer)
	self._endLessModelLayer = layer
end

function LengZhou6GameModel:getEndLessModelLayer()
	return self._endLessModelLayer or 1
end

function LengZhou6GameModel:setEndLessBattleProgress(progress)
	self._endlessBattleProgress = progress

	LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.OnEndlessChangeSelectState)
end

function LengZhou6GameModel:getEndLessBattleProgress()
	return self._endlessBattleProgress
end

function LengZhou6GameModel:calEnemyId()
	local endLessLayer = self:getEndLessModelLayer() or 1
	local maxLayer = LengZhou6Config.instance:getEliminateBattleCost(9)

	if endLessLayer <= maxLayer then
		local ids = LengZhou6Config.instance:getEnemyRandomIdsConfig(endLessLayer)

		if ids then
			local id = ids[math.random(1, #ids)]

			LengZhou6Config.instance:setSelectEnemyRandomId(endLessLayer, id)

			return id
		else
			return LengZhou6Enum.defaultEnemy
		end
	end

	local diffLayer = endLessLayer - maxLayer

	if self._recordLayerId == nil then
		self._recordLayerId = {}
	end

	local index = math.ceil(diffLayer / 5)

	if self._recordLayerId[index] == nil then
		local randomIdsStr = LengZhou6Config.instance:getEliminateBattleCostStr(16)
		local randomIds = string.splitToNumber(randomIdsStr, "#")

		if randomIds then
			self._recordLayerId[index] = randomIds[math.random(1, #randomIds)]
		end
	end

	return self._recordLayerId[index]
end

function LengZhou6GameModel:initSelectSkillId()
	if self._playerSelectSkillIds == nil then
		self._playerSelectSkillIds = {}
	end
end

function LengZhou6GameModel:getSelectSkillIdList()
	local skillIds = {}

	if self._playerSelectSkillIds ~= nil then
		for _, v in pairs(self._playerSelectSkillIds) do
			table.insert(skillIds, v)
		end
	end

	return skillIds
end

function LengZhou6GameModel:getSelectSkillId()
	return self._playerSelectSkillIds
end

function LengZhou6GameModel:isSelectSkill(skillId)
	if self._playerSelectSkillIds == nil then
		return false
	end

	for _, v in pairs(self._playerSelectSkillIds) do
		if v == skillId then
			return true
		end
	end

	return false
end

function LengZhou6GameModel:resetSelectSkillId()
	if self._playerSelectSkillIds then
		tabletool.clear(self._playerSelectSkillIds)
	end
end

function LengZhou6GameModel:setPlayerSelectSkillId(index, skillConfigId)
	if self._playerSelectSkillIds == nil then
		self._playerSelectSkillIds = {}
	end

	self._playerSelectSkillIds[index] = skillConfigId
end

function LengZhou6GameModel:calRound()
	local battleModel = self:getBattleModel()
	local endLessLayer = self:getEndLessModelLayer() or 1

	if battleModel == LengZhou6Enum.BattleModel.normal or endLessLayer == 0 then
		return self._round
	end

	if not self._round then
		local round = 0
		local normalUp = LengZhou6Config.instance:getEliminateBattleCost(6)
		local fiveLayerUp = LengZhou6Config.instance:getEliminateBattleCost(7)
		local basePoint = LengZhou6Config.instance:getEliminateBattleCost(8)
		local index = endLessLayer - 1

		if index ~= 0 then
			round = round + (index % basePoint == 0 and fiveLayerUp or normalUp)
		end

		return round
	end
end

function LengZhou6GameModel:getSkillEffectUp(effect)
	local battleModel = self:getBattleModel()
	local endLessLayer = self:getEndLessModelLayer() or 1
	local var_45_0

	if battleModel == LengZhou6Enum.BattleModel.normal or endLessLayer == 0 then
		do return 0 end

		var_45_0 = self:getEndLessModelLayer() or 1
	end

	local maxLayer = math.min(var_45_0, LengZhou6Config.instance:getEliminateBattleCost(9))
	local data = LengZhou6Config.instance:getEliminateBattleEndlessMode(maxLayer)

	return (data or nil) and (data[effect] or 0)
end

function LengZhou6GameModel:calEnemyHpUp()
	local battleModel = self:getBattleModel()
	local endLessLayer = self:getEndLessModelLayer() or 1

	if battleModel == LengZhou6Enum.BattleModel.normal or endLessLayer == 0 then
		return 0
	end

	local maxLayer = LengZhou6Config.instance:getEliminateBattleCost(9)

	if endLessLayer > 0 and endLessLayer <= maxLayer then
		local data = LengZhou6Config.instance:getEliminateBattleEndlessMode(endLessLayer)

		return data.hp
	end

	local data = LengZhou6Config.instance:getEliminateBattleEndlessMode(maxLayer)
	local baseUp = data.hp
	local normalUp = LengZhou6Config.instance:getEliminateBattleCost(10)
	local fiveLayerUp = LengZhou6Config.instance:getEliminateBattleCost(11)

	for i = 1, endLessLayer - maxLayer do
		baseUp = baseUp + (i % 5 == 0 and fiveLayerUp or normalUp)
	end

	return baseUp
end

function LengZhou6GameModel:enterNextLayer()
	if self._playerEntity then
		local skillIdList = LengZhou6GameModel.instance:getSelectSkillIdList()

		self._playerEntity:resetData(skillIdList)
	end

	local layer = self:getEndLessModelLayer()

	if self._isFirstEnterLayer then
		self:setEndLessModelLayer(LengZhou6Enum.DefaultEndLessBeginRound)

		self._isFirstEnterLayer = false
	else
		LocalEliminateChessModel.instance:createInitMoveState()
		self:setEndLessModelLayer(layer + 1)
		self:_initEnemyByConfig(self._episodeConfig)
	end

	if self:getBattleModel() == LengZhou6Enum.BattleModel.infinite then
		self._round = self:calRound()
	end

	self:setCurGameStep(LengZhou6Enum.BattleStep.gameBegin)
	LengZhou6GameModel.instance:setEndLessBattleProgress(LengZhou6Enum.BattleProgress.selectFinish)
end

function LengZhou6GameModel:recordChessData()
	local data = LocalEliminateChessModel.instance:getInitData()

	if self._recordServerData and data ~= nil then
		self._recordServerData:record(data)
	end
end

function LengZhou6GameModel:canSelectSkill()
	local layer = LengZhou6GameModel.instance:getEndLessModelLayer()

	if layer % LengZhou6Enum.EndLessChangeSkillLayer == 0 then
		return true
	end

	return false
end

function LengZhou6GameModel:isFirstEnterLayer()
	return self._isFirstEnterLayer
end

LengZhou6GameModel.instance = LengZhou6GameModel.New()

return LengZhou6GameModel
