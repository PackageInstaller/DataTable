-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/config/OriginKingMengMengClgConfig.lua

module("logic.extensions.originkingmengmengclg.config.OriginKingMengMengClgConfig", package.seeall)

local OriginKingMengMengClgConfig = class("OriginKingMengMengClgConfig", BaseConfig)

function OriginKingMengMengClgConfig:getNames()
	return {
		"origin_king_meng_meng_clg_activity",
		"origin_king_meng_meng_clg_creeps",
		"origin_king_meng_meng_clg_creeps_master",
		"origin_king_meng_meng_clg_property",
		"origin_king_meng_meng_clg_stage",
		"origin_king_meng_meng_clg_support_pet"
	}
end

function OriginKingMengMengClgConfig:handleConfig(name, content)
	if name == "origin_king_meng_meng_clg_activity" then
		self._origin_king_meng_meng_clg_activity = content
	elseif name == "origin_king_meng_meng_clg_creeps" then
		self._origin_king_meng_meng_clg_creeps = content
	elseif name == "origin_king_meng_meng_clg_creeps_master" then
		self._origin_king_meng_meng_clg_creeps_master = content
	elseif name == "origin_king_meng_meng_clg_property" then
		self._origin_king_meng_meng_clg_property = content
	elseif name == "origin_king_meng_meng_clg_stage" then
		self._origin_king_meng_meng_clg_stage = content
	elseif name == "origin_king_meng_meng_clg_support_pet" then
		self._origin_king_meng_meng_clg_support_pet = content
	end
end

function OriginKingMengMengClgConfig:_safeGet(data, ...)
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

function OriginKingMengMengClgConfig:getActivityData(activityId)
	return self:_safeGet(self._origin_king_meng_meng_clg_activity, activityId)
end

function OriginKingMengMengClgConfig:getCreepsDatas(creepsMasterId)
	return self:_safeGet(self._origin_king_meng_meng_clg_creeps, creepsMasterId)
end

function OriginKingMengMengClgConfig:getCreepsData(creepsMasterId, creepsId)
	return self:_safeGet(self._origin_king_meng_meng_clg_creeps, creepsMasterId, creepsId)
end

function OriginKingMengMengClgConfig:getCreepsMasterData(creepsMasterId)
	return self:_safeGet(self._origin_king_meng_meng_clg_creeps_master, creepsMasterId)
end

function OriginKingMengMengClgConfig:getPropertyDatass(activityId)
	return self:_safeGet(self._origin_king_meng_meng_clg_property, activityId)
end

function OriginKingMengMengClgConfig:getPropertyDatas(activityId, stageId)
	return self:_safeGet(self._origin_king_meng_meng_clg_property, activityId, stageId)
end

function OriginKingMengMengClgConfig:getPropertyData(activityId, stageId, propertyId)
	return self:_safeGet(self._origin_king_meng_meng_clg_property, activityId, stageId, propertyId)
end

function OriginKingMengMengClgConfig:getPropertyDataByValue(activityId, stageId, value)
	return MmUtil.binarySearchInSingleKey(self:getPropertyDatas(activityId, stageId), "value", value)
end

function OriginKingMengMengClgConfig:getStageDatas(activityId)
	return self:_safeGet(self._origin_king_meng_meng_clg_stage, activityId)
end

function OriginKingMengMengClgConfig:getStageData(activityId, stageId)
	return self:_safeGet(self._origin_king_meng_meng_clg_stage, activityId, stageId)
end

function OriginKingMengMengClgConfig:getSupportPetDatas(activityId)
	return self:_safeGet(self._origin_king_meng_meng_clg_support_pet, activityId)
end

function OriginKingMengMengClgConfig:getSupportPetData(activityId, creepsId)
	return self:_safeGet(self._origin_king_meng_meng_clg_support_pet, activityId, creepsId)
end

function OriginKingMengMengClgConfig:getSupportPetDatasByPlanId(activityId, supportPetPlanId)
	local result = {}

	if self._origin_king_meng_meng_clg_support_pet then
		if not self._origin_king_meng_meng_clg_support_pet.dataList then
			local dataList = {}

			for _, supportPetData in ipairs(dataList) do
				if supportPetData.activityId == activityId and supportPetData.supportPetPlanId == supportPetPlanId then
					table.insert(result, supportPetData)
				end
			end

			return result
		end
	end
end

OriginKingMengMengClgConfig.instance = OriginKingMengMengClgConfig.New()

return OriginKingMengMengClgConfig
