-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianchallenge/config/TunTianChallengeConfig.lua

module("logic.extensions.tuntianchallenge.config.TunTianChallengeConfig", package.seeall)

local TunTianChallengeConfig = class("TunTianChallengeConfig", BaseConfig)

function TunTianChallengeConfig:onInit()
	TunTianChallengeConfig.super.onInit(self)
end

function TunTianChallengeConfig:getNames()
	return {
		"tun_tian_challenge_activity",
		"tun_tian_challenge_client_common",
		"tun_tian_normal_clg_progress",
		"tun_tian_normal_clg_monster",
		"tun_tian_normal_clg_monster_type",
		"tun_tian_normal_clg_monster_slot",
		"tun_tian_extreme_clg_stage",
		"tun_tian_extreme_clg_stage_type",
		"tun_tian_extreme_clg_convert_plan",
		"tun_tian_clg_master",
		"tun_tian_clg_creeps"
	}
end

function TunTianChallengeConfig:handleConfig(name, content)
	if name == "tun_tian_challenge_activity" then
		self._baseCfg = content
	elseif name == "tun_tian_challenge_client_common" then
		self._clientCommonCfg = content
	elseif name == "tun_tian_normal_clg_progress" then
		self._norProgressCfg = content
	elseif name == "tun_tian_normal_clg_monster" then
		self._norMonsterCfg = content
	elseif name == "tun_tian_normal_clg_monster_type" then
		self._norMonsterTypeCfg = content
	elseif name == "tun_tian_normal_clg_monster_slot" then
		self._norMonsterSlotCfg = content
	elseif name == "tun_tian_extreme_clg_stage" then
		self._extStageCfg = content
	elseif name == "tun_tian_extreme_clg_stage_type" then
		self._extStageTypeCfg = content
	elseif name == "tun_tian_extreme_clg_convert_plan" then
		self._extConvertCfg = content
	elseif name == "tun_tian_clg_master" then
		self._masterCfg = content
	elseif name == "tun_tian_clg_creeps" then
		self._creepsCfg = content
	end
end

function TunTianChallengeConfig:getTtBaseData(activityId)
	return self._baseCfg[activityId]
end

function TunTianChallengeConfig:getTtClientCommonValue(activityId, key, isToNumber)
	local baseData = self:getTtBaseData(activityId)

	if baseData then
		if not baseData.comPlanId then
			local comPlanId = 0

			if self._clientCommonCfg[comPlanId] then
				local data = self._clientCommonCfg[comPlanId][key]
				local value

				if data then
					value = data.value

					if isToNumber then
						value = checknumber(value)
					end
				end

				return value
			end
		end
	end
end

function TunTianChallengeConfig:getTtNorProgressDataList(activityId)
	return self._norProgressCfg[activityId]
end

function TunTianChallengeConfig:getTtNorProgressData(activityId, dataBitId)
	return self._norProgressCfg[activityId][dataBitId]
end

function TunTianChallengeConfig:getTtNorMonsterData(activityId, creepsMasterId)
	return self._norMonsterCfg[activityId][creepsMasterId]
end

function TunTianChallengeConfig:getTtNorMonsterTypeDataList(activityId)
	return self._norMonsterTypeCfg[activityId]
end

function TunTianChallengeConfig:getTtNorMonsterTypeData(activityId, monsterTypeId)
	return self._norMonsterTypeCfg[activityId][monsterTypeId]
end

function TunTianChallengeConfig:getTtNorMonsterSlotDataList(activityId)
	return self._norMonsterSlotCfg[activityId]
end

function TunTianChallengeConfig:getTtNorMonsterSlotData(activityId, slotId)
	return self._norMonsterSlotCfg[activityId][slotId]
end

function TunTianChallengeConfig:getTtExtStageDataLists(activityId)
	return self._extStageCfg[activityId]
end

function TunTianChallengeConfig:getTtExtStageDataList(activityId, stageType)
	return self._extStageCfg[activityId][stageType]
end

function TunTianChallengeConfig:getTtExtStageData(activityId, stageType, stageId)
	return self._extStageCfg[activityId][stageType][stageId]
end

function TunTianChallengeConfig:getTtExtStageTypeDataList(activityId)
	return self._extStageTypeCfg[activityId]
end

function TunTianChallengeConfig:getTtExtStageTypeData(activityId, stageType)
	return self._extStageTypeCfg[activityId][stageType]
end

function TunTianChallengeConfig:getTtExtConvertDataList(balancedConvertPlanId)
	return self._extConvertCfg[balancedConvertPlanId]
end

function TunTianChallengeConfig:getTtExtConvertData(balancedConvertPlanId, distId)
	return self._extConvertCfg[balancedConvertPlanId][distId]
end

function TunTianChallengeConfig:getTtMasterData(creepsMasterId)
	return self._masterCfg[creepsMasterId]
end

function TunTianChallengeConfig:getTtCreepsDataList(creepsMasterId)
	return self._creepsCfg[creepsMasterId]
end

function TunTianChallengeConfig:getTtCreepsData(creepsMasterId, creepsId)
	return self._creepsCfg[creepsMasterId][creepsId]
end

TunTianChallengeConfig.instance = TunTianChallengeConfig.New()

return TunTianChallengeConfig
