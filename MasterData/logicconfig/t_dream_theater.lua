-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_theater.lua

module("logicconfig.config.t_dream_theater", package.seeall)

local title = {
	before = 5,
	theaterId = 4,
	after = 6,
	id = 1,
	activityId = 2,
	day = 3
}
local dataList = {
	{
		1,
		18004,
		1,
		1,
		1,
		0
	},
	{
		2,
		18004,
		2,
		2,
		1,
		0
	},
	{
		3,
		18004,
		3,
		3,
		1,
		0
	},
	{
		4,
		18004,
		4,
		4,
		1,
		0
	},
	{
		5,
		18004,
		5,
		5,
		1,
		0
	},
	{
		6,
		18004,
		6,
		6,
		1,
		0
	},
	{
		7,
		18004,
		7,
		7,
		1,
		0
	},
	{
		8,
		18004,
		8,
		8,
		1,
		0
	},
	{
		9,
		18004,
		9,
		9,
		1,
		0
	},
	{
		10,
		18004,
		10,
		10,
		1,
		0
	},
	{
		11,
		18004,
		11,
		11,
		1,
		0
	},
	{
		12,
		18004,
		12,
		12,
		1,
		0
	},
	{
		13,
		18004,
		13,
		13,
		1,
		0
	},
	{
		14,
		18004,
		14,
		14,
		1,
		0
	}
}
local t_dream_theater = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14]
}

t_dream_theater.dataList = dataList

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

return t_dream_theater
