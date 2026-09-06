-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_hire_item.lua

module("logicconfig.config.t_pet_hire_item", package.seeall)

local title = {
	itemId = 1,
	petDefineId = 2,
	times = 3
}
local dataList = {
	{
		510001,
		1,
		20
	},
	{
		510002,
		2,
		30
	},
	{
		510002,
		3,
		30
	},
	{
		510003,
		4,
		40
	},
	{
		510003,
		5,
		40
	},
	{
		510003,
		6,
		40
	},
	{
		510004,
		7,
		100
	},
	{
		510005,
		8,
		60
	},
	{
		510005,
		9,
		60
	},
	{
		510006,
		10,
		10
	},
	{
		510007,
		11,
		10
	}
}
local t_pet_hire_item = {
	[510001] = {
		dataList[1]
	},
	[510002] = {
		[2] = dataList[2],
		[3] = dataList[3]
	},
	[510003] = {
		[4] = dataList[4],
		[5] = dataList[5],
		[6] = dataList[6]
	},
	[510004] = {
		[7] = dataList[7]
	},
	[510005] = {
		[8] = dataList[8],
		[9] = dataList[9]
	},
	[510006] = {
		[10] = dataList[10]
	},
	[510007] = {
		[11] = dataList[11]
	}
}

t_pet_hire_item.dataList = dataList

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

return t_pet_hire_item
