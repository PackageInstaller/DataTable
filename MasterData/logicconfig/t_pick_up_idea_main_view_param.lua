-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pick_up_idea_main_view_param.lua

module("logicconfig.config.t_pick_up_idea_main_view_param", package.seeall)

local title = {
	resPath = 3,
	item = 5,
	jumpTo = 4,
	id = 2,
	activityId = 1
}
local dataList = {
	{
		338001,
		1,
		"",
		"func#95",
		"8:1"
	},
	{
		338001,
		2,
		"",
		"func#95",
		"8:1"
	},
	{
		338001,
		3,
		"",
		"func#95",
		"8:1"
	},
	{
		338001,
		4,
		"",
		"func#95",
		"8:1"
	}
}
local t_pick_up_idea_main_view_param = {
	[338001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_pick_up_idea_main_view_param.dataList = dataList

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

return t_pick_up_idea_main_view_param
