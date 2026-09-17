local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
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
				frame = 9,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 3000,
	offsetZ = 1,
	filename = "210920_effect",
	initpos = {
		offsetY = 1.5,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.7,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 210910010
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
			frame = 32,
			bullet = "skill1"
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "run_attack2",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 3000,
	offsetZ = 1,
	filename = "210920_effect",
	initpos = {
		offsetY = 1.5,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.7,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "skil",
		exe_tbl = {
			{
				frame = 1,
				id = 210920010
			},
			{
				frame = 2,
				id = 210920011
			},
			{
				frame = 10,
				id = 210920012
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
			frame = 1,
			id = 210930010
		},
		{
			frame = 2,
			id = 210930011
		},
		{
			frame = 43,
			id = 210930012
		},
		{
			frame = 46,
			id = 210930012
		},
		{
			frame = 51,
			id = 210930012
		},
		{
			frame = 58,
			id = 210930012
		},
		{
			frame = 62,
			id = 210930012
		},
		{
			frame = 67,
			id = 210930012
		},
		{
			frame = 74,
			id = 210930012
		},
		{
			frame = 82,
			id = 210930012
		},
		{
			frame = 90,
			id = 210930012
		},
		{
			frame = 93,
			id = 210930013
		},
		{
			frame = 94,
			id = 210930014
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "210920_bg",
	totalframe = 104,
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
			texture = "role/210920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/210920_xp",
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
