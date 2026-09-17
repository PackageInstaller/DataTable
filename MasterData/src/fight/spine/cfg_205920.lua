local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 3,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 3,
				bullet = "attack1"
			}
		}
	}
}

var_0_0.extra.attack1 = {
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1200,
	offsetZ = 1,
	filename = "205920_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = -0.5,
		object = "target"
	},
	attack = {
		totalframe = 20,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 5,
				id = 205910010
			}
		}
	}
}
var_0_0.attack2 = {
	totalframe = 30,
	animation = "attack2",
	exe_tbl = {
		{
			frame = 3,
			sound = {
				"202420_atk",
				0.6
			}
		},
		{
			frame = 3,
			bullet = "attack2"
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run_attack2",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1200,
	offsetZ = 1,
	filename = "205920_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = -0.5,
		object = "target"
	},
	attack = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 5,
				id = 205910011
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
	totalframe = 41,
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
			frame = 22,
			id = 205920010
		},
		{
			frame = 25,
			id = 205920010
		},
		{
			frame = 26,
			id = 205920011
		},
		{
			frame = 35,
			id = 205920012
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
	totalframe = 115,
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
			frame = 47,
			id = 205930010
		},
		{
			frame = 66,
			id = 205930010
		},
		{
			frame = 85,
			id = 205930010
		},
		{
			frame = 86,
			id = 205930011
		},
		{
			frame = 95,
			id = 205930012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "205920_bg",
	totalframe = 115,
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
			texture = "role/205920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/205920_xp",
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
			totalframe = 115,
			intime = 0.2
		},
		move = {
			{
				distance = 110,
				totalframe = 115,
				startframe = 0,
				time = 0.8
			}
		}
	}
}

return var_0_0
