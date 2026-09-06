-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/config/FamilyConfig.lua

module("logic.extensions.family.config.FamilyConfig", package.seeall)

local FamilyConfig = class("FamilyConfig", BaseConfig)
local json = require("cjson")

function FamilyConfig:onInit()
	FamilyConfig.super.onInit(self)

	self._cofignameCfg = nil
	self._faTabCfgs = nil
	self._faItemCfgs = nil
	self._rpCommonCfg = nil
	self._rpRedTypeCfgs = nil
	self._rpTaskCfgs = nil
	self.family_cube_channel = nil
end

function FamilyConfig:getNames()
	return {
		"family_authority",
		"family_common_config",
		"family_level_config",
		"family_common_config",
		"family_log",
		"donate",
		"donate_pool",
		"donate_prize",
		"family_boss",
		"family_boss_creeps",
		"family_boss_prize_strategy",
		"family_activity_tab",
		"family_activity_item",
		"family_packet_common",
		"family_packet_red",
		"family_packet_task",
		"family_totem",
		"family_cube_channel"
	}
end

function FamilyConfig:handleConfig(name, content)
	if name == "family_authority" then
		self._authorityCfg = content
	elseif name == "family_common_config" then
		self._commonCfg = content
	elseif name == "family_level_config" then
		self._levelCfg = content
	elseif name == "family_log" then
		self._logCfgs = content
	elseif name == "donate" then
		self._donateCfg = content
	elseif name == "donate_pool" then
		self._donatePoolCfg = content
	elseif name == "donate_prize" then
		self._donatePrizeCfg = content
	elseif name == "family_boss" then
		self._family_boss = content
	elseif name == "family_boss_creeps" then
		self._family_boss_creeps = content
	elseif name == "family_boss_prize_strategy" then
		self._family_boss_prize_strategy = content
	elseif name == "family_activity_tab" then
		self._faTabCfgs = content
	elseif name == "family_activity_item" then
		self._faItemCfgs = content
	elseif name == "family_packet_common" then
		self._rpCommonCfg = content
	elseif name == "family_packet_red" then
		self._rpRedTypeCfgs = content
	elseif name == "family_packet_task" then
		self._rpTaskCfgs = content
	elseif name == "family_cube_channel" then
		self.family_cube_channel = content
	elseif name == "family_totem" then
		self._family_totem = content
	end
end

function FamilyConfig:getTotemList()
	return self._family_totem.dataList
end

function FamilyConfig:getRedpackCommonValue(key, isToNumber)
	local str = ""

	if self._rpCommonCfg and self._rpCommonCfg[key] then
		str = self._rpCommonCfg[key].value
	end

	if isToNumber then
		return checknumber(str)
	else
		return str
	end
end

function FamilyConfig:getAllRedpackTypeCfgs()
	return self._rpRedTypeCfgs or {}
end

function FamilyConfig:getRedpackTypeCfg(typeId)
	if typeId == nil or self._rpRedTypeCfgs == nil then
		return
	end

	return self._rpRedTypeCfgs[typeId]
end

function FamilyConfig:getRedpackTaskCfgs()
	return self._rpTaskCfgs or {}
end

function FamilyConfig:getRedpackTaskCfgsById(taskId)
	if taskId == nil or self._rpTaskCfgs == nil then
		return
	end

	return self._rpTaskCfgs[taskId]
end

function FamilyConfig:getLvCfgByLv(lv)
	if self._levelCfg then
		return self._levelCfg[lv]
	end

	return nil
end

function FamilyConfig:getFamliyLvByScore(score)
	score = checknumber(score)

	local cfgs = self._levelCfg.dataList

	table.sort(cfgs, function(a, b)
		return a.level > b.level
	end)

	for _, v in ipairs(cfgs) do
		if score >= checknumber(v.upgradeConstruction) then
			return v.level
		end
	end

	return 1
end

