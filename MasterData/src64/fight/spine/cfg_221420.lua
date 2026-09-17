local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"240_atk",
					0.6
				}
			},
			{
				id = 221410010,
				frame = 18
			},
			{
				id = 221410011,
				frame = 19
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
					"20120-skill",
					0.6
				}
			},
			{
				frame = 10,
				id = 221420010
			},
			{
				frame = 23,
				id = 221420011
			},
			{
				frame = 36,
				id = 221420011
			},
			{
				frame = 37,
				id = 221420012
			},
			{
				frame = 38,
				id = 221420013
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
		totalframe = 131,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"260_xp",
					0.6
				}
			},
			{
				frame = 44,
				id = 221430010
			},
			{
				frame = 54,
				id = 221430010
			},
			{
				frame = 67,
				id = 221430010
			},
			{
				frame = 75,
				id = 221430010
			},
			{
				frame = 82,
				id = 221430010
			},
			{
				frame = 94,
				id = 221430011
			},
			{
				frame = 100,
				id = 221430012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "221420_bg",
	totalframe = 131,
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
			texture = "role/221420.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 150,
			sound = {
				"role_voice/221420_xp",
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
