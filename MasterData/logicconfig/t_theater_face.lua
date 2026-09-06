-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_theater_face.lua

module("logicconfig.config.t_theater_face", package.seeall)

local title = {
	id = 1,
	url = 2
}
local dataList = {
	{
		1,
		"board_antishi_09_1"
	},
	{
		2,
		"board_antishi_09_2"
	},
	{
		3,
		"board_antishi_09_3"
	},
	{
		4,
		"board_antishi_09_4"
	},
	{
		5,
		"board_antishi_09_5"
	},
	{
		6,
		"board_antishi_12_1"
	},
	{
		7,
		"board_antishi_12_2"
	},
	{
		8,
		"board_antishi_12_3"
	},
	{
		9,
		"board_antishi_12_4"
	}
}
local t_theater_face = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9]
}

t_theater_face.dataList = dataList

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

return t_theater_face
