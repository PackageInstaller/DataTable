-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_painter_activity.lua

module("logicconfig.config.t_dream_painter_activity", package.seeall)

local title = {
	excellentPrize = 6,
	participationPrize = 7,
	redPointId = 5,
	dailyTimes = 3,
	activation = 2,
	activityId = 1,
	votePrize = 4
}
local dataList = {
	{
		285001,
		60,
		3,
		"8:1:50000",
		498,
		"14:185:1#2:92:1#4:510182:1",
		"14:185:1#2:92:1#4:510182:1"
	},
	{
		285002,
		60,
		3,
		"8:1:50000",
		498,
		"14:185:1#2:92:1#4:510182:1",
		"14:185:1#2:92:1#4:510182:1"
	},
	{
		285003,
		60,
		3,
		"8:1:50000",
		498,
		"14:185:1#2:92:1#4:510182:1",
		"14:185:1#2:92:1#4:510182:1"
	},
	{
		285004,
		60,
		3,
		"8:1:50000",
		498,
		"14:185:1#2:92:1#4:510182:1",
		"14:185:1#2:92:1#4:510182:1"
	}
}
local t_dream_painter_activity = {
	[285001] = dataList[1],
	[285002] = dataList[2],
	[285003] = dataList[3],
	[285004] = dataList[4]
}

t_dream_painter_activity.dataList = dataList

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

return t_dream_painter_activity
