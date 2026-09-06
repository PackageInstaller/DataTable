-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_medal_source.lua

module("logicconfig.config.t_family_medal_source", package.seeall)

local title = {
	type = 2,
	desc = 3,
	progress = 4,
	sourceId = 1
}
local dataList = {
	{
		1,
		1,
		"家族累计完成420次护送",
		420
	},
	{
		2,
		1,
		"家族累计完成1800次护送",
		1800
	},
	{
		3,
		1,
		"家族累计完成5400次护送",
		5400
	},
	{
		4,
		4,
		"累计挑战家族围剿5次",
		5
	},
	{
		5,
		4,
		"累计挑战家族围剿10次",
		10
	},
	{
		6,
		4,
		"累计挑战家族围剿30次",
		30
	},
	{
		7,
		3,
		"家族集结令中获得",
		1
	},
	{
		8,
		3,
		"家族集结令中获得",
		1
	},
	{
		9,
		3,
		"家族集结令中获得",
		1
	},
	{
		10,
		3,
		"家族集结令中获得",
		1
	},
	{
		11,
		3,
		"家族集结令中获得",
		1
	},
	{
		12,
		3,
		"家族-神柱之战中达到指定段位获得",
		1
	},
	{
		13,
		3,
		"家族-神柱之战中达到指定段位获得",
		1
	},
	{
		14,
		3,
		"家族-神柱之战中达到指定段位获得",
		1
	},
	{
		15,
		3,
		"家族-神柱之战中达到指定段位获得",
		1
	}
}
local t_family_medal_source = {
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

t_family_medal_source.dataList = dataList

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

return t_family_medal_source
