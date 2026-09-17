local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 27,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				id = 213610010,
				frame = 14
			}
		}
	},
	attack2 = {
		totalframe = 27,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_attack",
					0.6
				}
			},
			{
				id = 213610010,
				frame = 15
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
		totalframe = 50,
		turnbacklimit = false,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"203020_skill",
					0.6
				}
			},
			{
				frame = 1,
				id = 213620010
			},
			{
				id = 213620011,
				behitted = "hitdown",
				frame = 32
			},
			{
				frame = 34,
				id = 213620012
			},
			{
				frame = 35,
				id = 213620013
			}
		}
	},
	usexp = {
		totalframe = 105,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27420_xp",
					0.6
				}
			},
			{
				frame = 69,
				id = 213630010
			},
			{
				frame = 76,
				id = 213630010
			},
			{
				frame = 84,
				id = 213630010
			},
			{
				frame = 85,
				id = 213630011
			},
			{
				frame = 86,
				id = 213630012
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 105,
	bgfile = "213620_bg",
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
			texture = "role/213620.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/213620_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {
			{
				scale = 0.7,
				totalframe = 45,
				startframe = 30
			},
			{
				scale = 0.85,
				totalframe = 5,
				startframe = 75
			},
			{
				scale = 1,
				totalframe = 25,
				startframe = 80
			}
		},
		move = {
			{
				distance = 200,
				time = 0.2,
				distanceY = 0,
				totalframe = 60,
				startframe = 28
			}
		}
	}
}

return var_0_0
