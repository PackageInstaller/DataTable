-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingkaya/config/KingKaYaConfig.lua

module("logic.extensions.kingkaya.config.KingKaYaConfig", package.seeall)

local KingKaYaConfig = class("KingKaYaConfig", BaseConfig)

function KingKaYaConfig:onInit()
	KingKaYaConfig.super.onInit(self)
end

function KingKaYaConfig:getNames()
	return {
		"king_kaya_activity",
		"king_kaya_client_common",
		"king_kaya_sign",
		"king_kaya_extreme_stage",
		"king_kaya_normal_difficulty",
		"king_kaya_normal_stage",
		"king_kaya_normal_progress_prize",
		"king_kaya_monster",
		"king_kaya_creeps"
	}
end

function KingKaYaConfig:handleConfig(name, content)
	if name == "king_kaya_activity" then
		self.king_kaya_activity = content
	elseif name == "king_kaya_client_common" then
		self.king_kaya_client_common = content
	elseif name == "king_kaya_sign" then
		self.king_kaya_sign = content
	elseif name == "king_kaya_extreme_stage" then
		self.king_kaya_extreme_stage = content
	elseif name == "king_kaya_normal_difficulty" then
		self.king_kaya_normal_difficulty = content
	elseif name == "king_kaya_normal_stage" then
		self.king_kaya_normal_stage = content
	elseif name == "king_kaya_normal_progress_prize" then
		self.king_kaya_normal_progress_prize = content
	elseif name == "king_kaya_monster" then
		self.king_kaya_monster = content
	elseif name == "king_kaya_creeps" then
		self.king_kaya_creeps = content
	end
end

function KingKaYaConfig:getActData(activityId)
	return self.king_kaya_activity[activityId]
end

function KingKaYaConfig:getCommonValue(activityId, key, isToNumber)
	local data = self:getActData(activityId)

	if data then
		if not data.comPlanId then
			local comPlanId = 0
			local comData = self.king_kaya_client_common[comPlanId]

			if comData then
				if isToNumber then
					return checknumber(comData[key])
				else
					return comData[key]
				end
			end
		end
	end
end

function KingKaYaConfig:getSignCfg(activityId)
	return self.king_kaya_sign[activityId]
end

function KingKaYaConfig:getSignData(activityId, signId)
	if self.king_kaya_sign[activityId] then
		return self.king_kaya_sign[activityId][signId]
	end
end

function KingKaYaConfig:getExtStageCfg(activityId)
	return self.king_kaya_extreme_stage[activityId]
end

function KingKaYaConfig:getExtStageData(activityId, stageId)
	if self.king_kaya_extreme_stage[activityId] then
		return self.king_kaya_extreme_stage[activityId][stageId]
	end
end

function KingKaYaConfig:getNorDiffCfg(activityId)
	return self.king_kaya_normal_difficulty[activityId]
end

function KingKaYaConfig:getNorDiffData(activityId, difficulty)
	if self.king_kaya_normal_difficulty[activityId] then
		return self.king_kaya_normal_difficulty[activityId][difficulty]
	end
end

function KingKaYaConfig:getNorStageCfg(activityId)
	return self.king_kaya_normal_stage[activityId]
end

function KingKaYaConfig:getNorStageData(activityId, stageId)
	if self.king_kaya_normal_stage[activityId] then
		return self.king_kaya_normal_stage[activityId][stageId]
	end
end

function KingKaYaConfig:getNorProgressCfg(activityId)
	return self.king_kaya_normal_progress_prize[activityId]
end

function KingKaYaConfig:getNorProgressData(activityId, prizeId)
	if self.king_kaya_normal_progress_prize[activityId] then
		return self.king_kaya_normal_progress_prize[activityId][prizeId]
	end
end

function KingKaYaConfig:getNorStageDataByScore(activityId, score)
	local data
	local cfg = self:getNorStageCfg(activityId)

	if cfg then
		for _, v in ipairs(cfg) do
			if score >= v.needScore then
				data = v
			else
				break
			end
		end
	end

	return data
end

function KingKaYaConfig:getMonsterData(creepsMasterId)
	return self.king_kaya_monster[creepsMasterId]
end

function KingKaYaConfig:getCreepsCfg(creepsMasterId)
	return self.king_kaya_creeps[creepsMasterId]
end

function KingKaYaConfig:getCreepsData(creepsMasterId, creepsId)
	if self.king_kaya_creeps[creepsMasterId] then
		return self.king_kaya_creeps[creepsMasterId][creepsId]
	end
end

KingKaYaConfig.instance = KingKaYaConfig.New()

return KingKaYaConfig
