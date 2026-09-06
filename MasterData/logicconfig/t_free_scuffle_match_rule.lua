-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_free_scuffle_match_rule.lua

module("logicconfig.config.t_free_scuffle_match_rule", package.seeall)

local title = {
	scoreRange = 3,
	activityId = 1,
	ruleId = 2
}
local dataList = {
	{
		489001,
		1,
		{
			-100,
			100
		}
	},
	{
		489001,
		2,
		{
			-200,
			200
		}
	},
	{
		489001,
		3,
		{
			-300,
			300
		}
	},
	{
		489001,
		4,
		{
			-500,
			500
		}
	},
	{
		489001,
		5,
		{
			-1000,
			1000
		}
	},
	{
		489002,
		1,
		{
			-100,
			100
		}
	},
	{
		489002,
		2,
		{
			-200,
			200
		}
	},
	{
		489002,
		3,
		{
			-300,
			300
		}
	},
	{
		489002,
		4,
		{
			-500,
			500
		}
	},
	{
		489002,
		5,
		{
			-1000,
			1000
		}
	},
	{
		489003,
		1,
		{
			-100,
			100
		}
	},
	{
		489003,
		2,
		{
			-200,
			200
		}
	},
	{
		489003,
		3,
		{
			-300,
			300
		}
	},
	{
		489003,
		4,
		{
			-500,
			500
		}
	},
	{
		489003,
		5,
		{
			-1000,
			1000
		}
	}
}
local t_free_scuffle_match_rule = {
	[489001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[489002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[489003] = {
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_free_scuffle_match_rule.dataList = dataList

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

return t_free_scuffle_match_rule
