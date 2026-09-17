local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20220-attack",
					0.6
				}
			},
			{
				id = 214610010,
				frame = 16
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20800_skill",
					0.6
				}
			},
			{
				id = 214610010,
				frame = 16
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp"
			}
		}
	},
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 49,
		turnbacklimit = false,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"28820_xp",
					0.6
				}
			},
			{
				frame = 37,
				id = 214620010
			},
			{
				frame = 38,
				id = 214620011
			},
			{
				frame = 39,
				id = 214620012
			},
			{
				frame = 40,
				id = 214620013
			},
			{
				frame = 41,
				id = 214620014
			}
		}
	},
	usexp = {
		totalframe = 106,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22220_xp",
					2
				}
			},
			{
				frame = 53,
				id = 214630010
			},
			{
				frame = 54,
				id = 214630011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 106,
	bgfile = "214620_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	inserteffect = {
		{
			texture = "role/214620.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/214620_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {}
	}
}

return var_0_0
