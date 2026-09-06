-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_dragon_temple_end_circle_buff.lua

module("logicconfig.config.t_holy_dragon_temple_end_circle_buff", package.seeall)

local title = {
	activityId = 1,
	circleNum = 2
}
local dataList = {
	{
		609001,
		1
	},
	{
		609001,
		2
	},
	{
		609001,
		3
	},
	{
		609001,
		4
	}
}
local t_holy_dragon_temple_end_circle_buff = {
	[609001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_holy_dragon_temple_end_circle_buff.dataList = dataList

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

return t_holy_dragon_temple_end_circle_buff
