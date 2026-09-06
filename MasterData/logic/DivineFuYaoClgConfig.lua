-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefuyaoclg/config/DivineFuYaoClgConfig.lua

module("logic.extensions.divinefuyaoclg.config.DivineFuYaoClgConfig", package.seeall)

local DivineFuYaoClgConfig = class("DivineFuYaoClgConfig", BaseConfig)

function DivineFuYaoClgConfig:getNames()
	return {
		"divine_fu_yao_clg_activity",
		"divine_fu_yao_clg_normal_stage",
		"divine_fu_yao_clg_extreme_stage",
		"divine_fu_yao_clg_extreme_buff",
		"divine_fu_yao_clg_extreme_elemental",
		"divine_fu_yao_clg_monster",
		"divine_fu_yao_clg_creeps"
	}
end

function DivineFuYaoClgConfig:handleConfig(name, content)
	if name == "divine_fu_yao_clg_activity" then
		self._divine_fu_yao_clg_activity = content
	elseif name == "divine_fu_yao_clg_normal_stage" then
		self._divine_fu_yao_clg_normal_stage = content
	elseif name == "divine_fu_yao_clg_extreme_stage" then
		self._divine_fu_yao_clg_extreme_stage = content
	elseif name == "divine_fu_yao_clg_extreme_buff" then
		self._divine_fu_yao_clg_extreme_buff = content
	elseif name == "divine_fu_yao_clg_extreme_elemental" then
		self._divine_fu_yao_clg_extreme_elemental = content
	elseif name == "divine_fu_yao_clg_monster" then
		self._divine_fu_yao_clg_monster = content
	elseif name == "divine_fu_yao_clg_creeps" then
		self._divine_fu_yao_clg_creeps = content
	end
end

function DivineFuYaoClgConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function DivineFuYaoClgConfig:getActivityData(activityId)
	return self:_safeGet(self._divine_fu_yao_clg_activity, activityId)
end

function DivineFuYaoClgConfig:getNormalStageDatas(activityId)
	return self:_safeGet(self._divine_fu_yao_clg_normal_stage, activityId)
end

function DivineFuYaoClgConfig:getNormalStageData(activityId, stageId)
	return self:_safeGet(self._divine_fu_yao_clg_normal_stage, activityId, stageId)
end

function DivineFuYaoClgConfig:getExtremeStageDatas(activityId)
	return self:_safeGet(self._divine_fu_yao_clg_extreme_stage, activityId)
end

function DivineFuYaoClgConfig:getExtremeStageData(activityId, stageId)
	return self:_safeGet(self._divine_fu_yao_clg_extreme_stage, activityId, stageId)
end

function DivineFuYaoClgConfig:getExtBuffDatas(activityId)
	return self:_safeGet(self._divine_fu_yao_clg_extreme_buff, activityId)
end

function DivineFuYaoClgConfig:getExtBuffData(activityId, deadNum)
	local datas = self:getExtBuffDatas(activityId)

	return MmUtil.binarySearchInSingleKey(datas, "deadNum", deadNum)
end

function DivineFuYaoClgConfig:getExtElementalData(activityId)
	return self:_safeGet(self._divine_fu_yao_clg_extreme_elemental, activityId)
end

function DivineFuYaoClgConfig:getMasterData(creepsMasterId)
	return self:_safeGet(self._divine_fu_yao_clg_monster, creepsMasterId)
end

function DivineFuYaoClgConfig:getCreepsData(creepsMasterId)
	return self:_safeGet(self._divine_fu_yao_clg_creeps, creepsMasterId)
end

DivineFuYaoClgConfig.instance = DivineFuYaoClgConfig.New()

return DivineFuYaoClgConfig
