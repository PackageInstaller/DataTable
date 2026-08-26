-- chunkname: @modules/logic/season/model/Activity104TaskListModel.lua

module("modules.logic.season.model.Activity104TaskListModel", package.seeall)

local Activity104TaskListModel = class("Activity104TaskListModel", ListScrollModel)

function Activity104TaskListModel:refreshList()
	local tasks = Activity104TaskModel.instance:getTaskSeasonList()
	local list = {}
	local finishCount = 0

	for i, v in ipairs(tasks) do
		list[i] = v

		if v.hasFinished then
			finishCount = finishCount + 1
		end
	end

	if finishCount > 1 then
		table.insert(list, 1, {
			isTotalGet = true
		})
	end

	self:setList(list)
end

Activity104TaskListModel.instance = Activity104TaskListModel.New()

return Activity104TaskListModel
