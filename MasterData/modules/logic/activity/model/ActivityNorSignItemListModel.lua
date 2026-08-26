-- chunkname: @modules/logic/activity/model/ActivityNorSignItemListModel.lua

module("modules.logic.activity.model.ActivityNorSignItemListModel", package.seeall)

local ActivityNorSignItemListModel = class("ActivityNorSignItemListModel", ListScrollModel)

function ActivityNorSignItemListModel:setDayList(Infos)
	self._moList = Infos and Infos or {}

	self:setList(self._moList)
end

ActivityNorSignItemListModel.instance = ActivityNorSignItemListModel.New()

return ActivityNorSignItemListModel
