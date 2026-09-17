local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 36,
		animation = "attack",
		exe_tbl = {
			{
				frame = 20,
				bullet = "attack"
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
		totalframe = 65,
		animation = "skill2",
		exe_tbl = {
			{
				id = 30810001,
				frame = 32,
				shake = {
					x = 4,
					y = 4
				},
				effect = {
					{
						ani = "skill-attack",
						name = "30805_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 30810001,
				frame = 37,
				shake = {
					x = 4,
					y = 4
				}
			},
			{
				id = 30810001,
				frame = 43,
				shake = {
					x = 4,
					y = 4
				}
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "30805_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.6,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				id = 30810001,
				frame = 1
			}
		}
	}
}

return var_0_0
