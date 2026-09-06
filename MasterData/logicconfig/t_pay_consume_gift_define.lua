-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_consume_gift_define.lua

module("logicconfig.config.t_pay_consume_gift_define", package.seeall)

local title = {
	giftId = 4,
	giftName = 5,
	consumeMoney = 2,
	id = 1,
	colourPic = 3,
	gift = 6
}
local dataList = {
	{
		1,
		600,
		{
			1,
			2,
			2,
			2
		},
		511,
		"召唤大礼包",
		"100:10167:1:1#4:32:1#4:2:20#8:1:20000"
	},
	{
		2,
		3000,
		{
			1,
			2,
			2,
			2
		},
		0,
		"",
		"7:111060:1:1#4:32:1#4:30001:10#8:1:50000"
	},
	{
		3,
		9800,
		{
			1,
			2,
			2,
			2
		},
		0,
		"",
		"7:112060:1:1#4:304:5#4:32:2#8:1:50000"
	},
	{
		4,
		19800,
		{
			1,
			1,
			2,
			2
		},
		0,
		"",
		"7:113060:1:1#7:114060:1:1#4:32:2#8:1:50000"
	}
}
local t_pay_consume_gift_define = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_pay_consume_gift_define.dataList = dataList

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

return t_pay_consume_gift_define
