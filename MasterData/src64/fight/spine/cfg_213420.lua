local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 47,
		animation = "attack",
		exe_tbl = {
			{
				frame = 3,
				sound = {
					"202420_atk",
					0.6
				}
			},
			{
				frame = 12,
				bullet = "attack1"
			},
			{
				frame = 17,
				bullet = "attack1"
			},
			{
				frame = 21,
				bullet = "attack2"
			},
			{
				frame = 27,
				bullet = "attack2"
			},
			{
				frame = 32,
				bullet = "attack2"
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
	filename = "213420_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 1.7,
		object = "self"
	},
	finalpos = {
		offsetY = 0.25,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 16,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 213410010
			}
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run_attack2",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1200,
	offsetZ = 1,
	filename = "213420_effect",
	initpos = {
		offsetY = 0.3,
		offsetX = 1.7,
		object = "self"
	},
	finalpos = {
		offsetY = 0.25,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 16,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				id = 213410011
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
	totalframe = 70,
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
			frame = 27,
			id = 213420010
		},
		{
			frame = 31,
			id = 213420010
		},
		{
			frame = 36,
			id = 213420010
		},
		{
			frame = 44,
			id = 213420010
		},
		{
			frame = 51,
			id = 213420010
		},
		{
			frame = 55,
			id = 213420010
		},
		{
			frame = 56,
			id = 213420011
		},
		{
			frame = 57,
			id = 213420012
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
	totalframe = 120,
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
			frame = 1,
			id = 213430010
		},
		{
			frame = 2,
			id = 213430011
		},
		{
			frame = 86,
			id = 213430012
		},
		{
			frame = 89,
			id = 213430012
		},
		{
			frame = 92,
			id = 213430012
		},
		{
			frame = 96,
			id = 213430012
		},
		{
			frame = 100,
			id = 213430012
		},
		{
			frame = 105,
			id = 213430012
		},
		{
			frame = 110,
			id = 213430012
		},
		{
			frame = 115,
			id = 213430012
		},
		{
			frame = 116,
			id = 213430013
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "213420_bg",
	totalframe = 119,
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
			texture = "role/213420.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/213420_xp",
				1
			}
		}
	},
	bgaction = {},
	lockframe = {},
	camera = {
		move = {
			{
				distance = 90,
				totalframe = 39,
				startframe = 80,
				time = 0.1
			}
		}
	}
}

return var_0_0
