-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_shop_sort_skin_cfg.lua

module("logicconfig.config.t_pay_shop_sort_skin_cfg", package.seeall)

local title = {
	id = 1,
	rank = 2,
	desc = 3
}
local dataList = {
	{
		1,
		1,
		"未拥有"
	},
	{
		2,
		3,
		"品质"
	},
	{
		3,
		4,
		"神钻购买"
	},
	{
		4,
		5,
		"皮肤币购买"
	},
	{
		5,
		2,
		"上架时间"
	}
}
local t_pay_shop_sort_skin_cfg = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_pay_shop_sort_skin_cfg.dataList = dataList

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

return t_pay_shop_sort_skin_cfg
