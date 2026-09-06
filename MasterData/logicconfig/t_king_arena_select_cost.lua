-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_arena_select_cost.lua

module("logicconfig.config.t_king_arena_select_cost", package.seeall)

local title = {
	cost = 3,
	selectCostPlanId = 1,
	times = 2
}
local dataList = {
	{
		1,
		1,
		""
	},
	{
		1,
		2,
		""
	},
	{
		1,
		3,
		"105:6101:100"
	},
	{
		1,
		4,
		"105:6101:200"
	},
	{
		1,
		5,
		"105:6101:300"
	},
	{
		1,
		6,
		"105:6101:500"
	},
	{
		1,
		7,
		"204:205:10"
	},
	{
		1,
		8,
		"204:205:10"
	},
	{
		1,
		9,
		"204:205:10"
	},
	{
		1,
		10,
		"204:205:10"
	}
}
local t_king_arena_select_cost = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_king_arena_select_cost.dataList = dataList

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

return t_king_arena_select_cost
