-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_prince_liyang_attribute.lua

module("logicconfig.config.t_prince_liyang_attribute", package.seeall)

local title = {
	id = 2,
	attrName = 4,
	activityId = 1,
	itemId = 3
}
local dataList = {
	{
		509001,
		1,
		509001,
		"财力"
	},
	{
		509001,
		2,
		509002,
		"民心"
	},
	{
		509001,
		3,
		509003,
		"威望"
	}
}
local t_prince_liyang_attribute = {
	[509001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_prince_liyang_attribute.dataList = dataList

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

return t_prince_liyang_attribute
