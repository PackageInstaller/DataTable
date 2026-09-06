-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_linkage_skin_intro_tab.lua

module("logicconfig.config.t_linkage_skin_intro_tab", package.seeall)

local title = {
	scale = 4,
	openTime = 5,
	skinId = 2,
	tabId = 1,
	operaId = 6,
	pos = 3,
	reportBehavior = 7
}
local dataList = {
	{
		1,
		1300301,
		{
			70,
			-175
		},
		0.9,
		"2022-09-02 05:00:00",
		4330002,
		201083
	},
	{
		2,
		1016702,
		{
			65,
			-120
		},
		1,
		"2022-09-02 05:00:00",
		4330003,
		201083
	},
	{
		3,
		1009901,
		{
			100,
			-135
		},
		1.3,
		"2022-09-02 05:00:00",
		4330004,
		201083
	},
	{
		4,
		1700301,
		{
			70,
			-110
		},
		1.2,
		"2022-09-16 05:00:00",
		4330001,
		201083
	}
}
local t_linkage_skin_intro_tab = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_linkage_skin_intro_tab.dataList = dataList

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

return t_linkage_skin_intro_tab
