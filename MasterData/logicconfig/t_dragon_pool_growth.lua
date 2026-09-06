-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_pool_growth.lua

module("logicconfig.config.t_dragon_pool_growth", package.seeall)

local title = {
	mood = 3,
	growthInc = 4,
	actId = 1,
	growthId = 2
}
local dataList = {
	{
		300001,
		1,
		9,
		0
	},
	{
		300001,
		2,
		10,
		1
	},
	{
		300001,
		3,
		30,
		2
	},
	{
		300001,
		4,
		50,
		3
	},
	{
		300001,
		5,
		70,
		4
	},
	{
		300001,
		6,
		100,
		5
	},
	{
		300001,
		7,
		120,
		6
	},
	{
		300001,
		8,
		200,
		7
	}
}
local t_dragon_pool_growth = {
	[300001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_dragon_pool_growth.dataList = dataList

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

return t_dragon_pool_growth
