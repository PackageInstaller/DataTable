-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/config/ShikongshenglongConfig.lua

module("logic.extensions.timelimitedchallenge.config.ShikongshenglongConfig", package.seeall)

local ShikongshenglongConfig = class("ShikongshenglongConfig", BaseConfig)
local chapterName = {
	[110001] = {
		"虚空耀魔",
		"时空湮魔",
		"圣龙试炼"
	},
	[110002] = {
		"龙族祝福",
		"空之祝福",
		"水之祝福"
	},
	[110005] = {
		"缘气挑战",
		"缘分挑战",
		"缘力挑战"
	},
	[110009] = {
		"隐匿挑战",
		"隐匿挑战",
		"隐匿挑战"
	}
}

function ShikongshenglongConfig:getNames()
	return {
		"light_dark_dragon_activity",
		"light_dark_dragon_stage",
		"light_dark_dragon_team",
		"light_dark_dragon_creeps",
		"light_dark_dragon_stage_client_buff",
		"light_dark_dragon_daily_sign",
		"light_dark_dragon_common"
	}
end

function ShikongshenglongConfig:handleConfig(name, content)
	if name == "light_dark_dragon_activity" then
		self._planCfg = content
	elseif name == "light_dark_dragon_stage" then
		self._stageCfg = content
	elseif name == "light_dark_dragon_team" then
		self._teamCfg = content
	elseif name == "light_dark_dragon_creeps" then
		self._creepsCfg = content
	elseif name == "light_dark_dragon_stage_client_buff" then
		self._buffCfg = content
	elseif name == "light_dark_dragon_daily_sign" then
		self._signCfg = content
	elseif name == "light_dark_dragon_common" then
		self._commonCfg = content
	end
end

function ShikongshenglongConfig:getActivityCfg(id)
	return self._planCfg[id]
end

function ShikongshenglongConfig:getPlanById(id)
	return self._planCfg[id].challengePlanId
end

function ShikongshenglongConfig:getStageCfg(id, stageId)
	local planid = self:getPlanById(id)

	return self._stageCfg[planid][stageId]
end

function ShikongshenglongConfig:getStages(id, chapterId)
	local planid = self:getPlanById(id)
	local stages = self._stageCfg[planid]
	local tab = {}

	for i, v in ipairs(stages) do
		if v.chapterId == chapterId then
			table.insert(tab, v)
		end
	end

	return tab
end

function ShikongshenglongConfig:getTeamCfg(masterId)
	return self._teamCfg[masterId]
end

function ShikongshenglongConfig:getCreepsCfg(masterId, creepsId)
	local list = self._creepsCfg[masterId]

	if creepsId == nil or list[creepsId] == nil then
		return list
	end

	return list[creepsId]
end

function ShikongshenglongConfig:getChapterNames(actid, chapterId)
	return chapterName[actid][chapterId]
end

function ShikongshenglongConfig:getBuffCfgs(stageId)
	return self._buffCfg[stageId]
end

function ShikongshenglongConfig:getSignCfgs(signId)
	return self._signCfg[signId]
end

function ShikongshenglongConfig:getCommonValue(key)
	if self._commonCfg[key] then
		return self._commonCfg[key].value
	end
end

ShikongshenglongConfig.instance = ShikongshenglongConfig.New()

return ShikongshenglongConfig
