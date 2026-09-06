-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fruit_ninja_critical.lua

module("logicconfig.config.t_fruit_ninja_critical", package.seeall)

local title = {
	score = 3,
	criPlanId = 1,
	criId = 2,
	rate = 4
}
local dataList = {
	{
		1,
		1,
		0,
		0.01
	},
	{
		1,
		2,
		250,
		0.1
	},
	{
		1,
		3,
		500,
		0.2
	},
	{
		1,
		4,
		800,
		0.3
	},
	{
		1,
		5,
		1200,
		0.4
	},
	{
		1,
		6,
		1500,
		0.5
	},
	{
		1,
		7,
		2000,
		0.6
	}
}
local t_fruit_ninja_critical = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_fruit_ninja_critical.dataList = dataList

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

return t_fruit_ninja_critical
