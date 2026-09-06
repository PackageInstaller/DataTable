-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_zhong_fei_clg_extreme_buff.lua

module("logicconfig.config.t_divine_zhong_fei_clg_extreme_buff", package.seeall)

local title = {
	killNum = 2,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		515001,
		1,
		"己阵非龙族精灵，全属性和最大生命值-10%"
	},
	{
		515001,
		2,
		"己阵非龙族精灵，全属性和最大生命值-20%"
	},
	{
		515001,
		3,
		"己阵非龙族精灵，全属性和最大生命值-30%"
	},
	{
		515001,
		4,
		"己阵非龙族精灵，全属性和最大生命值-40%"
	},
	{
		515001,
		5,
		"己阵非龙族精灵，全属性和最大生命值-50%，且全体造成的伤害-20%"
	}
}
local t_divine_zhong_fei_clg_extreme_buff = {
	[515001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_divine_zhong_fei_clg_extreme_buff.dataList = dataList

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

return t_divine_zhong_fei_clg_extreme_buff
