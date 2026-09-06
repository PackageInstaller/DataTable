-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_grid_game_type.lua

module("logicconfig.config.t_beast_rich_man_grid_game_type", package.seeall)

local title = {
	sweepCost = 3,
	gameImgName = 4,
	jumpViewName = 5,
	activityId = 1,
	gameId = 2
}
local dataList = {
	{
		558001,
		1,
		"105:6119:200",
		"board_ruishoudamaoxian08",
		"beastrichmanidiomchainmainview"
	},
	{
		558001,
		2,
		"105:6120:200",
		"board_ruishoudamaoxian10",
		"beastrichmanclearstargameview"
	},
	{
		558001,
		3,
		"105:6121:200",
		"board_ruishoudamaoxian09",
		"beastrichmanjumpfloorgameview"
	},
	{
		558001,
		4,
		"105:6122:200",
		"board_ruishoudamaoxian10_1",
		"beastrichmanlinkgameendlessview"
	}
}
local t_beast_rich_man_grid_game_type = {
	[558001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_beast_rich_man_grid_game_type.dataList = dataList

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

return t_beast_rich_man_grid_game_type
