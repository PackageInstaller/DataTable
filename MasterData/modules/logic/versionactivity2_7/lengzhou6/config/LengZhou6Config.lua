-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/config/LengZhou6Config.lua

module("modules.logic.versionactivity2_7.lengzhou6.config.LengZhou6Config", package.seeall)

local LengZhou6Config = class("LengZhou6Config", BaseConfig)

function LengZhou6Config:reqConfigNames()
	return {
		"activity190_episode",
		"activity190_task",
		"eliminate_battle_cost",
		"eliminate_battle_enemy",
		"eliminate_battle_enemybehavior",
		"eliminate_battle_endless_library_round",
		"eliminate_battle_character",
		"eliminate_battle_skill",
		"eliminate_battle_buff",
		"eliminate_battle_endless_mode",
		"eliminate_battle_eliminateblocks"
	}
end

function LengZhou6Config:onInit()
	self._eliminateBattleDamage = {}
	self._eliminateBattleHeal = {}
	self._skillIdToSpecialAttr = nil
	self._enemyRandomIdsConfig = nil
	self._selectEnemyIds = nil
end

function LengZhou6Config:onConfigLoaded(configName, configTable)
	return
end

function LengZhou6Config:getEpisodeConfig(activityId, episodeId)
	return lua_activity190_episode.configDict[activityId][episodeId]
end

function LengZhou6Config:getEliminateBattleEliminateBlocks(eliminateName, eliminateType)
	local value = lua_eliminate_battle_eliminateblocks.configDict[eliminateName]

	if eliminateName == nil or eliminateType == nil or value == nil then
		logError("getEliminateBattleEliminateBlocks error eliminateName or eliminateType is nil" .. tostring(eliminateName) .. tostring(eliminateType))
	end

	if value == nil then
		return nil
	end

	return value[eliminateType]
end

function LengZhou6Config:getEliminateBattleEnemy(enemyId)
	return lua_eliminate_battle_enemy.configDict[enemyId]
end

function LengZhou6Config:getEliminateBattleEnemyBehavior(enemyId)
	return lua_eliminate_battle_enemybehavior.configDict[enemyId]
end

function LengZhou6Config:getEliminateBattleCharacter(characterId)
	return lua_eliminate_battle_character.configDict[characterId]
end

function LengZhou6Config:getEliminateBattleSkill(skillId)
	return lua_eliminate_battle_skill.configDict[skillId]
end

function LengZhou6Config:getEliminateBattleBuff(buffId)
	return lua_eliminate_battle_buff.configDict[buffId]
end

function LengZhou6Config:getTaskByActId(activityId)
	if self._taskList == nil then
		self._taskList = {}

		for _, co in ipairs(lua_activity190_task.configList) do
			if co.activityId == activityId then
				table.insert(self._taskList, co)
			end
		end
	end

	return self._taskList
end

function LengZhou6Config:getPlayerAllSkillId()
	local skillIds = {}

	for _, co in ipairs(lua_eliminate_battle_skill.configList) do
		if co.type == LengZhou6Enum.SkillType.active or co.type == LengZhou6Enum.SkillType.passive and not LengZhou6Config.instance:isPlayerChessPassive(co.id) then
			table.insert(skillIds, co.id)
		end
	end

	return skillIds
end

function LengZhou6Config:isPlayerChessPassive(id)
	for i = 1, 4 do
		local skillId = LengZhou6Config.instance:getEliminateBattleCost(i)

		if skillId == id then
			return true
		end
	end

	return false
end

function LengZhou6Config:getEnemyRandomIdsConfig(endLessLayer)
	if self._enemyRandomIdsConfig == nil then
		self._enemyRandomIdsConfig = {}
		self._enemyEndlessLibraryRound = {}

		local configList = lua_eliminate_battle_endless_library_round.configList

		for i = 1, #configList do
			local co = configList[i]
			local endlessLibraryRound = string.splitToNumber(co.endlessLibraryRound, "#")
			local randomIds = string.splitToNumber(co.randomIds, "#")

			table.insert(self._enemyEndlessLibraryRound, endlessLibraryRound[2])
			table.insert(self._enemyRandomIdsConfig, randomIds)
		end
	end

	local index = self:recordEnemyLastRandomId(endLessLayer)

	return self._enemyRandomIdsConfig[index]
end

function LengZhou6Config:getEnemyRandomRealIndex(index)
	if self._enemyEndlessLibraryRound == nil then
		return 1
	end

	for i = 1, #self._enemyEndlessLibraryRound do
		local value = self._enemyEndlessLibraryRound[i]

		if index <= value then
			return i
		end
	end
end

function LengZhou6Config:recordEnemyLastRandomId(endLessLayer)
	local index = self:getEnemyRandomRealIndex(endLessLayer)

	if self._lastEnemyRoundIndex ~= nil and index ~= self._lastEnemyRoundIndex then
		self:clearSetSelectEnemyRandomId()
	end

	self._lastEnemyRoundIndex = index

	return index
