-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tun_tian_extreme_clg_stage_type.lua

module("logicconfig.config.t_tun_tian_extreme_clg_stage_type", package.seeall)

local title = {
	balanceType = 5,
	typeName = 3,
	balancedConvertPlanId = 6,
	tipsOne = 7,
	stageType = 2,
	activityId = 1,
	realName = 4
}
local dataList = {
	{
		289001,
		1,
		"<color=#067015FF>喜</color>",
		"回合数",
		1,
		1,
		"<color=#4eaeff>心情值说明：</color>根据挑战使用的回合数换算成心情值-喜"
	},
	{
		289001,
		2,
		"<color=#067015FF>怒</color>",
		"存活数",
		2,
		2,
		"<color=#4eaeff>心情值说明：</color>根据我方精灵存活数换算成心情值-怒"
	},
	{
		289001,
		3,
		"<color=#067015FF>哀</color>",
		"变身次数",
		3,
		3,
		"<color=#4eaeff>心情值说明：</color>根据我方精灵变身次数换算成心情值-哀"
	},
	{
		289001,
		4,
		"<color=#067015FF>乐</color>",
		"克制攻击",
		3,
		4,
		"<color=#4eaeff>心情值说明：</color>根据我方克制攻击次数换算成心情值-乐"
	},
	{
		289002,
		1,
		"<color=#067015FF>喜</color>",
		"回合数",
		1,
		1,
		"<color=#4eaeff>心情值说明：</color>根据挑战使用的回合数换算成心情值-喜"
	},
	{
		289002,
		2,
		"<color=#067015FF>怒</color>",
		"存活数",
		2,
		2,
		"<color=#4eaeff>心情值说明：</color>根据我方精灵存活数换算成心情值-怒"
	},
	{
		289002,
		3,
		"<color=#067015FF>哀</color>",
		"变身次数",
		3,
		3,
		"<color=#4eaeff>心情值说明：</color>根据我方精灵变身次数换算成心情值-哀"
	},
	{
		289002,
		4,
		"<color=#067015FF>乐</color>",
		"克制攻击",
		3,
		4,
		"<color=#4eaeff>心情值说明：</color>根据我方克制攻击次数换算成心情值-乐"
	}
}
local t_tun_tian_extreme_clg_stage_type = {
	[289001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[289002] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_tun_tian_extreme_clg_stage_type.dataList = dataList

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

return t_tun_tian_extreme_clg_stage_type
