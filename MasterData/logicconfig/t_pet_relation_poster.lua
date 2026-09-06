-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_relation_poster.lua

module("logicconfig.config.t_pet_relation_poster", package.seeall)

local title = {
	id = 1,
	ids = 2
}
local dataList = {
	{
		2,
		{
			10,
			7,
			1
		}
	},
	{
		3,
		{
			12
		}
	},
	{
		4,
		{
			11,
			8
		}
	},
	{
		5,
		{
			13,
			5
		}
	},
	{
		6,
		{
			9,
			15
		}
	},
	{
		7,
		{
			14
		}
	}
}
local t_pet_relation_poster = {
	[2] = dataList[1],
	[3] = dataList[2],
	[4] = dataList[3],
	[5] = dataList[4],
	[6] = dataList[5],
	[7] = dataList[6]
}

t_pet_relation_poster.dataList = dataList

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

return t_pet_relation_poster
