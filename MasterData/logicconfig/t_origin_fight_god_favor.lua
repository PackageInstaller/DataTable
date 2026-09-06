-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_fight_god_favor.lua

module("logicconfig.config.t_origin_fight_god_favor", package.seeall)

local title = {
	cost = 4,
	name = 3,
	gainType = 7,
	storyId = 6,
	creepsMasterId = 5,
	activityId = 1,
	godFavorId = 2
}
local dataList = {
	{
		525001,
		1,
		"空灵",
		"",
		0,
		4820025,
		"game#originfightbonedragondungeongameview"
	},
	{
		525001,
		2,
		"命渊",
		"",
		0,
		4820027,
		"game#originfightplanetariumview"
	},
	{
		525001,
		3,
		"永恒",
		"8:1:10000",
		0,
		4820029,
		"pay"
	},
	{
		525001,
		4,
		"悼影",
		"",
		0,
		4820023,
		"story"
	},
	{
		525001,
		5,
		"原初",
		"",
		0,
		4820024,
		"story"
	},
	{
		525001,
		6,
		"秩序",
		"",
		1001,
		4820028,
		"fight"
	},
	{
		525001,
		7,
		"誓祖",
		"",
		0,
		4820026,
		"game#originfightpickupideagameview"
	}
}
local t_origin_fight_god_favor = {
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

t_origin_fight_god_favor.dataList = dataList

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

return t_origin_fight_god_favor
