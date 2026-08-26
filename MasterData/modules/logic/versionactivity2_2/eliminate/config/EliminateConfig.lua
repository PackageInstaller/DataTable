-- chunkname: @modules/logic/versionactivity2_2/eliminate/config/EliminateConfig.lua

module("modules.logic.versionactivity2_2.eliminate.config.EliminateConfig", package.seeall)

local EliminateConfig = class("EliminateConfig", BaseConfig)

function EliminateConfig:reqConfigNames()
	return {
		"eliminate_episode",
		"eliminate_chapter",
		"eliminate_reward",
		"teamchess_character",
		"eliminate_slot",
		"soldier_chess",
		"strong_hold",
		"teamchess_enemy",
		"war_chess_episode",
		"character_skill",
		"soldier_skill",
		"eliminate_cost",
		"strong_hold_rule",
		"eliminate_dialog"
	}
end

function EliminateConfig:onInit()
	self:_initEliminateChessConfig()
end

function EliminateConfig:onConfigLoaded(configName, configTable)
	if configName == "eliminate_chapter" then
		self:_initChapter()
	elseif configName == "soldier_chess" then
		self:_initSoldierChess()
	elseif configName == "eliminate_cost" then
		self:_initEvaluateGear()
		self:_initCharacterDamageGear()
	end
end

function EliminateConfig:_initSoldierChess()
	self._soldierChessList = {}
	self._soldierChessShowList = {}
	self._soldierChessShowMap = {}

	for i, v in ipairs(lua_soldier_chess.configList) do
		local costValue = 0
		local list = GameUtil.splitString2(v.cost, false, "#", "_")

		if list then
			for _, costParam in ipairs(list) do
				local addValue = tonumber(costParam[2])

				if addValue then
					costValue = costValue + addValue
				else
					logError("eliminate_cost error:" .. tostring(v.id) .. " cost:" .. tostring(v.cost))
				end
			end
		end

		local data = {
			id = v.id,
			config = v,
			costList = list,
			costValue = costValue
		}

		table.insert(self._soldierChessList, data)

		if v.formationDisplays == 1 then
			table.insert(self._soldierChessShowList, data)

			self._soldierChessShowMap[v.id] = data
		end
	end
end

function EliminateConfig:getSoldierChessList()
	return self._soldierChessShowList
end

function EliminateConfig:getSoldierChessById(id)
	return self._soldierChessShowMap[id]
end

function EliminateConfig:getSoldierChessConfig(id)
	return lua_soldier_chess.configDict[id]
end

function EliminateConfig:getSoldierSkillConfig(id)
	return lua_soldier_skill.configDict[id]
end

function EliminateConfig:getSoldierChessQualityImageName(levelId)
	return EliminateTeamChessEnum.SoliderChessQualityImage[levelId] or EliminateTeamChessEnum.SoliderChessQualityImage[1]
end

function EliminateConfig:getSoldierChessDesc(id)
	local skillId = self:getSoldierChessConfig(id).skillId
	local skillIds = string.splitToNumber(skillId, "#")
	local desc = ""

	for _, v in ipairs(skillIds) do
		local skillConfig = lua_soldier_skill.configDict[v]

		if skillConfig then
			desc = desc .. skillConfig.skillDes .. "\n"
		end
	end

	return desc
end

function EliminateConfig:getUnLockMainCharacterSkillConst()
	return self:getConstValue(4)
end

function EliminateConfig:getUnLockChessSellConst()
	return self:getConstValue(5)
end

function EliminateConfig:getUnLockSelectSoliderConst()
	return self:getConstValue(6)
end

function EliminateConfig:getSellSoliderPermillage()
	local config = lua_eliminate_cost.configDict[12]

	return config and tonumber(config.value) or 1
end

function EliminateConfig:getConstValue(id)
	local config = lua_eliminate_cost.configDict[id]

	return config and tonumber(config.value) or 0
end

function EliminateConfig:getSoldierChessConfigConst(id)
	for _, data in ipairs(self._soldierChessList) do
		local config = data.config

		if config and config.id == id then
			return data.costList, data.costValue
		end
	end

	return nil
end

function EliminateConfig:getTeamChessCharacterConfig(id)
	return lua_teamchess_character.configDict[id]
end

function EliminateConfig:getTeamChessEnemyConfig(id)
	return lua_teamchess_enemy.configDict[id]
end

function EliminateConfig:getStrongHoldConfig(id)
	return lua_strong_hold.configDict[id]
end

function EliminateConfig:getSoldierChessModelPath(id)
	local config = self:getSoldierChessConfig(id)

	return (config or nil) and (config.resModel or "")
end

function EliminateConfig:_initChapter()
	self._normalChapterList = {}

	for i, v in ipairs(lua_eliminate_chapter.configList) do
		table.insert(self._normalChapterList, v)
	end
end

function EliminateConfig:_initEliminateChessConfig()
	self._chessBoardConfig = {}
	self._chessConfig = {}

	for i = 1, #T_lua_eliminate_chessBoard do
		local data = T_lua_eliminate_chessBoard[i]

		self._chessBoardConfig[data.type] = data
	end

	for i = 1, #T_lua_eliminate_chess do
		local data = T_lua_eliminate_chess[i]

		self._chessConfig[data.id] = data
	end
end

function EliminateConfig:getChessIconPath(id)
	return (self._chessConfig[id] or nil) and (self._chessConfig[id].iconPath or "")
end

function EliminateConfig:getChessSourceID(id)
	return (self._chessConfig[id] or nil) and (self._chessConfig[id].colorId or "")
end

function EliminateConfig:getChessBoardIconPath(typeId)
	return (self._chessBoardConfig[typeId] or nil) and (self._chessBoardConfig[typeId].iconPath or "")
end

function EliminateConfig:getNormalChapterList()
	return self._normalChapterList
end

function EliminateConfig:getEliminateEpisodeConfig(id)
	return lua_eliminate_episode.configDict[id]
end

function EliminateConfig:getWarChessEpisodeConfig(id)
	return lua_war_chess_episode.configDict[id]
end

function EliminateConfig:getMainCharacterSkillConfig(skillId)
	if skillId then
		local skillIds = string.splitToNumber(skillId, "#")

		return lua_character_skill.configDict[skillIds[1]]
	end

	return nil
end

function EliminateConfig:getStrongHoldRuleRuleConfig(ruleId)
	return lua_strong_hold_rule.configDict[ruleId]
end

function EliminateConfig:getEliminateDialogConfig(levelId)
	local levelDialog = lua_eliminate_dialog.configDict[levelId]

	if levelDialog == nil then
		levelDialog = {}
	end

	local globalDialogData = lua_eliminate_dialog.configDict[999999]

	if globalDialogData ~= nil then
		tabletool.addValues(levelDialog, globalDialogData)
	end

	return levelDialog
end

function EliminateConfig:_initEvaluateGear()
	local config = lua_eliminate_cost.configDict[36]

	self._evaluateGear = string.splitToNumber(config.value, "#")
end

function EliminateConfig:getEvaluateGear()
	return self._evaluateGear
end

function EliminateConfig:_initCharacterDamageGear()
	local config = lua_eliminate_cost.configDict[38]

	self._characterDamageGear = string.splitToNumber(config.value, "#")
end

function EliminateConfig:getCharacterDamageGear()
	return self._characterDamageGear
end

function EliminateConfig:getSoliderSkillConfig(id)
	return lua_soldier_skill.configDict[id] or {}
end

EliminateConfig.instance = EliminateConfig.New()

return EliminateConfig
