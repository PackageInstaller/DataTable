-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guess_box_game_setting.lua

module("logicconfig.config.t_guess_box_game_setting", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"totalExchangeTimes",
		"6"
	},
	{
		"selectCountDown",
		"10"
	},
	{
		"DgDuration",
		"500:0.5:1.2"
	},
	{
		"DgScaleFactor",
		"0.05:0:0.5"
	},
	{
		"DgInterval",
		"0.2"
	}
}
local t_guess_box_game_setting = {
	totalExchangeTimes = dataList[1],
	selectCountDown = dataList[2],
	DgDuration = dataList[3],
	DgScaleFactor = dataList[4],
	DgInterval = dataList[5]
}

t_guess_box_game_setting.dataList = dataList

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

return t_guess_box_game_setting
