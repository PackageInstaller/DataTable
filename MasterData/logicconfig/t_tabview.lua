-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tabview.lua

module("logicconfig.config.t_tabview", package.seeall)

local title = {
	id = 1,
	parameter = 6,
	viewname = 3,
	redpointId = 4,
	title = 2,
	reportBehavior = 5
}
local dataList = {
	{
		1,
		"小诺成长之路",
		"growthroadview",
		"",
		0,
		""
	},
	{
		2,
		"梦之队相助",
		"dreamteammutualhelpview",
		"-159",
		0,
		"showInTab"
	},
	{
		3,
		"梦想任务",
		"dreamtaskview",
		"179",
		0,
		""
	}
}
local t_tabview = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_tabview.dataList = dataList

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

return t_tabview
