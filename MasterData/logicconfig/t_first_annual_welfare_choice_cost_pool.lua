-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_first_annual_welfare_choice_cost_pool.lua

module("logicconfig.config.t_first_annual_welfare_choice_cost_pool", package.seeall)

local title = {
	index = 2,
	cost = 4,
	defineId = 3,
	poolId = 1
}
local dataList = {
	{
		10011,
		1,
		601,
		"204:250501:59"
	},
	{
		10011,
		2,
		602,
		"204:250501:59"
	},
	{
		10011,
		3,
		603,
		"204:250501:59"
	},
	{
		10011,
		4,
		604,
		"204:250501:59"
	},
	{
		10011,
		5,
		605,
		"204:250501:59"
	},
	{
		10011,
		6,
		606,
		"204:250501:59"
	},
	{
		10011,
		7,
		607,
		"204:250501:59"
	},
	{
		10011,
		8,
		608,
		"204:250501:59"
	},
	{
		10011,
		9,
		609,
		"204:250501:59"
	},
	{
		10011,
		10,
		610,
		"204:250501:99"
	}
}
local t_first_annual_welfare_choice_cost_pool = {
	[10011] = {
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

t_first_annual_welfare_choice_cost_pool.dataList = dataList

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

return t_first_annual_welfare_choice_cost_pool
