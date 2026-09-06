-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_run_game_label.lua

module("logicconfig.config.t_run_game_label", package.seeall)

local title = {
	labelId = 2,
	labelPlanId = 1,
	unLockCost = 3,
	name = 5,
	pos = 7,
	prize = 4,
	nameUnlock = 6
}
local dataList = {
	{
		1,
		1,
		"10:228002:80",
		"4:36:10#4:30006:20",
		"伤害刮痧",
		"溅射伤害",
		{
			50,
			-210
		}
	},
	{
		1,
		2,
		"10:228002:80",
		"4:111:10#4:30006:20",
		"仓库管理员",
		"降低气势",
		{
			-315,
			7
		}
	},
	{
		1,
		3,
		"10:228002:80",
		"4:400002:100#4:30006:20",
		"软弱无力",
		"高额护盾",
		{
			292,
			-95
		}
	},
	{
		1,
		4,
		"10:228002:80",
		"4:90312:2#4:30006:20",
		"曾经的神",
		"低血量增伤",
		{
			453,
			7
		}
	},
	{
		1,
		5,
		"10:228002:80",
		"4:12102:5#4:30006:20",
		"退环境",
		"队友免疫",
		{
			-200,
			-95
		}
	}
}
local t_run_game_label = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_run_game_label.dataList = dataList

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

return t_run_game_label
