-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_year_pray_progress.lua

module("logicconfig.config.t_new_year_pray_progress", package.seeall)

local title = {
	dataBitId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		326001,
		1,
		5,
		"8:1:1000000"
	},
	{
		326001,
		2,
		10,
		"4:112:2"
	},
	{
		326001,
		3,
		15,
		"8:1:1000000"
	},
	{
		326001,
		4,
		20,
		"4:112:2"
	},
	{
		326001,
		5,
		25,
		"4:90312:1"
	},
	{
		326001,
		6,
		30,
		"4:112:2"
	},
	{
		326001,
		7,
		35,
		"8:1:1000000"
	},
	{
		326001,
		8,
		40,
		"4:112:2"
	},
	{
		326001,
		9,
		45,
		"4:112:2"
	},
	{
		326001,
		10,
		50,
		"4:90312:1"
	}
}
local t_new_year_pray_progress = {
	[326001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_new_year_pray_progress.dataList = dataList

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

return t_new_year_pray_progress
