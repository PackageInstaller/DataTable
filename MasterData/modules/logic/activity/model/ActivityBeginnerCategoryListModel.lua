-- chunkname: @modules/logic/activity/model/ActivityBeginnerCategoryListModel.lua

module("modules.logic.activity.model.ActivityBeginnerCategoryListModel", package.seeall)

local ActivityBeginnerCategoryListModel = class("ActivityBeginnerCategoryListModel", ListScrollModel)

function ActivityBeginnerCategoryListModel:setSortInfos(infos)
	self._sortInfos = {}

	for i, v in ipairs(infos) do
		local activityId = v.co.id

		self._sortInfos[activityId] = ActivityBeginnerController.instance:showRedDot(activityId)
	end
end

function ActivityBeginnerCategoryListModel:checkTargetCategory(Infos)
	local id = ActivityModel.instance:getCurTargetActivityCategoryId()

	if id > 0 or not Infos or #Infos <= 0 then
		return
	end

	table.sort(Infos, ActivityBeginnerCategoryListModel._sort)
	ActivityModel.instance:setTargetActivityCategoryId(Infos[1].co.id)
end

function ActivityBeginnerCategoryListModel:setCategoryList(Infos)
	self._moList = Infos and Infos or {}

	table.sort(self._moList, ActivityBeginnerCategoryListModel._sort)
	self:setList(self._moList)
end

function ActivityBeginnerCategoryListModel._sort(a, b)
	local sortInfos = ActivityBeginnerCategoryListModel.instance._sortInfos
	local aId = a.co.id
	local bId = b.co.id

	if sortInfos[aId] then
		if not a.co.hintPriority then
			local aPriority = a.co.defaultPriority

			if sortInfos[bId] then
				if not b.co.hintPriority then
					local bPriority = b.co.defaultPriority

					if aPriority == bPriority then
						return bId < aId
					end

					return bPriority < aPriority
				end
			end
		end
	end
end

function ActivityBeginnerCategoryListModel:setOpenViewTime()
	self.openViewTime = Time.realtimeSinceStartup
end

ActivityBeginnerCategoryListModel.instance = ActivityBeginnerCategoryListModel.New()

return ActivityBeginnerCategoryListModel
