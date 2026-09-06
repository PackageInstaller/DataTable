-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_awaken_rare.lua

module("logicconfig.config.t_pet_awaken_rare", package.seeall)

local title = {
	totalRingNum = 8,
	name = 2,
	starNum = 5,
	rateOfPropertyBasicValue = 6,
	attrUpTitle = 11,
	rare_2 = 13,
	rare = 3,
	desc = 4,
	ringNum = 7,
	rare_3 = 14,
	upTitle = 10,
	rare_4 = 15,
	upDesc = 12,
	upBtnText = 9,
	lv = 1
}
local dataList = {
	{
		0,
		"无觉醒",
		1,
		"初代",
		0,
		1,
		-1,
		0,
		"觉醒",
		"无觉醒    <color=#60ee85>»»»</color>    <color=#60ee85>觉醒I</color>",
		"些微",
		"无觉醒",
		2,
		3,
		4
	},
	{
		1,
		"觉醒I",
		1,
		"幻兽",
		1,
		1,
		-1,
		0,
		"觉醒",
		"觉醒I    <color=#60ee85>»»»</color>    <color=#60ee85>觉醒II</color>",
		"些微",
		"觉醒I",
		2,
		3,
		4
	},
	{
		2,
		"觉醒II",
		1,
		"幻兽",
		2,
		1,
		-1,
		0,
		"觉醒",
		"觉醒II    <color=#60ee85>»»»</color>    <color=#60ee85>觉醒III</color>",
		"些微",
		"觉醒II",
		3,
		3,
		4
	},
	{
		3,
		"觉醒III",
		1,
		"超能",
		3,
		1,
		-1,
		0,
		"觉醒",
		"觉醒III    <color=#60ee85>»»»</color>    <color=#60ee85>觉醒IV</color>",
		"些微",
		"觉醒III",
		3,
		3,
		4
	},
	{
		4,
		"觉醒IV",
		1,
		"超能",
		4,
		1,
		-1,
		0,
		"觉醒",
		"觉醒IV    <color=#60ee85>»»»</color>    <color=#60ee85>觉醒V</color>",
		"些微",
		"觉醒IV",
		4,
		4,
		4
	},
	{
		5,
		"觉醒V",
		1,
		"超能",
		5,
		1,
		-1,
		0,
		"觉醒",
		"觉醒V    <color=#60ee85>»»»</color>    <color=#60ee85>觉醒VI</color>",
		"些微",
		"觉醒V",
		4,
		4,
		4
	},
	{
		6,
		"觉醒VI",
		1,
		"传说",
		6,
		1,
		-1,
		0,
		"觉醒",
		"当前已经 <color=#60ee85>满觉醒</color>",
		"些微",
		"觉醒VI",
		4,
		4,
		4
	}
}
local t_pet_awaken_rare = {
	[0] = dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_pet_awaken_rare.dataList = dataList

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

return t_pet_awaken_rare
