-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/config/LightKingConfig.lua

module("logic.extensions.timelimitedchallenge.config.LightKingConfig", package.seeall)

local LightKingConfig = class("LightKingConfig", BaseConfig)

function LightKingConfig:onInit()
	LightKingConfig.super.onInit(self)

	self._nameDict = {}

	local names = self:getNames()

	for _, v in ipairs(names) do
		self._nameDict[v] = true
	end

	self._configDict = {}
end

function LightKingConfig:getNames()
	return {
		"light_king_challenge_base_define",
		"light_king_challenge_params_define",
		"light_king_challenge_stage_define",
		"light_king_challenge_creeps",
		"light_king_challenge_support_pet",
		"light_king_challenge_buy_times_plan",
		"light_king_challenge_cheat_define",
		"light_king_challenge_progress_prize",
		"light_king_challenge_buff_define"
	}
end

function LightKingConfig:handleConfig(name, content)
	if self._nameDict[name] then
		self._configDict[name] = content
	end
end

function LightKingConfig:getCheatCfg(challengeType, stage)
	local content = self._configDict.light_king_challenge_cheat_define

	if content and content[challengeType] then
		return content[challengeType][stage]
	end
end

function LightKingConfig:getConstantValue(key, isToNumber)
	local content = self._configDict.light_king_challenge_params_define
	local value

	if content and content[key] then
		value = content[key].value
	end

	if isToNumber then
		return checknumber(value)
	else
		return value
	end
end

function LightKingConfig:getPrizeCfgs()
	local content = self._configDict.light_king_challenge_progress_prize
	local dataList

	if content then
		dataList = content.dataList
	end

	if dataList then
		table.sort(dataList, function(a, b)
			return checknumber(a.score) < checknumber(b.score)
		end)
	end

	return dataList or {}
end

function LightKingConfig:getBaseDefineCfg(challengeType)
	local content = self._configDict.light_king_challenge_base_define

	if content then
		return content[challengeType]
	end
end

function LightKingConfig:getStageCfg(challengeType, stage)
	local content = self._configDict.light_king_challenge_stage_define

	if content and content[challengeType] then
		return content[challengeType][stage]
	end
end

function LightKingConfig:getCreepsCfg(creepsMasterId)
	local content = self._configDict.light_king_challenge_creeps

	if content then
		return content[creepsMasterId]
	end
end

function LightKingConfig:getStageCfgsByType(challengeType)
	local content = self._configDict.light_king_challenge_stage_define

	self._stageCfgsDict = self._stageCfgsDict or {}

	if self._stageCfgsDict[challengeType] then
		return self._stageCfgsDict[challengeType]
	end

	local dataList = {}

	if content then
		if not content[challengeType] then
			for _, v in pairs(content[challengeType]) do
				table.insert(dataList, v)
			end
		end
	end

	table.sort(dataList, function(a, b)
		return checknumber(a.stage) < checknumber(b.stage)
	end)

	return dataList
end

function LightKingConfig:getCurAndTotalScore(challengeType, stage)
	print("getCurAndTotalScore challengeType = " .. challengeType .. "stage = " .. stage)

	local stageCfgs = self:getStageCfgsByType(challengeType)
	local cur, total = 0, 0

	for _, v in ipairs(stageCfgs) do
		if stage >= v.stage then
			cur = cur + v.score
		end

		total = total + v.score
	end

	return cur, total
end

function LightKingConfig:getPlanCfg(id)
	local content = self._configDict.light_king_challenge_buy_times_plan

	if content then
		return content[id]
	end
end

function LightKingConfig:getBuffCfg(id)
	local content = self._configDict.light_king_challenge_buff_define

	if content then
		return content[id]
	end
end

function LightKingConfig:getSupportCfg(planId)
	local content = self._configDict.light_king_challenge_support_pet

	if content then
		return content[planId]
	end
end

LightKingConfig.instance = LightKingConfig.New()

return LightKingConfig
