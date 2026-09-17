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
					"22320_attack",
					0.6
				}
			},
			{
				frame = 16,
				id = 220910010
			}
		}
	},
	attack2 = {
		totalframe = 30,
		turnbacklimit = true,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22320_attack",
					0.6
				}
			},
			{
				frame = 13,
				bullet = "attack2"
			}
		}
	}
}

var_0_0.extra.attack2 = {
	movingani = "run_attack",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "220920_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				frame = 4,
				id = 220910011
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
	totalframe = 47,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"22820_skill",
				0.6
			}
		},
		{
			frame = 10,
			bullet = "skill1"
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "run_attack",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "220920_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 60,
		animation = "skill",
		exe_tbl = {
			{
				id = 220920010,
				behitted = "hitdown",
				frame = 14
			},
			{
				frame = 18,
				id = 220920010
			},
			{
				id = 220920010,
				behitted = "hitdown",
				frame = 34
			},
			{
				frame = 38,
				id = 220920010
			},
			{
				frame = 44,
				id = 220920011
			},
			{
				frame = 50,
				id = 220920012
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
	totalframe = 124,
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
			frame = 56,
			id = 220930010
		},
		{
			frame = 63,
			id = 220930010
		},
		{
			frame = 70,
			id = 220930010
		},
		{
			frame = 77,
			id = 220930010
		},
		{
			frame = 84,
			id = 220930010
		},
		{
			frame = 90,
			id = 220930011
		},
		{
			frame = 100,
			id = 220930012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "220920_bg",
	totalframe = 124,
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
			texture = "role/220920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/220920_xp",
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
