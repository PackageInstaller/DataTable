-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_xiuer_info.lua

module("logicconfig.config.t_dragon_xiuer_info", package.seeall)

local title = {
	raceId = 5,
	allDestroyPrize = 3,
	jumpTo = 2,
	soulPrize = 4,
	activityId = 1
}
local dataList = {
	{
		323001,
		{
			"mibao#zhongyanzhilong4",
			"func#618#15019",
			"func#1003"
		},
		"4:409:90",
		"4:409:30",
		15019
	},
	{
		323002,
		{
			"mibao#zhongyanzhilong4",
			"func#618#12034",
			"func#1247"
		},
		"4:386:90",
		"4:386:30",
		12034
	}
}
local t_dragon_xiuer_info = {
	[323001] = dataList[1],
	[323002] = dataList[2]
}

t_dragon_xiuer_info.dataList = dataList

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

return t_dragon_xiuer_info
