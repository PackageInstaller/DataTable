-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_big_cast_challenge_job_prop.lua

module("logicconfig.config.t_big_cast_challenge_job_prop", package.seeall)

local title = {
	magicDefensePoint = 5,
	jobName = 1,
	hpPoint = 2,
	speedPoint = 6,
	physcialDefensePoint = 4,
	attackPoint = 3
}
local dataList = {
	{
		"利爪",
		30769,
		12615,
		2000,
		1846,
		1846
	},
	{
		"魔法",
		30769,
		12615,
		1846,
		2000,
		1846
	},
	{
		"疾速",
		36923,
		10462,
		2000,
		2000,
		2154
	},
	{
		"平衡",
		52308,
		9846,
		3231,
		3231,
		1385
	},
	{
		"肉盾",
		67692,
		7385,
		4000,
		4000,
		1231
	},
	{
		"治疗",
		44615,
		9231,
		3077,
		3077,
		1846
	}
}
local t_big_cast_challenge_job_prop = {
	利爪 = dataList[1],
	魔法 = dataList[2],
	疾速 = dataList[3],
	平衡 = dataList[4],
	肉盾 = dataList[5],
	治疗 = dataList[6]
}

t_big_cast_challenge_job_prop.dataList = dataList

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

return t_big_cast_challenge_job_prop
