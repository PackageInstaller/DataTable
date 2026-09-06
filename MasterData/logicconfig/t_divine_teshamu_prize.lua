-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_teshamu_prize.lua

module("logicconfig.config.t_divine_teshamu_prize", package.seeall)

local title = {
	activityId = 1,
	ruleDesc = 4,
	floorId = 2,
	prize = 3
}
local dataList = {
	{
		504001,
		1,
		"4:395:20",
		"1、布阵时必须上阵助战精灵神曜特莎姆，且特莎姆位置固定不可调整。每一关特莎姆的血量与上一关己阵阵亡精灵数量相关，每阵亡一只精灵特莎姆血量减少20%。\r\n2、每一关派有士兵驻守，挑战前判断敌我双方士兵数量，数量多的一方激活压制效果，数量相等则不激活压制效果，压制效果由双方士兵差值决定。\r\n3、成功破阵后，己阵每存活一个精灵，我方士兵数量增加20%，神曜特莎姆若阵亡则士兵数量不增加。"
	},
	{
		504001,
		2,
		"4:395:30",
		"1、布阵时必须上阵助战精灵神曜特莎姆，且特莎姆位置固定不可调整。每一关特莎姆的血量与上一关己阵阵亡精灵数量相关，每阵亡一只精灵特莎姆血量减少20%。\r\n2、每一关派有士兵驻守，挑战前判断敌我双方士兵数量，数量多的一方激活压制效果，数量相等则不激活压制效果，压制效果由双方士兵差值决定。\r\n3、成功破阵后，己阵每存活一个精灵，我方士兵数量增加20%，神曜特莎姆若阵亡则士兵数量不增加。"
	},
	{
		504001,
		3,
		"4:395:50",
		"1、布阵时必须上阵助战精灵神曜特莎姆，且特莎姆位置固定不可调整。每一关特莎姆的血量与上一关己阵阵亡精灵数量相关，每阵亡一只精灵特莎姆血量减少20%。\r\n2、每一关派有士兵驻守，挑战前判断敌我双方士兵数量，数量多的一方激活压制效果，数量相等则不激活压制效果，压制效果由双方士兵差值决定。\r\n3、成功破阵后，己阵每存活一个精灵，我方士兵数量增加20%，神曜特莎姆若阵亡则士兵数量不增加。"
	}
}
local t_divine_teshamu_prize = {
	[504001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_divine_teshamu_prize.dataList = dataList

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

return t_divine_teshamu_prize
