-- chunkname: @modules/logic/seasonver/act123/utils/Season123ViewHelper.lua

module("modules.logic.seasonver.act123.utils.Season123ViewHelper", package.seeall)

local Season123ViewHelper = class("Season123ViewHelper")

function Season123ViewHelper.openView(seasonId, viewName, param)
	local realView = Season123ViewHelper.getViewName(seasonId, viewName)

	if realView then
		ViewMgr.instance:openView(realView, param)
	end
end

function Season123ViewHelper.getViewName(seasonId, viewName, noError)
	seasonId = seasonId or Season123Model.instance:getCurSeasonId()

	if not Activity123Enum.SeasonViewPrefix[seasonId] then
		local prefix = ""
		local seasonViewName = string.format("Season123%s%s", prefix, viewName)
		local realViewName = ViewName[seasonViewName]

		if not realViewName and not noError then
			logError(string.format("cant find season123 view [%s] [%s]", seasonId, viewName))
		end

		return realViewName or seasonViewName
	end
end

function Season123ViewHelper.getIconUrl(url, param, actId)
	actId = actId or Season123Model.instance:getCurSeasonId()

	local version = Activity123Enum.SeasonIconPrefix[actId]

	return string.format(url, version, param)
end

return Season123ViewHelper
