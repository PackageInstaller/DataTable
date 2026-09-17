local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 13,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 400,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "101000_effect",
	initpos = {
		offsetY = 0.6,
		offsetX = 2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 1005101,
				frame = 5
			},
			{
				frame = 6,
				id = 1005103
			},
			{
				frame = 8,
				id = 1005104
			}
		}
	}
}
var_0_0.extra.skill_attack = {
	movingani = "run2",
	maxdistance = 400,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "101000_effect",
	initpos = {
		offsetY = 0.6,
		offsetX = 2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.3,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 1005211,
				frame = 5
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
	totalframe = 60,
	animation = "skill",
	exe_tbl = {
		{
			frame = 35,
			bullet = "skill_attack"
		}
	}
}

return var_0_0
