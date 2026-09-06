-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_privilege_gift.lua

module("logicconfig.config.t_privilege_gift", package.seeall)

local title = {
	consumePrize = 4,
	name = 5,
	privilegeDay = 3,
	payGoodsId = 2,
	id = 1
}
local dataList = {
	{
		1,
		"rmb_6",
		7,
		3,
		"7天特权"
	},
	{
		2,
		"rmb_18",
		30,
		7,
		"30天特权"
	}
}
local t_privilege_gift = {
	dataList[1],
	dataList[2]
}

t_privilege_gift.dataList = dataList

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

return t_privilege_gift
