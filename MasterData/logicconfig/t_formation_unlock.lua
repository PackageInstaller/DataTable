-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_formation_unlock.lua

module("logicconfig.config.t_formation_unlock", package.seeall)

local title = {
	name = 2,
	type = 3,
	id = 1,
	condition = 4,
	desc = 5
}
local dataList = {
	{
		1,
		"阵型1",
		0,
		0,
		""
	},
	{
		2,
		"阵型2",
		0,
		0,
		""
	},
	{
		3,
		"阵型3",
		0,
		0,
		""
	},
	{
		4,
		"阵型4",
		0,
		0,
		""
	},
	{
		5,
		"阵型5",
		0,
		0,
		""
	},
	{
		6,
		"阵型6",
		0,
		0,
		""
	},
	{
		7,
		"阵型7",
		0,
		0,
		""
	},
	{
		8,
		"阵型8",
		0,
		0,
		""
	}
}
local t_formation_unlock = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_formation_unlock.dataList = dataList

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

return t_formation_unlock
