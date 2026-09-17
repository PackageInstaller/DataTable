local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 14,
				bullet = "attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run1",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "100421_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.6,
		object = "self"
	},
	finalpos = {
		offsetY = 0.6,
		offsetX = -0.1,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "attack",
		action_on_complete = {
			{
				method = "catapult_next_target",
				param = {
					area = 500,
					maxcatapult = 1,
					condition = "normal"
				}
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 10049121
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
	totalframe = 35,
	animation = "skill",
	exe_tbl = {
		{
			frame = 12,
			bullet = "skill1_1"
		}
	}
}
var_0_0.extra.skill1_1 = {
	movingani = "run2",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "100421_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.8,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 11,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				id = 10042131
			}
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
	totalframe = 45,
	animation = "xp",
	exe_tbl = {
		{
			id = 10042141,
			frame = 18,
			effect = {
				{
					ani = "xp",
					name = "100421_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}

return var_0_0
