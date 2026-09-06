-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_farnas_extreme_clg_buff.lua

module("logicconfig.config.t_farnas_extreme_clg_buff", package.seeall)

local title = {
	lockRaceCount = 2,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		333001,
		0,
		"我方精灵增加20%闪避率，20%命中率"
	},
	{
		333001,
		3,
		"我方精灵增加35%闪避率，35%命中率"
	},
	{
		333001,
		7,
		"我方精灵增加50%闪避率，50%命中率"
	},
	{
		333001,
		11,
		"我方精灵增加65%闪避率，65%命中率"
	},
	{
		333001,
		15,
		"我方精灵增加80%闪避率，80%命中率"
	},
	{
		333002,
		0,
		"我方精灵增加20%闪避率，20%命中率"
	},
	{
		333002,
		3,
		"我方精灵增加35%闪避率，35%命中率"
	},
	{
		333002,
		7,
		"我方精灵增加50%闪避率，50%命中率"
	},
	{
		333002,
		11,
		"我方精灵增加65%闪避率，65%命中率"
	},
	{
		333002,
		15,
		"我方精灵增加80%闪避率，80%命中率"
	}
}
local t_farnas_extreme_clg_buff = {
	[333001] = {
		[0] = dataList[1],
		[3] = dataList[2],
		[7] = dataList[3],
		[11] = dataList[4],
		[15] = dataList[5]
	},
	[333002] = {
		[0] = dataList[6],
		[3] = dataList[7],
		[7] = dataList[8],
		[11] = dataList[9],
		[15] = dataList[10]
	}
}

t_farnas_extreme_clg_buff.dataList = dataList

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

return t_farnas_extreme_clg_buff
