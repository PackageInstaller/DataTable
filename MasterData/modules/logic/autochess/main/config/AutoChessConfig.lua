-- chunkname: @modules/logic/autochess/main/config/AutoChessConfig.lua

module("modules.logic.autochess.main.config.AutoChessConfig", package.seeall)

local AutoChessConfig = class("AutoChessConfig", BaseConfig)

function AutoChessConfig:reqConfigNames()
	return {
		"auto_chess_enemy",
		"auto_chess_enemy_formation",
		"auto_chess_episode",
		"auto_chess_boss",
		"auto_chess_master",
		"auto_chess_master_skill",
		"auto_chess_master_library",
		"auto_chess_mall",
		"auto_chess_mall_item",
		"auto_chess_mall_coin",
		"auto_chess",
		"auto_chess_skill",
		"auto_chess_translate",
		"auto_chess_buff",
		"auto_chess_skill_eff_desc",
		"auto_chess_round",
		"auto_chess_rank",
		"autochess_task",
		"auto_chess_const",
		"auto_chess_lose_streak_reward",
		"auto_chess_effect",
		"auto_chess_cardpack",
		"auto_chess_level",
		"auto_chess_collection",
		"auto_chess_mutation"
	}
end

function AutoChessConfig:onConfigLoaded(configName, configTable)
	if configName == "auto_chess_skill_eff_desc" then
		self.skillEffectDescConfig = configTable
	elseif configName == "auto_chess_rank" then
		self.loseStreakMap = {}

		for _, v in ipairs(configTable.configList) do
			local actId = v.activityId

			if not self.loseStreakMap[actId] and v.loseStreak == 0 then
				self.loseStreakMap[actId] = v.rankId
			end
		end
	elseif configName == "auto_chess_translate" then
		self.allRaceList = {}

		for _, v in ipairs(configTable.configList) do
			self.allRaceList[#self.allRaceList + 1] = v.id
		end
	end
end

function AutoChessConfig:getItemBuyCost(itemId)
	local itemCo = lua_auto_chess_mall_item.configDict[itemId]

	if itemCo then
		local params = string.splitToNumber(itemCo.context, "#")
		local chessCo = self:getChessCfg(params[1], params[2])

		if string.nilorempty(chessCo.specialShopCost) then
			return AutoChessStrEnum.CostType.Coin, itemCo.cost
		else
			params = string.split(chessCo.specialShopCost, "#")

			return params[1], tonumber(params[2])
		end
	else
		logError(string.format("自走棋商品表找不到配置ID: %s ", itemId))
	end
end

function AutoChessConfig:getChessCfg(id, star)
	local chessCfgMap = lua_auto_chess.configDict[id]

	if chessCfgMap and chessCfgMap[star] then
		return chessCfgMap[star]
	else
		logError(string.format("自走棋随从表找不到配置ID: %s 星级: %s", id, star))
	end
end

function AutoChessConfig:getChessCfgAnyway(chessId)
	local chessCfgs = lua_auto_chess.configDict[chessId]

	if chessCfgs then
		local _, config = next(chessCfgs)

		if config then
			return config
		end
	end

	logError(string.format("自走棋随从表找不到配置ID: %s", chessId))
end

function AutoChessConfig:getChessCfgRaceListMap()
	local result = {}

	for _, config in pairs(lua_auto_chess.configList) do
		if config.star == 1 and config.illustrationShow then
			result[config.race] = result[config.race] or {}

			table.insert(result[config.race], config)
		end
	end

	return result
end

function AutoChessConfig:getChessCfgs(chessId)
	local chessCfgs = lua_auto_chess.configDict[chessId]

	if chessCfgs then
		return chessCfgs
	else
		logError("自走棋随从表找不到配置 棋子ID: " .. chessId)
	end
end

function AutoChessConfig:getChessCfgBySkillId(skillId)
	for _, config in ipairs(lua_auto_chess.configList) do
		if tonumber(config.skillIds) == skillId then
			return config
		end
	end

	logError("自走棋随从表找不到配置 技能ID: " .. skillId)
end

function AutoChessConfig:getChessSkillCfg(skillId, ignore)
	local config = lua_auto_chess_skill.configDict[skillId]

	if config then
		return config
	elseif not ignore then
		logError("自走棋随从技能表找不到配置 技能ID: " .. skillId)
	end
end

function AutoChessConfig:getLeaderCfg(id)
	local config = lua_auto_chess_master.configDict[id]

	if config then
		return config
	else
		logError("自走棋领队表找不到配置 领队ID : " .. id)
	end
end

function AutoChessConfig:getLeaderSkillCfg(skillId)
	if not lua_auto_chess_master_skill.configDict[skillId] then
		local config = self:getChessSkillCfg(skillId)

		if lua_auto_chess_master_skill.configDict[skillId] then
			return lua_auto_chess_master_skill.configDict[skillId]
		else
			logError("自走棋领队技能表和随从技能表都找不到配置 技能ID: " .. skillId)
		end
	end
end

function AutoChessConfig:getTaskByActId(actId)
	local taskList = {}

	for _, co in ipairs(lua_autochess_task.configList) do
		if co.activityId == actId and co.isOnline == 1 then
			taskList[#taskList + 1] = co
		end
	end

	return taskList
end

function AutoChessConfig:getSkillEffectDesc(effId)
	local co = self.skillEffectDescConfig.configDict[effId]

	if not co then
		logError(string.format("异常:技能概要ID '%s' 不存在!!!", effId))
	end

	return co
end

function AutoChessConfig:getSkillEffectDescCoByName(name)
	if not self.skillBuffDescConfigByName then
		self.skillBuffDescConfigByName = {}

		for _, v in ipairs(self.skillEffectDescConfig.configList) do
			self.skillBuffDescConfigByName[v.name] = v
		end
	end

	local co = self.skillBuffDescConfigByName[name]

	if not co then
		logError(string.format("异常:技能概要名称 '%s' 不存在!!!", tostring(name)))
	end

	return co
end

function AutoChessConfig:getEpisodeCO(id)
	for _, v in ipairs(lua_auto_chess_episode.configList) do
		if v.id == id then
			return v
		end
	end

	logError(string.format("关卡ID: %s 关卡配置为空!!!", id))
end

function AutoChessConfig:getPveEpisodeCoList(actId)
	local list = {}

	for _, v in ipairs(lua_auto_chess_episode.configList) do
		if v.activityId == actId and v.type == AutoChessEnum.EpisodeType.PVE then
			list[#list + 1] = v
		end
	end

	if next(list) then
		return list
	else
		logError(string.format("活动ID: %s PVE关卡配置为空!!!", actId))
	end
end

function AutoChessConfig:getPvpEpisodeCo(actId)
	for _, v in ipairs(lua_auto_chess_episode.configList) do
		if v.activityId == actId and (v.type == AutoChessEnum.EpisodeType.PVP or v.type == AutoChessEnum.EpisodeType.PVP2) then
			return v
		end
	end

	logError(string.format(" 活动ID: %s PVP关卡配置为空!!!", actId))
end

function AutoChessConfig:getCardpackUnlockLevel(cardpackId)
	local actId = Activity182Model.instance:getCurActId()
	local warnLevelCfgs = lua_auto_chess_level.configDict[actId]

	for _, config in pairs(warnLevelCfgs) do
		local ids = string.splitToNumber(config.unlockCardpackIds, "#")

		if tabletool.indexOf(ids, cardpackId) then
			return config.level
		end
	end

	logError(string.format(" 活动ID: %s 卡包ID %s 未配置解锁警戒值等级!!!", actId, cardpackId))

	return 1
end

function AutoChessConfig:getBossUnlockLevel(bossId)
	local actId = Activity182Model.instance:getCurActId()
	local warnLevelCfgs = lua_auto_chess_level.configDict[actId]

	for _, config in pairs(warnLevelCfgs) do
		local ids = string.splitToNumber(config.unlockBossIds, "#")

		if tabletool.indexOf(ids, bossId) then
			return config.level
		end
	end

	return 1
end

function AutoChessConfig:getCollectionUnlockLevel(collectionId)
	local actId = Activity182Model.instance:getCurActId()
	local warnLevelCfgs = lua_auto_chess_level.configDict[actId]

	for _, config in pairs(warnLevelCfgs) do
		local ids = string.splitToNumber(config.unlockCollectionIds, "#")

		if tabletool.indexOf(ids, collectionId) then
			return config.level
		end
	end

	logError(string.format(" 活动ID: %s 藏品ID %s 未配置解锁警戒值等级!!!", actId, collectionId))

	return 1
end

function AutoChessConfig:getLeaderUnlockLevel(leaderId)
	local actId = Activity182Model.instance:getCurActId()
	local warnLevelCfgs = lua_auto_chess_level.configDict[actId]

	for _, config in pairs(warnLevelCfgs) do
		if config.spMasterId == leaderId then
			return config.level
		end
	end

	logError(string.format(" 活动ID: %s 特殊棋手ID %s 未配置解锁警戒值等级!!!", actId, leaderId))

	return 1
end

function AutoChessConfig:getCardpackCfg(cardpackId)
	local actId = Activity182Model.instance:getCurActId()
	local cardpackCfgs = lua_auto_chess_cardpack.configDict[actId]

	if cardpackCfgs and cardpackCfgs[cardpackId] then
		return cardpackCfgs[cardpackId]
	else
		logError(string.format("自走棋卡包表找不到配置 活动ID : %s 卡包ID : %s", actId, cardpackId))
	end
end

function AutoChessConfig:getCollectionCfg(collectionId)
	local config = lua_auto_chess_collection.configDict[collectionId]

	if config then
		return config
	else
		logError("自走棋收藏品表找不到配置 收藏品ID: " .. collectionId)
	end
end

function AutoChessConfig:getSpecialCollectionCfgs()
	local list = {}

	for _, config in ipairs(lua_auto_chess_collection.configList) do
		if config.isSp then
			list[#list + 1] = config
		end
	end

	return list
end

function AutoChessConfig:getSpecialLeaderCfgs()
	local list = {}

	for _, config in pairs(lua_auto_chess_master.configList) do
		if config.isSpMaster then
			list[#list + 1] = config
		end
	end

	return list
end

function AutoChessConfig:getBuffCfg(buffId)
	local config = lua_auto_chess_buff.configDict[buffId]

	if config then
		return config
	else
		logError("自走棋随从_随从Buff表找不到配置 BuffID: " .. buffId)
	end
end

function AutoChessConfig:getConstValue(constKey, isNumber)
	local config = lua_auto_chess_const.configDict[constKey]

	if config then
		if isNumber then
			return tonumber(config.value)
		else
			return config.value
		end
	else
		logError("自走棋基础设定常量表找不到配置 常量ID: " .. constKey)
	end
end

function AutoChessConfig:getRankCfg(rankId, ignore)
	local actId = Activity182Model.instance:getCurActId()
	local config

	for _, v in ipairs(lua_auto_chess_rank.configList) do
		if v.activityId == actId and v.rankId == rankId then
			config = v

			break
		end
	end

	if config then
		return config
	elseif not ignore then
		logError("自走棋基础设定段位表找不到配置 段位Id: " .. rankId)
	end
end

function AutoChessConfig:getMallCfg(mallId)
	local config = lua_auto_chess_mall.configDict[mallId]

	if config then
		return config
	else
		logError("自走棋商店表找不到配置 商店ID: " .. mallId)
	end
end

function AutoChessConfig:getMallItemCfg(itemId)
	local config = lua_auto_chess_mall_item.configDict[itemId]

	if config then
		return config
	else
		logError("自走棋商品表找不到配置 商品唯一ID: " .. itemId)
	end
end

function AutoChessConfig:getEffectCfg(id)
	local config = lua_auto_chess_effect.configDict[id]

	if config then
		return config
	else
		logError("自走棋特效表找不到配置 特效ID: " .. id)
	end
end

function AutoChessConfig:getBossCfg(bossId)
	local config = lua_auto_chess_boss.configDict[bossId]

	if config then
		return config
	else
		logError("自走棋关卡_3.2boss表找不到配置 BossID: " .. bossId)
	end
end

function AutoChessConfig:getMutationCfg(mutationId)
	local actId = Activity182Model.instance:getCurActId()

	for _, v in ipairs(lua_auto_chess_mutation.configList) do
		if v.activityId == actId and v.id == mutationId then
			return v
		end
	end

	logError("自走棋畸变表找不到配置 畸变ID: " .. mutationId)
end

function AutoChessConfig:getCampCfg(race)
	local campCo = lua_auto_chess_translate.configDict[race]

	if campCo then
		return campCo
	else
		logError("自走棋随从表_种族名词解释表找不到配置 种族: " .. race)
	end
end

function AutoChessConfig:getLoseStreakLvl(loseCount)
	local actId = Activity182Model.instance:getCurActId()
	local cfgList = lua_auto_chess_lose_streak_reward.configDict[actId]

	for i = #cfgList, 1, -1 do
		local config = cfgList[i]

		if loseCount >= config.loseStreak then
			return config.levelId
		end
	end

	return 0
end

function AutoChessConfig:getLoseStreakInvalidLvl()
	local actId = Activity182Model.instance:getCurActId()

	return self.loseStreakMap[actId] or 0
end

function AutoChessConfig:getAllRaceList()
	return self.allRaceList
end

AutoChessConfig.instance = AutoChessConfig.New()

return AutoChessConfig
