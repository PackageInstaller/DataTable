-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_year_card.lua

module("logicconfig.config.t_year_card", package.seeall)

local title = {
	fixedGain = 3,
	weeklyGain = 4,
	activityId = 1,
	payGoodsId = 2
}
local dataList = {
	{
		14001,
		"rmb_88",
		"100:10313:1:1#4:36:10",
		"104:2:500"
	},
	{
		14002,
		"rmb_88",
		"100:10313:1:1#4:36:10",
		"104:2:500"
	},
	{
		14003,
		"rmb_88",
		"100:10313:1:1#4:36:10",
		"104:2:500"
	}
}
local t_year_card = {
	[14001] = dataList[1],
	[14002] = dataList[2],
	[14003] = dataList[3]
}

t_year_card.dataList = dataList

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

return t_year_card
