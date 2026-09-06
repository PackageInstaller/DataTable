-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_collecting_skin_item_progress.lua

module("logicconfig.config.t_collecting_skin_item_progress", package.seeall)

local title = {
	dataBitId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		362005,
		1,
		5,
		"1:400044:-1:1#1:400045:-1:1"
	},
	{
		362005,
		2,
		10,
		"1:400046:-1:1#1:400047:-1:1"
	},
	{
		362005,
		3,
		22,
		"4:410001:1"
	}
}
local t_collecting_skin_item_progress = {
	[362005] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_collecting_skin_item_progress.dataList = dataList

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

return t_collecting_skin_item_progress
