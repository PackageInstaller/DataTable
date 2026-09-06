-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingroad/config/KingRoadConfig.lua

module("logic.extensions.kingroad.config.KingRoadConfig", package.seeall)

local KingRoadConfig = class("KingRoadConfig", BaseConfig)

function KingRoadConfig:onInit()
	KingRoadConfig.super.onInit(self)

	self._kingloadstrengthmonsterCfg = nil
	self._kingloadstrengthcreepsCfg = nil
	self._kingloadcollectprizeCfg = nil
end

function KingRoadConfig:getNames()
	return {
		"king_load_strength_monster",
		"king_load_strength_creeps",
		"king_load_collect_prize"
	}
end

function KingRoadConfig:handleConfig(name, content)
	if name == "king_load_strength_monster" then
		self._kingloadstrengthmonsterCfg = content
	elseif name == "king_load_strength_creeps" then
		self._kingloadstrengthcreepsCfg = content
	elseif name == "king_load_collect_prize" then
		self._kingloadcollectprizeCfg = content
	end
end

function KingRoadConfig:getStrengthMonsterCfgById(id)
	return self._kingloadstrengthmonsterCfg[id]
end

function KingRoadConfig:getStrengthCreepsCfgByIds(id)
	return self._kingloadstrengthcreepsCfg[id]
end

function KingRoadConfig:getCollectPrizeCfgById(id)
	return self._kingloadcollectprizeCfg[id]
end

KingRoadConfig.instance = KingRoadConfig.New()

return KingRoadConfig
