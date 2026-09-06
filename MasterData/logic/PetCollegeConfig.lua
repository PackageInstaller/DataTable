-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/config/PetCollegeConfig.lua

module("logic.extensions.teachingdungeon.config.PetCollegeConfig", package.seeall)

local PetCollegeConfig = class("PetCollegeConfig", BaseConfig)
local table_insert = table.insert

function PetCollegeConfig:onInit()
	return
end

function PetCollegeConfig:getNames()
	return {
		"pet_college_challenge",
		"pet_college_stage",
		"pet_college_support",
		"pet_college_creeps",
		"pet_college_team",
		"pet_college_guide"
	}
end

function PetCollegeConfig:handleConfig(name, content)
	if name == "pet_college_challenge" then
		self.pet_college_challengeCfg = content
	elseif name == "pet_college_stage" then
		self.pet_college_stageCfg = content
	elseif name == "pet_college_support" then
		self.pet_college_supportCfg = content
	elseif name == "pet_college_creeps" then
		self.pet_college_creepsCfg = content
	elseif name == "pet_college_team" then
		self.pet_college_teamCfg = content
	elseif name == "pet_college_guide" then
		self.pet_college_guideCfg = content
	end
end

function PetCollegeConfig:getChallegenCfg(challengeId)
	return self.pet_college_challengeCfg[challengeId]
end

function PetCollegeConfig:getStageCfg(challengeId)
	return self.pet_college_stageCfg[challengeId]
end

function PetCollegeConfig:getStageCfgByStageId(challengeId, stageId)
	return self.pet_college_stageCfg[challengeId][stageId]
end

function PetCollegeConfig:raceId2ChallengeId(raceId, skinId)
	skinId = skinId or 0

	for k, v in pairs(self.pet_college_challengeCfg) do
		if v.raceId == raceId and (skinId == 0 or v.faceId == skinId) then
			return v.challengeId
		end
	end

	return nil
end

function PetCollegeConfig:getStageGoods(challengeId, stageId)
	local cfg = self:getStageCfgByStageId(challengeId, stageId)

	return string.split(cfg.firstPassPrize, "#")
end

function PetCollegeConfig:getSupportCfg(challengeId, stageId)
	return self.pet_college_supportCfg[challengeId][stageId]
end

function PetCollegeConfig:getSupportPetIds(challengeId, stageId)
	local list = {}
	local cfgs = self:getSupportCfg(challengeId, stageId)

	for _, v in pairs(cfgs) do
		table_insert(list, v.creepsId)
	end

	return list
end

function PetCollegeConfig:getCreepsPetIds(challengeId, stageId)
	local cfgs = self:getCreepsCfgByStage(challengeId, stageId)
	local list = {}

	for _, v in pairs(cfgs) do
		table_insert(list, v.creepsId)
	end

	return list
end

function PetCollegeConfig:getTeamCfg(teamId)
	return self.pet_college_teamCfg[teamId]
end

function PetCollegeConfig:getCreepsCfg(creepsMasterId)
	return self.pet_college_creepsCfg[creepsMasterId]
end

function PetCollegeConfig:getMyPetCfg(challengeId, stageId, creepsId)
	local cfg = self:getSupportCfg(challengeId, stageId)

	return cfg[creepsId]
end

function PetCollegeConfig:getEnemyPetCfg(challengeId, stageId, creepsId)
	local cfg = self:getStageCfgByStageId(challengeId, stageId)
	local creepsCfg = self:getCreepsCfg(cfg.teamId)

	return creepsCfg[creepsId]
end

function PetCollegeConfig:getTeamCfgByStage(challengeId, stageId)
	local cfg = self:getStageCfgByStageId(challengeId, stageId)

	return self:getTeamCfg(cfg.teamId)
end

function PetCollegeConfig:getEnemyForm(challengeId, stageId)
	local cfgs = self:getCreepsCfgByStage(challengeId, stageId)
	local form = {}

	for i = 1, 9 do
		form[i] = 0
	end

	for i, v in pairs(cfgs) do
		form[v.posId] = v.creepsId
	end

	return form
end

function PetCollegeConfig:getCreepsCfgByStage(challengeId, stageId)
	local cfg = self:getStageCfgByStageId(challengeId, stageId)

	return self:getCreepsCfg(cfg.teamId)
end

function PetCollegeConfig:getBuffGuide(challengeId, stageId)
	local info = {}
	local cfg = self:getGuideCfg(challengeId, stageId)

	if not cfg then
		return false
	end

	local list1 = string.split(cfg.buff, "##")

	for i, v in ipairs(list1) do
		local list2 = string.split(v, "::")

		info[checknumber(list2[2])] = {
			desc = list2[3],
			npcId = checknumber(list2[1])
		}
	end

	return info
end

function PetCollegeConfig:getSkillGuide(challengeId, stageId)
	local cfg = self:getGuideCfg(challengeId, stageId)

	if not cfg then
		return false
	end

	local info = {}
	local list1 = string.split(cfg.skill, "##")

	for i, v in ipairs(list1) do
		local list2 = string.split(v, "::")

		info[checknumber(list2[2])] = {
			desc = list2[3],
			npcId = checknumber(list2[1])
		}
	end

	return info
end

function PetCollegeConfig:getstartGuide(challengeId, stageId)
	local cfg = self:getGuideCfg(challengeId, stageId)

	if not cfg then
		return "", "", 0
	end

	local list = string.split(cfg.start, "::")

	return list[2], checknumber(list[1])
end

function PetCollegeConfig:getGuideCfg(challengeId, stageId)
	return self.pet_college_guideCfg[challengeId] and self.pet_college_guideCfg[challengeId][stageId]
end

PetCollegeConfig.instance = PetCollegeConfig.New()

return PetCollegeConfig
