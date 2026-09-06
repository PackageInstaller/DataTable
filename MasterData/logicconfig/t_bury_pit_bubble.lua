-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bury_pit_bubble.lua

module("logicconfig.config.t_bury_pit_bubble", package.seeall)

local title = {
	id = 1,
	content = 2
}
local dataList = {
	{
		1,
		"专注埋人三十年"
	},
	{
		2,
		"没啥子，唯手熟尔"
	},
	{
		3,
		"能动手不BB"
	},
	{
		4,
		"埋三送一"
	},
	{
		5,
		"没有我埋不了的人"
	},
	{
		6,
		"我给你也挖了个坑"
	},
	{
		7,
		"姐来埋你咯"
	}
}
local t_bury_pit_bubble = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_bury_pit_bubble.dataList = dataList

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

return t_bury_pit_bubble
