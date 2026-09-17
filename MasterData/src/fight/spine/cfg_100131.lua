local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 11,
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
		totalframe = 41,
		animation = "skill",
		exe_tbl = {
			{
				frame = 19,
				bullet = "skill"
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 34,
	bgfile = "77100_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 1,
			ani = "BG"
		}
	},
	lockframe = {
		{
			totalframe = 34,
			startframe = 1,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.1,
				totalframe = 8,
				startframe = 1
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 15,
				startframe = 2,
				time = 0.1
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
	totalframe = 154,
	animation = "xp",
	action_on_complete = {
		{
			method = "useSkill",
			param = "usexp2"
		}
	}
}
var_0_0.usexp2 = {
	turnbacklimit = true,
	xpeffect = "xp_effect",
	totalframe = 34,
	animation = "xp2",
	exe_tbl = {
		{
			frame = 2,
			bullet = "xp"
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run1",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 500,
	offsetZ = 1,
	filename = "100131_effect",
	initpos = {
		offsetY = 0.8,
		offsetX = 0.2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.7,
		offsetX = 0.1,
		object = "target"
	},
	attack = {
		totalframe = 4,
		animation = "attack",
		exe_tbl = {
			{
				frame = 2,
				id = 10013161,
				effect = {
					{
						ani = "attack",
						name = "100131_effect",
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
var_0_0.extra.skill = {
	movingani = "run2",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 500,
	offsetZ = 1,
	filename = "100131_effect",
	initpos = {
		offsetY = 0.8,
		offsetX = 0.2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.7,
		offsetX = 0.1,
		object = "target"
	},
	attack = {
		totalframe = 4,
		animation = "attack",
		exe_tbl = {
			{
				frame = 2,
				id = 10013171,
				effect = {
					{
						ani = "skill",
						name = "100131_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 280,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "run1",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "100131_effect",
	initpos = {
		offsetY = 0.8,
		offsetX = 0.2,
		object = "self"
	},
	finalpos = {
		offsetY = 0.7,
		offsetX = 0.1,
		object = "target"
	},
	attack = {
		totalframe = 4,
		animation = "attack",
		exe_tbl = {
			{
				behitted = "hitdown",
				frame = 2,
				id = 10013191,
				effect = {
					{
						ani = "skill",
						name = "100131_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.4,
						shutdown = true,
						distance = 380,
						object = "target"
					}
				}
			}
		}
	}
}

return var_0_0
