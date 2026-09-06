-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ice_king_bubble_config.lua

module("logicconfig.config.t_ice_king_bubble_config", package.seeall)

local title = {
	id = 1,
	content = 2
}
local dataList = {
	{
		1,
		"站住"
	},
	{
		2,
		"此路不通"
	},
	{
		3,
		"到此为止吧"
	},
	{
		4,
		"先过我这关"
	},
	{
		5,
		"实力不错啊"
	},
	{
		6,
		"留下来吧"
	},
	{
		7,
		"抗揍才能走得远"
	}
}
local t_ice_king_bubble_config = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_ice_king_bubble_config.dataList = dataList

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

return t_ice_king_bubble_config
