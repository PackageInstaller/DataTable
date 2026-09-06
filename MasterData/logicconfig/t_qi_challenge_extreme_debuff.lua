-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_qi_challenge_extreme_debuff.lua

module("logicconfig.config.t_qi_challenge_extreme_debuff", package.seeall)

local title = {
	buffId = 3,
	tagShow = 4,
	time = 2,
	deBuffPlanId = 1
}
local dataList = {
	{
		1,
		1,
		1,
		"15%↓"
	},
	{
		1,
		2,
		2,
		"30%↓"
	},
	{
		1,
		3,
		3,
		"50%↓"
	},
	{
		1,
		4,
		4,
		"80%↓"
	},
	{
		1,
		5,
		5,
		"99%↓"
	}
}
local t_qi_challenge_extreme_debuff = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_qi_challenge_extreme_debuff.dataList = dataList

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

return t_qi_challenge_extreme_debuff
