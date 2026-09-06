-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_clear_star_game_convert.lua

module("logicconfig.config.t_clear_star_game_convert", package.seeall)

local title = {
	itemId = 3,
	limit = 5,
	ratio = 4,
	activityId = 1,
	scoreType = 2
}
local dataList = {
	{
		479001,
		1,
		479001,
		1,
		200
	},
	{
		479001,
		2,
		479002,
		1,
		200
	},
	{
		479001,
		3,
		479003,
		1,
		200
	},
	{
		479001,
		4,
		479004,
		1,
		200
	},
	{
		479001,
		5,
		479005,
		1,
		200
	},
	{
		479002,
		1,
		479009,
		1,
		200
	},
	{
		479002,
		2,
		479009,
		1,
		200
	},
	{
		479002,
		3,
		479009,
		1,
		200
	},
	{
		479002,
		4,
		479009,
		1,
		200
	},
	{
		479002,
		5,
		479009,
		1,
		200
	},
	{
		479003,
		1,
		479010,
		1,
		200
	},
	{
		479003,
		2,
		479010,
		1,
		200
	},
	{
		479003,
		3,
		479010,
		1,
		200
	},
	{
		479003,
		4,
		479010,
		1,
		200
	},
	{
		479003,
		5,
		479010,
		1,
		200
	}
}
local t_clear_star_game_convert = {
	[479001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[479002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[479003] = {
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_clear_star_game_convert.dataList = dataList

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

return t_clear_star_game_convert
