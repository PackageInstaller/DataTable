-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cloudcutfan/config/CloudCutFanConfig.lua

module("logic.extensions.cloudcutfan.config.CloudCutFanConfig", package.seeall)

local CloudCutFanConfig = class("CloudCutFanConfig", BaseConfig)

function CloudCutFanConfig:onInit()
	CloudCutFanConfig.super.onInit(self)
end

function CloudCutFanConfig:getNames()
	return {
		"cloud_cut_fan_material",
		"cloud_cut_fan_activity",
		"cloud_cut_fan_challenge_prize",
		"cloud_cut_fan_collection",
		"cloud_cut_fan_face_collection",
		"cloud_cut_fan_creeps",
		"cloud_cut_fan_master",
		"cloud_cut_fan_reward_prize",
		"cloud_cut_fan_face_repair_tips"
	}
end

function CloudCutFanConfig:handleConfig(name, content)
	if name == "cloud_cut_fan_material" then
		self._cloud_cut_fan_material = content

		self:_handleFanMaterialCfgs()
	elseif name == "cloud_cut_fan_activity" then
		self._cloud_cut_fan_activity = content
	elseif name == "cloud_cut_fan_challenge_prize" then
		self._cloud_cut_fan_challenge_prize = content
	elseif name == "cloud_cut_fan_collection" then
		self._cloud_cut_fan_collection = content

		self:_handleFanCollectionCfgs()
	elseif name == "cloud_cut_fan_face_collection" then
		self._cloud_cut_fan_face_collection = content
	elseif name == "cloud_cut_fan_creeps" then
		self._cloud_cut_fan_creeps = content
	elseif name == "cloud_cut_fan_master" then
		self._cloud_cut_fan_master = content
	elseif name == "cloud_cut_fan_reward_prize" then
		self._cloud_cut_fan_reward_prize = content
	elseif name == "cloud_cut_fan_face_repair_tips" then
		self._cloud_cut_fan_face_repair_tips = content
	end
end

function CloudCutFanConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function CloudCutFanConfig:getActCfgByActId(activityId)
	return self:_safeGet(self._cloud_cut_fan_activity, activityId)
end

function CloudCutFanConfig:getMaterialCfgById(activityId, materialId)
	return self:_safeGet(self._cloud_cut_fan_material, activityId, materialId)
end

function CloudCutFanConfig:getMaterialCfgListByActId(activityId)
	return self:_safeGet(self._cloud_cut_fan_material, activityId)
end

function CloudCutFanConfig:_handleFanMaterialCfgs(activityId)
	self._cloud_cut_fan_material_by_type = {}

	for _, materialCfg in pairs(self._cloud_cut_fan_material.dataList) do
		local activityId = materialCfg.activityId
		local typeId = materialCfg.typeId

		if not self._cloud_cut_fan_material_by_type[activityId] then
			if not self._cloud_cut_fan_material_by_type[activityId][typeId] then
				local typeList = {}

				table.insert(typeList, materialCfg)

				self._cloud_cut_fan_material_by_type[activityId][typeId] = typeList
				self._cloud_cut_fan_material_by_type[activityId] = self._cloud_cut_fan_material_by_type[activityId]
			end
		end
	end
end

function CloudCutFanConfig:getMaterialCfgListByType(activityId, typeId)
	return self:_safeGet(self._cloud_cut_fan_material_by_type, activityId, typeId) or {}
end

function CloudCutFanConfig:getAllChallengePrizeCfgs(activityId)
	return self:_safeGet(self._cloud_cut_fan_challenge_prize, activityId)
end

function CloudCutFanConfig:getChallengePrizeByDamage(activityId, damage)
	local challengePrizeCfgs = self:getAllChallengePrizeCfgs(activityId)

	if not challengePrizeCfgs then
		return ""
	end

	if damage <= 0 then
		return ""
	end

	for _, cfg in pairs(challengePrizeCfgs) do
		local damageRange = cfg.damageRange

		if damage >= damageRange[1] and damage <= damageRange[2] then
			return cfg.damagePrize
		end
	end

	if #challengePrizeCfgs > 0 then
		return challengePrizeCfgs[#challengePrizeCfgs].damagePrize
	end

	return ""
end

function CloudCutFanConfig:getFanFaceCfgById(activityId, fanFaceId)
	return self:_safeGet(self._cloud_cut_fan_face_collection, activityId, fanFaceId)
end

function CloudCutFanConfig:getAllFanFaceCfgs(activityId)
	return self:_safeGet(self._cloud_cut_fan_face_collection, activityId)
end

function CloudCutFanConfig:getFanMakeCfgById(activityId, fanId)
	return self:_safeGet(self._cloud_cut_fan_collection, activityId, fanId)
end

function CloudCutFanConfig:getAllFanMakeCfgs(activityId)
	return self:_safeGet(self._cloud_cut_fan_collection, activityId)
end

function CloudCutFanConfig:_handleFanCollectionCfgs()
	self._cloud_cut_fan_collection_by_recipe = {}

	for _, fanMakeCfg in pairs(self._cloud_cut_fan_collection.dataList) do
		local activityId = fanMakeCfg.activityId

		if not fanMakeCfg.recipe then
			if not self._cloud_cut_fan_collection_by_recipe[activityId] then
				local activityMap = {}

				activityMap[table.concat(fanMakeCfg.recipe, "_")] = fanMakeCfg
				self._cloud_cut_fan_collection_by_recipe[activityId] = activityMap
			end
		end
	end
end

function CloudCutFanConfig:getFanMakeCfgByRecipe(activityId, ...)
	local recipe = {
		...
	}

	if #recipe ~= 3 then
		return ""
	end

	for _, materialId in pairs(recipe) do
		local materialCfg = self:getMaterialCfgById(activityId, materialId)

		if not materialCfg then
			return ""
		end
	end

	local recipeId = table.concat(recipe, "_")

	return self:_safeGet(self._cloud_cut_fan_collection_by_recipe, activityId, recipeId) or ""
end

function CloudCutFanConfig:getAllFanRewardPrizeCfgs(activityId)
	return self:_safeGet(self._cloud_cut_fan_reward_prize, activityId)
end

function CloudCutFanConfig:getCreepCfgs(creepsMasterId)
	return self:_safeGet(self._cloud_cut_fan_creeps, creepsMasterId)
end

function CloudCutFanConfig:getTeamCfg(activityId, creepsMasterId)
	return self:_safeGet(self._cloud_cut_fan_master, activityId, creepsMasterId)
end

function CloudCutFanConfig:getRepairTipsCfg(activityId, id)
	return self:_safeGet(self._cloud_cut_fan_face_repair_tips, activityId, id)
end

CloudCutFanConfig.instance = CloudCutFanConfig.New()

return CloudCutFanConfig
