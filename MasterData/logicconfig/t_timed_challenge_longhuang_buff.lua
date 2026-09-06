-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_longhuang_buff.lua

module("logicconfig.config.t_timed_challenge_longhuang_buff", package.seeall)

local title = {
	buffKey = 5,
	name = 3,
	grade = 2,
	timeThreshold = 1,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		"强攻",
		"攻击伤害<color=#60ee85>+10%</color>",
		"10002"
	},
	{
		5,
		2,
		"强攻",
		"攻击伤害<color=#60ee85>+15%</color>",
		"10002"
	},
	{
		10,
		3,
		"强攻",
		"攻击伤害<color=#60ee85>+20%</color>",
		"10002"
	},
	{
		15,
		4,
		"强攻",
		"攻击伤害<color=#60ee85>+25%</color>",
		"10002"
	},
	{
		20,
		5,
		"强攻",
		"攻击伤害<color=#60ee85>+30%</color>",
		"10002"
	}
}
local t_timed_challenge_longhuang_buff = {
	dataList[1],
	[5] = dataList[2],
	[10] = dataList[3],
	[15] = dataList[4],
	[20] = dataList[5]
}

t_timed_challenge_longhuang_buff.dataList = dataList

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

return t_timed_challenge_longhuang_buff
