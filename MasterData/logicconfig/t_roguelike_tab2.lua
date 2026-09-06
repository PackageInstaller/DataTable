-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_roguelike_tab2.lua

module("logicconfig.config.t_roguelike_tab2", package.seeall)

local title = {
	index = 1,
	name = 2,
	viewName = 3,
	params = 4
}
local dataList = {
	{
		1,
		"龙脉诺",
		"roguelikerankview",
		{
			rankType = 1,
			phaseId = 1
		}
	},
	{
		2,
		"超神龙尊",
		"roguelikerankview",
		{
			rankType = 1,
			phaseId = 2
		}
	},
	{
		3,
		"龙脉试炼",
		"roguelikerankview",
		{
			rankType = 2,
			phaseId = 1
		}
	},
	{
		4,
		"超神试炼",
		"roguelikerankview",
		{
			rankType = 2,
			phaseId = 2
		}
	}
}
local t_roguelike_tab2 = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_roguelike_tab2.dataList = dataList

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

return t_roguelike_tab2
