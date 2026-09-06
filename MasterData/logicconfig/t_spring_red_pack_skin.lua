-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_spring_red_pack_skin.lua

module("logicconfig.config.t_spring_red_pack_skin", package.seeall)

local title = {
	bigOnPath = 5,
	smallOffPath = 2,
	bigOffPath = 4,
	skinId = 1,
	smallOnPath = 3
}
local dataList = {
	{
		1,
		"btn_hb_03",
		"board_hb_07",
		"btn_hb_02",
		"board_hb_06"
	},
	{
		2,
		"btn_hb_11",
		"btn_hb_12",
		"btn_hb_04",
		"board_hb_10"
	},
	{
		3,
		"btn_hb_14",
		"board_hb_07",
		"btn_hb_13",
		"board_hb_06"
	},
	{
		4,
		"btn_hb_18",
		"btn_hb_18_2",
		"btn_hb_17",
		"btn_hb_17_2"
	}
}
local t_spring_red_pack_skin = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_spring_red_pack_skin.dataList = dataList

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

return t_spring_red_pack_skin
