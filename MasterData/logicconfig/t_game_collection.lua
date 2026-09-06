-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_game_collection.lua

module("logicconfig.config.t_game_collection", package.seeall)

local title = {
	sortId = 6,
	id = 1,
	goToParam = 4,
	prizeRatio = 3,
	maxScore = 2,
	enterIcon = 5
}
local dataList = {
	{
		1,
		0,
		"",
		"func#17",
		"btn_ylc02",
		1
	},
	{
		2,
		100,
		"10:1",
		"",
		"",
		2
	},
	{
		3,
		500,
		"1:10",
		"func#16",
		"btn_ylc01",
		3
	},
	{
		4,
		99,
		"3:1",
		"",
		"",
		4
	},
	{
		5,
		99,
		"3:1",
		"",
		"",
		5
	}
}
local t_game_collection = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_game_collection.dataList = dataList

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

return t_game_collection
