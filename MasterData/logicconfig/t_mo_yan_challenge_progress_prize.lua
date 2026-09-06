-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mo_yan_challenge_progress_prize.lua

module("logicconfig.config.t_mo_yan_challenge_progress_prize", package.seeall)

local title = {
	gain = 5,
	name = 4,
	id = 2,
	planId = 1,
	needScore = 3
}
local dataList = {
	{
		1,
		1,
		100,
		"经验扫荡券",
		"4:11:60"
	},
	{
		1,
		2,
		200,
		"金币扫荡券",
		"4:12:60"
	},
	{
		1,
		3,
		300,
		"装备扫荡券",
		"4:13:60"
	},
	{
		1,
		4,
		500,
		"星神扫荡券",
		"4:14:60"
	},
	{
		1,
		5,
		700,
		"契约灵石",
		"4:120001:10"
	},
	{
		1,
		6,
		900,
		"高级藏宝图",
		"4:602:2"
	},
	{
		1,
		7,
		1100,
		"契约灵石",
		"4:120001:10"
	},
	{
		1,
		8,
		1400,
		"橙色装备自选箱",
		"4:90004:1"
	},
	{
		1,
		9,
		1700,
		"契约灵石",
		"4:120001:10"
	},
	{
		1,
		10,
		2000,
		"金色星神宝箱",
		"4:41004:1"
	},
	{
		1,
		11,
		2500,
		"女皇·末炎",
		"100:10097:1:1#62:59:1"
	}
}
local t_mo_yan_challenge_progress_prize = {
	{
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
		dataList[11]
	}
}

t_mo_yan_challenge_progress_prize.dataList = dataList

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

return t_mo_yan_challenge_progress_prize
