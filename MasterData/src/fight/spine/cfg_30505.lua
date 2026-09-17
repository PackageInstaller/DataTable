local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 40,
		animation = "attack",
		exe_tbl = {
			{
				frame = 27,
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
		totalframe = 20,
		animation = "skill",
		exe_tbl = {
			{
				frame = 12,
				id = 30330001
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "30505_effect",
	size = {
		width = 50,
		height = 50
	},
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "target"
	},
	attack = {
		totalframe = 19,
		animation = "attack",
		exe_tbl = {
			{
				id = 30510001,
				frame = 1,
				shake = {
					x = 2,
					y = 2
				}
			}
		}
	}
}

return var_0_0