end

function LengZhou6Config:setSelectEnemyRandomId(endLessLayer, id)
	if id == nil then
		return
	end

	if self._selectEnemyIds == nil then
		self._selectEnemyIds = {}
	end

	if not self._selectEnemyIds[id] then
		local count = 0

		self._selectEnemyIds[id] = count + 1

		if self._selectEnemyIds[id] == 2 then
			local index = self:getEnemyRandomRealIndex(endLessLayer)

			if self._enemyRandomIdsConfig ~= nil then
				local randomIds = self._enemyRandomIdsConfig[index]

				for i = 1, #randomIds do
					if randomIds[i] == id then
						table.remove(randomIds, i)

						break
					end
				end

				self._enemyRandomIdsConfig[index] = randomIds
			end
		end
	end
end

function LengZhou6Config:clearSetSelectEnemyRandomId()
	self._selectEnemyIds = nil
end

function LengZhou6Config:getEliminateBattleCost(id)
	if not lua_eliminate_battle_cost.configDict[id].value then
		return tonumber(lua_eliminate_battle_cost.configDict[id].value)
	end
end

function LengZhou6Config:getEliminateBattleCostStr(id)
	return lua_eliminate_battle_cost.configDict[id].value
end

function LengZhou6Config:getComboThreshold()
	return (self:getEliminateBattleCost(27))
end

function LengZhou6Config:getAllSpecialAttr()
	if self._skillIdToSpecialAttr == nil then
		self._skillIdToSpecialAttr = {}

		for i = 28, 31 do
			local config = self:getEliminateBattleCostStr(i)

			if not string.nilorempty(config) then
				local list = string.split(config, "#")
				local skillId = tonumber(list[1])
				local effect = list[2]
				local chessType = list[3]
				local value = tonumber(list[4])

				self._skillIdToSpecialAttr[skillId] = {
					effect = effect,
					chessType = chessType,
					value = value
				}
			end
		end
	end

	return self._skillIdToSpecialAttr
end

function LengZhou6Config:getEliminateBattleEndlessMode(id)
	if self._battleEndLessMode == nil then
		self._battleEndLessMode = {}
	end

	if self._battleEndLessMode[id] == nil then
		local info = lua_eliminate_battle_endless_mode.configDict[id]

		if info == nil then
			return nil
		end

		local data = {}

		data.hp = tonumber(info.hpUp)

		for i = 1, 5 do
			local effectName = info["skill" .. i]
			local powerUp = info["powerUp" .. i]

			if not string.nilorempty(effectName) then
				data[effectName] = tonumber(powerUp)
			end
		end

		self._battleEndLessMode[id] = data
	end

	return self._battleEndLessMode[id]
end

function LengZhou6Config:getDamageValue(eliminateName, eliminateType)
	if self._eliminateBattleDamage == nil then
		self._eliminateBattleDamage = {}
	end

	if self._eliminateBattleDamage[eliminateName] == nil then
		self._eliminateBattleDamage[eliminateName] = {}
	end

	if self._eliminateBattleDamage[eliminateName][eliminateType] == nil then
		local data = {}
		local configData = self:getEliminateBattleEliminateBlocks(eliminateName, eliminateType)

		if configData ~= nil then
			local dataValues = string.splitToNumber(configData.damageRate, "#")

			data[1] = dataValues[1]
			data[2] = dataValues[2]
		end

		self._eliminateBattleDamage[eliminateName][eliminateType] = data
	end

	local data = self._eliminateBattleDamage[eliminateName][eliminateType]

	return data[1] or 0, data[2] or 0
end

function LengZhou6Config:getHealValue(eliminateName, eliminateType)
	if self._eliminateBattleHeal == nil then
		self._eliminateBattleHeal = {}
	end

	if self._eliminateBattleHeal[eliminateName] == nil then
		self._eliminateBattleHeal[eliminateName] = {}
	end

	if self._eliminateBattleHeal[eliminateName][eliminateType] == nil then
		local data = {}
		local configData = self:getEliminateBattleEliminateBlocks(eliminateName, eliminateType)

		if configData ~= nil then
			local dataValues = string.splitToNumber(configData.healRate, "#")

			data[1] = dataValues[1]
			data[2] = dataValues[2]
		end

		self._eliminateBattleHeal[eliminateName][eliminateType] = data
	end

	local data = self._eliminateBattleHeal[eliminateName][eliminateType]

	return data[1] or 0, data[2] or 0
end

function LengZhou6Config:clearLevelCache()
	self._enemyRandomIdsConfig = nil
	self._enemyEndlessLibraryRound = nil
	self._selectEnemyIds = nil
end

LengZhou6Config.instance = LengZhou6Config.New()

return LengZhou6Config
