local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 26,
		animation = "attack",
		exe_tbl = {
			{
				frame = 4,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 8,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "204920_effect",
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
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 204910010
			}
		}
	}
}
var_0_0.attack2 = {
	totalframe = 26,
	animation = "attack2",
	exe_tbl = {
		{
			frame = 4,
			sound = {
				"202420_atk",
				0.6
			}
		},
		{
			frame = 9,
			bullet = "attack2"
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 900,
	offsetZ = 1,
	filename = "204920_effect",
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
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 204910010
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
	totalframe = 45,
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
			frame = 17,
			id = 204920010
		},
		{
			frame = 21,
			id = 204920010
		},
		{
			frame = 24,
			id = 204920010
		},
		{
			frame = 25,
			id = 204920011
		},
		{
			frame = 26,
			id = 204920012
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
	totalframe = 105,
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
			frame = 30,
			id = 204930010
		},
		{
			frame = 35,
			id = 204930010
		},
		{
			frame = 45,
			id = 204930010
		},
		{
			frame = 58,
			id = 204930010
		},
		{
			frame = 67,
			id = 204930010
		},
		{
			frame = 84,
			id = 204930010
		},
		{
			frame = 85,
			id = 204930011
		},
		{
			frame = 86,
			id = 204930012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "204920_bg",
	totalframe = 105,
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
			texture = "role/204920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/204920_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		{
			startframe = 25,
			scale = 1,
			anchory = 300,
			outtime = 0.3,
			totalframe = 105,
			intime = 0.2
		},
		move = {
			{
				distance = 110,
				totalframe = 105,
				startframe = 25,
				time = 0.8
			}
		}
	}
}

return var_0_0
