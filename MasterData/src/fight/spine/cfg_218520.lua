local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 23,
		animation = "attack",
		exe_tbl = {
			{
				frame = 11,
				sound = {
					"28820_attack",
					0.6
				}
			},
			{
				frame = 12,
				bullet = "attack"
			}
		}
	},
	attack2 = {
		totalframe = 40,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"28720_attack2",
					0.6
				}
			},
			{
				id = 218510011,
				frame = 20
			},
			{
				id = 218510012,
				frame = 21
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "218520_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.25,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				frame = 6,
				id = 218510010
			}
		}
	}
}
var_0_0.skill1 = {
	{
		{
			method = "useSkill",
			param = "useskill1"
		}
	}
}
var_0_0.useskill1 = {
	totalframe = 55,
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
			frame = 16,
			id = 218520010
		},
		{
			frame = 30,
			id = 218520010
		},
		{
			frame = 31,
			id = 218520011
		},
		{
			frame = 45,
			id = 218520010
		},
		{
			frame = 46,
			id = 218520012
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "usexp1"
		}
	}
}
var_0_0.usexp1 = {
	totalframe = 113,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"22320_xp1",
				0.6
			}
		},
		{
			frame = 67,
			id = 218530011
		},
		{
			frame = 68,
			id = 218530010
		},
		{
			frame = 75,
			id = 218530010
		},
		{
			frame = 82,
			id = 218530010
		},
		{
			frame = 91,
			id = 218530010
		},
		{
			id = 218530010,
			behitted = "hitdown",
			frame = 105
		},
		{
			frame = 112,
			id = 218530012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "218520_bg",
	totalframe = 113,
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
			texture = "role/218520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 150,
			sound = {
				"role_voice/218520_xp",
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
