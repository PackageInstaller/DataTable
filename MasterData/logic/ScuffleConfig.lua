-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/config/ScuffleConfig.lua

module("logic.extensions.scuffle.config.ScuffleConfig", package.seeall)

local ScuffleConfig = class("ScuffleConfig", BaseConfig)

function ScuffleConfig:onInit()
	ScuffleConfig.super.onInit(self)

	self._scuffle_seasonCfg = nil
	self._scuffle_levelCfg = nil
	self._scuffle_system_petCfg = nil
	self._scuffle_level_prizeCfg = nil
	self._scuffle_rank_prizeCfg = nil
	self._scuffle_taskCfg = nil
	self._scuffle_commonCfg = nil
	self.scuffle_random_buff = nil
	self.scuffle_daily_buff = nil
end

function ScuffleConfig:getNames()
	return {
		"scuffle_season",
		"scuffle_level",
		"scuffle_system_pet",
		"scuffle_level_prize",
		"scuffle_rank_prize",
		"scuffle_task",
		"scuffle_common",
		"scuffle_random_buff",
		"scuffle_daily_buff"
	}
end

function ScuffleConfig:handleConfig(name, content)
	if name == "scuffle_season" then
		self._scuffle_seasonCfg = content
	elseif name == "scuffle_level" then
		self._scuffle_levelCfg = content
	elseif name == "scuffle_system_pet" then
		self._scuffle_system_petCfg = content
	elseif name == "scuffle_level_prize" then
		self._scuffle_level_prizeCfg = content
	elseif name == "scuffle_rank_prize" then
		self._scuffle_rank_prizeCfg = content
	elseif name == "scuffle_task" then
		self._scuffle_taskCfg = content
	elseif name == "scuffle_common" then
		self._scuffle_commonCfg = content
	elseif name == "scuffle_random_buff" then
		self.scuffle_random_buff = content
	elseif name == "scuffle_daily_buff" then
		self.scuffle_daily_buff = content
	end
end

function ScuffleConfig:getSeasonCfg(id)
	return self._scuffle_seasonCfg[id]
end

function ScuffleConfig:getLevelCfg(level)
	return self._scuffle_levelCfg[level]
end

function ScuffleConfig:getLevelCfgs()
	return self._scuffle_levelCfg.dataList
end

function ScuffleConfig:getLevelCfgByScore(score)
	score = checknumber(score)

	if score < 0 then
		score = 0
	end

	local count = #self._scuffle_levelCfg.dataList

	for i = count, 1, -1 do
		local cfg = self._scuffle_levelCfg.dataList[i]

		if score >= cfg.baseScore then
			return cfg
		end
	end

	return self._scuffle_levelCfg.dataList[1]
end

function ScuffleConfig:getSystemPetCfg(creepsId)
	return self._scuffle_system_petCfg[creepsId]
end

function ScuffleConfig:getLevelPrizeCfg(seasonId, level)
	if self._scuffle_level_prizeCfg[seasonId] then
		return self._scuffle_level_prizeCfg[seasonId][level]
	end

	return nil
end

function ScuffleConfig:getLevelPrizeCfgs(seasonId)
	local result = TableUtil.toList(self._scuffle_level_prizeCfg[seasonId] or {})

	table.sort(result, function(a, b)
		return a.level < b.level
	end)

	return result
end

function ScuffleConfig:getRankPrizeCfg(seasonId, rightTop)
	if self._scuffle_rank_prizeCfg[seasonId] then
		return self._scuffle_rank_prizeCfg[seasonId][rightTop]
	end

	return nil
end

function ScuffleConfig:getRankPrizeCfgs(seasonId)
	local result = TableUtil.toList(self._scuffle_rank_prizeCfg[seasonId])

	table.sort(result, function(a, b)
		return a.rightTop < b.rightTop
	end)

	return result
end

function ScuffleConfig:getTaskCfg(seasonId, taskId)
	if self._scuffle_taskCfg[seasonId] then
		return self._scuffle_taskCfg[seasonId][taskId]
	end

	return nil
end

function ScuffleConfig:getTaskCfgs(seasonId)
	return self._scuffle_taskCfg[seasonId] or {}
end

function ScuffleConfig:getCommonValueByKey(key)
	if self._scuffle_commonCfg[key] then
		if not string.nilorempty(self._scuffle_commonCfg[key].value2) then
			return self._scuffle_commonCfg[key].value2
		else
			return self._scuffle_commonCfg[key].value
		end
	end

	return nil
end

function ScuffleConfig:getBuffCfg(id)
	return self.scuffle_random_buff[id]
end

function ScuffleConfig:getDailyBuffList(id)
	return self.scuffle_daily_buff[id]
end

function ScuffleConfig:getDailyBuff(id, day)
	if self.scuffle_daily_buff[id] then
		return self.scuffle_daily_buff[id][day]
	end
end

ScuffleConfig.instance = ScuffleConfig.New()

return ScuffleConfig
