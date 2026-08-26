-- chunkname: @modules/logic/meilanni/model/MeilanniTaskListModel.lua

module("modules.logic.meilanni.model.MeilanniTaskListModel", package.seeall)

local MeilanniTaskListModel = class("MeilanniTaskListModel", ListScrollModel)

function MeilanniTaskListModel:setTaskRewardList(value)
	self._rewardList = value
end

function MeilanniTaskListModel:getTaskRewardList()
	return self._rewardList
end

function MeilanniTaskListModel:showTaskList()
	local result = {}
	local getAll = false

	for i, v in ipairs(lua_activity108_grade.configList) do
		local get, finish = MeilanniTaskListModel._getTaskStatus(v)

		if get == 0 and finish == 0 then
			getAll = true
		end

		table.insert(result, v)
	end

	table.sort(result, MeilanniTaskListModel._sort)

	if getAll then
		table.insert(result, 1, {
			id = 0,
			isGetAll = true
		})
	end

	self:setList(result)
end

function MeilanniTaskListModel._sort(a, b)
	local a_get, a_finish = MeilanniTaskListModel._getTaskStatus(a)
	local b_get, b_finish = MeilanniTaskListModel._getTaskStatus(b)

	if a_get ~= b_get then
		return a_get < b_get
	end

	if a_finish ~= b_finish then
		return a_finish < b_finish
	end

	return a.id < b.id
end

function MeilanniTaskListModel._getTaskStatus(mo)
	local isGet, isFinish = MeilanniTaskListModel.getTaskStatus(mo)

	return isGet and 1 or 0, isFinish and 0 or 1
end

function MeilanniTaskListModel.getTaskStatus(mo)
	local mapInfo = MeilanniModel.instance:getMapInfo(mo.mapId)
	local curScore = mapInfo and mapInfo:getMaxScore() or 0
	local totalScore = mo.score
	local isGet = mapInfo and mapInfo:isGetReward(mo.id)
	local isFinish = totalScore <= curScore

	return isGet, isFinish
end

MeilanniTaskListModel.instance = MeilanniTaskListModel.New()

return MeilanniTaskListModel
