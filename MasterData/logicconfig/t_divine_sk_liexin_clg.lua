-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_sk_liexin_clg.lua

module("logicconfig.config.t_divine_sk_liexin_clg", package.seeall)

local title = {
	stagePlanId = 3,
	name = 2,
	emptyPosAddTag = 9,
	jumpTo = 12,
	reliveBuffSignId = 10,
	tagReliveBuffId = 8,
	relivePrizePlanId = 7,
	collectRaceIds = 5,
	raceId = 11,
	passStagePrizePlanId = 6,
	activityId = 1,
	collectBuffPlanId = 4
}
local dataList = {
	{
		478001,
		"神曜圣骑烈心-普通挑战",
		1,
		1,
		{
			11029,
			14035,
			12032,
			13024,
			15035
		},
		1,
		2,
		20064001,
		{
			{
				-1,
				0
			},
			{
				1,
				0
			},
			{
				0,
				-1
			},
			{
				0,
				1
			}
		},
		20064003,
		12031,
		{
			"func#618#12031",
			"ui#lottery",
			"mibao#shengqiyangcheng",
			"func#545#22"
		}
	},
	{
		478002,
		"神曜圣骑烈心-系统属性",
		1,
		0,
		nil,
		0,
		0,
		20064001,
		{
			{
				-1,
				0
			},
			{
				1,
				0
			},
			{
				0,
				-1
			},
			{
				0,
				1
			}
		},
		20064003,
		12031,
		{
			"func#618#12031",
			"ui#lottery",
			"mibao#shengqiyangcheng",
			"func#545#22"
		}
	},
	{
		478003,
		"神曜圣骑烈心-背包属性",
		1,
		0,
		nil,
		0,
		0,
		20064001,
		{
			{
				-1,
				0
			},
			{
				1,
				0
			},
			{
				0,
				-1
			},
			{
				0,
				1
			}
		},
		20064003,
		12031,
		{
			"func#618#12031",
			"ui#lottery",
			"mibao#shengqiyangcheng",
			"func#545#22"
		}
	}
}
local t_divine_sk_liexin_clg = {
	[478001] = dataList[1],
	[478002] = dataList[2],
	[478003] = dataList[3]
}

t_divine_sk_liexin_clg.dataList = dataList

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

return t_divine_sk_liexin_clg
