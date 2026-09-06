-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pan_tao_feast_daily_gift.lua

module("logicconfig.config.t_pan_tao_feast_daily_gift", package.seeall)

local title = {
	gridElementId = 3,
	weight = 4,
	activityId = 1,
	giftId = 2
}
local dataList = {
	{
		622001,
		1,
		30001,
		50
	},
	{
		622001,
		2,
		1,
		5
	},
	{
		622001,
		3,
		8,
		5
	},
	{
		622001,
		4,
		15,
		5
	},
	{
		622001,
		5,
		22,
		5
	}
}
local t_pan_tao_feast_daily_gift = {
	[622001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_pan_tao_feast_daily_gift.dataList = dataList

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

return t_pan_tao_feast_daily_gift
