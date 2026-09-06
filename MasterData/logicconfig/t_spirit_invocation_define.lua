-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_spirit_invocation_define.lua

module("logicconfig.config.t_spirit_invocation_define", package.seeall)

local title = {
	playerLimitClazz = 3,
	name = 2,
	enterEffectRes = 13,
	frontImgRes = 12,
	headOffset = 9,
	idleEffectRes = 15,
	playerLimitParams = 4,
	enterEffectOffset = 14,
	headImgRes = 10,
	spiritSkinId = 6,
	minTriggerProgress = 8,
	spiritInvocationSkillId = 1,
	backImgRes = 11,
	uiEffectRes = 17,
	uiEffectOffset = 18,
	idleEffectOffset = 16,
	spiritRaceId = 5,
	spiritAttributePlanId = 7
}
local dataList = {
	{
		716893,
		"唤灵技测试",
		"AllEffected",
		"",
		16893,
		16893,
		1,
		20,
		{
			-40,
			0
		},
		"board_zd_hls_01",
		"board_zd_hls_02",
		"board_zd_hls_03",
		"20260724/lingti/fx_ui_chuchang02.prefab",
		{
			26,
			-51
		},
		"20260724/lingti/fx_ui_daiji02.prefab",
		{
			195,
			-150
		},
		"",
		{
			195,
			-150
		}
	},
	{
		716047,
		"零界矩阵·无限未来",
		"GenderCreature",
		"女性#5",
		46047,
		46047,
		1,
		100,
		{
			-40,
			0
		},
		"board_zd_hls_01",
		"board_zd_hls_02",
		"board_zd_hls_03",
		"20260724/lingti/fx_ui_chuchang02.prefab",
		{
			26,
			-51
		},
		"20260724/lingti/fx_ui_daiji02.prefab",
		{
			195,
			-150
		},
		"",
		{
			195,
			-150
		}
	},
	{
		71604702,
		"恋颂序言·无限未来",
		"GenderCreature",
		"女性#5",
		46047,
		4604702,
		1,
		100,
		{
			-40,
			0
		},
		"board_zd_hls_04",
		"board_zd_hls_05",
		"board_zd_hls_06",
		"20260724/lingti/fx_ui_chuchang01.prefab",
		{
			-6,
			-51
		},
		"20260724/lingti/fx_ui_daiji01.prefab",
		{
			195,
			-141
		},
		"",
		{
			195,
			-141
		}
	}
}
local t_spirit_invocation_define = {
	[716893] = dataList[1],
	[716047] = dataList[2],
	[71604702] = dataList[3]
}

t_spirit_invocation_define.dataList = dataList

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

return t_spirit_invocation_define
