-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_year_pray_wishing_tab.lua

module("logicconfig.config.t_new_year_pray_wishing_tab", package.seeall)

local title = {
	name = 3,
	wishingPlanId = 1,
	lanternIdList = 4,
	tabId = 2
}
local dataList = {
	{
		1,
		1,
		"小雨",
		{
			1,
			2,
			3
		}
	},
	{
		1,
		2,
		"中雨",
		{
			4,
			5,
			6
		}
	},
	{
		1,
		3,
		"大雨",
		{
			7,
			8,
			9
		}
	},
	{
		1,
		4,
		"多云",
		{
			10,
			11,
			12
		}
	},
	{
		1,
		5,
		"小雪",
		{
			13,
			14,
			15
		}
	},
	{
		1,
		6,
		"中雪",
		{
			16,
			17,
			18
		}
	},
	{
		1,
		7,
		"大雪",
		{
			19,
			20,
			21
		}
	},
	{
		1,
		8,
		"晴",
		{
			22,
			23,
			24
		}
	},
	{
		1,
		9,
		"阴",
		{
			25,
			26,
			27
		}
	}
}
local t_new_year_pray_wishing_tab = {
	{
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

t_new_year_pray_wishing_tab.dataList = dataList

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

return t_new_year_pray_wishing_tab
