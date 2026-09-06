-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_an_extreme_buff.lua

module("logicconfig.config.t_origin_an_extreme_buff", package.seeall)

local title = {
	activityId = 1,
	buffDesc = 4,
	buffId = 2,
	blockHealTimes = 3
}
local dataList = {
	{
		589001,
		1,
		5,
		"敌阵获得10%免伤及非伤免伤，每次闪避后，永久提升自己20%全属性"
	},
	{
		589001,
		2,
		10,
		"敌阵获得20%免伤及非伤免伤，每次闪避后，永久提升自己25%全属性"
	},
	{
		589001,
		3,
		20,
		"敌阵获得20%免伤及非伤免伤，每次闪避后，永久提升自己30%全属性"
	},
	{
		589001,
		4,
		30,
		"敌阵获得30%免伤及非伤免伤，每次闪避后，永久提升自己35%全属性"
	}
}
local t_origin_an_extreme_buff = {
	[589001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_origin_an_extreme_buff.dataList = dataList

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

return t_origin_an_extreme_buff
