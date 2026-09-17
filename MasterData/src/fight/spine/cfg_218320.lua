local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 19,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27820_attack",
					0.6
				}
			},
			{
				id = 218310010,
				frame = 10
			}
		}
	},
	attack2 = {
		totalframe = 31,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27820_attack",
					0.6
				}
			},
			{
				id = 218310010,
				frame = 18
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
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202520_skill",
					0.6
				}
			},
			{
				id = 218320010,
				behitted = "hitdown",
				frame = 30
			},
			{
				frame = 40,
				id = 218320011
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
		totalframe = 106,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202520_xp",
					0.6
				}
			},
			{
				frame = 25,
				id = 218330010
			},
			{
				frame = 46,
				id = 218330010
			},
			{
				frame = 57,
				id = 218330010
			},
			{
				frame = 69,
				id = 218330010
			},
			{
				frame = 90,
				id = 218330010
			},
			{
				frame = 91,
				id = 218330011
			},
			{
				frame = 100,
				id = 218330012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "218320_bg",
	totalframe = 106,
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
			texture = "role/218320.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 150,
			sound = {
				"role_voice/218320_xp",
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
