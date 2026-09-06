-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_legend_challenge_treasure.lua

module("logicconfig.config.t_legend_challenge_treasure", package.seeall)

local title = {
	treasureId = 1,
	condition = 3,
	prize = 2
}
local dataList = {
	{
		1,
		"4:31:1#104:2:100#8:1:10000",
		"1_1,2_2"
	},
	{
		2,
		"4:31:1#104:2:100#8:1:10000",
		"3_5,4_5"
	},
	{
		3,
		"4:31:1#104:2:100#8:1:10000",
		"5_1,6_5"
	},
	{
		4,
		"4:31:1#104:2:100#8:1:10000",
		"7_5,8_5"
	},
	{
		5,
		"4:31:2#104:2:100#8:1:10000",
		"9_5,10_5"
	},
	{
		6,
		"4:31:2#104:2:100#8:1:10000",
		"11_5,12_5"
	},
	{
		7,
		"4:31:2#104:2:100#8:1:10000",
		"13_1,14_5"
	}
}
local t_legend_challenge_treasure = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_legend_challenge_treasure.dataList = dataList

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

return t_legend_challenge_treasure
