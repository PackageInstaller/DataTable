-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_brother_group_position.lua

module("logicconfig.config.t_brother_group_position", package.seeall)

local title = {
	posId = 1,
	type = 2
}
local dataList = {
	{
		1,
		{
			1
		}
	},
	{
		2,
		{
			2,
			3
		}
	},
	{
		3,
		{
			2,
			3
		}
	},
	{
		4,
		{
			2,
			3
		}
	},
	{
		5,
		{
			2,
			3
		}
	},
	{
		6,
		{
			2,
			3
		}
	}
}
local t_brother_group_position = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_brother_group_position.dataList = dataList

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

return t_brother_group_position
