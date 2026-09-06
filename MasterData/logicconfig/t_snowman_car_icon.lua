-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_snowman_car_icon.lua

module("logicconfig.config.t_snowman_car_icon", package.seeall)

local title = {
	id = 1,
	carBgPath = 3,
	iconPath = 2
}
local dataList = {
	{
		1,
		"com_player_ax",
		"board_xuerenzhuangche_05"
	},
	{
		2,
		"com_player_xiaorui",
		"board_xuerenzhuangche_03"
	},
	{
		3,
		"com_player_xiaotian",
		"board_xuerenzhuangche_04"
	},
	{
		4,
		"com_player_syly02",
		"board_xuerenzhuangche_01"
	},
	{
		5,
		"com_player_xiaonuo",
		"board_xuerenzhuangche_02"
	}
}
local t_snowman_car_icon = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_snowman_car_icon.dataList = dataList

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

return t_snowman_car_icon
