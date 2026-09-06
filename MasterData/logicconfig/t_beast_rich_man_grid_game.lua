-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_grid_game.lua

module("logicconfig.config.t_beast_rich_man_grid_game", package.seeall)

local title = {
	id = 2,
	games = 3,
	activityId = 1
}
local dataList = {
	{
		558001,
		1,
		{
			1,
			2,
			3,
			4
		}
	}
}
local t_beast_rich_man_grid_game = {
	[558001] = {
		dataList[1]
	}
}

t_beast_rich_man_grid_game.dataList = dataList

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

return t_beast_rich_man_grid_game
