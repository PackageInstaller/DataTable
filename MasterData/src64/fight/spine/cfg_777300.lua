local var_0_0 = {
	extra = {},
	attack = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 8,
					range = 20
				}
			},
			{
				method = "useSkill",
				param = "attack1"
			}
		},
		{
			{
				method = "useSkill",
				param = "attack2"
			}
		}
	},
	attack1 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 18,
				bullet = "attack1",
				sound = {
					"fire",
					0.4
				}
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 18,
				bullet = "attack2",
				sound = {
					"fire",
					0.4
				}
			}
		}
	}
}

var_0_0.extra.attack1 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "777100_effect",
	initpos = {
		offsetY = 1.25,
		offsetX = 1.6,
		object = "self"
	},
	finalpos = {
		offsetY = 1,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 14,
		animation = "attack",
		exe_tbl = {
			{
				frame = 2,
				id = 60110001
			}
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "777100_effect",
	initpos = {
		offsetY = 1.25,
		offsetX = 1.6,
		object = "self"
	},
	finalpos = {
		offsetY = 1,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 14,
		animation = "attack",
		exe_tbl = {
			{
				id = 60110001,
				behitted = "hitdown",
				frame = 2
			}
		}
	}
}

return var_0_0
