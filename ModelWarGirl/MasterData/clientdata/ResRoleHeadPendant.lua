-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResRoleHeadPendant.lua

local RT = {}

RT[1] = {
	value = 800,
	type = 13
}
RT[2] = {
	value = 200,
	type = 11
}

local Data = {
	[830001] = {
		picture_name = "BgPendant01",
		head_pendant_id = 830001,
		picture_path = "Atlas/PlayerInforAtlas/PlayerInfoAtlas2",
		limit_day = 60,
		desc = Lang.get(66374),
		name = Lang.get(65640)
	},
	[830002] = {
		picture_name = "BgPendant02",
		head_pendant_id = 830002,
		picture_path = "Atlas/PlayerInforAtlas/PlayerInfoAtlas2",
		limit_day = 60,
		desc = Lang.get(66375),
		name = Lang.get(66290)
	},
	[830003] = {
		picture_name = "BgPendant03",
		head_pendant_id = 830003,
		picture_path = "Atlas/PlayerInforAtlas/PlayerInfoAtlas2",
		limit_day = 60,
		desc = Lang.get(66376),
		name = Lang.get(66292)
	},
	[830004] = {
		effect_path = "Effects/UI/efx_ui_brochatmessage.prefab",
		picture_name = "BgPendant04",
		head_pendant_id = 830004,
		picture_path = "Atlas/PlayerInforAtlas/PlayerInfoAtlas2",
		limit_day = 60,
		desc = Lang.get(66377),
		name = Lang.get(65642)
	},
	[830005] = {
		effect_path = "Effects/UI/efx_ui_brochatmessage_1.prefab",
		picture_name = "BgPendant05",
		head_pendant_id = 830005,
		picture_path = "Atlas/PlayerInforAtlas/PlayerInfoAtlas2",
		limit_day = 60,
		desc = Lang.get(66378),
		name = Lang.get(65644)
	},
	[830006] = {
		picture_name = "BgPendant09",
		head_pendant_id = 830006,
		picture_path = "Atlas/PlayerInforAtlas/PlayerInfoAtlas2",
		limit_day = 2,
		desc = Lang.get(76903),
		name = Lang.get(78577)
	},
	[830007] = {
		picture_name = "BgPendant08",
		head_pendant_id = 830007,
		picture_path = "Atlas/PlayerInforAtlas/PlayerInfoAtlas2",
		limit_day = 2,
		desc = Lang.get(76904),
		name = Lang.get(78575)
	},
	[830008] = {
		picture_name = "BgPendant07",
		head_pendant_id = 830008,
		picture_path = "Atlas/PlayerInforAtlas/PlayerInfoAtlas2",
		limit_day = 2,
		desc = Lang.get(76905),
		name = Lang.get(78573)
	},
	[830009] = {
		picture_name = "BgPendant06",
		head_pendant_id = 830009,
		picture_path = "Atlas/PlayerInforAtlas/PlayerInfoAtlas2",
		limit_day = 2,
		desc = Lang.get(76906),
		name = Lang.get(78571)
	},
	[830010] = {
		effect_path = "Effects/UI/efx_ui_brochatmessage.prefab",
		name = "【备注文本】测试挂件",
		picture_name = "BgPendant04",
		head_pendant_id = 830010,
		picture_path = "Atlas/PlayerInforAtlas/PlayerInfoAtlas2",
		limit_day = 10,
		attrs = {
			{
				value = 100,
				type = 11
			},
			RT[1]
		},
		desc = Lang.get(81387)
	},
	[830011] = {
		effect_path = "Effects/UI/efx_ui_brochatmessage.prefab",
		name = "【备注文本】测试挂件",
		picture_name = "BgPendant04",
		head_pendant_id = 830011,
		picture_path = "Atlas/PlayerInforAtlas/PlayerInfoAtlas2",
		limit_day = 10,
		attrs = {
			RT[2]
		},
		desc = Lang.get(81387)
	},
	[830012] = {
		picture_name = "BgPendant10",
		head_pendant_id = 830012,
		picture_path = "Atlas/PlayerInforAtlas/PlayerInfoAtlas2",
		limit_day = 30,
		attrs = {
			RT[2],
			RT[1]
		},
		desc = Lang.get(96872),
		name = Lang.get(90315)
	},
	[999999] = {
		picture_name = "HeadFrame00",
		head_pendant_id = 999999,
		picture_path = "Atlas/CommonAtlas/HeadFrameAtlas/HeadFrameAtlas01",
		desc = Lang.get(67099),
		name = Lang.get(67100)
	}
}

return Data
