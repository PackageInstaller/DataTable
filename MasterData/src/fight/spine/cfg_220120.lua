local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 35,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21100_attack",
					0.6
				}
			},
			{
				id = 220110010,
				frame = 24
			},
			{
				id = 220110011,
				frame = 24
			}
		}
	},
	attack2 = {
		totalframe = 35,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"23320_atk",
					0.6
				}
			},
			{
				id = 220110010,
				frame = 24
			},
			{
				id = 220110011,
				frame = 24
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
		totalframe = 51,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"260_skill1",
					0.6
				}
			},
			{
				frame = 45,
				id = 220120010
			},
			{
				frame = 46,
				id = 220120011
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
		totalframe = 138,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"241_xp",
					0.6
				}
			},
			{
				frame = 73,
				id = 220130010
			},
			{
				frame = 75,
				id = 220130010
			},
			{
				frame = 77,
				id = 220130010
			},
			{
				frame = 79,
				id = 220130010
			},
			{
				frame = 90,
				id = 220130011
			},
			{
				frame = 92,
				id = 220130012
			},
			{
				frame = 100,
				id = 220130013
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "220120_bg",
	totalframe = 138,
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
			texture = "role/220120.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 150,
			sound = {
				"role_voice/220120_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		move = {}
	}
}

return var_0_0
