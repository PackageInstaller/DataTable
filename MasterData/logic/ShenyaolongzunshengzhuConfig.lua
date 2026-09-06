-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaolongzunshengzhu/config/ShenyaolongzunshengzhuConfig.lua

module("logic.extensions.shenyaolongzunshengzhu.config.ShenyaolongzunshengzhuConfig", package.seeall)

local ShenyaolongzunshengzhuConfig = class("ShenyaolongzunshengzhuConfig", BaseConfig)

function ShenyaolongzunshengzhuConfig:getNames()
	return {
		"divine_dragon_arya_clg_activity",
		"divine_dragon_arya_clg_stage",
		"divine_dragon_arya_clg_rule",
		"divine_dragon_arya_clg_monster",
		"divine_dragon_arya_clg_creeps",
		"divine_dragon_arya_clg_common"
	}
end

function ShenyaolongzunshengzhuConfig:handleConfig(name, content)
	if name == "divine_dragon_arya_clg_activity" then
		self._divine_dragon_arya_clg_activity = content
	elseif name == "divine_dragon_arya_clg_stage" then
		self._divine_dragon_arya_clg_stage = content
	elseif name == "divine_dragon_arya_clg_rule" then
		self._divine_dragon_arya_clg_rule = content
	elseif name == "divine_dragon_arya_clg_monster" then
		self._divine_dragon_arya_clg_monster = content
	elseif name == "divine_dragon_arya_clg_creeps" then
		self._divine_dragon_arya_clg_creeps = content
	elseif name == "divine_dragon_arya_clg_common" then
		self._divine_dragon_arya_clg_common = content
	end
end

function ShenyaolongzunshengzhuConfig:getCommonValue(key)
	if self._divine_dragon_arya_clg_common[key] then
		return self._divine_dragon_arya_clg_common[key].value
	end
end

function ShenyaolongzunshengzhuConfig:getActivityCfgById(id)
	return self._divine_dragon_arya_clg_activity[id]
end

function ShenyaolongzunshengzhuConfig:getStageListById(id)
	return self._divine_dragon_arya_clg_stage[id]
end

function ShenyaolongzunshengzhuConfig:getStageCfgById(id, stageId)
	if self._divine_dragon_arya_clg_stage[id] then
		return self._divine_dragon_arya_clg_stage[id][stageId]
	end
end

function ShenyaolongzunshengzhuConfig:getRuleCfgById(id)
	return self._divine_dragon_arya_clg_rule[id]
end

function ShenyaolongzunshengzhuConfig:getMonsterCfgById(id)
	return self._divine_dragon_arya_clg_monster[id]
end

function ShenyaolongzunshengzhuConfig:getCreepsCfgById(id)
	return self._divine_dragon_arya_clg_creeps[id]
end

ShenyaolongzunshengzhuConfig.instance = ShenyaolongzunshengzhuConfig.New()

return ShenyaolongzunshengzhuConfig
