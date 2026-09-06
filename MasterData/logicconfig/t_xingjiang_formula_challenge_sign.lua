-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xingjiang_formula_challenge_sign.lua

module("logicconfig.config.t_xingjiang_formula_challenge_sign", package.seeall)

local title = {
	id = 2,
	prize = 3,
	signInPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"8:1:1000"
	},
	{
		1,
		2,
		"8:1:1000"
	},
	{
		1,
		3,
		"8:1:1000"
	},
	{
		1,
		4,
		"8:1:1000"
	},
	{
		1,
		5,
		"8:1:1000"
	},
	{
		1,
		6,
		"8:1:1000"
	},
	{
		1,
		7,
		"8:1:1000"
	},
	{
		1,
		8,
		"8:1:1000"
	},
	{
		1,
		9,
		"8:1:1000"
	},
	{
		1,
		10,
		"8:1:1000"
	},
	{
		1,
		11,
		"8:1:1000"
	},
	{
		1,
		12,
		"8:1:1000"
	}
}
local t_xingjiang_formula_challenge_sign = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_xingjiang_formula_challenge_sign.dataList = dataList

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

return t_xingjiang_formula_challenge_sign
