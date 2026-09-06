-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_meng_meng_challenge_element_stage.lua

module("logicconfig.config.t_king_meng_meng_challenge_element_stage", package.seeall)

local title = {
	stageId = 2,
	name = 3,
	raceId = 5,
	buffName = 6,
	creepsMasterId = 4,
	buffDesc = 7,
	activityId = 1,
	buffIcon = 8
}
local dataList = {
	{
		278001,
		1,
		"水之元素",
		201,
		10142,
		"水之力量",
		"水系精灵攻击BOSS时伤害提升30%",
		"icon_expedition_xueliangtishengshanghai"
	},
	{
		278001,
		2,
		"火之元素",
		202,
		10143,
		"火之力量",
		"火系精灵攻击BOSS时获得30气势",
		"icon_expedition_yuzhanyuyong"
	},
	{
		278001,
		3,
		"草之元素",
		203,
		10144,
		"草之力量",
		"草系精灵受到BOSS伤害降低20%",
		"icon_expedition_dikang_cao"
	},
	{
		278001,
		4,
		"光之元素",
		204,
		10145,
		"光之力量",
		"光系精灵免疫一次BOSS伤害",
		"icon_expedition_wufang"
	},
	{
		278001,
		5,
		"暗之元素",
		205,
		10146,
		"暗之力量",
		"暗系精灵攻击会降低BOSS20%双防（不可叠加）",
		"icon_expedition_liaoxiaojiangdi"
	},
	{
		278002,
		1,
		"水之元素",
		201,
		10142,
		"水之力量",
		"水系精灵攻击BOSS时伤害提升30%",
		"icon_expedition_xueliangtishengshanghai"
	},
	{
		278002,
		2,
		"火之元素",
		202,
		10143,
		"火之力量",
		"火系精灵攻击BOSS时获得30气势",
		"icon_expedition_yuzhanyuyong"
	},
	{
		278002,
		3,
		"草之元素",
		203,
		10144,
		"草之力量",
		"草系精灵受到BOSS伤害降低20%",
		"icon_expedition_dikang_cao"
	},
	{
		278002,
		4,
		"光之元素",
		204,
		10145,
		"光之力量",
		"光系精灵免疫一次BOSS伤害",
		"icon_expedition_wufang"
	},
	{
		278002,
		5,
		"暗之元素",
		205,
		10146,
		"暗之力量",
		"暗系精灵攻击会降低BOSS20%双防（不可叠加）",
		"icon_expedition_liaoxiaojiangdi"
	}
}
local t_king_meng_meng_challenge_element_stage = {
	[278001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[278002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_king_meng_meng_challenge_element_stage.dataList = dataList

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

return t_king_meng_meng_challenge_element_stage
