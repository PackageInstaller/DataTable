local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 24,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22120_attack",
					0.6
				}
			},
			{
				frame = 12,
				id = 207010010
			}
		}
	},
	attack2 = {
		totalframe = 26,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20100_attack",
					0.6
				}
			},
			{
				frame = 11,
				id = 207010010
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
		totalframe = 42,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"240_skill",
					0.6
				}
			},
			{
				frame = 14,
				id = 207020010
			},
			{
				frame = 16,
				id = 207020011
			},
			{
				frame = 19,
				id = 207020011
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
		totalframe = 110,
		xpeffect = "xp_effect",
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
				frame = 35,
				id = 207030010
			},
			{
				frame = 45,
				id = 207030011
			},
			{
				frame = 59,
				id = 207030011
			},
			{
				frame = 69,
				id = 207030011
			},
			{
				frame = 79,
				id = 207030012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1.05,
	bgfile = "207020_bg",
	totalframe = 110,
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
			texture = "role/207020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/207020_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		{
			startframe = 0,
			scale = 1,
			anchory = 200,
			outtime = 0.1,
			totalframe = 110,
			intime = 0.2
		},
		move = {
			{
				distance = -30,
				totalframe = 94,
				startframe = 0,
				time = 0.8
			}
		}
	}
}

return var_0_0
