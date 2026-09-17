local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10063120,
				frame = 22,
				effect = {
					{
						ani = "attack",
						name = "100631_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
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
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	useskill1 = {
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				id = 10063130,
				frame = 15
			},
			{
				id = 10063130,
				frame = 25
			},
			{
				id = 10063130,
				frame = 35
			},
			{
				id = 10063130,
				frame = 45,
				bullet = "skill"
			}
		}
	},
	useskill2 = {
		totalframe = 60,
		animation = "skill2",
		exe_tbl = {
			{
				id = 10063140,
				frame = 40,
				effect = {
					{
						ani = "skill2",
						name = "100631_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 3,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.extra.skill = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "100631_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "skill",
		exe_tbl = {
			{
				id = 10067130,
				behitted = "hitdown",
				frame = 9,
				effect = {
					{
						ani = "skill",
						name = "100631_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
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
	turnbacklimit = true,
	totalframe = 84,
	animation = "xp",
	action_on_start = {
		{
			startframe = 10,
			action = {
				{
					method = "rush_to_target",
					param = {
						frame = 28,
						posx = 40
					}
				}
			}
		}
	},
	exe_tbl = {
		{
			id = 10063160,
			frame = 50
		},
		{
			id = 10063160,
			frame = 58
		},
		{
			id = 10063160,
			frame = 66
		},
		{
			id = 10063160,
			behitted = "hitdown",
			frame = 74
		}
	}
}

return var_0_0
