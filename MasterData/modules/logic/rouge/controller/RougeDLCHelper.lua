-- chunkname: @modules/logic/rouge/controller/RougeDLCHelper.lua

module("modules.logic.rouge.controller.RougeDLCHelper", package.seeall)

local RougeDLCHelper = class("RougeDLCHelper")

function RougeDLCHelper.isUsingDLCs()
	local versions = RougeModel.instance:getVersion()

	return versions and #versions > 0
end

function RougeDLCHelper.isUsingTargetDLC(dlcId)
	local versions = RougeModel.instance:getVersion()

	if versions then
		local index = tabletool.indexOf(versions, dlcId)

		return index and index > 0
	end
end

function RougeDLCHelper.isCurrentUsingContent(configVersionStr)
	local isUsing = RougeDLCHelper.isCurrentBaseContent(configVersionStr)

	isUsing = isUsing or RougeDLCHelper.isCurrentUsingVersions(configVersionStr)

	return isUsing
end

function RougeDLCHelper.isCurrentUsingVersions(configVersionStr)
	local configVersionList = RougeDLCHelper.versionStrToList(configVersionStr)
	local curVersionList = RougeModel.instance:getVersion()
	local curVersionMap = RougeDLCHelper.versionListToMap(curVersionList)

	for _, configVersion in ipairs(configVersionList) do
		if curVersionMap[configVersion] then
			return true
		end
	end
end

function RougeDLCHelper.isCurrentBaseContent(configVersionStr)
	return string.nilorempty(configVersionStr)
end

function RougeDLCHelper.versionListToMap(versionList)
	local versionMap = {}

	if versionList then
		for _, version in ipairs(versionList) do
			versionMap[version] = true
		end
	end

	return versionMap
end

function RougeDLCHelper.versionStrToList(versionStr)
	if string.nilorempty(versionStr) then
		return {}
	end

	return (string.splitToNumber(versionStr, "#"))
end

function RougeDLCHelper.getAllCurrentUseStyleSkills(styleId)
	local config = RougeOutsideModel.instance:config()
	local styleCo = config:getStyleConfig(styleId)

	if not styleCo then
		return {}
	end

	local allSkills = {}
	local fightSkills = string.splitToNumber(styleCo.activeSkills, "#")
	local mapSkills = string.splitToNumber(styleCo.mapSkills, "#")
	local skillCos = RougeDLCConfig101.instance:getStyleUnlockSkills(styleId)

	for _, fightSkillId in ipairs(fightSkills) do
		local skillMo = RougeDLCHelper._createSkillMo(RougeEnum.SkillType.Style, fightSkillId)

		table.insert(allSkills, skillMo)
	end

	for _, mapSkillId in ipairs(mapSkills) do
		local skillMo = RougeDLCHelper._createSkillMo(RougeEnum.SkillType.Map, mapSkillId)

		table.insert(allSkills, skillMo)
	end

	local gameRecordInfo = RougeOutsideModel.instance:getRougeGameRecord()

	for _, skillCo in ipairs(skillCos or {}) do
		local isUsing = RougeDLCHelper.isCurrentUsingContent(skillCo.version)
		local isUnlock = gameRecordInfo:isSkillUnlock(skillCo.type, skillCo.skillId)

		if isUsing and isUnlock then
			local skillMo = RougeDLCHelper._createSkillMo(skillCo.type, skillCo.skillId)

			table.insert(allSkills, skillMo)
		end
	end

	table.sort(allSkills, RougeDLCHelper._styleSkillSortFunc)

	return allSkills
end

function RougeDLCHelper._createSkillMo(skillType, skillId)
	return {
		type = skillType,
		skillId = skillId
	}
end

function RougeDLCHelper._styleSkillSortFunc(aSkillMo, bSkillMo)
	local config = RougeOutsideModel.instance:config()
	local aSkillCo = config and config:getSkillCo(aSkillMo.type, aSkillMo.skillId)
	local bSkillCo = config and config:getSkillCo(bSkillMo.type, bSkillMo.skillId)
	local is_A_Base = RougeDLCHelper.isCurrentBaseContent(aSkillCo and aSkillCo.version)
	local is_B_Base = RougeDLCHelper.isCurrentBaseContent(bSkillCo and bSkillCo.version)

	if is_A_Base ~= is_B_Base then
		return is_A_Base
	end

	local aSortId = RougeEnum.SkillTypeSortEnum[aSkillMo.type]
	local bSortId = RougeEnum.SkillTypeSortEnum[bSkillMo.type]

	if aSortId and bSortId and aSortId ~= bSortId then
		return aSortId < bSortId
	end

	return aSkillMo.skillId < bSkillMo.skillId
end

function RougeDLCHelper.getCurrentUseStyleFightSkills(styleId)
	local config = RougeOutsideModel.instance:config()
	local styleCo = config:getStyleConfig(styleId)

	if not styleCo then
		return {}
	end

	local allSkills = {}
	local fightSkills = string.splitToNumber(styleCo.activeSkills, "#")

	for _, fightSkillId in ipairs(fightSkills) do
		local skillMo = RougeDLCHelper._createSkillMo(RougeEnum.SkillType.Style, fightSkillId)

		table.insert(allSkills, skillMo)
	end

	local gameRecordInfo = RougeOutsideModel.instance:getRougeGameRecord()
	local skillCos = RougeDLCConfig101.instance:getStyleUnlockSkills(styleId)

	for _, skillCo in ipairs(skillCos or {}) do
		local isUsing = RougeDLCHelper.isCurrentUsingContent(skillCo.version)
		local isUnlock = gameRecordInfo:isSkillUnlock(skillCo.type, skillCo.skillId)

		if isUsing and isUnlock and skillCo.type == RougeEnum.SkillType.Style then
			local skillMo = RougeDLCHelper._createSkillMo(skillCo.type, skillCo.skillId)

			table.insert(allSkills, skillMo)
		end
	end

	table.sort(allSkills, RougeDLCHelper._styleSkillSortFunc)

	return allSkills
end

function RougeDLCHelper.getCurVersionString()
	local gameRecordInfo = RougeOutsideModel.instance:getRougeGameRecord()
	local versions = gameRecordInfo and gameRecordInfo:getVersionIds()

	return RougeDLCHelper.versionListToString(versions)
end

function RougeDLCHelper.versionListToString(versionIds)
	return (versionIds or nil) and table.concat(versionIds, "_")
end

return RougeDLCHelper
