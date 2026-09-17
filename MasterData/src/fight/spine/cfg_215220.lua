local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 24,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202820_attack",
					0.6
				}
			},
			{
				id = 215210010,
				frame = 16
			}
		}
	},
	attack2 = {
		totalframe = 24,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202820_attack",
					0.6
				}
			},
			{
				id = 215210010,
				frame = 16
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
		totalframe = 52,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"28820_skill",
					0.6
				}
			},
			{
				frame = 34,
				id = 215220010
			},
			{
				frame = 39,
				id = 215220010
			},
			{
				frame = 34,
				id = 215220010
			},
			{
				frame = 46,
				id = 215220011
			},
			{
				frame = 48,
				id = 215220012
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp1"
			}
		}
	},
	usexp1 = {
		totalframe = 117,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"28820_xp",
					0.6
				}
			},
			{
				frame = 1,
				id = 215230010
			},
			{
				frame = 65,
				id = 215230011
			},
			{
				frame = 73,
				id = 215230011
			},
			{
				frame = 80,
				id = 215230011
			},
			{
				frame = 89,
				id = 215230011
			},
			{
				frame = 97,
				id = 215230011
			},
			{
				frame = 98,
				id = 215230012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "215220_bg",
	totalframe = 116,
	locktarget = {
		locktargetpool = "oponent",
		locktarget = false
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
			texture = "role/215220.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/215220_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		zoom = {},
		move = {}
	}
}

return var_0_0
