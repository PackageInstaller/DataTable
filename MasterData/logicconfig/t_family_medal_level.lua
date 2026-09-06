-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_medal_level.lua

module("logicconfig.config.t_family_medal_level", package.seeall)

local title = {
	gloryValue = 2,
	level = 1
}
local dataList = {
	{
		1,
		1
	},
	{
		2,
		3
	},
	{
		3,
		5
	}
}
local t_family_medal_level = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_family_medal_level.dataList = dataList

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

return t_family_medal_level
