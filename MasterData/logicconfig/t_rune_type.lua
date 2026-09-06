-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rune_type.lua

module("logicconfig.config.t_rune_type", package.seeall)

local title = {
	runeType = 1,
	name = 2
}
local dataList = {
	{
		1,
		"生命"
	},
	{
		2,
		"物攻"
	},
	{
		3,
		"魔攻"
	},
	{
		4,
		"超攻"
	},
	{
		5,
		"物防"
	},
	{
		6,
		"魔防"
	},
	{
		7,
		"超防"
	},
	{
		8,
		"速度"
	},
	{
		9,
		"命中"
	},
	{
		10,
		"闪避"
	},
	{
		11,
		"破击"
	},
	{
		12,
		"格挡"
	},
	{
		13,
		"暴击"
	},
	{
		14,
		"防暴"
	},
	{
		15,
		"攻击"
	}
}
local t_rune_type = {
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

t_rune_type.dataList = dataList

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

return t_rune_type
