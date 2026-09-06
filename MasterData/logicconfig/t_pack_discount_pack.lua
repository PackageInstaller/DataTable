-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pack_discount_pack.lua

module("logicconfig.config.t_pack_discount_pack", package.seeall)

local title = {
	activityId = 1,
	packItems = 2,
	packGoodsId = 3
}
local dataList = {
	{
		291001,
		{
			1,
			2,
			3
		},
		"rmb_18"
	}
}
local t_pack_discount_pack = {
	[291001] = dataList[1]
}

t_pack_discount_pack.dataList = dataList

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

return t_pack_discount_pack
