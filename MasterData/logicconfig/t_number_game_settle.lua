-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_number_game_settle.lua

module("logicconfig.config.t_number_game_settle", package.seeall)

local title = {
	score = 2,
	scoreDes = 3,
	no = 1
}
local dataList = {
	{
		1,
		5,
		"<color=#0083e7>5</color>分"
	},
	{
		2,
		3,
		"<color=#0083e7>3</color>分"
	},
	{
		3,
		0,
		"<color=red>0</color>分"
	},
	{
		4,
		-3,
		"<color=red>-3</color>分"
	}
}
local t_number_game_settle = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_number_game_settle.dataList = dataList

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

return t_number_game_settle
