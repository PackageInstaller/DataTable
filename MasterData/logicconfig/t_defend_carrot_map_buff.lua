-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_defend_carrot_map_buff.lua

module("logicconfig.config.t_defend_carrot_map_buff", package.seeall)

local title = {
	weaponId = 3,
	background = 2,
	buffDesc = 6,
	bulletBuffids = 5,
	mapBuffId = 1,
	weaponBuffids = 4
}
local dataList = {
	{
		1,
		"#ffffff",
		7,
		"52",
		"",
		"提高攻击、提高攻速"
	},
	{
		2,
		"#ffffff",
		8,
		"53",
		"",
		"提高攻击、提高攻速"
	},
	{
		3,
		"#ffffff",
		1,
		"54",
		"",
		"提高攻击"
	},
	{
		4,
		"#ffffff",
		5,
		"",
		"55",
		"延长暂停时间"
	},
	{
		5,
		"#ffffff",
		10,
		"",
		"56",
		"增加爆炸伤害"
	},
	{
		6,
		"#ffffff",
		5,
		"",
		"55",
		"延长暂停时间"
	},
	{
		7,
		"#ffffff",
		10,
		"",
		"56",
		"增加爆炸伤害"
	},
	{
		8,
		"#ffffff",
		6,
		"57",
		"",
		"提高攻击、提高攻速"
	},
	{
		9,
		"#ffffff",
		9,
		"21",
		"",
		"翻倍攻击所需次数减少"
	},
	{
		10,
		"#ffffff",
		6,
		"57",
		"",
		"提高攻击、提高攻速"
	},
	{
		11,
		"#ffffff",
		9,
		"21",
		"",
		"翻倍攻击所需次数减少"
	},
	{
		12,
		"#ffffff",
		2,
		"",
		"58",
		"延长灼烧时间"
	},
	{
		13,
		"#ffffff",
		3,
		"",
		"19",
		"增加弹射次数"
	}
}
local t_defend_carrot_map_buff = {
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
	dataList[13]
}

t_defend_carrot_map_buff.dataList = dataList

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

return t_defend_carrot_map_buff
