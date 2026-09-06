-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_contest_progress_sld.lua

module("logicconfig.config.t_goddess_contest_progress_sld", package.seeall)

local title = {
	desc = 4,
	showTime = 5,
	hudDesc = 6,
	Id = 2,
	progressSldPlanId = 1,
	startTime = 3
}
local dataList = {
	{
		1,
		1,
		"2023-03-03 05:00:00",
		"活动开始，可进行团长竞选报名",
		"3.3",
		"竞选团长报名"
	},
	{
		1,
		2,
		"2023-03-19 05:00:00",
		"决胜出团长名选",
		"3.19",
		"决出团长"
	},
	{
		1,
		3,
		"2023-03-24 05:00:00",
		"开始决赛冲刺",
		"3.24",
		"决赛冲刺"
	},
	{
		1,
		4,
		"2023-03-26 05:00:00",
		"公布优胜组、优胜女神",
		"3.26",
		"结果公布"
	},
	{
		2,
		1,
		"2024-03-01 05:00:00",
		"活动开始，可进行团长竞选报名",
		"3.1",
		"竞选团长报名"
	},
	{
		2,
		2,
		"2024-03-17 05:00:00",
		"决胜出团长名选",
		"3.17",
		"决出团长"
	},
	{
		2,
		3,
		"2024-03-22 05:00:00",
		"开始决赛冲刺",
		"3.22",
		"决赛冲刺"
	},
	{
		2,
		4,
		"2024-03-24 05:00:00",
		"公布优胜组、优胜女神",
		"3.24",
		"结果公布"
	}
}
local t_goddess_contest_progress_sld = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_goddess_contest_progress_sld.dataList = dataList

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

return t_goddess_contest_progress_sld
