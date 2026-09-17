local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 31,
		animation = "attack",
		exe_tbl = {
			{
				frame = 13,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 14,
				bullet = "attack1"
			},
			{
				frame = 22,
				bullet = "attack2"
			}
		}
	}
}

var_0_0.extra.attack1 = {
	movingani = "run_attack1",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "208020_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = -0.5,
		object = "target"
	},
	attack = {
		totalframe = 12,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 208010010
			}
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run_attack2",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "208020_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = -0.5,
		object = "target"
	},
	attack = {
		totalframe = 12,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 208010011
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
	totalframe = 48,
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
			id = 208020010
		},
		{
			frame = 17,
			id = 208020010
		},
		{
			frame = 21,
			id = 208020010
		},
		{
			frame = 30,
			id = 208020011
		},
		{
			frame = 31,
			id = 208020012
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
	totalframe = 80,
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
			frame = 29,
			id = 208030010
		},
		{
			frame = 35,
			id = 208030010
		},
		{
			frame = 35,
			id = 208030010
		},
		{
			frame = 42,
			id = 208030010
		},
		{
			frame = 46,
			id = 208030010
		},
		{
			frame = 50,
			id = 208030010
		},
		{
			frame = 54,
			id = 208030010
		},
		{
			frame = 57,
			id = 208030011
		},
		{
			frame = 80,
			id = 208030012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "208020_bg",
	totalframe = 80,
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
			texture = "role/208020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/208020_xp",
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
			totalframe = 96,
			intime = 0.2
		},
		move = {
			{
				distance = 140,
				totalframe = 96,
				startframe = 0,
				time = 0.8
			}
		}
	}
}

return var_0_0
