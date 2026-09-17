local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 16,
				bullet = "attack",
				sound = {
					"20400_attack",
					0.6
				}
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "216320_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 0.8,
		object = "self"
	},
	finalpos = {
		offsetY = 0.2,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack",
		exe_tbl = {
			{
				id = 216310010,
				frame = 1
			},
			{
				id = 216310011,
				frame = 2
			},
			{
				id = 216310012,
				frame = 3
			}
		}
	}
}
var_0_0.attack2 = {
	totalframe = 30,
	animation = "attack2",
	exe_tbl = {
		{
			frame = 17,
			bullet = "attack",
			sound = {
				"20400_attack",
				0.6
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
	totalframe = 49,
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
			id = 216320010,
			behitted = "hitdown",
			frame = 17
		},
		{
			frame = 19,
			id = 216320010
		},
		{
			id = 216320010,
			behitted = "hitdown",
			frame = 23
		},
		{
			id = 216320010,
			behitted = "hitdown",
			frame = 26
		},
		{
			id = 216320010,
			behitted = "hitdown",
			frame = 30
		},
		{
			frame = 31,
			id = 216320011
		},
		{
			frame = 32,
			id = 216320012
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
	totalframe = 114,
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
			frame = 66,
			id = 216330010
		},
		{
			frame = 69,
			id = 216330010
		},
		{
			frame = 76,
			id = 216330010
		},
		{
			frame = 80,
			id = 216330010
		},
		{
			frame = 82,
			id = 216330010
		},
		{
			frame = 86,
			id = 216330010
		},
		{
			frame = 87,
			id = 216330010
		},
		{
			frame = 89,
			id = 216330010
		},
		{
			frame = 94,
			id = 216330010
		},
		{
			frame = 97,
			id = 216330011
		},
		{
			frame = 98,
			id = 216330012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "216320_bg",
	totalframe = 114,
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
			texture = "role/216320.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/216320_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		zoom = {},
		move = {
			{
				distance = 150,
				totalframe = 44,
				startframe = 60,
				time = 0.1
			}
		}
	}
}

return var_0_0
