local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 10,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "attack",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 700,
	offsetZ = 1,
	filename = "640600_effect",
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
		totalframe = 11,
		animation = "hit",
		exe_tbl = {
			{
				frame = 11,
				id = 64060021
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
	totalframe = 28,
	animation = "skill1",
	exe_tbl = {
		{
			frame = 1,
			sound = "21500_skill"
		},
		{
			frame = 21,
			id = 64060031
		},
		{
			frame = 23,
			id = 64060031
		},
		{
			frame = 25,
			id = 64060031
		},
		{
			frame = 26,
			id = 64060032
		}
	}
}
var_0_0.skill2 = {
	{
		{
			method = "useSkill",
			param = "useskill2"
		}
	}
}
var_0_0.useskill2 = {
	totalframe = 30,
	animation = "skill2",
	exe_tbl = {
		{
			frame = 1,
			sound = "21500_skill"
		},
		{
			frame = 8,
			id = 64060041
		},
		{
			frame = 11,
			id = 64060041
		},
		{
			frame = 14,
			id = 64060041
		},
		{
			frame = 17,
			id = 64060041
		},
		{
			frame = 20,
			id = 64060041
		},
		{
			frame = 23,
			id = 64060041
		},
		{
			frame = 24,
			id = 64060042
		}
	}
}
var_0_0.skill3 = {
	{
		{
			method = "useSkill",
			param = "useskill3"
		}
	}
}
var_0_0.useskill3 = {
	totalframe = 45,
	turnbacklimit = true,
	animation = "skill3",
	exe_tbl = {
		{
			frame = 1,
			sound = "100601_skill2"
		},
		{
			frame = 34,
			id = 64060051
		},
		{
			frame = 35,
			id = 64060052
		}
	}
}
var_0_0.xp = {
	{
		{
			method = "useSkill",
			param = "usexp"
		}
	}
}
var_0_0.usexp = {
	totalframe = 80,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = "100481_xp"
		},
		{
			frame = 62,
			id = 64060061
		},
		{
			frame = 64,
			id = 64060061
		},
		{
			frame = 66,
			id = 64060061
		},
		{
			frame = 68,
			id = 64060061
		},
		{
			frame = 70,
			id = 64060061
		},
		{
			frame = 72,
			id = 64060061
		},
		{
			frame = 74,
			id = 64060061
		},
		{
			frame = 78,
			id = 64060061
		},
		{
			frame = 79,
			id = 64060062
		}
	}
}

return var_0_0
