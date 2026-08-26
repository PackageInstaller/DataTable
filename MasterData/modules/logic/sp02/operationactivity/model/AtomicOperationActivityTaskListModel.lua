-- chunkname: @modules/logic/sp02/operationactivity/model/AtomicOperationActivityTaskListModel.lua

module("modules.logic.sp02.operationactivity.model.AtomicOperationActivityTaskListModel", package.seeall)

local AtomicOperationActivityTaskListModel = class("AtomicOperationActivityTaskListModel", MixScrollModel)

function AtomicOperationActivityTaskListModel:init(activityId)
	self._activityId = activityId
end

function AtomicOperationActivityTaskListModel:refresh()
	local actMo = Activity186Model.instance:getById(self._activityId)

	if not actMo then
		return
	end

	local taskMoList = actMo:getTaskList()
	local actOpenTime = ActivityModel.instance:getActStartTime(self._activityId)
	local nowTime = ServerTime.now()
	local list = {}

	for i, v in ipairs(taskMoList) do
		local config = v.config

		if config then
			if not config.showDay then
				local showDay = 1
				local duration = TimeUtil.OneDaySecond * (showDay - 1)
				local showTime = actOpenTime / TimeUtil.OneSecondMilliSecond + duration
				local showTask = showTime <= nowTime or v.status == Activity186Enum.TaskStatus.Canget

				if showTask then
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
							logNormal("SP02联动任务到达时间 id:" .. tostring(config.id) .. "开启时间: " .. tostring(showTime))
						end
					else
						table.insert(list, v)
						logNormal("SP02联动任务到达时间 id:" .. tostring(config.id) .. "开启时间: " .. tostring(showTime))
					end
				else
					logNormal("SP02联动任务未到时间 id:" .. tostring(config.id) .. "开启时间: " .. tostring(showTime))
				end
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

AtomicOperationActivityTaskListModel.instance = AtomicOperationActivityTaskListModel.New()

return AtomicOperationActivityTaskListModel
