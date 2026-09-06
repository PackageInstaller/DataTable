-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_painter_common.lua

module("logicconfig.config.t_dream_painter_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CURR_ACTIVITY_ID",
		"285004"
	},
	{
		"MAIN_VIEW_ITEM",
		"8:1:50000"
	},
	{
		"RED_POINT_ID",
		"498"
	},
	{
		"TAB_PRIZE_NAME",
		"奖励预览"
	}
}
local t_dream_painter_common = {
	CURR_ACTIVITY_ID = dataList[1],
	MAIN_VIEW_ITEM = dataList[2],
	RED_POINT_ID = dataList[3],
	TAB_PRIZE_NAME = dataList[4]
}

t_dream_painter_common.dataList = dataList

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

return t_dream_painter_common
