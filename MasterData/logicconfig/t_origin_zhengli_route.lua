-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_zhengli_route.lua

module("logicconfig.config.t_origin_zhengli_route", package.seeall)

local title = {
	activityId = 1,
	stageSequence = 3,
	passNeedAwakenBuffNum = 4,
	passNeedGrowthBuffNum = 5,
	routeId = 2
}
local dataList = {
	{
		587001,
		1,
		{
			5,
			2,
			3,
			6
		},
		1,
		1
	},
	{
		587001,
		2,
		{
			5,
			8,
			9,
			6
		},
		1,
		1
	},
	{
		587001,
		3,
		{
			5,
			2,
			1,
			4,
			7,
			8
		},
		1,
		1
	}
}
local t_origin_zhengli_route = {
	[587001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_origin_zhengli_route.dataList = dataList

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

return t_origin_zhengli_route
