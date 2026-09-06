-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_dispatch.lua

module("logicconfig.config.t_pet_dispatch", package.seeall)

local title = {
	id = 1,
	levelSection = 2,
	taskNum = 3,
	dispatchPro = 4
}
local dataList = {
	{
		1,
		1,
		4,
		1
	},
	{
		2,
		15,
		4,
		2
	},
	{
		3,
		21,
		5,
		3
	},
	{
		4,
		31,
		6,
		4
	},
	{
		5,
		41,
		7,
		5
	},
	{
		6,
		51,
		8,
		6
	},
	{
		7,
		61,
		8,
		7
	},
	{
		8,
		71,
		9,
		8
	},
	{
		9,
		81,
		9,
		9
	}
}
local t_pet_dispatch = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9]
}

t_pet_dispatch.dataList = dataList

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

return t_pet_dispatch
