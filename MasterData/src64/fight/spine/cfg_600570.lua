local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 17,
				bullet = "attack",
				effect = {
					{
						ani = "attack",
						name = "600510_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0.8,
						object = "self"
					}
				}
			}
		}
	}
}

var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "600520_effect",
	initpos = {
		offsetY = 0.6,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 15,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				id = 60051021
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
	turnbacklimit = true,
	totalframe = 40,
	animation = "skill3",
	action_on_start = {
		{
			startframe = 13,
			action = {
				{
					method = "grab",
					param = {
						bonename = "role",
						finaloffset = cc.p(-200, 0)
					}
				}
			}
		},
		{
			startframe = 32,
			action = {
				{
					method = "releasegrab"
				}
			}
		}
	},
	exe_tbl = {
		{
			id = 60051051,
			frame = 1,
			effect = {
				{
					ani = "attack",
					name = "600510_effect",
					offsetZ = 1,
					offsetY = 0,
					offsetX = 0.8,
					object = "self"
				}
			}
		}
	}
}

return var_0_0
