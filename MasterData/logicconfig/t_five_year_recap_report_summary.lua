-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_five_year_recap_report_summary.lua

module("logicconfig.config.t_five_year_recap_report_summary", package.seeall)

local title = {
	barId = 3,
	name = 5,
	partId = 2,
	value = 6,
	index = 4,
	activityId = 1
}
local dataList = {
	{
		586001,
		1,
		1,
		1,
		"当前战力",
		"DataId$13"
	},
	{
		586001,
		1,
		1,
		2,
		"战力超越",
		"RankRatio$3#13"
	},
	{
		586001,
		1,
		2,
		1,
		"累计战斗",
		"DataId$42"
	},
	{
		586001,
		1,
		2,
		2,
		"参与挑战",
		"DataId$43"
	},
	{
		586001,
		2,
		1,
		1,
		"经典排位传说次数",
		"DataId$55"
	},
	{
		586001,
		2,
		1,
		2,
		"极限排位传说次数",
		"DataId$57"
	},
	{
		586001,
		2,
		1,
		3,
		"3V3冠军次数",
		"DataId$46"
	},
	{
		586001,
		2,
		1,
		4,
		"经典排位最高段位",
		"DataId$54"
	},
	{
		586001,
		2,
		1,
		5,
		"极限排位最高段位",
		"DataId$56"
	},
	{
		586001,
		2,
		1,
		6,
		"竞技场最高排名",
		"DataId$44"
	},
	{
		586001,
		2,
		1,
		7,
		"3V3最高排名",
		"DataId$45"
	},
	{
		586001,
		2,
		2,
		1,
		"少年竞技王冠军次数",
		"DataId$48"
	},
	{
		586001,
		2,
		2,
		2,
		"战皇次数",
		"DataId$50"
	},
	{
		586001,
		2,
		2,
		3,
		"巅峰赛冠军次数",
		"DataId$53"
	},
	{
		586001,
		2,
		2,
		4,
		"少年竞技王最高排名",
		"DataId$47"
	},
	{
		586001,
		2,
		2,
		5,
		"王者竞技场最高排名",
		"DataId$49"
	},
	{
		586001,
		2,
		2,
		6,
		"巅峰赛最高排名",
		"DataId$52"
	}
}
local t_five_year_recap_report_summary = {
	[586001] = {
		{
			{
				dataList[1],
				dataList[2]
			},
			{
				dataList[3],
				dataList[4]
			}
		},
		{
			{
				dataList[5],
				dataList[6],
				dataList[7],
				dataList[8],
				dataList[9],
				dataList[10],
				dataList[11]
			},
			{
				dataList[12],
				dataList[13],
				dataList[14],
				dataList[15],
				dataList[16],
				dataList[17]
			}
		}
	}
}

t_five_year_recap_report_summary.dataList = dataList

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

return t_five_year_recap_report_summary
