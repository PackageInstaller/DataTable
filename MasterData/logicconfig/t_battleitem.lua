-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_battleitem.lua

module("logicconfig.config.t_battleitem", package.seeall)

local title = {
	name = 2,
	display = 6,
	consumeNumPerAction = 5,
	type = 3,
	enableSale = 11,
	salePrice = 12,
	target = 4,
	desc = 7,
	maxQuantity = 8,
	id = 1,
	isVipItem = 9,
	enableTransaction = 10
}
local dataList = {
	{
		1,
		"单体精灵球",
		"捕捉类",
		1,
		1,
		"特效XXX",
		"",
		9999,
		false,
		true,
		true,
		50
	},
	{
		2,
		"全体精灵球",
		"捕捉类",
		2,
		1,
		"特效XXX",
		"",
		9999,
		false,
		true,
		true,
		100
	}
}
local t_battleitem = {
	dataList[1],
	dataList[2]
}

t_battleitem.dataList = dataList

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

return t_battleitem
