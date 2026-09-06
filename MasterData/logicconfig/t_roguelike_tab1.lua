-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_roguelike_tab1.lua

module("logicconfig.config.t_roguelike_tab1", package.seeall)

local title = {
	tabViewName = 6,
	name = 2,
	sortIndex = 4,
	isHide = 5,
	index = 1,
	params = 7,
	childIndex = 3
}
local dataList = {
	{
		1,
		"击杀榜",
		{
			1,
			2
		},
		1,
		false,
		""
	},
	{
		2,
		"速通榜",
		{
			3,
			4
		},
		2,
		false,
		""
	}
}
local t_roguelike_tab1 = {
	dataList[1],
	dataList[2]
}

t_roguelike_tab1.dataList = dataList

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

return t_roguelike_tab1
