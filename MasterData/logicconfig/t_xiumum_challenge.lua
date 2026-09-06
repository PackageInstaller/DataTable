-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiumum_challenge.lua

module("logicconfig.config.t_xiumum_challenge", package.seeall)

local title = {
	challengeId = 6,
	gotoRank = 5,
	tierPlanId = 2,
	gotoExchangeShop = 4,
	activityId = 1,
	gotoShop = 3
}
local dataList = {
	{
		239001,
		1,
		"mibao#xinchun3",
		"func#191#191#191003",
		"func#618#15013",
		63
	},
	{
		239002,
		2,
		"mibao#shenyaolibao",
		"func#191#239#239002",
		"func#618#14015",
		116
	},
	{
		239003,
		3,
		"mibao#shenyaolibao",
		"func#191#239#239003",
		"func#618#16021",
		153
	}
}
local t_xiumum_challenge = {
	[239001] = dataList[1],
	[239002] = dataList[2],
	[239003] = dataList[3]
}

t_xiumum_challenge.dataList = dataList

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

return t_xiumum_challenge
