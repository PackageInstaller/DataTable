-- chunkname: @modules/versionactivitybase/fixed1/dungeon/config/VersionActivityFixedDungeonConfig1.lua

module("modules.versionactivitybase.fixed1.dungeon.config.VersionActivityFixedDungeonConfig1", package.seeall)

local VersionActivityFixedDungeonConfig1 = class("VersionActivityFixedDungeonConfig1", BaseConfig)

function VersionActivityFixedDungeonConfig1:getOptionConfigs()
	local _reportList = {}

	for i = #lua_chapter_map_element.configList, 1, -1 do
		local config = lua_chapter_map_element.configList[i]

		if config.type == self:_getSpecialElementType() then
			table.insert(_reportList, config)
		elseif #_reportList > 0 then
			break
		end
	end

	return _reportList
end

function VersionActivityFixedDungeonConfig1:_getSpecialElementType()
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local enum = VersionActivityFixedHelper.getVersionActivityEnum(bigVersion, smallVersion)

	return enum and enum.specialElementType
end

function VersionActivityFixedDungeonConfig1:getChapterMap(episodeId)
	return lua_v3a2_chapter_map.configDict[episodeId]
end

function VersionActivityFixedDungeonConfig1:getChapterReward(id)
	return lua_v3a2_chapter_reward.configDict[id]
end

function VersionActivityFixedDungeonConfig1:getChapterResult(id)
	return lua_v3a2_chapter_result.configDict[id]
end

function VersionActivityFixedDungeonConfig1:getChapterReport(id)
	return lua_v3a2_chapter_report.configDict[id]
end

function VersionActivityFixedDungeonConfig1:getElementsChapterReport()
	local list = lua_v3a2_chapter_report.configList
	local resultList = {}

	for i, config in ipairs(list) do
		if DungeonMapModel.instance:elementIsFinished(config.element) then
			table.insert(resultList, config.element)
		end
	end

	return resultList
end

VersionActivityFixedDungeonConfig1.instance = VersionActivityFixedDungeonConfig1.New()

return VersionActivityFixedDungeonConfig1
