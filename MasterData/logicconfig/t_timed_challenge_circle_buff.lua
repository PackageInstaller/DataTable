-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_circle_buff.lua

module("logicconfig.config.t_timed_challenge_circle_buff", package.seeall)

local title = {
	desc = 3,
	name = 2,
	level = 1
}
local dataList = {
	{
		1,
		"简易盔甲",
		"生命+5%"
	},
	{
		2,
		"长剑",
		"攻击+4%"
	},
	{
		3,
		"木盾",
		"物防+8%"
	},
	{
		4,
		"小斗篷",
		"魔防+8%"
	},
	{
		5,
		"匕首",
		"暴击率+10%"
	},
	{
		6,
		"海洋护符",
		"水系精灵生命+9%"
	},
	{
		7,
		"水之刃",
		"水系精灵攻击+9%"
	},
	{
		8,
		"短剑",
		"物理伤害提升8%"
	},
	{
		9,
		"火焰护符",
		"火系精灵生命+9%"
	},
	{
		10,
		"火之刃",
		"火系精灵攻击+9%"
	},
	{
		11,
		"魔典",
		"魔法伤害提升8%"
	},
	{
		12,
		"森林护符",
		"草系精灵生命+9%"
	}
}
local t_timed_challenge_circle_buff = {
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
	dataList[12]
}

t_timed_challenge_circle_buff.dataList = dataList

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

return t_timed_challenge_circle_buff
