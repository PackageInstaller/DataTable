local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 14,
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
		totalframe = 50,
		turnbacklimit = true,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 17,
				bullet = "skill1"
			},
			{
				frame = 30,
				bullet = "skill1"
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
		totalframe = 40,
		turnbacklimit = true,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 27,
				bullet = "skill2"
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
		totalframe = 75,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				id = 77330001,
				frame = 32
			},
			{
				id = 77330001,
				frame = 37
			},
			{
				id = 77330001,
				frame = 42
			},
			{
				id = 77330001,
				frame = 47
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 75,
	bgfile = "77100_bg",
	locktarget = {
		mindistance = 240,
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
			totalframe = 1.5,
			startframe = 46,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 40,
				startframe = 0
			},
			{
				scale = 1,
				totalframe = 42,
				startframe = 45
			}
		},
		move = {
			{
				distance = 240,
				totalframe = 50,
				startframe = 25,
				time = 0.1
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "attack_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "77102_effect",
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
		totalframe = 8,
		animation = "attack",
		exe_tbl = {
			{
				id = 77310001,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "skill1_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "77102_effect",
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
		totalframe = 7,
		animation = "skill",
		exe_tbl = {
			{
				id = 77320001,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill2 = {
	movingani = "skill2_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "77102_effect",
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
		totalframe = 7,
		animation = "skill",
		exe_tbl = {
			{
				id = 77321001,
				frame = 1
			}
		}
	}
}

return var_0_0
