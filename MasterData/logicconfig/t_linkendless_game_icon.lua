-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_linkendless_game_icon.lua

module("logicconfig.config.t_linkendless_game_icon", package.seeall)

local title = {
	raceId = 3,
	stateIdx = 2,
	iconPlan = 1
}
local dataList = {
	{
		1,
		1,
		1803101
	},
	{
		1,
		2,
		1602802
	},
	{
		1,
		3,
		1604503
	},
	{
		1,
		4,
		1302803
	},
	{
		1,
		5,
		1202105
	},
	{
		1,
		6,
		1204402
	},
	{
		1,
		7,
		1204503
	},
	{
		1,
		8,
		18031
	},
	{
		1,
		9,
		12040
	},
	{
		1,
		10,
		12042
	}
}
local t_linkendless_game_icon = {
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
		dataList[10]
	}
}

t_linkendless_game_icon.dataList = dataList

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

return t_linkendless_game_icon
