-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wheel_lottery_pool.lua

module("logicconfig.config.t_wheel_lottery_pool", package.seeall)

local title = {
	poolBubble = 5,
	comPlanId = 6,
	tierPlanId = 3,
	infinite = 7,
	poolName = 4,
	activityId = 1,
	poolId = 2
}
local dataList = {
	{
		409001,
		1,
		1,
		"灵纹宠物",
		"总计:灵纹经验*150万、随机红灵纹*10、随机宠物*20、萌宠品质药水*3w",
		1,
		false
	},
	{
		409001,
		2,
		2,
		"召唤转盘",
		"总计:召唤券*30、神唤券*30、炼金石*20、神炼石*20",
		1,
		false
	},
	{
		409001,
		3,
		3,
		"经验转盘",
		"随机星神碎片*200、千万金币等你来拿",
		1,
		true
	}
}
local t_wheel_lottery_pool = {
	[409001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_wheel_lottery_pool.dataList = dataList

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

return t_wheel_lottery_pool
