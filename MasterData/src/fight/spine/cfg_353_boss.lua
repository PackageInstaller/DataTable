local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 100,
		animation = "xp",
		exe_tbl = {
			{
				frame = 31,
				bullet = "attack",
				sound = "21600_attack"
			},
			{
				frame = 43,
				bullet = "attack",
				sound = "21600_attack"
			},
			{
				frame = 55,
				bullet = "attack",
				sound = "21600_attack"
			},
			{
				frame = 67,
				bullet = "attack",
				sound = "21600_attack"
			},
			{
				frame = 79,
				bullet = "attack",
				sound = "21600_attack"
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "xp_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "35301_effect",
	initpos = {
		offsetY = 0.75,
		offsetX = 1.3,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 21,
		animation = "xp_attack",
		exe_tbl = {
			{
				id = 35330001,
				frame = 1,
				shake = {
					x = 4,
					y = 4
				}
			}
		}
	}
}

return var_0_0
