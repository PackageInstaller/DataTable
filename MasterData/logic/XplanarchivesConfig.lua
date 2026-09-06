-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xplanarchives/config/XplanarchivesConfig.lua

module("logic.extensions.xplanarchives.config.XplanarchivesConfig", package.seeall)

local XplanarchivesConfig = class("XplanarchivesConfig", BaseConfig)

function XplanarchivesConfig:onInit()
	return
end

function XplanarchivesConfig:getNames()
	return {
		"x_plan_archives_activity",
		"x_plan_archives_type",
		"x_plan_archives_type_prize",
		"x_plan_archives_progress",
		"x_plan_archives_page",
		"x_plan_archives_view"
	}
end

function XplanarchivesConfig:handleConfig(name, content)
	if name == "x_plan_archives_activity" then
		self._x_plan_archives_activity = content
	elseif name == "x_plan_archives_type" then
		self._x_plan_archives_type = content
	elseif name == "x_plan_archives_type_prize" then
		self._x_plan_archives_type_prize = content
	elseif name == "x_plan_archives_progress" then
		self._x_plan_archives_progress = content
	elseif name == "x_plan_archives_page" then
		self._x_plan_archives_page = content
	elseif name == "x_plan_archives_view" then
		self._x_plan_archives_view = content
	end
end

function XplanarchivesConfig:getProgressCfgs(activityId)
	return self._x_plan_archives_progress[activityId]
end

function XplanarchivesConfig:getProgressCfg(activityId, prizeId)
	return self._x_plan_archives_progress[activityId][prizeId]
end

function XplanarchivesConfig:getPageCfgs(activityId)
	return self._x_plan_archives_page[activityId]
end

function XplanarchivesConfig:getPageCfg(activityId, tabIdx, page)
	return self._x_plan_archives_page[activityId][tabIdx][page]
end

function XplanarchivesConfig:getViewCfgs(activityId, tabIdx, page)
	local list = {}

	for k, v in pairs(self._x_plan_archives_view[activityId][tabIdx][page]) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.page < b.page
	end)

	return list
end

function XplanarchivesConfig:getTypeCfg(activityId, typeId)
	return self._x_plan_archives_type[activityId][typeId]
end

function XplanarchivesConfig:getTypePrizeCfg(activityId, typeId, prizeId)
	return self._x_plan_archives_type_prize[activityId][typeId][prizeId]
end

function XplanarchivesConfig:getActCfg(activityId)
	return self._x_plan_archives_activity[activityId]
end

XplanarchivesConfig.instance = XplanarchivesConfig.New()

return XplanarchivesConfig
