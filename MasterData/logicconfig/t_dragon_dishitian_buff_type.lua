-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_dishitian_buff_type.lua

module("logicconfig.config.t_dragon_dishitian_buff_type", package.seeall)

local title = {
	itemId = 3,
	buffType = 2,
	endDateTime = 5,
	openDateTime = 4,
	activityId = 1
}
local dataList = {
	{
		343002,
		1,
		343001,
		"2038-12-30T05:00:00",
		"2038-12-30T05:00:00"
	},
	{
		343002,
		2,
		343002,
		"2038-12-30T05:00:00",
		"2038-12-30T05:00:00"
	}
}
local t_dragon_dishitian_buff_type = {
	[343002] = {
		dataList[1],
		dataList[2]
	}
}

t_dragon_dishitian_buff_type.dataList = dataList

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

return t_dragon_dishitian_buff_type
