-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_yishi_challenge_common.lua

module("logicconfig.config.t_yishi_challenge_common", package.seeall)

local title = {
	challengeId = 1,
	jump_rank = 2,
	time = 5,
	raceId = 6,
	jump_shop = 4,
	pos = 8,
	jump_lotery = 3,
	desc = 7
}
local dataList = {
	{
		99,
		"func#618#16013",
		"func#830",
		"mibao#nvshentehui4",
		"活动时间：03.17 05:00 - 03.31 05:00",
		16013,
		"存活的精灵可点亮对应位置的元素，三个相同元素形成直线就可以通关关卡！",
		{
			0,
			50,
			0.9
		}
	},
	{
		226,
		"func#618#15034",
		"func#545#3",
		"ui#lottery",
		"活动时间：05.09 05:00 - 05.30 05:00",
		15034,
		"存活的精灵可点亮对应位置的元素，三个相同元素形成直线就可以通关关卡！",
		{
			0,
			50,
			0.9
		}
	}
}
local t_yishi_challenge_common = {
	[99] = dataList[1],
	[226] = dataList[2]
}

t_yishi_challenge_common.dataList = dataList

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

return t_yishi_challenge_common
