-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kindergarten_class.lua

module("logicconfig.config.t_kindergarten_class", package.seeall)

local title = {
	classId = 2,
	icon = 4,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		353001,
		1,
		"1班",
		"ui/icon/items/icon_10271_mininuo"
	},
	{
		353001,
		2,
		"2班",
		"ui/icon/items/icon_10272_yuangunuo"
	},
	{
		353001,
		3,
		"3班",
		"ui/icon/items/icon_10280_konglongnuo"
	},
	{
		353001,
		4,
		"4班",
		"ui/icon/items/icon_10281_shayunuo"
	}
}
local t_kindergarten_class = {
	[353001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_kindergarten_class.dataList = dataList

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

return t_kindergarten_class
