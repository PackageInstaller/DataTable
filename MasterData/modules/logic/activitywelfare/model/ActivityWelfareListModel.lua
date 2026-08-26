-- chunkname: @modules/logic/activitywelfare/model/ActivityWelfareListModel.lua

module("modules.logic.activitywelfare.model.ActivityWelfareListModel", package.seeall)

local ActivityWelfareListModel = class("ActivityWelfareListModel", ListScrollModel)

function ActivityWelfareListModel:setCategoryList(Infos)
	self._moList = Infos and Infos or {}

	table.sort(self._moList, ActivityWelfareListModel._sort)
	self:setList(self._moList)
	self.checkTargetCategory(self._moList)
end

function ActivityWelfareListModel.checkTargetCategory(Infos)
	local id = ActivityModel.instance:getCurTargetActivityCategoryId()

	if id > 0 or not Infos or #Infos <= 0 then
		return
	end

	table.sort(Infos, ActivityWelfareListModel._sort)
	ActivityModel.instance:setTargetActivityCategoryId(Infos[1].co.id)
end

function ActivityWelfareListModel._sort(a, b)
	local aId = a.co.id
	local bId = b.co.id
	local aPriority = a.co.defaultPriority
	local bPriority = b.co.defaultPriority

	if aPriority == bPriority then
		return bId < aId
	end

	return bPriority < aPriority
end

function ActivityWelfareListModel:setOpenViewTime()
	self.openViewTime = Time.realtimeSinceStartup
end

ActivityWelfareListModel.instance = ActivityWelfareListModel.New()

return ActivityWelfareListModel
