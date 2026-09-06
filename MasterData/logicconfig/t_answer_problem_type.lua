-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_answer_problem_type.lua

module("logicconfig.config.t_answer_problem_type", package.seeall)

local title = {
	typePlanId = 1,
	problemPlanId = 4,
	skinId = 5,
	plotPlanId = 3,
	typeId = 2,
	skinIdList = 6
}
local dataList = {
	{
		1,
		1,
		1,
		1,
		0
	},
	{
		2,
		1,
		2,
		1,
		1100202,
		{
			13006,
			1100202,
			1032401,
			1031401,
			1600401,
			1014702
		}
	},
	{
		2,
		2,
		3,
		1,
		1601001,
		{
			1600601,
			1601001,
			1601101,
			16008,
			1401101,
			1002701
		}
	},
	{
		2,
		3,
		4,
		1,
		1600102,
		{
			14001,
			1009701,
			1600102,
			1200401,
			1032601,
			1033001
		}
	},
	{
		2,
		4,
		5,
		1,
		1700201,
		{
			15013,
			12005,
			1031301,
			1700201,
			1600501,
			1700301
		}
	}
}
local t_answer_problem_type = {
	{
		dataList[1]
	},
	{
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_answer_problem_type.dataList = dataList

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

return t_answer_problem_type
