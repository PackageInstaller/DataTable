-- chunkname: @modules/logic/versionactivity3_9/racingcar/config/V3a9RacingCarConfig.lua

module("modules.logic.versionactivity3_9.racingcar.config.V3a9RacingCarConfig", package.seeall)

local V3a9RacingCarConfig = class("V3a9RacingCarConfig", BaseConfig)

function V3a9RacingCarConfig:reqConfigNames()
	return {
		"racing_const",
		"racing_game_level",
		"racing_item",
		"racing_element",
		"racing_racer",
		"racing_ultimate",
		"racing_buff",
		"racing_effect",
		"racing_camera",
		"243_const",
		"243_episode",
		"racing_gift_group",
		"racing_gift",
		"racing_reward"
	}
end

function V3a9RacingCarConfig:onInit()
	return
end

function V3a9RacingCarConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function V3a9RacingCarConfig:racing_buffConfigLoaded(configTable)
	self._racing_buff = {}

	for _, config in ipairs(lua_racing_buff.configList) do
		self._racing_buff[config.id] = {
			config = config,
			features = self:_parseBuffFeatures(config.id, config.features)
		}
	end
end

function V3a9RacingCarConfig:_parseBuffFeatures(buffId, features)
	local effects = {}

	if not features or features == "" then
		return effects
	end

	local featureList = string.split(features, "|")

	for _, feature in ipairs(featureList) do
		if feature and feature ~= "" then
			local parts = string.split(feature, "#")
			local effectType = parts[1]

			if effectType == RacingCarPropEnum.BuffParamType.Attr then
				local var_5_1 = {
					type = effectType
				}

				var_5_1.paramId = tonumber(parts[2]) or 0
				var_5_1.baseValue = tonumber(parts[3]) or 0
				var_5_1.ratio = tonumber(parts[4]) or 0

				table.insert(effects, var_5_1)
			elseif effectType == RacingCarPropEnum.BuffParamType.Immunity then
				if not parts[2] then
					table.insert(effects, {
						type = effectType,
						immunityBuffTypes = string.splitToNumber(parts[2], ",")
					})
				end
			elseif effectType == RacingCarPropEnum.BuffParamType.Absorb then
				local var_5_3 = {
					type = effectType
				}

				var_5_3.radius = tonumber(parts[2]) or 0

				table.insert(effects, var_5_3)
			elseif effectType == RacingCarPropEnum.BuffParamType.Height then
				local var_5_5 = {
					type = effectType
				}

				var_5_5.heightOffset = tonumber(parts[2]) or 0

				table.insert(effects, var_5_5)
			elseif effectType == RacingCarPropEnum.BuffParamType.Invisible then
				table.insert(effects, {
					type = effectType
				})
			elseif effectType == RacingCarPropEnum.BuffParamType.Restrict then
				table.insert(effects, {
					type = effectType
				})
			elseif effectType == RacingCarPropEnum.BuffParamType.Hide then
				table.insert(effects, {
					type = effectType
				})
			elseif effectType == RacingCarPropEnum.BuffParamType.Penetrate then
				local var_5_7 = {
					type = effectType
				}

				var_5_7.speedMultiplier = tonumber(parts[2]) or 0
				var_5_7.acceleration = tonumber(parts[3]) or 0

				table.insert(effects, var_5_7)
			else
				logError("V3a9RacingCarConfig:_parseBuffFeatures Unknown effect type: ", buffId, effectType)
			end
		end
	end

	return effects
end

function V3a9RacingCarConfig:getTrackConfig(name)
	local configName = string.format("lua_%s", name)
	local config = _G[configName]

	if config then
		return config
	end

	logError(string.format("V3a9RacingCarConfig:get error, cfg is nil,name:%s", name))
end

function V3a9RacingCarConfig:getRacingItemConfig(id)
	local config = lua_racing_item.configDict[id]

	if config then
		return config
	end

	logError(string.format("V3a9RacingCarConfig:getRacingItemConfig error, cfg is nil,id:%s", id))
end

function V3a9RacingCarConfig:getRacingElementConfig(id)
	local config = lua_racing_element.configDict[id]

	if config then
		return config
	end

	logError(string.format("V3a9RacingCarConfig:getRacingElementConfig error, cfg is nil,id:%s", id))
end

