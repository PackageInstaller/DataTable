-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_war_buff.lua

module("logicconfig.config.t_ultimate_war_buff", package.seeall)

local title = {
	checkInDays = 3,
	activityId = 1,
	buffId = 2,
	buffDesc = 4
}
local dataList = {
	{
		434001,
		1,
		1,
		"生命+<color=#20b376>10%</color>\n全属性+<color=#20b376>10%</color>"
	},
	{
		434001,
		2,
		2,
		"生命+<color=#20b376>30%</color>\n全属性+<color=#20b376>30%</color>"
	},
	{
		434001,
		3,
		3,
		"生命+<color=#20b376>50%</color>\n全属性+<color=#20b376>50%</color>"
	},
	{
		434001,
		4,
		4,
		"生命+<color=#20b376>150%</color>\n全属性+<color=#20b376>150%</color>"
	},
	{
		434001,
		5,
		5,
		"生命+<color=#20b376>300%</color>\n全属性+<color=#20b376>300%</color>"
	},
	{
		434001,
		6,
		6,
		"生命+<color=#20b376>500%</color>\n全属性+<color=#20b376>500%</color>"
	},
	{
		434001,
		7,
		7,
		"生命+<color=#20b376>800%</color>\n全属性+<color=#20b376>800%</color>"
	}
}
local t_ultimate_war_buff = {
	[434001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_ultimate_war_buff.dataList = dataList

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

return t_ultimate_war_buff
