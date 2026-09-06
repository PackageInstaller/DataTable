-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_treasure_new_turntable.lua

module("logicconfig.config.t_treasure_new_turntable", package.seeall)

local title = {
	index = 2,
	prize = 3,
	turntableId = 1
}
local dataList = {
	{
		1,
		0,
		"8:1:5000"
	},
	{
		1,
		1,
		"4:30001:5"
	},
	{
		1,
		2,
		"4:31:1"
	},
	{
		1,
		3,
		"4:310:1"
	},
	{
		1,
		4,
		"104:2:100"
	},
	{
		1,
		5,
		"4:501:10"
	},
	{
		1,
		6,
		"4:2:20"
	},
	{
		1,
		7,
		"8:8:200"
	},
	{
		2,
		0,
		"8:1:20000"
	},
	{
		2,
		1,
		"4:30003:3"
	},
	{
		2,
		2,
		"4:31:2"
	},
	{
		2,
		3,
		"4:90003:1"
	},
	{
		2,
		4,
		"104:2:200"
	},
	{
		2,
		5,
		"4:503:6"
	},
	{
		2,
		6,
		"104:2:100"
	},
	{
		2,
		7,
		"8:8:500"
	},
	{
		3,
		0,
		"4:111:2"
	},
	{
		3,
		1,
		"4:503:65"
	},
	{
		3,
		2,
		"4:31:2"
	},
	{
		3,
		3,
		"4:40008:1"
	},
	{
		3,
		4,
		"4:111:3"
	},
	{
		3,
		5,
		"10:17073:500"
	},
	{
		3,
		6,
		"4:31:3"
	},
	{
		3,
		7,
		"4:30003:100"
	}
}
local t_treasure_new_turntable = {
	{
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		[0] = dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	},
	{
		[0] = dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24]
	}
}

t_treasure_new_turntable.dataList = dataList

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

return t_treasure_new_turntable
