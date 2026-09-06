-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_fight_titan.lua

module("logicconfig.config.t_origin_fight_titan", package.seeall)

local title = {
	progressId = 3,
	titanId = 2,
	reward = 5,
	name = 6,
	maxProgress = 4,
	activityId = 1
}
local dataList = {
	{
		525001,
		1,
		1,
		100000,
		"4:36:10",
		"草"
	},
	{
		525001,
		2,
		1,
		100000,
		"4:36:10",
		"火"
	},
	{
		525001,
		3,
		1,
		100000,
		"8:1:30000000",
		"水"
	},
	{
		525001,
		4,
		2,
		100000,
		"4:12102:5",
		"光"
	},
	{
		525001,
		5,
		2,
		100000,
		"4:11002:15000",
		"暗"
	},
	{
		525001,
		6,
		3,
		100000,
		"4:90312:1",
		"空"
	},
	{
		525001,
		7,
		3,
		100000,
		"4:90312:1",
		"创"
	}
}
local t_origin_fight_titan = {
	[525001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_origin_fight_titan.dataList = dataList

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

return t_origin_fight_titan
