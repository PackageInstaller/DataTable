-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_teshamu_buff.lua

module("logicconfig.config.t_divine_teshamu_buff", package.seeall)

local title = {
	activityId = 1,
	difference = 3,
	buffId = 2,
	buffDesc = 4
}
local dataList = {
	{
		504001,
		1,
		10,
		"士兵数量少的一方全属性，生命上限减少10%，起始气势-10"
	},
	{
		504001,
		2,
		20,
		"士兵数量少的一方全属性，生命上限减少20%，起始气势-20"
	},
	{
		504001,
		3,
		30,
		"士兵数量少的一方全属性，生命上限减少30%，起始气势-30"
	},
	{
		504001,
		4,
		40,
		"士兵数量少的一方全属性，生命上限减少40%，起始气势-40"
	},
	{
		504001,
		5,
		50,
		"士兵数量少的一方全属性，生命上限减少50%，起始气势-50"
	},
	{
		504001,
		6,
		100,
		"士兵数量少的一方全属性，生命上限减少70%，起始气势-50"
	},
	{
		504001,
		7,
		200,
		"士兵数量少的一方全属性，生命上限减少90%，起始气势-50"
	}
}
local t_divine_teshamu_buff = {
	[504001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_divine_teshamu_buff.dataList = dataList

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

return t_divine_teshamu_buff
