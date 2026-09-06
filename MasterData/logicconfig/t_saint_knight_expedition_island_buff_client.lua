-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_expedition_island_buff_client.lua

module("logicconfig.config.t_saint_knight_expedition_island_buff_client", package.seeall)

local title = {
	buffDesc = 4,
	islandBuffId = 2,
	activityId = 1,
	skinId = 3
}
local dataList = {
	{
		481001,
		1,
		11029,
		"普攻：伤害倍率+10%，气势增伤比例提高5%\r\n超杀：技能倍率+15%，气势增伤比例提高10%"
	},
	{
		481001,
		2,
		14035,
		"普攻：伤害倍率+10%，攻击后额外获得一层光轮\r\n超杀：技能倍率+20%，伤害降低比例提高10%"
	},
	{
		481001,
		3,
		13024,
		"普攻：伤害倍率+10%，攻击后为自身及己阵生命最低的精灵恢复10%最大生命值\r\n超杀：技能倍率+20%，攻击后为己阵全体精灵恢复10%最大生命值"
	},
	{
		481001,
		4,
		12031,
		"普攻：伤害倍率+10%，气势额外提高10点\r\n超杀：技能倍率+20%，每消耗一朵红莲造成的伤害倍率提高20%"
	},
	{
		481001,
		5,
		12032,
		"普攻：伤害倍率+10%，自身每有一层灼烧，伤害+5%\r\n超杀：技能倍率+15%，复活时恢复的生命比例提高40%"
	},
	{
		481001,
		6,
		15035,
		"普攻：伤害倍率+10%，全属性额外减少5%\r\n超杀：技能倍率+15%，赎死精灵获得的气势提高30点"
	}
}
local t_saint_knight_expedition_island_buff_client = {
	[481001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_saint_knight_expedition_island_buff_client.dataList = dataList

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

return t_saint_knight_expedition_island_buff_client
