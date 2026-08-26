-- chunkname: @modules/logic/season/utils/SeasonViewHelper.lua

module("modules.logic.season.utils.SeasonViewHelper", package.seeall)

local SeasonViewHelper = class("SeasonViewHelper")

function SeasonViewHelper.openView(seasonId, viewName, param)
	local realView = SeasonViewHelper.getViewName(seasonId, viewName)

	if realView then
		ViewMgr.instance:openView(realView, param)
	end
end

function SeasonViewHelper.getViewName(seasonId, viewName, noError)
	seasonId = seasonId or Activity104Model.instance:getCurSeasonId()

	if not Activity104Enum.SeasonViewPrefix[seasonId] then
		local prefix = ""
		local seasonViewName = string.format("Season%s%s", prefix, viewName)
		local realViewName = ViewName[seasonViewName]

		if not realViewName and not noError then
			logError(string.format("cant find season view [%s] [%s]", seasonId, viewName))
		end

		return realViewName
	end
end

function SeasonViewHelper.getSeasonIcon(resName, seasonId)
	seasonId = seasonId or Activity104Model.instance:getCurSeasonId()

	local folder = Activity104Enum.SeasonIconFolder[seasonId]

	return string.format("singlebg/%s/%s", folder, resName)
end

function SeasonViewHelper.getAllSeasonViewList(seasonId)
	local list = {}

	for k, viewName in pairs(Activity104Enum.ViewName) do
		local realViewName = SeasonViewHelper.getViewName(seasonId, viewName, true)

		if realViewName then
			table.insert(list, realViewName)
		end
	end

	return list
end

function SeasonViewHelper.getIconUrl(url, param, actId)
	actId = actId or Activity104Model.instance:getCurSeasonId()

	local version = Activity104Enum.SeasonIconFolder[actId]

	return string.format(url, version, param)
end

return SeasonViewHelper
