local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 18,
		animation = "attack",
		exe_tbl = {
			{
				frame = 11,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "1",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "630600_effect",
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
		animation = "2",
		exe_tbl = {
			{
				frame = 1,
				id = 63060021
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
	animation = "skill1",
	exe_tbl = {
		{
			frame = 1,
			sound = "21500_skill"
		},
		{
			frame = 26,
			id = 63060031
		},
		{
			frame = 27,
			id = 63060032
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
	totalframe = 53,
	turnbacklimit = true,
	animation = "skill2",
	exe_tbl = {
		{
			frame = 33,
			id = 63060041
		},
		{
			id = 63060041,
			behitted = "hitdown",
			frame = 42
		},
		{
			frame = 43,
			id = 63060042
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
	totalframe = 40,
	turnbacklimit = true,
	animation = "skill3",
	exe_tbl = {
		{
			frame = 1,
			sound = "100601_skill2"
		},
		{
			frame = 12,
			id = 63060051
		},
		{
			frame = 25,
			id = 63060052
		},
		{
			frame = 27,
			id = 63060053
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
	totalframe = 70,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = "100481_xp"
		},
		{
			frame = 27,
			id = 63060061
		},
		{
			frame = 40,
			id = 63060061
		},
		{
			frame = 53,
			id = 63060061
		},
		{
			frame = 54,
			id = 63060062
		}
	}
}

return var_0_0
