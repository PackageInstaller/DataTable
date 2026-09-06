-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pack_discount_item.lua

module("logicconfig.config.t_pack_discount_item", package.seeall)

local title = {
	itemId = 1,
	content = 2,
	packGoodsId = 3
}
local dataList = {
	{
		1,
		"8:1:101#104:2:300",
		"rmb_1"
	},
	{
		2,
		"8:1:102#104:2:301",
		"rmb_6"
	},
	{
		3,
		"8:1:102#104:2:302",
		"rmb_12"
	}
}
local t_pack_discount_item = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_pack_discount_item.dataList = dataList

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

return t_pack_discount_item
