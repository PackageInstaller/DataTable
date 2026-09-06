-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xu_challenge_buff.lua

module("logicconfig.config.t_xu_challenge_buff", package.seeall)

local title = {
	activityId = 1,
	desc = 4,
	buffId = 2,
	sacrificeNum = 3
}
local dataList = {
	{
		613001,
		1,
		1,
		"敌阵免伤+10%，吸血+10%，攻击后对目标造成自身攻击*30%的伤害"
	},
	{
		613001,
		2,
		2,
		"敌阵免伤+10%，吸血+10%，攻击后对目标造成自身攻击*40%的伤害"
	},
	{
		613001,
		3,
		3,
		"敌阵免伤+10%，吸血+10%，攻击后对目标造成自身攻击*50%的伤害"
	},
	{
		613001,
		4,
		4,
		"敌阵免伤+15%，吸血+15%，攻击后对目标造成自身攻击*60%的伤害"
	},
	{
		613001,
		5,
		5,
		"敌阵免伤+20%，吸血+20%，攻击后对目标造成自身攻击*70%的伤害"
	},
	{
		613001,
		6,
		6,
		"敌阵免伤+25%，吸血+25%，攻击后对目标造成自身攻击*80%的伤害"
	},
	{
		613001,
		7,
		7,
		"敌阵获得免伤+30%，吸血+30%，攻击后对目标造成自身攻击*90%的伤害"
	}
}
local t_xu_challenge_buff = {
	[613001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_xu_challenge_buff.dataList = dataList

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

return t_xu_challenge_buff
