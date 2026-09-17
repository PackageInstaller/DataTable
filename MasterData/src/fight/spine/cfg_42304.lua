local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 21,
		animation = "attack",
		exe_tbl = {
			{
				frame = 11,
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
		totalframe = 37,
		animation = "skill1",
		exe_tbl = {
			{
				id = 42320001,
				frame = 15,
				shake = {
					x = 2,
					y = 0
				}
			}
		}
	},
	useskill2 = {
		totalframe = 30,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 16,
				bullet = "skill2",
				shake = {
					x = 0,
					y = 2
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 66,
	bgfile = "44000_bg",
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
	inserteffect = {
		{
			texture = "role/42304.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 38,
				startframe = 17
			}
		},
		move = {
			{
				pos = "target",
				totalframe = 38,
				startframe = 17,
				time = 0.1
			}
		}
	}
}
var_0_0.usexp = {
	totalframe = 67,
	xpeffect = "xp_effect",
	animation = "xp",
	exe_tbl = {
		{
			frame = 17,
			bullet = "xp",
			shake = {
				x = 0,
				y = 2
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = 1,
	filename = "43304_effect",
	initpos = {
		offsetY = 0.45,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.45,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 7,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 42310001,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 10,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill2 = {
	movingani = "skill2_run",
	maxdistance = 1200,
	movingtype = "locktarget",
	speed = 600,
	offsetZ = 1,
	filename = "42304_effect",
	initpos = {
		offsetY = 0.45,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0.45,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 23,
		animation = "skill2_attack",
		exe_tbl = {
			{
				frame = 2,
				id = 42321001,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 250,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 0
				}
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "skill2_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 500,
	offsetZ = 1,
	filename = "42304_effect",
	initpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 38,
		animation = "xp_attack",
		exe_tbl = {
			{
				id = 42330001,
				frame = 6,
				sound = {
					"20400_attack"
				}
			},
			{
				id = 42330001,
				frame = 16,
				sound = {
					"20400_attack"
				}
			},
			{
				id = 42330001,
				frame = 26,
				sound = {
					"20400_attack"
				}
			},
			{
				id = 42330001,
				frame = 32,
				sound = {
					"20400_attack"
				}
			}
		}
	}
}

return var_0_0
