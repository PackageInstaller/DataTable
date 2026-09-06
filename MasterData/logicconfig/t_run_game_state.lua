-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_run_game_state.lua

module("logicconfig.config.t_run_game_state", package.seeall)

local title = {
	rewardTime = 4,
	effectPath = 5,
	StateName = 3,
	Id = 2,
	planId = 1
}
local dataList = {
	{
		1,
		1,
		"普通加速",
		-1,
		""
	},
	{
		1,
		2,
		"超级加速",
		-3,
		""
	},
	{
		1,
		3,
		"减速",
		2,
		""
	},
	{
		1,
		4,
		"摔倒",
		4,
		""
	},
	{
		1,
		5,
		"结算标志",
		0,
		""
	},
	{
		2,
		1,
		"普通突破",
		-1,
		""
	},
	{
		2,
		2,
		"超级突破",
		-3,
		""
	},
	{
		2,
		3,
		"减速",
		2,
		""
	},
	{
		2,
		4,
		"受阻",
		4,
		""
	},
	{
		2,
		5,
		"结算标志",
		0,
		""
	}
}
local t_run_game_state = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_run_game_state.dataList = dataList

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

return t_run_game_state
