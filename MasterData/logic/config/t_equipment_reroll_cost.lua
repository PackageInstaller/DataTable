-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_equipment_reroll_cost.lua

module("logic.config.t_equipment_reroll_cost", package.seeall)

local title = {
	costGoldZoom = 2,
	costItems = 3,
	times = 1
}
local dataList = {
	{
		1,
		2.4,
		"{1100014:100}"
	},
	{
		2,
		2.4,
		"{1100014:200}"
	},
	{
		3,
		2.4,
		"{1100014:300}"
	},
	{
		4,
		2.4,
		"{1100014:400}"
	},
	{
		5,
		2.4,
		"{1100014:500}"
	},
	{
		6,
		4.8,
		"{1100014:600}"
	},
	{
		7,
		4.8,
		"{1100014:700}"
	},
	{
		8,
		4.8,
		"{1100014:1000}"
	},
	{
		9,
		7.2,
		"{1100014:1500}"
	},
	{
		10,
		7.2,
		"{1100014:2000}"
	},
	{
		11,
		7.2,
		"{1100014:2500}"
	},
	{
		12,
		9.6,
		"{1100014:3000}"
	},
	{
		13,
		9.6,
		"{1100014:3500}"
	},
	{
		14,
		9.6,
		"{1100014:4000}"
	},
	{
		15,
		12,
		"{1100014:4500}"
	},
	{
		16,
		12,
		"{1100014:5000}"
	},
	{
		17,
		12,
		"{1100014:5500}"
	},
	{
		18,
		19.2,
		"{1100014:6000}"
	},
	{
		19,
		19.2,
		"{1100014:6500}"
	},
	{
		20,
		19.2,
		"{1100014:7000}"
	},
	{
		21,
		36,
		"{1100014:7500}"
	},
	{
		22,
		36,
		"{1100014:8000}"
	},
	{
		23,
		36,
		"{1100014:8500}"
	},
	{
		24,
		48,
		"{1100014:9000}"
	},
	{
		25,
		72,
		"{1100014:9500}"
	},
	{
		26,
		72,
		"{1100014:10000}"
	},
	{
		27,
		72,
		"{1100014:10000}"
	},
	{
		28,
		72,
		"{1100014:10000}"
	},
	{
		29,
		72,
		"{1100014:10000}"
	},
	{
		30,
		72,
		"{1100014:10000}"
	}
}
local t_equipment_reroll_cost = {}

t_equipment_reroll_cost.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_equipment_reroll_cost[v[1]] = v

	setmetatable(v, mt)
end

return t_equipment_reroll_cost
