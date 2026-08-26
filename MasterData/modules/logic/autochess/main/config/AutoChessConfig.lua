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
		"auto_chess_effect",
		"auto_chess_cardpack",
		"auto_chess_level",
		"auto_chess_collection"
	}
end

function AutoChessConfig:onConfigLoaded(configName, configTable)
	if configName == "auto_chess_skill_eff_desc" then
		self.skillEffectDescConfig = configTable
	end
end

function AutoChessConfig:getItemBuyCost(itemId)
	local itemCo = lua_auto_chess_mall_item.configDict[itemId]

	if itemCo then
		local params = string.splitToNumber(itemCo.context, "#")
		local chessCo = self:getChessCfgById(params[1], params[2])

		if string.nilorempty(chessCo.specialShopCost) then
			return AutoChessStrEnum.CostType.Coin, itemCo.cost
		else
			params = string.split(chessCo.specialShopCost, "#")

			return params[1], tonumber(params[2])
		end
	else
		logError(string.format("自走棋商品表不存在配置ID: %s ", itemId))
	end
end

function AutoChessConfig:getChessCfgBySkillId(skillId)
	for _, config in ipairs(lua_auto_chess.configList) do
		if tonumber(config.skillIds) == skillId then
			return config
		end
	end

	logError(string.format("自走棋随从表不存在技能ID为: %s 的配置", skillId))
end

function AutoChessConfig:getChessCfgById(chessId, star)
	local chessCfgs = lua_auto_chess.configDict[chessId]

	if star then
		if chessCfgs[star] then
			return chessCfgs[star]
		else
			logError(string.format("自走棋随从表不存在配置ID: %s 星级: %s", chessId, star))
		end
	elseif chessCfgs then
		return chessCfgs
	else
		logError(string.format("自走棋随从表不存在配置ID: %s", chessId))
	end
end

function AutoChessConfig:getChessCfg(chessId)
	local chessCfgs = lua_auto_chess.configDict[chessId]

	if chessCfgs then
		for _, config in pairs(chessCfgs) do
			return config
		end
	else
		logError(string.format("自走棋随从表不存在配置ID: %s", chessId))
	end
end

function AutoChessConfig:getLeaderCfg(id)
	local config = lua_auto_chess_master.configDict[id]

	if config then
		return config
	else
		logError(string.format("自走棋领队表不存在配置ID : %s", id))
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
	local cardpackCfg = lua_auto_chess_cardpack.configDict[actId][cardpackId]

	if cardpackCfg then
		return cardpackCfg
	else
		logError(string.format("自走棋卡包品表不存在配置 活动ID : %s 卡包ID : %s", actId, cardpackId))
	end
end

function AutoChessConfig:getCollectionCfg(collectionId)
	local collectionCfg = lua_auto_chess_collection.configDict[collectionId]

	if collectionCfg then
		return collectionCfg
	else
		logError(string.format("自走棋收藏品表不存在配置 收藏品ID : %s", collectionId))
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

AutoChessConfig.instance = AutoChessConfig.New()

return AutoChessConfig
