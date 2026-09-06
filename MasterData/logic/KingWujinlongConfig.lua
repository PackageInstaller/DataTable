-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingwujinlong/config/KingWujinlongConfig.lua

module("logic.extensions.kingwujinlong.config.KingWujinlongConfig", package.seeall)

local KingWujinlongConfig = class("KingWujinlongConfig", BaseConfig)

function KingWujinlongConfig:getNames()
	return {
		"king_ashless_dragon_clg_creeps_master",
		"king_ashless_dragon_clg_pos_buff",
		"king_ashless_dragon_clg_accu_buff",
		"king_ashless_dragon_clg",
		"king_ashless_dragon_clg_stage",
		"king_ashless_dragon_clg_creeps"
	}
end

function KingWujinlongConfig:handleConfig(name, content)
	if name == "king_ashless_dragon_clg_creeps_master" then
		self._king_ashless_dragon_clg_creeps_master = content
	elseif name == "king_ashless_dragon_clg_pos_buff" then
		self._king_ashless_dragon_clg_pos_buff = content
	elseif name == "king_ashless_dragon_clg_accu_buff" then
		self._king_ashless_dragon_clg_accu_buff = content
	elseif name == "king_ashless_dragon_clg" then
		self._king_ashless_dragon_clg = content
	elseif name == "king_ashless_dragon_clg_stage" then
		self._king_ashless_dragon_clg_stage = content
	elseif name == "king_ashless_dragon_clg_creeps" then
		self._king_ashless_dragon_clg_creeps = content
	end
end

function KingWujinlongConfig:getActivityCfgById(id)
	return self._king_ashless_dragon_clg[id]
end

function KingWujinlongConfig:getStageCfgListById(id)
	return self._king_ashless_dragon_clg_stage[id]
end

function KingWujinlongConfig:getStageCfgById(id, stageId)
	if self._king_ashless_dragon_clg_stage[id] then
		return self._king_ashless_dragon_clg_stage[id][stageId]
	end
end

function KingWujinlongConfig:getMonsterCfgById(id)
	return self._king_ashless_dragon_clg_creeps_master[id]
end

function KingWujinlongConfig:getCreepsById(id)
	return self._king_ashless_dragon_clg_creeps[id]
end

function KingWujinlongConfig:getBuffListById(id)
	return self._king_ashless_dragon_clg_accu_buff[id]
end

KingWujinlongConfig.instance = KingWujinlongConfig.New()

return KingWujinlongConfig
