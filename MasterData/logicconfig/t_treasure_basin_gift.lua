-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_treasure_basin_gift.lua

module("logicconfig.config.t_treasure_basin_gift", package.seeall)

local title = {
	name = 3,
	key = 1,
	giftId = 2
}
local dataList = {
	{
		1,
		1001,
		"钻石礼包1"
	},
	{
		2,
		507,
		"钻石礼包2"
	},
	{
		3,
		512,
		"钻石礼包3"
	}
}
local t_treasure_basin_gift = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_treasure_basin_gift.dataList = dataList

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

return t_treasure_basin_gift
