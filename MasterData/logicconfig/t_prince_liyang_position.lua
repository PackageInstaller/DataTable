-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_prince_liyang_position.lua

module("logicconfig.config.t_prince_liyang_position", package.seeall)

local title = {
	activityId = 1,
	typeId = 3,
	posId = 2,
	title = 4
}
local dataList = {
	{
		509001,
		1,
		1,
		"boss"
	},
	{
		509001,
		2,
		2,
		"破阵"
	},
	{
		509001,
		3,
		2,
		"破阵"
	}
}
local t_prince_liyang_position = {
	[509001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_prince_liyang_position.dataList = dataList

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

return t_prince_liyang_position
