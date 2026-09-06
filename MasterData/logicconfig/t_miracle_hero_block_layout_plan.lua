-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miracle_hero_block_layout_plan.lua

module("logicconfig.config.t_miracle_hero_block_layout_plan", package.seeall)

local title = {
	layoutId = 3,
	elementNum = 2,
	planId = 1
}
local dataList = {
	{
		1,
		5,
		{
			1
		}
	},
	{
		2,
		5,
		{
			2,
			3,
			4,
			5,
			6
		}
	},
	{
		3,
		5,
		{
			7,
			8
		}
	},
	{
		4,
		5,
		{
			9
		}
	},
	{
		5,
		5,
		{
			10,
			11,
			12,
			13,
			14
		}
	},
	{
		6,
		5,
		{
			15,
			16
		}
	}
}
local t_miracle_hero_block_layout_plan = {
	{
		[5] = dataList[1]
	},
	{
		[5] = dataList[2]
	},
	{
		[5] = dataList[3]
	},
	{
		[5] = dataList[4]
	},
	{
		[5] = dataList[5]
	},
	{
		[5] = dataList[6]
	}
}

t_miracle_hero_block_layout_plan.dataList = dataList

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

return t_miracle_hero_block_layout_plan
