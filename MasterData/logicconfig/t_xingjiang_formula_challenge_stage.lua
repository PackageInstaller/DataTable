-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xingjiang_formula_challenge_stage.lua

module("logicconfig.config.t_xingjiang_formula_challenge_stage", package.seeall)

local title = {
	stageId = 2,
	prize = 3,
	challengePlanId = 1
}
local dataList = {
	{
		1,
		1,
		"4:136:1"
	},
	{
		1,
		2,
		"4:136:1"
	},
	{
		1,
		3,
		"4:136:2"
	},
	{
		1,
		4,
		"4:136:2"
	},
	{
		1,
		5,
		"4:136:2"
	},
	{
		1,
		6,
		"4:136:6"
	},
	{
		2,
		1,
		"4:510402:4"
	},
	{
		2,
		2,
		"4:510402:4"
	},
	{
		2,
		3,
		"4:510402:4"
	},
	{
		2,
		4,
		"4:510402:4"
	},
	{
		2,
		5,
		"4:510402:4"
	}
}
local t_xingjiang_formula_challenge_stage = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11]
	}
}

t_xingjiang_formula_challenge_stage.dataList = dataList

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

return t_xingjiang_formula_challenge_stage
