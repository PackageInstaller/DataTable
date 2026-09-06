-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anniversary_koi_pool.lua

module("logicconfig.config.t_anniversary_koi_pool", package.seeall)

local title = {
	participationPrize = 8,
	bigPrizeCount = 6,
	numberPlanId = 4,
	type = 3,
	activityScoreLimit = 9,
	SpecialPrizeCount = 7,
	bigPrizeDec = 11,
	poolId = 2,
	participationPrizeDec = 13,
	SpecialPrizeDec = 12,
	numberCount = 5,
	poolDec = 10,
	activityId = 1
}
local dataList = {
	{
		261001,
		1,
		1,
		261001,
		7,
		1,
		5,
		"4:90311:3",
		0,
		"天选锦鲤",
		"神宠承包",
		"随机新宠",
		"参与有礼"
	},
	{
		261001,
		2,
		2,
		0,
		0,
		1,
		5,
		"4:90311:3",
		0,
		"免单锦鲤",
		"全额返钻",
		"随机免单",
		"参与有礼"
	},
	{
		261001,
		3,
		3,
		0,
		0,
		1,
		5,
		"4:90311:3",
		120,
		"肝帝锦鲤",
		"爆肝返还",
		"小肝怡情",
		"参与有礼"
	}
}
local t_anniversary_koi_pool = {
	[261001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_anniversary_koi_pool.dataList = dataList

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

return t_anniversary_koi_pool
