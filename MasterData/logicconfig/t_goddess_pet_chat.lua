-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_pet_chat.lua

module("logicconfig.config.t_goddess_pet_chat", package.seeall)

local title = {
	raceId = 1,
	planId = 2,
	lvLimit = 3
}
local dataList = {
	{
		16005,
		1,
		1
	},
	{
		16005,
		2,
		1
	},
	{
		16005,
		3,
		1
	},
	{
		16005,
		4,
		1
	},
	{
		16005,
		5,
		5
	},
	{
		16005,
		6,
		5
	},
	{
		16005,
		7,
		5
	},
	{
		16005,
		8,
		5
	},
	{
		16005,
		9,
		9
	},
	{
		16005,
		10,
		9
	},
	{
		16005,
		11,
		9
	},
	{
		16005,
		12,
		9
	}
}
local t_goddess_pet_chat = {
	[16005] = {
		{
			dataList[1]
		},
		{
			dataList[2]
		},
		{
			dataList[3]
		},
		{
			dataList[4]
		},
		{
			[5] = dataList[5]
		},
		{
			[5] = dataList[6]
		},
		{
			[5] = dataList[7]
		},
		{
			[5] = dataList[8]
		},
		{
			[9] = dataList[9]
		},
		{
			[9] = dataList[10]
		},
		{
			[9] = dataList[11]
		},
		{
			[9] = dataList[12]
		}
	}
}

t_goddess_pet_chat.dataList = dataList

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

return t_goddess_pet_chat
