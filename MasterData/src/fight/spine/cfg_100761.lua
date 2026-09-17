local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 30,
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
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "100761_effect",
	size = {
		width = 25,
		height = 25
	},
	initpos = {
		offsetY = 0.4,
		offsetX = 0.4,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.2,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 10076121
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
	animation = "skill",
	exe_tbl = {
		{
			frame = 18,
			bullet = "skill1"
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "skill",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "100761_effect",
	initpos = {
		offsetY = 0.4,
		offsetX = 0.4,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.2,
		object = "target"
	},
	attack = {
		totalframe = 9,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 10076131
			}
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
	totalframe = 45,
	animation = "skill2",
	exe_tbl = {
		{
			id = 10076141,
			frame = 15,
			effect = {
				{
					ani = "skill2",
					name = "100761_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			force = {
				{
					shotdown = false,
					time = 0.5,
					distance = 200,
					object = "target"
				}
			}
		}
	}
}

return var_0_0
