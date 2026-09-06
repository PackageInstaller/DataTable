-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/config/FunCampNpcConfig.lua

module("logic.extensions.funcamp.config.FunCampNpcConfig", package.seeall)

local FunCampNpcConfig = class("FunCampNpcConfig", BaseConfig)

function FunCampNpcConfig:onInit()
	FunCampNpcConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function FunCampNpcConfig:getNames()
	return {
		"camp_battle_path_finding",
		"camp_battle_path_finding_buy",
		"camp_battle_path_finding_scene",
		"camp_battle_path_finding_npc",
		"camp_battle_path_finding_master",
		"camp_battle_path_finding_creeps",
		"camp_battle_path_finding_help"
	}
end

function FunCampNpcConfig:handleConfig(name, content)
	if name == "camp_battle_path_finding" then
		self._camp_battle_path_finding = content
	elseif name == "camp_battle_path_finding_buy" then
		self._camp_battle_path_finding_buy = content
	elseif name == "camp_battle_path_finding_scene" then
		self._camp_battle_path_finding_scene = content
	elseif name == "camp_battle_path_finding_npc" then
		self._camp_battle_path_finding_npc = content
	elseif name == "camp_battle_path_finding_master" then
		self._camp_battle_path_finding_master = content
	elseif name == "camp_battle_path_finding_creeps" then
		self._camp_battle_path_finding_creeps = content
	elseif name == "camp_battle_path_finding_help" then
		self._camp_battle_path_finding_help = content
	end
end

function FunCampNpcConfig:getCfgById(id)
	return self._camp_battle_path_finding[id]
end

function FunCampNpcConfig:getCreepsMasterId(sceneId, npcId)
	local scene = self._camp_battle_path_finding_npc[sceneId]
	local npc = scene[checknumber(npcId)]

	print("lbc============", sceneId, npcId)

	return npc.creepsMasterId
end

function FunCampNpcConfig:getTeamInfo(creepsMasterId)
	return self._camp_battle_path_finding_master[creepsMasterId]
end

function FunCampNpcConfig:getPetCreeps(creepsMasterId)
	return self._camp_battle_path_finding_creeps[creepsMasterId]
end

function FunCampNpcConfig:getNpcCfg(sceneId, npcId)
	local scene = self._camp_battle_path_finding_npc[sceneId]

	return scene[checknumber(npcId)]
end

function FunCampNpcConfig:getNpcId(sceneId, npcId)
	local npc = self:getNpcCfg(sceneId, npcId)

	return npc.npcId
end

function FunCampNpcConfig:getGameBuyCost(times)
	local actId = FunCampModel.instance:getActivityId()
	local info = self:getCfgById(actId)
	local cfg = self._camp_battle_path_finding_buy[info.buyPlanId]

	for i, v in ipairs(cfg) do
		if checknumber(v.time) == times then
			return v
		end
	end

	return nil
end

function FunCampNpcConfig:getGameBuyMax()
	local actId = FunCampModel.instance:getActivityId()
	local info = self:getCfgById(actId)
	local cfg = self._camp_battle_path_finding_buy[info.buyPlanId]

	print("lbc======", info.buyPlanId)

	local times = 0

	for k, v in pairs(cfg) do
		if times < v.time then
			times = v.time
		end
	end

	return times
end

function FunCampNpcConfig:getCampSupPetInfo(actId, campId)
	local info = self._camp_battle_path_finding_help[actId]

	return info[campId]
end

FunCampNpcConfig.instance = FunCampNpcConfig.New()

return FunCampNpcConfig
