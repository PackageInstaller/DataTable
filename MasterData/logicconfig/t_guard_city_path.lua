-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guard_city_path.lua

module("logicconfig.config.t_guard_city_path", package.seeall)

local title = {
	pathPlanId = 1,
	pathLength = 3,
	pathId = 2
}
local dataList = {
	{
		1,
		1,
		8
	},
	{
		1,
		2,
		10
	},
	{
		1,
		3,
		12
	},
	{
		1,
		4,
		12
	},
	{
		1,
		5,
		10
	},
	{
		1,
		6,
		8
	}
}
local t_guard_city_path = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_guard_city_path.dataList = dataList

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

return t_guard_city_path
