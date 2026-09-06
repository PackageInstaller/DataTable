-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xia_yin_activity.lua

module("logicconfig.config.t_xia_yin_activity", package.seeall)

local title = {
	challengeId = 4,
	jumpTo2 = 6,
	name = 2,
	signInPlanId = 9,
	params = 10,
	jumpTo3 = 7,
	redPointId = 3,
	jumpTo1 = 5,
	jumpTo4 = 8,
	activityId = 1
}
local dataList = {
	{
		336001,
		"夏因挑战",
		551,
		149,
		"func#1019",
		"mibao#tanggongyeyan1",
		"mibao#tanggongyeyan1",
		"func#618#14023",
		0
	},
	{
		336002,
		"神曜圣骑阎罗挑战",
		0,
		231,
		"ui#lottery",
		"mibao#tanggongyeyan1",
		"func#545#20",
		"func#618#15035",
		1,
		{
			jumpShopStr = "mibao#shengqiyangcheng"
		}
	},
	{
		336003,
		"夏因挑战",
		0,
		149,
		"func#1019",
		"mibao#tanggongyeyan1",
		"mibao#tanggongyeyan1",
		"func#618#14023",
		0
	}
}
local t_xia_yin_activity = {
	[336001] = dataList[1],
	[336002] = dataList[2],
	[336003] = dataList[3]
}

t_xia_yin_activity.dataList = dataList

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

return t_xia_yin_activity
