-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_beast_prize.lua

module("logicconfig.config.t_beast_rich_man_beast_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	needScore = 3
}
local dataList = {
	{
		558001,
		1,
		5,
		"4:36:5"
	},
	{
		558001,
		2,
		10,
		"4:31:10"
	},
	{
		558001,
		3,
		15,
		"104:2:194"
	},
	{
		558001,
		4,
		20,
		"8:1:5000000"
	},
	{
		558001,
		5,
		25,
		"8:25:600"
	},
	{
		558001,
		6,
		30,
		"4:36:5"
	},
	{
		558001,
		7,
		35,
		"4:31:10"
	},
	{
		558001,
		8,
		40,
		"104:2:194"
	},
	{
		558001,
		9,
		45,
		"8:1:5000000"
	},
	{
		558001,
		10,
		49,
		"8:25:600"
	}
}
local t_beast_rich_man_beast_prize = {
	[558001] = {
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

t_beast_rich_man_beast_prize.dataList = dataList

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

return t_beast_rich_man_beast_prize
