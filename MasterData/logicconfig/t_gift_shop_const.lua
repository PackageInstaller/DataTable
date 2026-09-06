-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gift_shop_const.lua

module("logicconfig.config.t_gift_shop_const", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"GiftId1",
		"417:12"
	},
	{
		"GiftId2",
		"417:13"
	},
	{
		"GiftId3",
		"417:14"
	},
	{
		"Func_417_BG",
		"board_jlzg_bg02"
	}
}
local t_gift_shop_const = {
	GiftId1 = dataList[1],
	GiftId2 = dataList[2],
	GiftId3 = dataList[3],
	Func_417_BG = dataList[4]
}

t_gift_shop_const.dataList = dataList

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

return t_gift_shop_const
