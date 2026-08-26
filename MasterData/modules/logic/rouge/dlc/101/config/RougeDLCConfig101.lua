-- chunkname: @modules/logic/rouge/dlc/101/config/RougeDLCConfig101.lua

module("modules.logic.rouge.dlc.101.config.RougeDLCConfig101", package.seeall)

local RougeDLCConfig101 = class("RougeDLCConfig101", BaseConfig)

function RougeDLCConfig101:reqConfigNames()
	return {
		"rouge_limit",
		"rouge_limit_group",
		"rouge_risk",
		"rouge_limit_buff",
		"rouge_dlc_const",
		"rouge_surprise_attack",
		"rouge_unlock_skills"
	}
end

function RougeDLCConfig101:onConfigLoaded(configName, configTable)
	if configName == "rouge_limit" then
		self:_buildRougeLimitMap(configTable)
	elseif configName == "rouge_limit_group" then
		self:_buildLimiterGroupMap(configTable)
	elseif configName == "rouge_risk" then
		self._rougeRiskTab = configTable
	elseif configName == "rouge_limit_buff" then
		self:_buildLimiterBuffMap(configTable)
	elseif configName == "rouge_unlock_skills" then
		self:_buildRougeUnlockSkillsMap(configTable)
	end
end

function RougeDLCConfig101:_buildRougeLimitMap(configTable)
	self._limitConfigTab = configTable
	self._limiterCoGroupMap = {}
	self._limiterCoMap = {}

	for _, Co in ipairs(configTable.configList) do
		local groupId = Co.group

		self._limiterCoGroupMap[groupId] = self._limiterCoGroupMap[groupId] or {}

		table.insert(self._limiterCoGroupMap[groupId], Co)

		self._limiterCoMap[Co.id] = Co
	end

	for _, groupLimitCOs in pairs(self._limiterCoGroupMap) do
		table.sort(groupLimitCOs, RougeDLCConfig101.limiterCoGroupSortFunc)
	end
end

function RougeDLCConfig101.limiterCoGroupSortFunc(aLimitCO, bLimitCO)
	local aSort = aLimitCO.level
	local bSort = bLimitCO.level

	if aSort ~= bSort then
		return aSort < bSort
	end

	return aLimitCO.id < bLimitCO.id
end

function RougeDLCConfig101:getVersionLimiterCos(version)
	return self._limitConfigTab.configDict[version]
end

function RougeDLCConfig101:getLimiterCo(limiterId)
	return self._limiterCoMap and self._limiterCoMap[limiterId]
end

function RougeDLCConfig101:_buildLimiterGroupMap(configTable)
	self._limitGroupConfigTab = configTable
	self._limiterGroupVersionMap = {}

	if configTable then
		for _, limiterGroupCo in ipairs(configTable.configList) do
			local versions = RougeDLCHelper.versionStrToList(limiterGroupCo.version)

			for _, version in ipairs(versions) do
				self._limiterGroupVersionMap[version] = self._limiterGroupVersionMap[version] or {}

				table.insert(self._limiterGroupVersionMap[version], limiterGroupCo)
			end
		end
	end
end

function RougeDLCConfig101:getLimiterGroupCo(groupId)
	return self._limitGroupConfigTab and self._limitGroupConfigTab.configDict[groupId]
end

function RougeDLCConfig101:getAllLimiterGroupCos()
	return self._limitGroupConfigTab.configList
end

function RougeDLCConfig101:getAllVersionLimiterGroupCos(versions)
	local limiterGroupCos = {}
	local limiterGroupCoMap = {}

	if versions then
		for _, version in ipairs(versions) do
			if self._limiterGroupVersionMap then
				if self._limiterGroupVersionMap then
					for _, co in ipairs(self._limiterGroupVersionMap) do
						if not limiterGroupCoMap[co.id] then
							table.insert(limiterGroupCos, co)

							limiterGroupCoMap[co.id] = true
						end
					end
				end
			end
		end
	end

	table.sort(limiterGroupCos, RougeDLCConfig101._limiterGroupSortFunc)

	return limiterGroupCos
end

