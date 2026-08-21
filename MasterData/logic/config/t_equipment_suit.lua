-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_equipment_suit.lua

module("logic.config.t_equipment_suit", package.seeall)

local title = {
	isFilter = 6,
	name = 2,
	id = 1,
	icon = 4,
	suitEffect = 3,
	sort = 5
}
local dataList = {
	{
		1001,
		"规律的疯狂",
		1510011,
		"1020001",
		1,
		1
	},
	{
		1002,
		"虚数的记录者",
		1510021,
		"1020002",
		4,
		1
	},
	{
		1003,
		"第三种旋律",
		1510031,
		"1020003",
		7,
		1
	},
	{
		1004,
		"D.R.O.P",
		1545012,
		"1020004",
		5,
		1
	},
	{
		1005,
		"遗忘录音",
		1510041,
		"1020005",
		2,
		1
	},
	{
		1006,
		"人无法独自飞行",
		1565012,
		"1020006",
		8,
		1
	},
	{
		1007,
		"观星者",
		1515022,
		"1020007",
		6,
		1
	},
	{
		1008,
		"虹色跃迁",
		1525022,
		"1020008",
		10,
		0
	},
	{
		1009,
		"直达彼端",
		1535022,
		"1020009",
		9,
		1
	},
	{
		1010,
		"青蛙狂想曲",
		1510051,
		"1020010",
		3,
		1
	}
}
local t_equipment_suit = {}

t_equipment_suit.dataList = dataList

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
	t_equipment_suit[v[1]] = v

	setmetatable(v, mt)
end

return t_equipment_suit