function V3a9RacingCarConfig:racing_effectConfigLoaded(configTable)
	self._racing_effect = {}

	for _, config in ipairs(configTable.configList) do
		self._racing_effect[config.id] = {
			config = config,
			paramData = self:_parseEffectParam(config)
		}
	end
end

function V3a9RacingCarConfig:_parseEffectParam(config)
	local effectType = config.effectType
	local param = config.param
	local id = config.id
	local result = {}

	if not param or param == "" then
		return result
	end

	local parts = string.split(param, "#")
	local triggerType = parts[1]
	local triggerTypeList = string.split(triggerType, "&")

	result.triggerType = triggerTypeList[1]
	result.targetType = tonumber(parts[2])

	if RacingCarPropEnum.PassiveTriggerType[result.triggerType] then
		if result.triggerType == RacingCarPropEnum.TriggerType.Rank then
			result.triggerTypeParam = string.splitToNumber(triggerTypeList[2], ",")
		elseif RacingCarPropEnum.MultiIdTriggerType[result.triggerType] then
			if triggerTypeList[2] and triggerTypeList[2] ~= "" then
				result.triggerTypeParam = string.splitToNumber(triggerTypeList[2], ",")
			end
		else
			result.triggerTypeParam = tonumber(triggerTypeList[2])
		end
	end

	if not RacingCarPropEnum.SkillParamType[effectType] then
		logError("V3a9RacingCarConfig:_parseEffectParam Unknown effect type: ", id, effectType)

		return result
	end

	if not RacingCarPropEnum.TriggerType[result.triggerType] then
		logError("V3a9RacingCarConfig:_parseEffectParam Unknown trigger type: ", id, result.triggerType)

		return result
	end

	if result.targetType < RacingCarPropEnum.TargetType.Self or result.targetType > RacingCarPropEnum.TargetType.TriggerTarget then
		logError("V3a9RacingCarConfig:_parseEffectParam Unknown target type: ", id, result.targetType)

		return result
	end

	local isEditor = SLFramework.FrameworkSettings.IsEditor

	if effectType == RacingCarPropEnum.SkillParamType.AddBuff then
		result.buffId = tonumber(parts[3]) or 0

		if isEditor then
			self:getRacingBuffConfig(result.buffId)
		end
	elseif effectType == RacingCarPropEnum.SkillParamType.TempFix then
		result.paramId = tonumber(parts[3]) or 0
		result.baseValue = tonumber(parts[4]) or 0
		result.ratio = (tonumber(parts[5]) or 0) / 10000

		if isEditor then
			local paramIdValid = false

			for _, v in pairs(RacingCarPropEnum.RacingParamId) do
				if v == result.paramId then
					paramIdValid = true

					break
				end
			end

			if not paramIdValid then
				logError("V3a9RacingCarConfig:_parseEffectParam Unknown paramId in TempFix: ", id, result.paramId)
			end
		end
	elseif effectType == RacingCarPropEnum.SkillParamType.TempSet then
		result.paramId = tonumber(parts[3]) or 0
		result.baseValue = tonumber(parts[4]) or 0
		result.ratio = (tonumber(parts[5]) or 0) / 10000

		if isEditor then
			local paramIdValid = false

			for _, v in pairs(RacingCarPropEnum.RacingParamId) do
				if v == result.paramId then
					paramIdValid = true

					break
				end
			end

			if not paramIdValid then
				logError("V3a9RacingCarConfig:_parseEffectParam Unknown paramId in TempSet: ", id, result.paramId)
			end
		end
	elseif effectType == RacingCarPropEnum.SkillParamType.AddItem then
		result.itemIds = string.splitToNumber(parts[3] or "", ",")
		result.count = tonumber(parts[4]) or 1

		if isEditor then
			if not result.itemIds or #result.itemIds == 0 then
				logError("V3a9RacingCarConfig:_parseEffectParam AddItem itemIds is empty: ", id)
			else
				for _, itemId in ipairs(result.itemIds) do
					self:getRacingItemConfig(itemId)
				end
			end
		end
	elseif effectType == RacingCarPropEnum.SkillParamType.AddSkill then
		result.skillIds = string.splitToNumber(parts[3] or "", ",")

		if isEditor and (not result.skillIds or #result.skillIds == 0) then
			logError("V3a9RacingCarConfig:_parseEffectParam AddSkill skillIds is empty: ", id)
		end
	elseif effectType == RacingCarPropEnum.SkillParamType.JumpTrack then
		result.laneOffset = tonumber(parts[3]) or 0
	elseif effectType == RacingCarPropEnum.SkillParamType.RemoveBuff then
		result.removeBuffTypeId = tonumber(parts[3]) or 0
		result.removeBuffCount = tonumber(parts[4]) or 0

		if isEditor and result.removeBuffTypeId == 0 then
			logError("V3a9RacingCarConfig:_parseEffectParam RemoveBuff typeId is invalid: ", id)
		end
	elseif effectType == RacingCarPropEnum.SkillParamType.ItemConversion then
		result.sourceItemIds = string.splitToNumber(parts[3] or "", ",")
		result.destItemIds = string.splitToNumber(parts[4] or "", ",")

		if isEditor then
			if not result.sourceItemIds or #result.sourceItemIds == 0 then
				logError("V3a9RacingCarConfig:_parseEffectParam ItemConversion sourceItemIds is empty: ", id)
			end

			if not result.destItemIds or #result.destItemIds == 0 then
				logError("V3a9RacingCarConfig:_parseEffectParam ItemConversion destItemIds is empty: ", id)
			end

			if result.sourceItemIds and result.destItemIds and #result.sourceItemIds ~= #result.destItemIds then
				logError("V3a9RacingCarConfig:_parseEffectParam ItemConversion source/dest count mismatch: ", id)
			end
		end
	elseif effectType == RacingCarPropEnum.SkillParamType.AddRangBuff then
		result.radius = tonumber(parts[3]) or 0
		result.buffIds = string.splitToNumber(parts[4] or "", ",")
		result.includeSelf = tonumber(parts[2]) or 0

		if isEditor then
			if not result.radius or result.radius <= 0 then
				logError("V3a9RacingCarConfig:_parseEffectParam AddRangBuff radius is invalid: ", id)
			end

			if not result.buffIds or #result.buffIds == 0 then
				logError("V3a9RacingCarConfig:_parseEffectParam AddRangBuff buffIds is empty: ", id)
			else
				for _, buffId in ipairs(result.buffIds) do
					self:getRacingBuffConfig(buffId)
				end
			end
		end
	end

	return result
end

function V3a9RacingCarConfig:getRacingEffectConfig(id)
	local config = self._racing_effect[id]

	if config then
		return config
	end

	logError(string.format("V3a9RacingCarConfig:getRacingEffectConfig error, cfg is nil,id:%s", id))
end

function V3a9RacingCarConfig:getRacingBuffConfig(id)
	local config = self._racing_buff[id]

	if config then
		return config
	end

	logError(string.format("V3a9RacingCarConfig:getRacingBuffConfig error, cfg is nil,id:%s", id))
end

function V3a9RacingCarConfig:racing_giftConfigLoaded(configTable)
	self._actTalentCos = {}

	for _, co in ipairs(configTable.configList) do
		self._actTalentCos[co.activityId] = self._actTalentCos[co.activityId] or {}
		self._actTalentCos[co.activityId][co.gift_point] = self._actTalentCos[co.activityId][co.gift_point] or {}
		self._actTalentCos[co.activityId][co.gift_point][co.level] = co
	end
end

function V3a9RacingCarConfig:getTalentCosByActId(activityId)
	return self._actTalentCos[activityId]
end

function V3a9RacingCarConfig:getTalentCosByTalentId(activityId, talentId)
	local cos = self:getTalentCosByActId(activityId)

	return cos and cos[talentId]
end

function V3a9RacingCarConfig:getAct243ConstValue(actId, constId, isValue2, isToNum, defaultValue)
	if lua_243_const.configDict then
		if not lua_243_const.configDict[actId] then
			local actDict

			if actDict then
				if not actDict[constId] then
					local co

					if co then
						if isValue2 then
							return co.value2
						end

						local value = co.value

						if isToNum then
							return tonumber(value)
						end

						return value
					end

					logError(string.format("V3a9RacingCarConfig:getAct243ConstValue error, cfg is nil, actId:%s id:%s", actId, constId))

					return defaultValue
				end
			end
		end
	end
end

V3a9RacingCarConfig.instance = V3a9RacingCarConfig.New()

return V3a9RacingCarConfig
