-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_xiuer_all_destroy_mode.lua

module("logicconfig.config.t_dragon_xiuer_all_destroy_mode", package.seeall)

local title = {
	stageId = 2,
	name = 6,
	prize = 5,
	teams = 4,
	activityId = 1,
	scoreType = 3
}
local dataList = {
	{
		323001,
		1,
		"ActiveCount",
		{
			1001,
			1002,
			1003
		},
		"4:409:30",
		"消灭众敌"
	},
	{
		323001,
		2,
		"CircleCount",
		{
			1004,
			1005,
			1006
		},
		"4:409:30",
		"极致对抗"
	},
	{
		323001,
		3,
		"RoundCount",
		{
			1007,
			1008,
			1009
		},
		"4:409:30",
		"绝对公平"
	},
	{
		323002,
		1,
		"ActiveCount",
		{
			2001,
			2002,
			2003
		},
		"4:386:30",
		"消灭众敌"
	},
	{
		323002,
		2,
		"CircleCount",
		{
			2004,
			2005,
			2006
		},
		"4:386:30",
		"极致对抗"
	},
	{
		323002,
		3,
		"RoundCount",
		{
			2007,
			2008,
			2009
		},
		"4:386:30",
		"绝对公平"
	}
}
local t_dragon_xiuer_all_destroy_mode = {
	[323001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[323002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_dragon_xiuer_all_destroy_mode.dataList = dataList

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

return t_dragon_xiuer_all_destroy_mode
