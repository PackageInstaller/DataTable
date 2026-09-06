-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/config/ElementSparkConfig.lua

module("logic.extensions.elementspark.config.ElementSparkConfig", package.seeall)

local ElementSparkConfig = class("ElementSparkConfig", BaseConfig)

function ElementSparkConfig:onInit()
	ElementSparkConfig.super.onInit(self)
end

function ElementSparkConfig:getNames()
	return {
		"element_spark_activity",
		"element_spark_camp",
		"element_spark_zone",
		"element_spark_common_vars",
		"element_spark_map_chunk_plan",
		"element_spark_map_lv_plan",
		"element_spark_product",
		"element_spark_pet_shop_item",
		"element_spark_surround",
		"element_spark_support_pet",
		"element_spark_master",
		"element_spark_creeps",
		"element_spark_buff",
		"element_spark_camp_rank_prize",
		"element_spark_person_rank_prize",
		"element_spark_story"
	}
end

function ElementSparkConfig:handleConfig(name, content)
	if name == "element_spark_activity" then
		self._element_spark_activityCfg = content
	elseif name == "element_spark_camp" then
		self._element_spark_campCfg = content
	elseif name == "element_spark_zone" then
		self._element_spark_zoneCfg = content
	elseif name == "element_spark_common_vars" then
		self._element_spark_common_varsCfg = content
	elseif name == "element_spark_map_chunk_plan" then
		self._element_spark_map_chunk_planCfg = content
	elseif name == "element_spark_map_lv_plan" then
		self._element_spark_map_lv_planCfg = content
	elseif name == "element_spark_product" then
		self._element_spark_productCfg = content
	elseif name == "element_spark_pet_shop_item" then
		self._element_spark_pet_shopCfg = content
	elseif name == "element_spark_surround" then
		self._element_spark_surroundCfg = content
	elseif name == "element_spark_support_pet" then
		self._element_spark_support_petCfg = content
	elseif name == "element_spark_master" then
		self._element_spark_masterCfg = content
	elseif name == "element_spark_creeps" then
		self._element_spark_creepsCfg = content
	elseif name == "element_spark_buff" then
		self._element_spark_buffCfg = content
	elseif name == "element_spark_camp_rank_prize" then
		self._element_spark_camp_rank_prizeCfg = content
	elseif name == "element_spark_person_rank_prize" then
		self._element_spark_person_rank_prizeCfg = content
	elseif name == "element_spark_story" then
		self._element_spark_storyCfg = content
	end
end

function ElementSparkConfig:getActivityCfgById(activityId)
	return self._element_spark_activityCfg[activityId]
end

function ElementSparkConfig:getCampCfg(activityId)
	return self._element_spark_campCfg[activityId]
end

function ElementSparkConfig:getCampCfgById(activityId, campId)
	return self._element_spark_campCfg[activityId][campId]
end

function ElementSparkConfig:getCommonCfgByKey(key, isNumber)
	if isNumber then
		return checknumber(self._element_spark_common_varsCfg[key].value)
	end

	return self._element_spark_common_varsCfg[key].value
end

function ElementSparkConfig:getMapChunkCfgs(planId)
	return self._element_spark_map_chunk_planCfg[planId]
end

function ElementSparkConfig:getMapChunkCfgById(planId, chunkId)
	return self._element_spark_map_chunk_planCfg[planId][chunkId]
end

function ElementSparkConfig:getMapLvCfg(planId, star)
	return self._element_spark_map_lv_planCfg[planId][star]
end

function ElementSparkConfig:getMapLvCfgById(planId, star, level)
	return self._element_spark_map_lv_planCfg[planId][star][level]
end

function ElementSparkConfig:getBuffCfg(buffId)
	return self._element_spark_buffCfg[buffId]
end

function ElementSparkConfig:getMasterCfg(creepsMasterId)
	return self._element_spark_masterCfg[creepsMasterId]
end

function ElementSparkConfig:getCreepsCfg(creepsMasterId)
	return self.self._element_spark_masterCfg[creepsMasterId]
end

function ElementSparkConfig:getCampPrizeCfg(activityId)
	return self._element_spark_camp_rank_prizeCfg[activityId]
end

function ElementSparkConfig:getCampPrizeByRank(actId, rank)
	local cfg = self:getCampPrizeCfg(actId)

	if cfg then
		local lastCommanderPrize, lastPrize = "", ""

		for _, v in pairs(cfg) do
			local min = v.rankRange[1]
			local max = v.rankRange[#v.rankRange]

			if min <= rank and rank <= max then
				do return v.commanderPrize, v.prize end

				lastPrize = v.prize
			end

			lastCommanderPrize = v.commanderPrize
		end

		return lastCommanderPrize, lastPrize
	end

	return "", ""
end

function ElementSparkConfig:getPersonPrizeCfg(activityId)
	return self._element_spark_person_rank_prizeCfg[activityId]
end

function ElementSparkConfig:getPersonPrizeByRank(actId, rank)
	local cfg = self:getPersonPrizeCfg(actId)

	if cfg then
		local lastCommanderPrize, lastPrize = "", ""

		for _, v in pairs(cfg) do
			local min = v.rankRange[1]
			local max = v.rankRange[#v.rankRange]

			if min <= rank and rank <= max then
				return v.prize
			end

			commanderPrize, prize = v.commanderPrize, v.prize
		end

		return lastCommanderPrize, lastPrize
	end

	return "", ""
end

function ElementSparkConfig:getProductCfg(number)
	return self._element_spark_productCfg[number]
end

function ElementSparkConfig:getPetShopCfgs(shopId)
	return self._element_spark_pet_shopCfg[shopId]
end

function ElementSparkConfig:getPetShopCfgById(shopId, shopItemId)
	return self._element_spark_pet_shopCfg[shopId][shopItemId]
end

function ElementSparkConfig:getSupportPetCfg(supportPetId)
	return self._element_spark_support_petCfg[supportPetId]
end

function ElementSparkConfig:getStoryCfg(activityId, stageId)
	return self._element_spark_storyCfg[activityId][stageId]
end

function ElementSparkConfig:getSparkSurroundCfgs(sparkPlanId)
	return self._element_spark_surroundCfg[sparkPlanId]
end

ElementSparkConfig.instance = ElementSparkConfig.New()

return ElementSparkConfig
