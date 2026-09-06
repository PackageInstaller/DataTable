-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_dark_mm_challenge_buff.lua

module("logicconfig.config.t_holy_dark_mm_challenge_buff", package.seeall)

local title = {
	num = 2,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		284001,
		1,
		"己阵全属性+<color=#20b376>30%</color>"
	},
	{
		284001,
		2,
		"己阵全属性+<color=#20b376>60%</color>"
	},
	{
		284001,
		3,
		"己阵全属性+<color=#20b376>120%</color>"
	},
	{
		284001,
		4,
		"己阵全属性+<color=#20b376>250%</color>"
	},
	{
		284001,
		5,
		"己阵全属性+<color=#20b376>500%</color>"
	},
	{
		284001,
		6,
		"己阵全属性+<color=#20b376>500%</color>"
	},
	{
		284002,
		1,
		"己阵全属性+<color=#20b376>30%</color>"
	},
	{
		284002,
		2,
		"己阵全属性+<color=#20b376>60%</color>"
	},
	{
		284002,
		3,
		"己阵全属性+<color=#20b376>120%</color>"
	},
	{
		284002,
		4,
		"己阵全属性+<color=#20b376>250%</color>"
	},
	{
		284002,
		5,
		"己阵全属性+<color=#20b376>500%</color>"
	},
	{
		284002,
		6,
		"己阵全属性+<color=#20b376>500%</color>"
	}
}
local t_holy_dark_mm_challenge_buff = {
	[284001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[284002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_holy_dark_mm_challenge_buff.dataList = dataList

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

return t_holy_dark_mm_challenge_buff
