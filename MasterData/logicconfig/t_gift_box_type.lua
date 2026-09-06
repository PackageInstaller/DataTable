-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gift_box_type.lua

module("logicconfig.config.t_gift_box_type", package.seeall)

local title = {
	boxType = 1,
	superPrizeScorePlan = 4,
	name = 5,
	ratePlan = 3,
	superPrizePlanId = 2
}
local dataList = {
	{
		1,
		1,
		1,
		1,
		"至尊礼盒"
	},
	{
		2,
		2,
		2,
		2,
		"精美礼盒"
	}
}
local t_gift_box_type = {
	dataList[1],
	dataList[2]
}

t_gift_box_type.dataList = dataList

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

return t_gift_box_type
