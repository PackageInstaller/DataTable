-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lantern_festival_channel_prize.lua

module("logicconfig.config.t_lantern_festival_channel_prize", package.seeall)

local title = {
	activityId = 1,
	prize = 3,
	dayOfWeek = 2
}
local dataList = {
	{
		566001,
		1,
		"9:1300042:1"
	},
	{
		566001,
		2,
		"9:1300043:1"
	},
	{
		566001,
		3,
		"9:1300042:1"
	},
	{
		566001,
		4,
		"9:1300043:1"
	},
	{
		566001,
		5,
		"9:1300044:1"
	},
	{
		566001,
		6,
		"9:1300044:1"
	},
	{
		566001,
		7,
		"4:510723:1"
	}
}
local t_lantern_festival_channel_prize = {
	[566001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_lantern_festival_channel_prize.dataList = dataList

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

return t_lantern_festival_channel_prize
