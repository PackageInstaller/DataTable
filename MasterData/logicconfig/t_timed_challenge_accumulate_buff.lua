-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_accumulate_buff.lua

module("logicconfig.config.t_timed_challenge_accumulate_buff", package.seeall)

local title = {
	benefit = 6,
	name = 3,
	buffId = 1,
	grade = 2,
	buffKey = 5,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		"弱击",
		"攻击伤害<color=#eb4642>-20%</color>",
		"10001",
		2
	},
	{
		2,
		2,
		"弱击",
		"攻击伤害<color=#eb4642>-10%</color>",
		"10001",
		2
	},
	{
		3,
		1,
		"强攻",
		"攻击伤害<color=#60ee85>+10%</color>",
		"10002",
		1
	},
	{
		4,
		2,
		"强攻",
		"攻击伤害<color=#60ee85>+20%</color>",
		"10002",
		1
	},
	{
		5,
		3,
		"强攻",
		"攻击伤害<color=#60ee85>+30%</color>",
		"10002",
		1
	},
	{
		6,
		4,
		"强攻",
		"攻击伤害<color=#60ee85>+50%</color>",
		"10002",
		1
	}
}
local t_timed_challenge_accumulate_buff = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_timed_challenge_accumulate_buff.dataList = dataList

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

return t_timed_challenge_accumulate_buff
