local var_0_0 = {
	extra = {},
	attack = {
		totalframe = 34,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack"
			},
			{
				frame = 19,
				bullet = "attack"
			},
			{
				frame = 23,
				bullet = "attack"
			}
		}
	},
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 48,
		animation = "skill",
		exe_tbl = {
			{
				frame = 30,
				bullet = "skill",
				shake = {
					x = 4,
					y = 4
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
		totalframe = 96,
		animation = "xp",
		exe_tbl = {
			{
				behitted = "hitdown",
				id = 36330001,
				frame = 50,
				shake = {
					x = 6,
					y = 0
				}
			},
			{
				behitted = "hitdown",
				id = 36330001,
				frame = 58,
				shake = {
					x = 6,
					y = 0
				}
			},
			{
				behitted = "hitdown",
				id = 36330001,
				frame = 66,
				shake = {
					x = 6,
					y = 0
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
	filename = "36300_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.5,
		offsetX = 2.2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 14,
		animation = "attack",
		exe_tbl = {
			{
				id = 36310001,
				frame = 3
			}
		}
	}
}
var_0_0.extra.skill = {
	movingani = "skill-run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1500,
	offsetZ = 1,
	filename = "36300_effect",
	size = {
		width = 20,
		height = 40
	},
	initpos = {
		offsetY = 0.6,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 20,
		animation = "skill-attack",
		exe_tbl = {
			{
				frame = 3,
				id = 36320001,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				}
			}
		}
	}
}

return var_0_0
