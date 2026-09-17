local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		{
			{
				operator = ">=",
				method = "random",
				param = {
					num = 5,
					range = 10
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
				frame = 15,
				bullet = "attack1"
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack2"
			}
		}
	}
}

var_0_0.extra.attack1 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "600170_effect",
	initpos = {
		offsetY = 1,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 60017021,
				frame = 10
			}
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run2",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "600170_effect",
	initpos = {
		offsetY = 1,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				id = 60017022,
				frame = 10
			}
		}
	}
}

return var_0_0
