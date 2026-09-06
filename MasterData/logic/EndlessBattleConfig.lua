-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessbattle/config/EndlessBattleConfig.lua

module("logic.extensions.endlessbattle.config.EndlessBattleConfig", package.seeall)

local EndlessBattleConfig = class("EndlessBattleConfig", BaseConfig)

function EndlessBattleConfig:onInit()
	EndlessBattleConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function EndlessBattleConfig:getNames()
	return {
		"infinite_fight_stage",
		"infinite_fight_buff",
		"infinite_fight_wave",
		"infinite_fight_creeps",
		"infinite_fight_team",
		"infinite_fight_common"
	}
end

function EndlessBattleConfig:handleConfig(name, content)
	if name == "infinite_fight_stage" then
		self._stageCfgs = content
	elseif name == "infinite_fight_buff" then
		self._buffCfgs = content
	elseif name == "infinite_fight_wave" then
		self._waveCfgs = content
	elseif name == "infinite_fight_creeps" then
		self._creepCfgs = content
	elseif name == "infinite_fight_team" then
		self._teamCfgs = content
	elseif name == "infinite_fight_common" then
		self._commonCfgs = content
	end
end

function EndlessBattleConfig:getConstantValue(key)
	if self._commonCfgs then
		return self._commonCfgs[key].value
	end
end

function EndlessBattleConfig:getTeamCfg(id)
	if self._teamCfgs then
		return self._teamCfgs[id]
	end
end

function EndlessBattleConfig:getCreepCfgs(creepsMasterId)
	if self._creepCfgs then
		return self._creepCfgs[creepsMasterId] or {}
	end

	return {}
end

function EndlessBattleConfig:getStageCfgById(id)
	if self._stageCfgs then
		return self._stageCfgs[id]
	end

	return nil
end

function EndlessBattleConfig:getStageCfgs()
	return self._stageCfgs.dataList
end

function EndlessBattleConfig:getBuffCfg(planId, buffId)
	if self._buffCfgs and self._buffCfgs[planId] then
		return self._buffCfgs[planId][buffId]
	end

	return nil
end

function EndlessBattleConfig:getWaveCfg(id)
	if self._waveCfgs then
		return self._waveCfgs[id]
	end

	return nil
end

function EndlessBattleConfig:getWaveCfgs()
	if self._waveCfgs then
		return self._waveCfgs.dataList
	else
		return {}
	end
end

function EndlessBattleConfig:getStageCfgsByWaveId(waveId)
	local cfgs = {}

	if self._stageCfgs then
		for _, v in ipairs(self._stageCfgs.dataList) do
			if v.waveId == waveId then
				table.insert(cfgs, v)
			end
		end
	end

	table.sort(cfgs, function(a, b)
		return a.stageId < b.stageId
	end)

	return cfgs
end

EndlessBattleConfig.instance = EndlessBattleConfig.New()

return EndlessBattleConfig
