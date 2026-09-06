-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_clear_star_game_item.lua

module("logicconfig.config.t_clear_star_game_item", package.seeall)

local title = {
	id = 2,
	cost = 3,
	activityId = 1,
	dealType = 4
}
local dataList = {
	{
		479001,
		1,
		"10:479008:1",
		1
	},
	{
		479001,
		2,
		"10:479006:1",
		2
	},
	{
		479001,
		3,
		"10:479007:1",
		3
	}
}
local t_clear_star_game_item = {
	[479001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_clear_star_game_item.dataList = dataList

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

return t_clear_star_game_item
