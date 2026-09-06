-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_acc_consume_gift_define.lua

module("logicconfig.config.t_acc_consume_gift_define", package.seeall)

local title = {
	showType = 3,
	pos = 6,
	showItem = 4,
	sprite = 7,
	id = 1,
	leftConsume = 2,
	gift = 5
}
local dataList = {
	{
		1,
		499800,
		3,
		"4:1005:1",
		"4:40208:1#4:1005:1#104:2:1500",
		{
			-445,
			2
		},
		"gift_motuo"
	},
	{
		2,
		999800,
		3,
		"4:1007:1",
		"4:70003:1#4:1007:1#104:2:1500",
		{
			-419,
			20
		},
		"gift_chiyanlongwang"
	}
}
local t_acc_consume_gift_define = {
	dataList[1],
	dataList[2]
}

t_acc_consume_gift_define.dataList = dataList

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

return t_acc_consume_gift_define
