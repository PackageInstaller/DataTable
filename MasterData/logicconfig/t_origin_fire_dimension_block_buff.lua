-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_fire_dimension_block_buff.lua

module("logicconfig.config.t_origin_fire_dimension_block_buff", package.seeall)

local title = {
	activityId = 1,
	buffNum = 3,
	buffId = 2,
	buffIcon = 4
}
local dataList = {
	{
		560001,
		1,
		"6",
		"board_yqhcy_jb01"
	},
	{
		560001,
		2,
		"6",
		"board_yqhcy_jb02"
	},
	{
		560001,
		3,
		"6",
		"board_yqhcy_jb03"
	}
}
local t_origin_fire_dimension_block_buff = {
	[560001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_origin_fire_dimension_block_buff.dataList = dataList

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

return t_origin_fire_dimension_block_buff
