-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_jieshen_clg_normal_buff.lua

module("logicconfig.config.t_divine_jieshen_clg_normal_buff", package.seeall)

local title = {
	desc = 3,
	activityId = 1,
	passStageCount = 2
}
local dataList = {
	{
		387001,
		1,
		"全属性+10%"
	},
	{
		387001,
		2,
		"全属性+20%"
	},
	{
		387001,
		3,
		"全属性+40%"
	},
	{
		387001,
		4,
		"全属性+80%"
	},
	{
		387001,
		5,
		"全属性+120%"
	},
	{
		387001,
		6,
		"全属性+200%"
	},
	{
		387001,
		7,
		"全属性+300%"
	},
	{
		387001,
		8,
		"全属性+400%"
	},
	{
		387001,
		9,
		"全属性+600%"
	},
	{
		387001,
		10,
		"全属性+800%"
	}
}
local t_divine_jieshen_clg_normal_buff = {
	[387001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_divine_jieshen_clg_normal_buff.dataList = dataList

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

return t_divine_jieshen_clg_normal_buff
