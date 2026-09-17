local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 16,
				sound = {
					"26620_attack",
					0.6
				}
			},
			{
				frame = 17,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run_attack",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "217920_effect",
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
				frame = 5,
				id = 217910010
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
	totalframe = 50,
	turnbacklimit = true,
	animation = "skill",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"27620_skill",
				0.6
			}
		},
		{
			frame = 25,
			id = 217920010
		},
		{
			frame = 35,
			id = 217920011
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
	totalframe = 133,
	xpeffect = "xp_effect",
	turnbacklimit = true,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"26820_xp",
				0.6
			}
		},
		{
			frame = 40,
			id = 217930010
		},
		{
			frame = 44,
			id = 217930010
		},
		{
			frame = 48,
			id = 217930010
		},
		{
			frame = 52,
			id = 217930010
		},
		{
			frame = 56,
			id = 217930010
		},
		{
			frame = 60,
			id = 217930010
		},
		{
			frame = 64,
			id = 217930010
		},
		{
			frame = 68,
			id = 217930010
		},
		{
			frame = 72,
			id = 217930010
		},
		{
			frame = 76,
			id = 217930010
		},
		{
			frame = 84,
			id = 217930011
		},
		{
			frame = 90,
			id = 217930012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "217920_bg",
	totalframe = 133,
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
			texture = "role/217920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/217920_xp",
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
