-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_preheat_sale.lua

module("logicconfig.config.t_preheat_sale", package.seeall)

local title = {
	gainExtraGiftTime = 4,
	extraGift = 3,
	payGoodsId = 5,
	activityId = 1,
	gift = 2
}
local dataList = {
	{
		87001,
		"22:4:1#19:8:1#4:90089:1#104:2:300#4:90062:200",
		"4:36:5",
		"2021-11-26T05:00:00",
		"rmb_30"
	},
	{
		87002,
		"22:5:1#14:71:1#4:90089:1#4:90129:1",
		"",
		nil,
		"rmb_30"
	},
	{
		87003,
		"22:5:1#14:71:1#4:90089:1#4:90129:1",
		"",
		nil,
		"rmb_30"
	}
}
local t_preheat_sale = {
	[87001] = dataList[1],
	[87002] = dataList[2],
	[87003] = dataList[3]
}

t_preheat_sale.dataList = dataList

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

return t_preheat_sale
