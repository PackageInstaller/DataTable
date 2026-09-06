-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunlunchallenge/config/KunLunChallengeConfig.lua

module("logic.extensions.kunlunchallenge.config.KunLunChallengeConfig", package.seeall)

local KunLunChallengeConfig = class("KunLunChallengeConfig", BaseConfig)

function KunLunChallengeConfig:onInit()
	KunLunChallengeConfig.super.onInit(self)
end

function KunLunChallengeConfig:getNames()
	return {
		"kun_lun_challenge_activity",
		"kun_lun_challenge_client_common",
		"kun_lun_challenge_damage",
		"kun_lun_challenge_extreme_card_group",
		"kun_lun_challenge_extreme_card",
		"kun_lun_challenge_extreme_stage",
		"kun_lun_challenge_monster",
		"kun_lun_challenge_creeps"
	}
end

function KunLunChallengeConfig:handleConfig(name, content)
	if name == "kun_lun_challenge_activity" then
		self._klActData = content
	elseif name == "kun_lun_challenge_client_common" then
		self._clientCommonCfg = content
	elseif name == "kun_lun_challenge_damage" then
		self._klDamageCfg = content
	elseif name == "kun_lun_challenge_extreme_card_group" then
		self._klExtCardGroupCfg = content
	elseif name == "kun_lun_challenge_extreme_card" then
		self._klExtCardCfg = content

		self:_handleKlExtCardCfg(content.dataList)
	elseif name == "kun_lun_challenge_extreme_stage" then
		self._klExtStageCfg = content
	elseif name == "kun_lun_challenge_monster" then
		self._klMonsterCfg = content
	elseif name == "kun_lun_challenge_creeps" then
		self._klChallengeCreepsCfg = content
	end
end

function KunLunChallengeConfig:getKlActData(activityId)
	return self._klActData[activityId]
end

function KunLunChallengeConfig:getClientCommonValue(activityId, key, isToNumber)
	local baseData = self:getKlActData(activityId)

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

function KunLunChallengeConfig:getKlDamageDataList(activityId)
	return self._klDamageCfg[activityId]
end

function KunLunChallengeConfig:getKlDamageData(activityId, prizeId)
	if self._klDamageCfg[activityId] then
		return self._klDamageCfg[activityId][prizeId]
	end
end

function KunLunChallengeConfig:getKlDamageDataByHp(activityId, bossLeftHp)
	local data
	local dataList = self:getKlDamageDataList(activityId)

	for _, v in ipairs(dataList) do
		if bossLeftHp >= v.bossLeftHp then
			data = v
		else
			break
		end
	end

	return data
end

function KunLunChallengeConfig:getKlExtCardGroupDataList(activityId)
	return self._klExtCardGroupCfg[activityId]
end

function KunLunChallengeConfig:getKlExtCardGroupData(activityId, groupId)
	if self._klExtCardGroupCfg[activityId] then
		return self._klExtCardGroupCfg[activityId][groupId]
	end
end

function KunLunChallengeConfig:getKlExtCardCfgs(activityId)
	return self._klExtCardCfg[activityId]
end

function KunLunChallengeConfig:getKlExtCardCfg(activityId, groupId)
	if self._klExtCardCfg[activityId] then
		return self._klExtCardCfg[activityId][groupId]
	end
end

function KunLunChallengeConfig:getKlExtCardData(activityId, groupId, index)
	if self._klExtCardCfg[activityId] and self._klExtCardCfg[activityId][groupId] then
		return self._klExtCardCfg[activityId][groupId][index]
	end
end

function KunLunChallengeConfig:_handleKlExtCardCfg(dataList)
	self._klExtCardDataListGroup = {}

	for _, data in ipairs(dataList) do
		if self._klExtCardDataListGroup[data.activityId] == nil then
			self._klExtCardDataListGroup[data.activityId] = {}
		end

		self._klExtCardDataListGroup[data.activityId][data.cardId] = data
	end
end

function KunLunChallengeConfig:getKlExtCardDataListById(activityId)
	return self._klExtCardDataListGroup[activityId]
end

function KunLunChallengeConfig:getKlExtCardDataById(activityId, cardId)
	if self._klExtCardDataListGroup[activityId] then
		return self._klExtCardDataListGroup[activityId][cardId]
	end
end

function KunLunChallengeConfig:getKlExtStageDataList(activityId)
	return self._klExtStageCfg[activityId]
end

function KunLunChallengeConfig:getKlExtStageData(activityId, stageId)
	if self._klExtStageCfg[activityId] then
		return self._klExtStageCfg[activityId][stageId]
	end
end

function KunLunChallengeConfig:getKlExtremeMonsterDataList()
	return self._klMonsterCfg
end

function KunLunChallengeConfig:getKlExtremeMonsterData(creepsMasterId)
	return self._klMonsterCfg[creepsMasterId]
end

function KunLunChallengeConfig:getKlChallengeCreepsDataList(creepsMasterId)
	return self._klChallengeCreepsCfg[creepsMasterId]
end

function KunLunChallengeConfig:getKlChallengeCreepsData(creepsMasterId, creepsId)
	if self._klChallengeCreepsCfg[creepsMasterId] then
		return self._klChallengeCreepsCfg[creepsMasterId][creepsId]
	end
end

KunLunChallengeConfig.instance = KunLunChallengeConfig.New()

return KunLunChallengeConfig
