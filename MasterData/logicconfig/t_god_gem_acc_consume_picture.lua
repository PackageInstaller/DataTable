-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_gem_acc_consume_picture.lua

module("logicconfig.config.t_god_gem_acc_consume_picture", package.seeall)

local title = {
	id = 1,
	iconName = 2
}
local dataList = {
	{
		1,
		"board_mb_11"
	},
	{
		2,
		"board_mb_05"
	},
	{
		3,
		"board_mb_08"
	},
	{
		4,
		"board_mb_10"
	},
	{
		5,
		"board_mb_09"
	},
	{
		6,
		"board_mb_12"
	},
	{
		7,
		"board_mb_07"
	}
}
local t_god_gem_acc_consume_picture = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_god_gem_acc_consume_picture.dataList = dataList

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

return t_god_gem_acc_consume_picture