function RougeDLCConfig101._limiterGroupSortFunc(aLimiterGroupCo, bLimiterGroupCo)
	return aLimiterGroupCo.id < bLimiterGroupCo.id
end

function RougeDLCConfig101:getAllLimiterCosInGroup(groupId)
	if self._limiterCoGroupMap then
		return self._limiterCoGroupMap
	end
end

function RougeDLCConfig101:getLimiterCoByGroupIdAndLv(groupId, level)
	local groupCO = self:getAllLimiterCosInGroup(groupId)

	return groupCO and groupCO[level]
end

function RougeDLCConfig101:getLimiterGroupMaxLevel(groupId)
	local groupCO = self:getAllLimiterCosInGroup(groupId)

	return (groupCO or nil) and (#groupCO or 0)
end

function RougeDLCConfig101:getRougeRiskCo(riskId)
	return self._rougeRiskTab and self._rougeRiskTab[riskId]
end

function RougeDLCConfig101:getRougeRiskCoByRiskValue(riskValue)
	local targetRiskCo

	for _, riskCo in ipairs(self._rougeRiskTab.configList) do
		local riskValues = string.splitToNumber(riskCo.range, "#")

		if not riskValues[1] then
			if not riskValues[2] then
				local maxRiskValue = 0

				if riskValues[1] <= riskValue and riskValue <= maxRiskValue then
					targetRiskCo = riskCo

					break
				end
			end
		end
	end

	return targetRiskCo
end

function RougeDLCConfig101:_buildLimiterBuffMap(configTable)
	self._buffTab = configTable
	self._buffTypeMap = {}

	for _, buffCo in ipairs(configTable.configList) do
		local buffType = buffCo.buffType

		if not string.nilorempty(buffType) then
			local versions = RougeDLCHelper.versionStrToList(buffCo.version)

			for _, verison in ipairs(versions) do
				self._buffTypeMap[buffType] = self._buffTypeMap[buffType] or {}
				self._buffTypeMap[buffType][verison] = self._buffTypeMap[buffType][verison] or {}

				table.insert(self._buffTypeMap[buffType][verison], buffCo)
			end
		else
			logError("肉鸽限制器Buff词条类型为空, buffId = " .. tostring(buffCo.id))
		end
	end
end

function RougeDLCConfig101:getAllLimiterBuffCosByType(versions, buffType)
	local typeBuffCos, typeBuffCoMap = {}, {}

	if self._buffTypeMap then
		local versionBuffCos = self._buffTypeMap[buffType]

		if versionBuffCos and versions then
			for _, version in ipairs(versions) do
				local buffCos = versionBuffCos[version]

				if buffCos then
					for _, buffCo in ipairs(buffCos) do
						if not typeBuffCoMap[buffCo.id] then
							typeBuffCoMap[buffCo.id] = true

							table.insert(typeBuffCos, buffCo)
						end
					end
				end
			end
		end

		return typeBuffCos
	end
end

function RougeDLCConfig101:getLimiterBuffCo(buffId)
	return self._buffTab and self._buffTab.configDict[buffId]
end

function RougeDLCConfig101:getAllLimiterBuffCos()
	return self._buffTab and self._buffTab.configList
end

function RougeDLCConfig101:_buildRougeUnlockSkillsMap(configTable)
	self._unlockSkillConfigTab = configTable
	self._unlockSkillMap = {}

	for _, skillCo in ipairs(configTable.configList) do
		local style = skillCo.style

		self._unlockSkillMap[style] = self._unlockSkillMap[style] or {}

		table.insert(self._unlockSkillMap[style], skillCo)
	end
end

function RougeDLCConfig101:getStyleUnlockSkills(style)
	return self._unlockSkillMap and self._unlockSkillMap[style]
end

function RougeDLCConfig101:getUnlockSkills(skillId)
	return self._unlockSkillConfigTab.configDict[skillId]
end

function RougeDLCConfig101:getMaxLevlRiskCo()
	local riskCount = #lua_rouge_risk.configList

	return lua_rouge_risk.configList[riskCount]
end

RougeDLCConfig101.instance = RougeDLCConfig101.New()

return RougeDLCConfig101
