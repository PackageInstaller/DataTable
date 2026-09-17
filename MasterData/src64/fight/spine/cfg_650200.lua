local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 34,
		animation = "attack",
		exe_tbl = {
			{
				frame = 16,
				id = 65020021
			},
			{
				frame = 20,
				id = 65020021
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
		totalframe = 47,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				sound = "21500_skill"
			},
			{
				frame = 30,
				id = 65020031
			}
		}
	},
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	useskill2 = {
		totalframe = 44,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = "21500_skill"
			},
			{
				frame = 14,
				id = 65020041
			},
			{
				frame = 18,
				id = 65020042
			},
			{
				frame = 19,
				id = 65020042
			},
			{
				frame = 20,
				id = 65020043
			}
		}
	},
	skill3 = {
		{
			{
				method = "useSkill",
				param = "useskill3"
			}
		}
	},
	useskill3 = {
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 1,
				sound = "100601_skill2"
			},
			{
				frame = 13,
				bullet = "skill"
			}
		}
	}
}

var_0_0.extra.skill = {
	movingani = "fly",
	maxdistance = 1500,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "650200_effect",
	initpos = {
		offsetY = 0.2,
		offsetX = 1.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = -0.5,
		object = "target"
	},
	attack = {
		totalframe = 19,
		animation = "run_skill",
		exe_tbl = {
			{
				frame = 8,
				id = 65020051
			},
			{
				frame = 9,
				id = 65020052
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
	totalframe = 101,
	animation = "xp",
	exe_tbl = {
		{
			frame = 1,
			sound = "100481_xp"
		},
		{
			frame = 34,
			id = 65020061
		},
		{
			frame = 40,
			id = 65020061
		},
		{
			frame = 48,
			id = 65020061
		},
		{
			frame = 58,
			id = 65020061
		},
		{
			frame = 85,
			id = 65020061
		},
		{
			frame = 90,
			id = 65020062
		}
	}
}

return var_0_0
