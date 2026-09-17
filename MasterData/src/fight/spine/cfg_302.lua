local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				id = 30210001,
				frame = 7,
				effect = {
					{
						ani = "attack",
						name = "30400_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp"
			}
		}
	},
	usexp = {
		totalframe = 25,
		animation = "skill",
		exe_tbl = {
			{
				frame = 16,
				bullet = "xp"
			}
		}
	}
}

var_0_0.extra.xp = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = -1,
	filename = "30200_effect",
	initpos = {
		offsetY = 1,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 1,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 30230001,
				shake = {
					x = 5,
					y = 5
				}
			}
		}
	}
}

return var_0_0
