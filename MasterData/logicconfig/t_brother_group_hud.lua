-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_brother_group_hud.lua

module("logicconfig.config.t_brother_group_hud", package.seeall)

local title = {
	redpointId = 6,
	name = 3,
	viewname = 4,
	parameter = 7,
	id = 2,
	planId = 1,
	sort = 5
}
local dataList = {
	{
		1,
		1,
		"组队列表",
		"brothergroupteamview",
		1,
		"",
		""
	},
	{
		1,
		2,
		"兄弟任务",
		"brothergrouptaskview",
		2,
		"364",
		""
	},
	{
		1,
		3,
		"组队通行证",
		"brothergrouppassportview",
		3,
		"365",
		""
	},
	{
		1,
		4,
		"个人奖励",
		"brothergroupprizeview",
		4,
		"373",
		""
	}
}
local t_brother_group_hud = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_brother_group_hud.dataList = dataList

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

return t_brother_group_hud
