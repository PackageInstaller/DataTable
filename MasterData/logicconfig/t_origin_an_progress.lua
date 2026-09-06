-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_an_progress.lua

module("logicconfig.config.t_origin_an_progress", package.seeall)

local title = {
	progressId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		589001,
		1,
		5,
		"8:1:1000000"
	},
	{
		589001,
		2,
		10,
		"4:442:5"
	},
	{
		589001,
		3,
		15,
		"4:442:5"
	},
	{
		589001,
		4,
		20,
		"4:442:10"
	},
	{
		589001,
		5,
		25,
		"4:90004:1"
	},
	{
		589001,
		6,
		30,
		"4:30006:20"
	},
	{
		589001,
		7,
		35,
		"4:30006:20"
	}
}
local t_origin_an_progress = {
	[589001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_origin_an_progress.dataList = dataList

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

return t_origin_an_progress