function FamilyConfig:getCurLvProgress(score)
	score = checknumber(score)

	local cfgs = self._levelCfg.dataList

	table.sort(cfgs, function(a, b)
		return a.level > b.level
	end)

	local isMaxLv = true

	for _, v in ipairs(cfgs) do
		local needVal = checknumber(v.upgradeConstruction)

		if needVal <= score then
			local nextCfg = self:getLvCfgByLv(v.level + 1)
			local curLvNeed = nextCfg and checknumber(nextCfg.upgradeConstruction) - needVal or 0

			print("isMaxLv = " .. tostring(isMaxLv))

			return v.level, score - needVal, curLvNeed, isMaxLv
		else
			isMaxLv = false
		end
	end

	return 1, score, 0, true
end

function FamilyConfig:getCommonValue(key, isToNumber)
	local str = ""

	if self._commonCfg and self._commonCfg[key] then
		str = self._commonCfg[key].value
	end

	if isToNumber then
		return checknumber(str)
	else
		return str
	end
end

function FamilyConfig:getCostByKey(key)
	local id = self:getCommonValue(key)

	if string.nilorempty(id) then
		return 0
	else
		local cfg = GoodsConfig.instance:getCfg(checknumber(id))

		if cfg then
			return checknumber(cfg.price)
		else
			return 0
		end
	end
end

function FamilyConfig:isHasAuthority(key, role)
	if self._authorityCfg and self._authorityCfg[key] then
		local value = self._authorityCfg[key]["member" .. role]

		return value == 1
	else
		return false
	end
end

function FamilyConfig:getLogCfgById(id)
	if self._logCfgs then
		return self._logCfgs[id]
	end

	return nil
end

function FamilyConfig:getLogContent(id, param)
	local cfg = self:getLogCfgById(id)
	local content, userName
	local var_19_0, var_19_1 = StringUtil.parseJsonParams((cfg or nil) and (cfg.content or ""), param, true, true)

	return var_19_1, var_19_0
end

function FamilyConfig:getMaxRoleCount(lv, role)
	local cfg = self:getLvCfgByLv(lv)

	if cfg then
		return checknumber(cfg["maxCount" .. role])
	else
		return 0
	end
end

function FamilyConfig:getDonateList()
	return self._donateCfg.dataList
end

function FamilyConfig:getDonateCfg(times)
	if self._donateCfg then
		for i = times, 1, -1 do
			if self._donateCfg[i] then
				return self._donateCfg[i]
			end
		end
	end

	return nil
end

function FamilyConfig:getDonatePoolCfg(familyLv)
	if self._donatePoolCfg then
		return self._donatePoolCfg[familyLv]
	end

	return nil
end

function FamilyConfig:getDonatePrizeCfg(familyLv, fullTimes)
	if self._donatePrizeCfg and self._donatePrizeCfg[familyLv] then
		local t = self._donatePrizeCfg[familyLv]

		fullTimes = (fullTimes - 1) % #t + 1

		return self._donatePrizeCfg[familyLv][fullTimes]
	end

	return nil
end

function FamilyConfig:getApplyMaxNum()
	return 19
end

function FamilyConfig:getAllFamilyBossCfg()
	return self._family_boss
end

function FamilyConfig:getFamilyBossCfg(bossId)
	return self._family_boss[bossId]
end

function FamilyConfig:getFamilyBossNeedLiveness(bossId)
	return self._family_boss[bossId].openConsume
end

function FamilyConfig:getBossCreepsCfg(bossId)
	local cfg = self:getFamilyBossCfg(bossId)

	return self._family_boss_creeps[cfg.creepsMasterId]
end

function FamilyConfig:getBossPrizeStrategy(bossId)
	local cfg = self:getFamilyBossCfg(bossId)

	return self._family_boss_prize_strategy[cfg.rewardId]
end

function FamilyConfig:getFamilyActivityTabCfgs()
	local list = {}

	for _, cfg in pairs(self._faTabCfgs or {}) do
		if cfg and checknumber(cfg.sort) > 0 then
			table.insert(list, cfg)
		end
	end

	if list and #list > 1 then
		table.sort(list, function(a, b)
			return a.sort < b.sort
		end)
	end

	return list
end

function FamilyConfig:getFamilyActivityItemCfgs(planId)
	if self._faItemCfgs then
		return self._faItemCfgs[planId]
	end
end

function FamilyConfig:getCubeChannel(channelId)
	return self.family_cube_channel[channelId]
end

FamilyConfig.instance = FamilyConfig.New()

return FamilyConfig
