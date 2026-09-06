-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_liu_dao_buff.lua

module("logicconfig.config.t_liu_dao_buff", package.seeall)

local title = {
	buffId = 1,
	buffResName = 3,
	buffDes = 2
}
local dataList = {
	{
		1,
		"全属性及其生命上限+20%",
		"icon_expedition_ydnzhufu"
	},
	{
		2,
		"攻击令对手无法恢复生命值、无法复活",
		"icon_expedition_shenqi_an"
	},
	{
		3,
		"每次出手后，伤害+10%",
		"icon_expedition_meicigongjizengshang"
	},
	{
		4,
		"受到致命伤害时使该伤害为0（最多触发1次）",
		"icon_expedition_xueliangtishengshanghai"
	},
	{
		5,
		"攻击有30%概率使对方昏睡2回合",
		"icon_expedition_tangping"
	},
	{
		6,
		"攻击吸收目标25气势",
		"icon_expedition_bianyi01"
	}
}
local t_liu_dao_buff = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_liu_dao_buff.dataList = dataList

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

return t_liu_dao_buff
