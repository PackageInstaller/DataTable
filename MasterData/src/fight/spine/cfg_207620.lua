local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 23,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 16,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack",
	maxdistance = 500,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "207620_effect",
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
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 207610010
			},
			{
				frame = 1,
				id = 207610011
			}
		}
	}
}
var_0_0.attack2 = {
	totalframe = 28,
	animation = "attack2",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"202420_atk",
				0.6
			}
		},
		{
			frame = 21,
			bullet = "attack2"
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run_attack1",
	maxdistance = 500,
	movingtype = "locktarget",
	speed = 300,
	offsetZ = 1,
	filename = "207620_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 2.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = -0.5,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				id = 207610012
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
			frame = 34,
			bullet = "skill"
		}
	}
}
var_0_0.extra.skill = {
	movingani = "run_skill",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "207620_effect",
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
		totalframe = 15,
		animation = "skill",
		initpos = {
			offsetY = 0.2,
			offsetX = -1,
			object = "target"
		},
		exe_tbl = {
			{
				frame = 1,
				id = 207620010
			},
			{
				frame = 1,
				id = 207620011
			}
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
	totalframe = 125,
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
			frame = 72,
			id = 207630010
		},
		{
			frame = 79,
			id = 207630010
		},
		{
			frame = 86,
			id = 207630010
		},
		{
			frame = 93,
			id = 207630010
		},
		{
			frame = 100,
			id = 207630010
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "207620_bg",
	totalframe = 125,
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
			texture = "role/207620.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/207620_xp",
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
