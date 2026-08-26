-- chunkname: @modules/logic/fight/controller/FightTLHelper.lua

module("modules.logic.fight.controller.FightTLHelper", package.seeall)

local FightTLHelper = _M

function FightTLHelper.getTableParam(paramStr, delimiter, isNumber)
	if isNumber then
		return FightStrUtil.instance:getSplitToNumberCache(paramStr, delimiter)
	else
		return FightStrUtil.instance:getSplitCache(paramStr, delimiter)
	end
end

function FightTLHelper.getBoolParam(paramStr)
	return paramStr == "1"
end

function FightTLHelper.getNumberParam(paramStr)
	return tonumber(paramStr)
end

local DefaultEmptyTable = {}
local TimelineJsonCacheDict = {}

function FightTLHelper.getTLJsonData(assetItem, timelineUrl)
	if not timelineUrl then
		return DefaultEmptyTable
	end

	local cacheJson = TimelineJsonCacheDict[timelineUrl]

	if cacheJson then
		return cacheJson
	end

	local jsonStr = ZProj.SkillTimelineAssetHelper.GeAssetJson(assetItem, timelineUrl)

	cacheJson = not string.nilorempty(jsonStr) and cjson.decode(jsonStr) or DefaultEmptyTable
	TimelineJsonCacheDict[timelineUrl] = cacheJson

	return cacheJson
end

function FightTLHelper.clearCache()
	tabletool.clear(TimelineJsonCacheDict)
end

return FightTLHelper
