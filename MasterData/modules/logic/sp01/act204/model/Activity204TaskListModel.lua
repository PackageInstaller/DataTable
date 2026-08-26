-- chunkname: @modules/logic/sp01/act204/model/Activity204TaskListModel.lua

module("modules.logic.sp01.act204.model.Activity204TaskListModel", package.seeall)

local Activity204TaskListModel = class("Activity204TaskListModel", MixScrollModel)

function Activity204TaskListModel:init(activityId)
	self._activityId = activityId
end

function Activity204TaskListModel:refresh()
	local actMo = Activity204Model.instance:getById(self._activityId)

	if not actMo then
		return
	end

	self._nextRefreshTime = nil

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

			self:_updateNextRefreshTime(v)
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

function Activity204TaskListModel:_updateNextRefreshTime(taskMo)
	if not taskMo or not taskMo.config or taskMo.hasGetBonus then
		return
	end

	if taskMo.config.durationHour == 0 then
		return
	end

	if not taskMo.expireTime or taskMo.expireTime <= ServerTime.now() then
		return
	end

	if not self._nextRefreshTime or taskMo.expireTime < self._nextRefreshTime then
		self._nextRefreshTime = taskMo.expireTime
	end
end

function Activity204TaskListModel:getNextRefreshTime()
	return self._nextRefreshTime
end

Activity204TaskListModel.instance = Activity204TaskListModel.New()

return Activity204TaskListModel
