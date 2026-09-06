-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saintknight_rui_info.lua

module("logicconfig.config.t_saintknight_rui_info", package.seeall)

local title = {
	stageId = 2,
	name = 3,
	spriteName3 = 7,
	spriteName1 = 5,
	spriteName2 = 6,
	prize = 4,
	challengePlanId = 1
}
local dataList = {
	{
		1,
		1,
		"万物回春",
		"4:143:30#8:1:375000",
		"board_sq_01",
		"board_sq_09",
		"board_sq_05"
	},
	{
		1,
		2,
		"魔伤免疫",
		"4:143:30#8:1:375000",
		"board_sq_02",
		"board_sq_10",
		"board_sq_06"
	},
	{
		1,
		3,
		"物伤免疫",
		"4:143:30#8:1:375000",
		"board_sq_03",
		"board_sq_11",
		"board_sq_07"
	},
	{
		1,
		4,
		"坚不可摧",
		"4:143:30#8:1:375000",
		"board_sq_04",
		"board_sq_12",
		"board_sq_08"
	}
}
local t_saintknight_rui_info = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_saintknight_rui_info.dataList = dataList

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

return t_saintknight_rui_info
