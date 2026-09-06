-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_colorful_lantern_fragment.lua

module("logicconfig.config.t_colorful_lantern_fragment", package.seeall)

local title = {
	fragmentId = 2,
	prize = 4,
	fragmentPlanId = 1,
	costScore = 3
}
local dataList = {
	{
		1,
		1,
		15,
		"8:1:200000"
	},
	{
		1,
		2,
		15,
		"8:1:200000"
	},
	{
		1,
		3,
		15,
		"8:1:200000"
	},
	{
		1,
		4,
		15,
		"8:1:200000"
	},
	{
		1,
		5,
		15,
		"8:1:200000"
	}
}
local t_colorful_lantern_fragment = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_colorful_lantern_fragment.dataList = dataList

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

return t_colorful_lantern_fragment
