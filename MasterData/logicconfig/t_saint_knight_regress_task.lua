-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_regress_task.lua

module("logicconfig.config.t_saint_knight_regress_task", package.seeall)

local title = {
	title = 5,
	type = 3,
	id = 2,
	maxProgress = 4,
	activityId = 1,
	desc = 6
}
local dataList = {
	{
		483001,
		1,
		43,
		1,
		"获得精灵",
		"获得精灵：神曜圣骑·审判光轮"
	},
	{
		483001,
		2,
		43,
		1,
		"获得精灵",
		"获得精灵：神曜圣骑·苍穹天闪"
	},
	{
		483001,
		3,
		43,
		1,
		"获得精灵",
		"获得精灵：神曜圣骑·红莲烈心"
	},
	{
		483001,
		4,
		43,
		1,
		"获得精灵",
		"获得精灵：神曜圣骑·万象迷踪"
	},
	{
		483001,
		5,
		43,
		1,
		"获得精灵",
		"获得精灵：神曜圣骑·怒麟炎神"
	},
	{
		483001,
		6,
		43,
		1,
		"获得精灵",
		"获得精灵：神曜圣骑·疾刃阎罗"
	},
	{
		483001,
		7,
		1,
		1,
		"登录游戏",
		"累计登录1天"
	},
	{
		483001,
		8,
		1,
		2,
		"登录游戏",
		"累计登录2天"
	},
	{
		483001,
		9,
		1,
		3,
		"登录游戏",
		"累计登录3天"
	}
}
local t_saint_knight_regress_task = {
	[483001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_saint_knight_regress_task.dataList = dataList

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

return t_saint_knight_regress_task
