-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_contest_fans_group.lua

module("logicconfig.config.t_goddess_contest_fans_group", package.seeall)

local title = {
	deputyDirectorNums = 9,
	limitNums = 7,
	directorConversionRate = 11,
	deputyDirectorConversionRate = 12,
	campaignNums = 8,
	eliteConversionRate = 13,
	fansGroupId = 2,
	fansGroupGoddess = 4,
	fansGroupName = 3,
	fansGroupDeclaration = 5,
	eliteNums = 10,
	hudWord = 14,
	fansGroupPlanId = 1,
	proactiveNums = 6
}
local dataList = {
	{
		1,
		1,
		"花",
		{
			13006,
			1100202,
			1032401,
			1031401,
			1600401,
			1014702
		},
		"欢迎加入花组，一起为女神投票吧！",
		10000,
		50000,
		1000,
		3,
		10,
		3,
		3,
		2,
		"花"
	},
	{
		1,
		2,
		"月",
		{
			1600601,
			1601001,
			1601101,
			16008,
			1401101,
			1002701
		},
		"欢迎加入月组，一起为女神投票吧！",
		10000,
		50000,
		1000,
		3,
		10,
		3,
		3,
		2,
		"月"
	},
	{
		1,
		3,
		"星",
		{
			14001,
			1009702,
			1600102,
			1200401,
			1032601,
			1033001
		},
		"欢迎加入星组，一起为女神投票吧！",
		10000,
		50000,
		1000,
		3,
		10,
		3,
		3,
		2,
		"星"
	},
	{
		1,
		4,
		"宙",
		{
			15013,
			1200501,
			1031301,
			1700201,
			1600501,
			1700301
		},
		"欢迎加入宙组，一起为女神投票吧！",
		10000,
		50000,
		1000,
		3,
		10,
		3,
		3,
		2,
		"宙"
	},
	{
		2,
		1,
		"权杖",
		{
			1401602,
			1602202,
			12009,
			12005,
			16014,
			1031402
		},
		"欢迎加入权杖组，一起为女神投票吧！",
		10000,
		50000,
		1000,
		3,
		10,
		3,
		3,
		2,
		"权杖"
	},
	{
		2,
		2,
		"宝剑",
		{
			1101103,
			16019,
			13006,
			1402201,
			15013,
			1300801
		},
		"欢迎加入宝剑组，一起为女神投票吧！",
		10000,
		50000,
		1000,
		3,
		10,
		3,
		3,
		2,
		"宝剑"
	},
	{
		2,
		3,
		"星币",
		{
			1402301,
			1201602,
			1601602,
			1401302,
			1701502,
			10147
		},
		"欢迎加入星币组，一起为女神投票吧！",
		10000,
		50000,
		1000,
		3,
		10,
		3,
		3,
		2,
		"星币"
	},
	{
		2,
		4,
		"圣杯",
		{
			1800101,
			14020,
			16006,
			1502001,
			1401402,
			1701402
		},
		"欢迎加入圣杯组，一起为女神投票吧！",
		10000,
		50000,
		1000,
		3,
		10,
		3,
		3,
		2,
		"圣杯"
	}
}
local t_goddess_contest_fans_group = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_goddess_contest_fans_group.dataList = dataList

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

return t_goddess_contest_fans_group
