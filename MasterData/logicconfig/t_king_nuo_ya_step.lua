-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_nuo_ya_step.lua

module("logicconfig.config.t_king_nuo_ya_step", package.seeall)

local title = {
	stages = 4,
	prize = 5,
	type = 2,
	stepId = 3,
	activityId = 1
}
local dataList = {
	{
		321001,
		1,
		1,
		{
			1,
			2
		},
		"4:407:10"
	},
	{
		321001,
		1,
		2,
		{
			3,
			4,
			5
		},
		"4:407:20"
	},
	{
		321001,
		1,
		3,
		{
			6,
			7,
			8,
			9
		},
		"4:407:30"
	},
	{
		321001,
		2,
		1,
		{
			10,
			11
		},
		"4:407:10"
	},
	{
		321001,
		2,
		2,
		{
			12,
			13,
			14
		},
		"4:407:20"
	},
	{
		321001,
		2,
		3,
		{
			15,
			16,
			17,
			18
		},
		"4:407:30"
	}
}
local t_king_nuo_ya_step = {
	[321001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		}
	}
}

t_king_nuo_ya_step.dataList = dataList

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

return t_king_nuo_ya_step
