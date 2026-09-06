-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luyngarde_pet.lua

module("logicconfig.config.t_luyngarde_pet", package.seeall)

local title = {
	cost = 4,
	creepsId = 3,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		466001,
		0,
		100000001,
		""
	},
	{
		466001,
		1,
		400000001,
		"10:466001:10000"
	},
	{
		466001,
		2,
		500000001,
		"10:466002:10000"
	},
	{
		466001,
		3,
		600000001,
		"10:466002:15000"
	}
}
local t_luyngarde_pet = {
	[466001] = {
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_luyngarde_pet.dataList = dataList

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

return t_luyngarde_pet
