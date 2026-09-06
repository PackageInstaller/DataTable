-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_seek_food_site.lua

module("logicconfig.config.t_seek_food_site", package.seeall)

local title = {
	siteId = 2,
	activityId = 1,
	openDateTime = 3
}
local dataList = {
	{
		282001,
		1,
		"2023-06-30T05:00:00"
	},
	{
		282001,
		2,
		"2023-07-07T05:00:00"
	},
	{
		282001,
		3,
		"2023-07-14T05:00:00"
	},
	{
		282001,
		4,
		"2023-07-21T05:00:00"
	}
}
local t_seek_food_site = {
	[282001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_seek_food_site.dataList = dataList

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

return t_seek_food_site
