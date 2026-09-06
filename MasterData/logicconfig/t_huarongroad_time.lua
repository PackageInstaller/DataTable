-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_huarongroad_time.lua

module("logicconfig.config.t_huarongroad_time", package.seeall)

local title = {
	cost = 3,
	timePlanId = 1,
	count = 2,
	time = 4
}
local dataList = {
	{
		1,
		1,
		"105:6028:20",
		60
	},
	{
		1,
		2,
		"105:6029:20",
		60
	},
	{
		1,
		3,
		"105:6030:20",
		60
	},
	{
		1,
		4,
		"105:6031:20",
		60
	},
	{
		1,
		5,
		"105:6032:20",
		60
	},
	{
		2,
		1,
		"105:6071:20",
		60
	},
	{
		2,
		2,
		"105:6072:20",
		60
	},
	{
		2,
		3,
		"105:6073:20",
		60
	},
	{
		2,
		4,
		"105:6074:20",
		60
	},
	{
		2,
		5,
		"105:6075:20",
		60
	}
}
local t_huarongroad_time = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_huarongroad_time.dataList = dataList

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

return t_huarongroad_time
