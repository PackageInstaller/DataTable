-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pillar_space.lua

module("logicconfig.config.t_pillar_space", package.seeall)

local title = {
	id = 1,
	range = 2
}
local dataList = {
	{
		1,
		{
			5,
			10
		}
	},
	{
		2,
		{
			5,
			12
		}
	},
	{
		3,
		{
			5,
			14
		}
	},
	{
		4,
		{
			5,
			16
		}
	},
	{
		5,
		{
			5,
			20
		}
	}
}
local t_pillar_space = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_pillar_space.dataList = dataList

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

return t_pillar_space
