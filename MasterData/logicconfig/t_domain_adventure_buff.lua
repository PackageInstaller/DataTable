-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_domain_adventure_buff.lua

module("logicconfig.config.t_domain_adventure_buff", package.seeall)

local title = {
	prefabPath = 7,
	name = 4,
	buffId = 2,
	buffDesc = 5,
	iconPath = 6,
	blockId = 3,
	activityId = 1
}
local dataList = {
	{
		402001,
		1,
		755,
		"弑战燃砂",
		"群攻伤害+30%",
		"ui/icon/items/icon_attack_orange2",
		"scene/domainadventure/buff/domadv_buff_1"
	},
	{
		402001,
		2,
		489,
		"真坚砾石",
		"暴击伤害+30%",
		"ui/icon/items/icon_blood_orange1",
		"scene/domainadventure/buff/domadv_buff_2"
	},
	{
		402001,
		3,
		716,
		"泣血赤钻",
		"攻击时吸血30%",
		"ui/icon/items/icon_blood_purple2",
		"scene/domainadventure/buff/domadv_buff_3"
	},
	{
		402001,
		4,
		833,
		"琥色璨金",
		"普攻伤害+50%",
		"ui/icon/items/icon_defense_orange2",
		"scene/domainadventure/buff/domadv_buff_4"
	},
	{
		402001,
		5,
		115,
		"逐湮皎珀",
		"超杀伤害+30%",
		"ui/icon/items/icon_defense_purple2",
		"scene/domainadventure/buff/domadv_buff_5"
	},
	{
		402001,
		6,
		328,
		"极态幽珠",
		"非直接伤害+50%",
		"ui/icon/items/icon_mag_orange2",
		"scene/domainadventure/buff/domadv_buff_6"
	},
	{
		402001,
		7,
		38,
		"元素澄晶",
		"起始气势+50",
		"ui/icon/items/icon_mag_orange3",
		"scene/domainadventure/buff/domadv_buff_7"
	},
	{
		402001,
		8,
		336,
		"源能黯坠",
		"全属性+20%",
		"ui/icon/items/icon_speed_orange3",
		"scene/domainadventure/buff/domadv_buff_8"
	}
}
local t_domain_adventure_buff = {
	[402001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_domain_adventure_buff.dataList = dataList

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

return t_domain_adventure_buff
