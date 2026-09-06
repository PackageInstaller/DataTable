-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mo_yan_challenge.lua

module("logicconfig.config.t_mo_yan_challenge", package.seeall)

local title = {
	challengeId = 1,
	rankSize = 2,
	GOODS_ID = 9,
	progressPrizePlan = 4,
	extItem2 = 7,
	extItem = 6,
	rankPrize = 3,
	challengePlan = 5,
	ruleKey = 8
}
local dataList = {
	{
		20,
		5999,
		"14:38:1",
		1,
		1,
		"100:10334",
		"100:10097",
		"honglianduijuechallenge",
		4522
	}
}
local t_mo_yan_challenge = {
	[20] = dataList[1]
}

t_mo_yan_challenge.dataList = dataList

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

return t_mo_yan_challenge
