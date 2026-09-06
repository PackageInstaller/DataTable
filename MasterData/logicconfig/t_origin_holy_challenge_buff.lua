-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_holy_challenge_buff.lua

module("logicconfig.config.t_origin_holy_challenge_buff", package.seeall)

local title = {
	planId = 1,
	enemyLiveNum = 3,
	buffId = 2,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		"5-6",
		"对满血目标造成的伤害增加40%，对血量小于50%的目标造成的伤害增加30%"
	},
	{
		1,
		2,
		"<=4",
		"减伤及非伤减伤提高10%，阵亡后对敌阵战力最高的存活精灵施加沉默（2回合）"
	},
	{
		1,
		3,
		"<=2",
		"减伤及非伤减伤提高10%，出手后给自身添加生命值*30%的护盾（可叠加，最多90%）"
	}
}
local t_origin_holy_challenge_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_origin_holy_challenge_buff.dataList = dataList

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

return t_origin_holy_challenge_buff
