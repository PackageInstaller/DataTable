-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_zhengli_buff.lua

module("logicconfig.config.t_origin_zhengli_buff", package.seeall)

local title = {
	buffType = 3,
	buffId = 2,
	buffDesc = 5,
	activateNeedPoints = 4,
	activityId = 1
}
local dataList = {
	{
		587001,
		1,
		2,
		30,
		"敌阵全属性及最大生命值+10%，且对我方通灵师造成的伤害增加15%"
	},
	{
		587001,
		2,
		1,
		30,
		"我方通灵师存活时，敌阵精灵提高40%的暴击率及暴击伤害"
	},
	{
		587001,
		3,
		1,
		30,
		"敌阵精灵首次阵亡时复活并恢复100%生命值"
	},
	{
		587001,
		4,
		1,
		30,
		"敌阵攻击力最高的精灵每个大回合首次出手后对我方通灵师造成自身攻击力*200%的伤害"
	},
	{
		587001,
		5,
		1,
		30,
		"敌阵精灵每次超杀后降低我方40通灵进度"
	},
	{
		587001,
		6,
		1,
		30,
		"敌阵精灵免疫所有负面状态且我方精灵进入战斗时获得禁疗（3个大回合）"
	},
	{
		587001,
		7,
		1,
		30,
		"敌阵精灵首次阵亡时解除无法回血状态复活并恢复50%生命值"
	}
}
local t_origin_zhengli_buff = {
	[587001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_origin_zhengli_buff.dataList = dataList

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

return t_origin_zhengli_buff
