-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_yu_hui_challenge.lua

module("logicconfig.config.t_yu_hui_challenge", package.seeall)

local title = {
	challengeId = 1,
	gotoCultivation = 8,
	redPointId = 10,
	gotoCall = 7,
	gotoRank = 6,
	gotoShop = 5,
	stagePlanId = 2,
	signInBuffPlanId = 4,
	buffPlanId = 3,
	openFunId = 9
}
local dataList = {
	{
		107,
		1,
		1,
		0,
		"mibao#honglianyaoshi4",
		"func#618#12012",
		"func#878",
		"",
		5055,
		0
	},
	{
		180,
		180,
		180,
		180,
		"mibao#shenyaolibao",
		"func#618#17017",
		"mibao#shenyaolibao",
		"",
		5125,
		0
	},
	{
		270,
		270,
		270,
		270,
		"func#545#52",
		"func#618#16042",
		"ui#lottery",
		"mibao#jinglingyangcheng",
		5216,
		0
	}
}
local t_yu_hui_challenge = {
	[107] = dataList[1],
	[180] = dataList[2],
	[270] = dataList[3]
}

t_yu_hui_challenge.dataList = dataList

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

return t_yu_hui_challenge
