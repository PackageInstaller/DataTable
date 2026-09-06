-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_medal.lua

module("logicconfig.config.t_family_medal", package.seeall)

local title = {
	height = 7,
	labelType = 8,
	name = 3,
	notAvailable = 10,
	sourceId = 4,
	desc = 5,
	id = 1,
	icon = 9,
	width = 6,
	level = 2
}
local dataList = {
	{
		1,
		1,
		"护卫团",
		1,
		"",
		2,
		2,
		4,
		"jiazu_xz_04",
		0
	},
	{
		2,
		2,
		"警卫团",
		2,
		"",
		3,
		3,
		4,
		"jiazu_xz_05",
		0
	},
	{
		3,
		3,
		"精锐护卫团",
		3,
		"",
		4,
		4,
		4,
		"jiazu_xz_06",
		0
	},
	{
		4,
		1,
		"剿灭团",
		4,
		"",
		2,
		2,
		4,
		"jiazu_xz_01",
		0
	},
	{
		5,
		2,
		"剿灭精英",
		5,
		"",
		3,
		3,
		4,
		"jiazu_xz_02",
		0
	},
	{
		6,
		3,
		"剿灭王者",
		6,
		"",
		4,
		4,
		4,
		"jiazu_xz_03",
		0
	},
	{
		7,
		1,
		"集结新兵",
		7,
		"",
		2,
		2,
		6,
		"jiazu_xz_07",
		1
	},
	{
		8,
		1,
		"集结斗士",
		8,
		"",
		2,
		2,
		6,
		"jiazu_xz_08",
		1
	},
	{
		9,
		2,
		"集结精锐",
		9,
		"",
		3,
		3,
		6,
		"jiazu_xz_09",
		1
	},
	{
		10,
		2,
		"集结王团",
		10,
		"",
		3,
		3,
		6,
		"jiazu_xz_10",
		1
	},
	{
		11,
		3,
		"集结圣兵团",
		11,
		"",
		4,
		4,
		6,
		"jiazu_xz_11",
		1
	},
	{
		12,
		3,
		"赤炎龙神团",
		12,
		"",
		4,
		4,
		5,
		"jiazu_xz_15",
		0
	},
	{
		13,
		2,
		"赤炎龙团",
		13,
		"",
		3,
		3,
		5,
		"jiazu_xz_14",
		0
	},
	{
		14,
		2,
		"炎龙兵团",
		14,
		"",
		3,
		3,
		5,
		"jiazu_xz_13",
		0
	},
	{
		15,
		1,
		"炎兵团",
		15,
		"",
		2,
		2,
		5,
		"jiazu_xz_12",
		0
	}
}
local t_family_medal = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15]
}

t_family_medal.dataList = dataList

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

return t_family_medal
