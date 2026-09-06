-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gift_box_gain_luck.lua

module("logicconfig.config.t_gift_box_gain_luck", package.seeall)

local title = {
	id = 2,
	scoreRange = 3,
	activityId = 1
}
local dataList = {
	{
		318001,
		1,
		{
			1,
			5
		}
	},
	{
		318001,
		2,
		{
			6,
			10
		}
	},
	{
		318001,
		3,
		{
			11,
			15
		}
	}
}
local t_gift_box_gain_luck = {
	[318001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_gift_box_gain_luck.dataList = dataList

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

return t_gift_box_gain_luck
