-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dual_dragon_buff.lua

module("logicconfig.config.t_origin_dual_dragon_buff", package.seeall)

local title = {
	activityId = 1,
	buffId = 2,
	buffDesc = 3
}
local dataList = {
	{
		618001,
		1,
		"受治疗最多的精灵，获得永久禁疗（不可清除）"
	},
	{
		618001,
		2,
		"生命值最低的精灵，进入战斗时立即死亡"
	},
	{
		618001,
		3,
		"造成伤害最高的精灵，受到的所有伤害+50%且获得禁疗（1个大回合）"
	},
	{
		618001,
		4,
		"造成伤害最高的精灵，进入战斗时立即死亡"
	}
}
local t_origin_dual_dragon_buff = {
	[618001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_origin_dual_dragon_buff.dataList = dataList

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

return t_origin_dual_dragon_buff
