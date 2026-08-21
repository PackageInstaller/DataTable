-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_living_facilities_mark.lua

module("logic.config.t_house_living_facilities_mark", package.seeall)

local title = {
	condition = 5,
	name = 3,
	id = 1,
	icon = 4,
	markType = 2,
	desc = 6
}
local dataList = {
	{
		1,
		1,
		"男生宿舍",
		"rc_nan",
		1,
		"男生宿舍1"
	},
	{
		2,
		1,
		"女生宿舍",
		"rc_nv",
		0,
		"女生宿舍1"
	},
	{
		3,
		2,
		"OAD联合会",
		"camp_logo_301",
		1,
		"OAD联合会1"
	},
	{
		4,
		2,
		"伊甸之树俱乐部",
		"camp_logo_302",
		2,
		"伊甸之树俱乐部1"
	},
	{
		5,
		2,
		"真理兄弟会",
		"camp_logo_303",
		3,
		"真理兄弟会1"
	},
	{
		6,
		2,
		"白银黎明社团",
		"camp_logo_304",
		4,
		"白银黎明社团1"
	},
	{
		7,
		2,
		"诺亚方舟",
		"camp_logo_305",
		5,
		"诺亚方舟1"
	},
	{
		8,
		2,
		"星空教会宿舍",
		"camp_logo_306",
		6,
		"星空教会宿舍1"
	},
	{
		9,
		2,
		"水滴结社",
		"camp_logo_307",
		7,
		"水滴结社1"
	}
}
local t_house_living_facilities_mark = {}

t_house_living_facilities_mark.dataList = dataList

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
	t_house_living_facilities_mark[v[1]] = v

	setmetatable(v, mt)
end

return t_house_living_facilities_mark
