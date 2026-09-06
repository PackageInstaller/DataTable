-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_task_summarize.lua

module("logicconfig.config.t_task_summarize", package.seeall)

local title = {
	refreshTime = 7,
	name = 8,
	weekopenTime = 6,
	type = 4,
	rankId = 3,
	reward = 9,
	onlineTime = 5,
	funcId = 2,
	id = 1,
	show = 10
}
local dataList = {
	{
		1,
		52,
		1,
		6,
		"",
		"0",
		"1899-12-31 05:00:00",
		"失落遗迹",
		"4:50008:0#4:50007:0",
		"每日5:00刷新"
	},
	{
		2,
		91,
		2,
		3,
		"0-0-0 08:00:00#0-0-0 23:00:00",
		"0",
		"",
		"家族护送",
		"8:5:0",
		"每日8:00-23:00开放"
	},
	{
		3,
		93,
		3,
		3,
		"0-0-0 08:00:00#0-0-0 23:00:00",
		"0",
		"",
		"世界boss",
		"9:60004:0#9:60003:0#4:503:0",
		"每日8:00-23:00开放"
	},
	{
		4,
		18,
		4,
		5,
		"",
		"1",
		"1899-12-31 05:00:00",
		"破阵天下",
		"4:502:0#9:60004:0",
		"每周五5:00刷新"
	},
	{
		5,
		19,
		5,
		6,
		"",
		"0",
		"1899-12-31 05:00:00",
		"竞技场",
		"104:2:0#8:3:0",
		"每日5:00刷新"
	},
	{
		6,
		69,
		6,
		3,
		"0-0-0 18:00:00#0-0-0 22:00:00",
		"0",
		"1899-12-31 05:00:00",
		"排位赛",
		"104:2:0#8:3:0",
		"每日18:00-22:00开放"
	}
}
local t_task_summarize = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_task_summarize.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_task_summarize
