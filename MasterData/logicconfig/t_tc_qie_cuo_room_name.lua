-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tc_qie_cuo_room_name.lua

module("logicconfig.config.t_tc_qie_cuo_room_name", package.seeall)

local title = {
	id = 1,
	name = 2
}
local dataList = {
	{
		1,
		"兄弟来"
	},
	{
		2,
		"别怕 我保护你"
	},
	{
		3,
		"虐全区"
	},
	{
		4,
		"我的房间我做主"
	},
	{
		5,
		"一决高下"
	},
	{
		6,
		"决战到天亮"
	}
}
local t_tc_qie_cuo_room_name = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_tc_qie_cuo_room_name.dataList = dataList

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

return t_tc_qie_cuo_room_name
