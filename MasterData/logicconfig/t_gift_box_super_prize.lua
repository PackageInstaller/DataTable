-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gift_box_super_prize.lua

module("logicconfig.config.t_gift_box_super_prize", package.seeall)

local title = {
	prizeId = 2,
	floor = 4,
	prize = 3,
	superPrizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		"17:1401805:-1:1",
		9
	},
	{
		2,
		1,
		"4:12102:3",
		8
	},
	{
		2,
		2,
		"4:7008:50",
		16
	},
	{
		2,
		3,
		"4:400002:50",
		24
	},
	{
		2,
		4,
		"8:25:300",
		32
	},
	{
		2,
		5,
		"4:12102:3",
		40
	},
	{
		2,
		6,
		"4:7008:50",
		48
	},
	{
		2,
		7,
		"4:400002:50",
		56
	},
	{
		2,
		8,
		"4:12102:4",
		64
	},
	{
		2,
		9,
		"4:90097:1",
		72
	}
}
local t_gift_box_super_prize = {
	{
		dataList[1]
	},
	{
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_gift_box_super_prize.dataList = dataList

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

return t_gift_box_super_prize
