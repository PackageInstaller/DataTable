-- chunkname: @modules/logic/monthcard/model/VersionActivity3_8FreeMonthCardModel.lua

module("modules.logic.monthcard.model.VersionActivity3_8FreeMonthCardModel", package.seeall)

local VersionActivity3_8FreeMonthCardModel = class("VersionActivity3_8FreeMonthCardModel", BaseModel)

function VersionActivity3_8FreeMonthCardModel:onInit()
	self:reInit()
end

function VersionActivity3_8FreeMonthCardModel:reInit()
	self._openDay = 0
	self._todaySigned = false
	self._act240Infos = {}
end

function VersionActivity3_8FreeMonthCardModel:set240Infos(info)
	self._openDay = info.openDay
	self._todaySigned = info.todaySigned
	self._act240Infos = self:_buildAct240Infos(info.infos)
end

function VersionActivity3_8FreeMonthCardModel:_buildAct240Infos(infos)
	local act240Infos = {}

	for _, info in ipairs(infos) do
		local act240Info = VersionActivity3_8FreeMonthCardAct240InfoMo.New()

		act240Info:init(info)
		table.insert(act240Infos, act240Info)
	end

	return act240Infos
end

function VersionActivity3_8FreeMonthCardModel:setDaySignIn(dayIds)
	local curDay = self:getCurSignDay()

	if not self._act240Infos then
		return
	end

	for _, dayId in ipairs(dayIds) do
		if self._act240Infos[dayId] then
			if dayId == curDay then
				self._todaySigned = true
			end

			self._act240Infos[dayId]:updateState(MonthCardEnum.Act240SignState.HasGet)
		end
	end
end

function VersionActivity3_8FreeMonthCardModel:isTodaySigned()
	return self._todaySigned
end

function VersionActivity3_8FreeMonthCardModel:getOpenDay()
	return self._openDay
end

function VersionActivity3_8FreeMonthCardModel:getCurSignDay()
	local maxSignDay = self:getMaxSignDay()

	for i = maxSignDay, 2, -1 do
		if self._act240Infos[i] and self._act240Infos[i - 1] and self._act240Infos[i - 1].state == MonthCardEnum.Act240SignState.HasGet and self._act240Infos[i].state ~= MonthCardEnum.Act240SignState.HasGet then
			local todaySigned = self:isTodaySigned()

			if todaySigned then
				return i - 1
			else
				return i
			end
		end
	end

	return 1
end

function VersionActivity3_8FreeMonthCardModel:getDaySignState(dayId)
	if not self._act240Infos or not self._act240Infos[dayId] then
		return MonthCardEnum.Act240SignState.Unsigned
	end

	return self._act240Infos[dayId].state
end

function VersionActivity3_8FreeMonthCardModel:isDayCanSign(dayId)
	if dayId > self._openDay then
		return false
	end

	if dayId == self._openDay then
		return not self._todaySigned
	end

	local state = self:getDaySignState(dayId)

	return state == MonthCardEnum.Act240SignState.CanSigned
end

function VersionActivity3_8FreeMonthCardModel:getRewardGetDayCount()
	local count = 0

	for _, actInfo in ipairs(self._act240Infos) do
		if actInfo.state == MonthCardEnum.Act240SignState.HasGet then
			count = count + 1
		end
	end

	return count
end

function VersionActivity3_8FreeMonthCardModel:getMaxSignDay()
	local day = 0
	local actCos = Activity240Config.instance:getActivity240Cos()

	for _, actCo in pairs(actCos) do
		day = day < actCo.id and actCo.id or day
	end

	return day
end

function VersionActivity3_8FreeMonthCardModel:getCanBackdateDayCount(actId)
	actId = actId or VersionActivity3_8Enum.ActivityId.FreeMonthCard

	local hasSignDay = self:getRewardGetDayCount()
	local totalDay = self:getMaxSignDay()

	if self._todaySigned then
		return math.min(self._openDay - hasSignDay, totalDay - hasSignDay)
	else
		return math.min(self._openDay - 1 - hasSignDay, totalDay - hasSignDay)
	end
end

function VersionActivity3_8FreeMonthCardModel:getCanBackdateTotalDayCount(actId)
	actId = actId or VersionActivity3_8Enum.ActivityId.FreeMonthCard

	local hasSignDay = self:getRewardGetDayCount()

	if self._todaySigned then
		return (self._openDay - hasSignDay > 0 or nil) and (self._openDay - hasSignDay or 0)
	else
		return (self._openDay - hasSignDay - 1 > 0 or nil) and (self._openDay - hasSignDay - 1 or 0)
	end
end

function VersionActivity3_8FreeMonthCardModel:getCanBackdateDayItemCount(actId)
	actId = actId or VersionActivity3_8Enum.ActivityId.FreeMonthCard

	local backdateCo = Activity240Config.instance:getActivity240BackdateCo(actId)
	local itemCos = string.splitToNumber(backdateCo.cost, "#")

	return (ItemModel.instance:getItemQuantity(itemCos[1], itemCos[2]))
end

function VersionActivity3_8FreeMonthCardModel:getAllTasks(actId)
	actId = actId or VersionActivity3_8Enum.ActivityId.FreeMonthCard

	local taskCos = Activity240Config.instance:getActivity240TaskCos(actId)
	local taskList = {}

	for _, taskCo in ipairs(taskCos) do
		table.insert(taskList, taskCo.id)
	end

	table.sort(taskList, VersionActivity3_8FreeMonthCardModel.sortFunc)

	return taskList
end

function VersionActivity3_8FreeMonthCardModel.sortFunc(a, b)
	local aTaskCo = Activity240Config.instance:getActivity240TaskCo(a)
	local bTaskCo = Activity240Config.instance:getActivity240TaskCo(b)
	local aTaskMo = TaskModel.instance:getTaskById(a)
	local bTaskMo = TaskModel.instance:getTaskById(b)

	if not aTaskMo or not bTaskMo then
		return a < b
	end

	local aValue = aTaskMo.progress >= aTaskCo.maxProgress and aTaskMo.finishCount > 0 and 3 or aTaskMo.hasFinished and 1 or 2
	local bValue = bTaskMo.progress >= bTaskCo.maxProgress and bTaskMo.finishCount > 0 and 3 or bTaskMo.hasFinished and 1 or 2

	if aValue ~= bValue then
		return aValue < bValue
	else
		return a < b
	end
end

function VersionActivity3_8FreeMonthCardModel:isAllTasksFinished()
	local taskCos = Activity240Config.instance:getActivity240TaskCos(VersionActivity3_8Enum.ActivityId.FreeMonthCard)

	for _, taskCo in ipairs(taskCos) do
		local taskMo = TaskModel.instance:getTaskById(taskCo.id)

		if not taskMo or taskMo.finishCount < taskCo.maxProgress then
			return false
		end
	end

	return true
end

VersionActivity3_8FreeMonthCardModel.instance = VersionActivity3_8FreeMonthCardModel.New()

return VersionActivity3_8FreeMonthCardModel
