local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 35,
		animation = "attack",
		exe_tbl = {
			{
				id = 10015161,
				frame = 14,
				effect = {
					{
						ani = "attack",
						name = "100151_effect",
						offsetZ = 1,
						offsetY = 0.4,
						offsetX = 0.2,
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
	useskill1 = {
		totalframe = 51,
		animation = "skill",
		exe_tbl = {
			{
				id = 10015171,
				frame = 27,
				effect = {
					{
						ani = "attack",
						name = "100151_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
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
				id = 10015181,
				frame = 20,
				bullet = "bs"
			}
		}
	}
}

var_0_0.extra.bs = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "100151_effect",
	initpos = {
		offsetY = 0.45,
		offsetX = 0.2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.4,
		offsetX = -0.2,
		object = "target"
	},
	attack = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 10015181,
				frame = 2
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
	exe_crash_type = "carry",
	animation = "xp",
	xpeffect = "xp_effect",
	exe_crash_bound = 45,
	exe_type = "crash",
	totalframe = 55,
	action_on_start = {
		{
			startframe = 22,
			action = {
				{
					method = "rush_forward",
					param = {
						distance = 500,
						time = 0.5
					}
				}
			}
		}
	},
	exe_tbl = {
		{
			behitted = "hitdown",
			id = 10015191,
			frame = 35,
			shake = {
				x = 6,
				y = 2
			},
			effect = {
				{
					ani = "xp",
					name = "100151_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.xpeffect.xp_effect = {
	totalframe = 50,
	bgfile = "77100_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 5,
			timescale = 0.2
		}
	},
	lockframe = {
		{
			totalframe = 6,
			startframe = 40,
			timescale = 0.4
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 40,
				startframe = 22
			}
		},
		move = {}
	}
}

return var_0_0
