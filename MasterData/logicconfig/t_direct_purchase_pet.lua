-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_direct_purchase_pet.lua

module("logicconfig.config.t_direct_purchase_pet", package.seeall)

local title = {
	activityId = 1,
	raceId = 2
}
local dataList = {
	{
		75001,
		10334
	},
	{
		75002,
		10370
	},
	{
		75003,
		11001
	},
	{
		86001,
		10345
	},
	{
		75004,
		14004
	},
	{
		86002,
		10328
	}
}
local t_direct_purchase_pet = {
	[75001] = dataList[1],
	[75002] = dataList[2],
	[75003] = dataList[3],
	[86001] = dataList[4],
	[75004] = dataList[5],
	[86002] = dataList[6]
}

t_direct_purchase_pet.dataList = dataList

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

return t_direct_purchase_pet
