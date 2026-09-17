local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 20510001,
				frame = 15,
				sound = {
					"fire",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 20510001,
				frame = 15,
				sound = {
					"fire",
					0.6
				}
			}
		}
	},
	attack3 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 20510001,
				frame = 15,
				sound = {
					"fire",
					0.6
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
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				frame = 26,
				bullet = "skill1",
				sound = {
					"20500_xp1",
					0.6
				}
			}
		}
	},
	skill1_1 = {
		{
			{
				method = "useSkill",
				param = "useskill1_1"
			}
		}
	},
	useskill1_1 = {
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				frame = 26,
				bullet = "skill1_1",
				sound = {
					"20500_xp1",
					0.6
				}
			}
		}
	},
	skill1_2 = {
		{
			{
				method = "useSkill",
				param = "useskill1_2"
			}
		}
	},
	useskill1_2 = {
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				frame = 26,
				bullet = "skill1_2",
				sound = {
					"20500_xp1",
					0.6
				}
			}
		}
	},
	skill1_3 = {
		{
			{
				method = "useSkill",
				param = "useskill1_3"
			}
		}
	},
	useskill1_3 = {
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				frame = 26,
				bullet = "skill1_3",
				sound = {
					"20500_xp1",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 79,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 37,
				id = 20530001,
				shake = {
					x = 2,
					y = 2
				},
				sound = {
					"20500_xp1"
				}
			},
			{
				frame = 43,
				id = 20530001,
				shake = {
					x = 2,
					y = 2
				},
				sound = {
					"20500_xp1"
				}
			},
			{
				frame = 57,
				id = 20530002,
				shake = {
					x = 5,
					y = 5
				},
				sound = {
					"20500_xp2"
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 78,
	bgfile = "swim_bg",
	locktarget = {
		mindistance = 350,
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "bg"
		}
	},
	inserteffect = {
		{
			texture = "role/20502.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/20502_03",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 16,
			timescale = 0.1
		},
		{
			totalframe = 2,
			startframe = 58,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 46,
				startframe = 19
			}
		},
		move = {
			{
				distance = 200,
				totalframe = 40,
				startframe = 24,
				time = 0.1
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 700,
	offsetZ = 1,
	filename = "10560_20500_effect",
	initpos = {
		offsetY = 0.35,
		offsetX = 1.4,
		object = "self"
	},
	finalpos = {
		offsetY = 0.35,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "attack",
		exe_tbl = {
			{
				id = 20520001,
				frame = 3,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 150,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill1_1 = {
	movingani = "run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 700,
	offsetZ = 1,
	filename = "10560_20500_effect",
	initpos = {
		offsetY = 0.35,
		offsetX = 1.4,
		object = "self"
	},
	finalpos = {
		offsetY = 0.35,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "attack",
		exe_tbl = {
			{
				id = 20520101,
				frame = 3,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 150,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill1_2 = {
	movingani = "run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 700,
	offsetZ = 1,
	filename = "10560_20500_effect",
	initpos = {
		offsetY = 0.35,
		offsetX = 1.4,
		object = "self"
	},
	finalpos = {
		offsetY = 0.35,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "attack",
		exe_tbl = {
			{
				id = 20520201,
				frame = 3,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 150,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill1_3 = {
	movingani = "run",
	maxdistance = 600,
	movingtype = "locktarget",
	speed = 700,
	offsetZ = 1,
	filename = "10560_20500_effect",
	initpos = {
		offsetY = 0.35,
		offsetX = 1.4,
		object = "self"
	},
	finalpos = {
		offsetY = 0.35,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 8,
		animation = "attack",
		exe_tbl = {
			{
				id = 20520301,
				frame = 3,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 150,
						object = "target"
					}
				}
			}
		}
	}
}

return var_0_0
