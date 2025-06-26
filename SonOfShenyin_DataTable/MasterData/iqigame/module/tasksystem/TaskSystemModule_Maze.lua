-- chunkname: @IQIGame\\Module\\TaskSystem\\TaskSystemModule_Maze.lua

local this = TaskSystemModule
local TaskType = {
	Child = 1,
	Main = 0
}
local TaskSeasonIndex = 1
local TaskIdIndex = 2
local TaskTypeIndex = 3

function this.GetMazeTaskData()
	local curSeaon = MazeModule.GetMazeSeason()
	local tb = {}
	local taskList = this.GetTaskListByConfig(Constant.TaskType.Maze)

	for _, v in pairs(taskList) do
		if v.type == Constant.TaskType.Maze then
			local season = v.extendType[TaskSeasonIndex]

			if season <= curSeaon then
				local team = v.extendType[TaskIdIndex]
				local type = v.extendType[TaskTypeIndex]

				if not tb[season] then
					tb[season] = {}
					tb[season].Data = {}
					tb[season].seasonId = season
				end

				if not tb[season].Data[team] then
					tb[season].Data[team] = {}
					tb[season].Data[team].childData = {}
				end

				if type == TaskType.Main then
					tb[season].Data[team].mainData = v
				elseif type == TaskType.Child then
					table.insert(tb[season].Data[team].childData, v)
				end
			end
		end
	end

	for k, v in pairs(tb) do
		for i, j in pairs(v.Data) do
			table.sort(j.childData, function(a, b)
				return a.cid < b.cid
			end)
		end

		table.sort(v, function(a, b)
			return a.mainData.cid < b.mainData.cid
		end)
	end

	table.sort(tb, function(a, b)
		return a.seasonId < b.seasonId
	end)

	return tb
end
