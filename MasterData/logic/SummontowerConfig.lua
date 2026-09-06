-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/config/SummontowerConfig.lua

module("logic.extensions.summer.config.SummontowerConfig", package.seeall)

local SummontowerConfig = class("SummontowerConfig", BaseConfig)

function SummontowerConfig:onInit()
	SummontowerConfig.super.onInit(self)

	self._SummerCostCfg = nil
	self._SummerPrizeCfg = nil
end

function SummontowerConfig:getNames()
	return {
		"summon_master_tower_activity",
		"summon_master_tower_common",
		"summon_master_tower_player_lv",
		"summon_master_tower_pet",
		"summon_master_tower_stage",
		"summon_master_tower_map",
		"summon_master_tower_guard_event",
		"summon_master_tower_guard_creeps",
		"summon_master_tower_shop",
		"summon_master_tower_wish",
		"summon_master_tower_item_type",
		"summon_master_tower_buy_times",
		"summon_master_tower_first_pass_prize",
		"summon_master_tower_rank_prize"
	}
end

function SummontowerConfig:handleConfig(name, content)
	if name == "summon_master_tower_activity" then
		self._actCfg = content
	elseif name == "summon_master_tower_common" then
		self._commCfg = content
	elseif name == "summon_master_tower_player_lv" then
		self._playerLv = content
	elseif name == "summon_master_tower_pet" then
		self._petCfg = content
	elseif name == "summon_master_tower_stage" then
		self._stageCfg = content
	elseif name == "summon_master_tower_map" then
		self._mapCfg = content
	elseif name == "summon_master_tower_guard_event" then
		self._eventCfg = content
	elseif name == "summon_master_tower_guard_creeps" then
		self._creepCfg = content
	elseif name == "summon_master_tower_shop" then
		self._shopCfg = content
	elseif name == "summon_master_tower_wish" then
		self._wishCfg = content
	elseif name == "summon_master_tower_item_type" then
		self._itemCfg = content
	elseif name == "summon_master_tower_buy_times" then
		self._buyCfg = content
	elseif name == "summon_master_tower_first_pass_prize" then
		self._prizeCfg = content
	elseif name == "summon_master_tower_rank_prize" then
		self._rankCfg = content
	end
end

function SummontowerConfig:getActivities()
	return self._actCfg.dataList
end

function SummontowerConfig:getActivitieCo(id)
	return self._actCfg[id]
end

function SummontowerConfig:getParamsString(key)
	if self._commCfg[key] then
		return self._commCfg[key].value
	end
end

function SummontowerConfig:getParamsInt(key)
	return checknumber(self:getParamsString(key))
end

function SummontowerConfig:getMaxBuyTimes()
	return #self._buyCfg.dataList
end

function SummontowerConfig:getBuyTimesCost(times)
	local data = self._buyCfg.dataList[times]

	if data then
		return data.consume
	end
end

function SummontowerConfig:getSummonPetsCo(curLevel)
	local summonPets = {}

	for i = 1, #self._petCfg.dataList do
		local petCo = self._petCfg.dataList[i]

		if checknumber(petCo.summonedPetId) > 0 and curLevel == petCo.playerLv then
			table.insert(summonPets, petCo)
		end
	end

	return summonPets
end

function SummontowerConfig:getPetCo(id)
	return self._petCfg[id]
end

function SummontowerConfig:getStageCo(id)
	return self._stageCfg[id]
end

function SummontowerConfig:getStageNumById(id)
	return #self._stageCfg[id]
end

function SummontowerConfig:getStagesNum()
	return #self._stageCfg.dataList
end

function SummontowerConfig:getMapCo(id)
	return self._mapCfg[id]
end

function SummontowerConfig:getMapGridCo(id, gridId)
	return self._mapCfg[id][gridId]
end

function SummontowerConfig:getGuardEventCo(id)
	return self._eventCfg[id]
end

function SummontowerConfig:getFirstRewardsCos(season)
	return self._prizeCfg[season]
end

function SummontowerConfig:getRankRewardsCos(season)
	return self._rankCfg[season]
end

function SummontowerConfig:getShopItemCo(shopId, shopItemId)
	return self._shopCfg[shopId][shopItemId]
end

function SummontowerConfig:getShopItemList(shopId)
	return self._shopCfg[shopId]
end

function SummontowerConfig:getGameItemCo(itemId)
	return self._itemCfg[itemId]
end

function SummontowerConfig:getCreepCo(id)
	return self._creepCfg[id]
end

function SummontowerConfig:getPlayerLevel(exp)
	local currLevel = 0
	local currExp = 0
	local lvupNeedExp = 0

	for i = 1, #self._playerLv.dataList do
		local expCo = self._playerLv.dataList[i]

		if exp >= expCo.exp then
			currLevel = expCo.lv
			currExp = expCo.exp
			lvupNeedExp = self._playerLv.dataList[i + 1] and self._playerLv.dataList[i + 1].exp - currExp or math.huge
		end
	end

	return currLevel, exp - currExp, lvupNeedExp
end

SummontowerConfig.instance = SummontowerConfig.New()

return SummontowerConfig
