local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 27,
		turnbacklimit = true,
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
				frame = 14,
				id = 221910010
			}
		}
	},
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 60,
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
}

var_0_0.extra.skill1 = {
	movingani = "run_attack",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "221920_effect",
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
		totalframe = 37,
		animation = "skill",
		exe_tbl = {
			{
				id = 221920010,
				behitted = "hitdown",
				frame = 12
			},
			{
				frame = 29,
				id = 221920011
			},
			{
				frame = 30,
				id = 221920012
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
	totalframe = 123,
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
			frame = 48,
			id = 221930010
		},
		{
			frame = 62,
			id = 221930010
		},
		{
			frame = 76,
			id = 221930010
		},
		{
			frame = 90,
			id = 221930010
		},
		{
			frame = 104,
			id = 221930010
		},
		{
			frame = 105,
			id = 221930011
		},
		{
			frame = 120,
			id = 221930012
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1,
	bgfile = "221920_bg",
	totalframe = 123,
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
			texture = "role/221920.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/221920_xp",
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
