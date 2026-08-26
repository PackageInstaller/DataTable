-- chunkname: @modules/logic/activity/model/ActivityNormalCategoryListModel.lua

module("modules.logic.activity.model.ActivityNormalCategoryListModel", package.seeall)

local ActivityNormalCategoryListModel = class("ActivityNormalCategoryListModel", ListScrollModel)

function ActivityNormalCategoryListModel:setCategoryList(Infos)
	self._moList = Infos and Infos or {}

	table.sort(self._moList, function(a, b)
		return a.co.displayPriority < b.co.displayPriority
	end)
	self:setList(self._moList)
end

ActivityNormalCategoryListModel.instance = ActivityNormalCategoryListModel.New()

return ActivityNormalCategoryListModel
