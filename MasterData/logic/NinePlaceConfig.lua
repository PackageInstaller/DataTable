-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/config/NinePlaceConfig.lua

module("logic.extensions.nineplace.config.NinePlaceConfig", package.seeall)

local NinePlaceConfig = class("NinePlaceConfig", BaseConfig)

function NinePlaceConfig:onInit()
	NinePlaceConfig.super.onInit(self)

	self.stageCfg = nil
	self.monsterCfg = nil
	self.creepsCfg = nil
	self.levelCfg = nil
end

function NinePlaceConfig:getNames()
	return {
		"nine_place_stage",
		"nine_place_monster",
		"nine_place_creeps"
	}
end

function NinePlaceConfig:handleConfig(name, content)
	if name == "nine_place_monster" then
		self.monsterCfg = content
	elseif name == "nine_place_stage" then
		self.stageCfg = content
	elseif name == "nine_place_creeps" then
		self.creepsCfg = content
	end
end

function NinePlaceConfig:getStageCfgs()
	return self.stageCfg
end

function NinePlaceConfig:getStageCfgById(stageId)
	return self.stageCfg[stageId]
end

function NinePlaceConfig:getMonstersCfgByStageId(stageId)
	local list = {}
	local tempList = self.monsterCfg[stageId]

	for k, v in pairs(tempList) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.creepsMasterId < b.creepsMasterId
	end)

	return list
end

function NinePlaceConfig:getMonsterCfg(stageId, creepsMasterId)
	return self.monsterCfg[stageId][creepsMasterId]
end

function NinePlaceConfig:getPetCfg(creepsMasterId, creepsId)
	return self.creepsCfg[creepsMasterId][creepsId]
end

function NinePlaceConfig:getPetsCfg(creepsMasterId)
	return self.creepsCfg[creepsMasterId]
end

NinePlaceConfig.instance = NinePlaceConfig.New()

return NinePlaceConfig
