-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_medal_wall.lua

module("logicconfig.config.t_family_medal_wall", package.seeall)

local title = {
	id = 1,
	width = 3,
	length = 2
}
local dataList = {
	{
		1,
		24,
		12
	}
}
local t_family_medal_wall = {
	dataList[1]
}

t_family_medal_wall.dataList = dataList

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

return t_family_medal_wall
