-- chunkname: @modules/logic/versionactivity2_5/act186/model/Activity186TaskListModel.lua

module("modules.logic.versionactivity2_5.act186.model.Activity186TaskListModel", package.seeall)

local Activity186TaskListModel = class("Activity186TaskListModel", MixScrollModel)

function Activity186TaskListModel:init(activityId)
	self._activityId = activityId
end

function Activity186TaskListModel:refresh()
	local actMo = Activity186Model.instance:getById(self._activityId)

	if not actMo then
		return
	end

	local taskMoList = actMo:getTaskList()
	local list = {}

	for i, v in ipairs(taskMoList) do
		local config = v.config

		if config then
			if not string.nilorempty(config.prepose) then
				local preposeFinish = true
				local preposes = string.splitToNumber(config.prepose, "#")

				for _, preposeId in ipairs(preposes) do
					local taskInfo = actMo:getTaskInfo(preposeId)

					if not taskInfo or not taskInfo.hasGetBonus then
						preposeFinish = false

						break
					end
				end

				if preposeFinish then
					table.insert(list, v)
				end
			else
				table.insert(list, v)
			end
		end
	end

	if #list > 1 then
		table.sort(list, SortUtil.tableKeyLower({
			"status",
			"missionorder",
			"id"
		}))
	end

	for i, v in ipairs(list) do
		v.index = i
	end

	self:setList(list)
end

Activity186TaskListModel.instance = Activity186TaskListModel.New()

return Activity186TaskListModel
