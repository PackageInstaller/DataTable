-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_run2023_game_state.lua

module("logicconfig.config.t_run2023_game_state", package.seeall)

local title = {
	rewardTime = 4,
	StateName = 3,
	Id = 2,
	icon = 5,
	planId = 1
}
local dataList = {
	{
		1,
		1,
		"普通加速",
		-1,
		"com_gouxuan01"
	},
	{
		1,
		2,
		"超级加速",
		-2,
		"com_gouxuan01"
	},
	{
		1,
		3,
		"减速",
		2,
		"com_gouxuan07"
	},
	{
		1,
		4,
		"摔倒",
		5,
		""
	},
	{
		1,
		5,
		"结算标志",
		0,
		""
	}
}
local t_run2023_game_state = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_run2023_game_state.dataList = dataList

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

return t_run2023_game_state
