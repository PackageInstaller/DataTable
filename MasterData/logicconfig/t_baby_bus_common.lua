-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_baby_bus_common.lua

module("logicconfig.config.t_baby_bus_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"SIGN_IN_TIPS_ICON_PRE",
		"board_dhm_"
	},
	{
		"SIGN_IN_TIPS_LIST",
		"01#11#12"
	},
	{
		"Xuyuanlin_name",
		"许愿林"
	},
	{
		"Xuyuanlin_icon",
		"board_shizhounian_16"
	},
	{
		"Xuyuanlin_jumpTo",
		"event#opentabframeworkview#12#5"
	},
	{
		"Xuyuanlin_redpointId",
		"482"
	}
}
local t_baby_bus_common = {
	SIGN_IN_TIPS_ICON_PRE = dataList[1],
	SIGN_IN_TIPS_LIST = dataList[2],
	Xuyuanlin_name = dataList[3],
	Xuyuanlin_icon = dataList[4],
	Xuyuanlin_jumpTo = dataList[5],
	Xuyuanlin_redpointId = dataList[6]
}

t_baby_bus_common.dataList = dataList

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

return t_baby_bus_common
