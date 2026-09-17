local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 31,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack",
				sound = {
					"20300_attack",
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
		skillattackframe = 30,
		totalframe = 31,
		animation = "skill",
		exe_tbl = {
			{
				frame = 14,
				bullet = "skill1",
				sound = {
					"20300_skill1",
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
		totalframe = 31,
		animation = "skill",
		exe_tbl = {
			{
				frame = 14,
				bullet = "skill1_1",
				sound = {
					"20300_skill1",
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
		totalframe = 31,
		animation = "skill",
		exe_tbl = {
			{
				frame = 14,
				bullet = "skill1_2",
				sound = {
					"20300_skill1",
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
		totalframe = 31,
		animation = "skill",
		exe_tbl = {
			{
				frame = 14,
				bullet = "skill1_3",
				sound = {
					"20300_skill1",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 78,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 31,
				bullet = "xp",
				sound = {
					"20300_xp"
				}
			},
			{
				frame = 37,
				shake = {
					x = 6,
					y = 6
				}
			},
			{
				frame = 40,
				shake = {
					x = 4,
					y = 4
				}
			},
			{
				frame = 43,
				shake = {
					x = 6,
					y = 6
				}
			},
			{
				frame = 51,
				shake = {
					x = 4,
					y = 4
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 77,
	bgfile = "20330_bg",
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
			texture = "role/20330.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 2,
			startframe = 28,
			timescale = 0.1
		},
		{
			totalframe = 10,
			startframe = 30,
			timescale = 0.4
		},
		{
			totalframe = 10,
			startframe = 40,
			timescale = 0.6
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 22,
				startframe = 0
			},
			{
				scale = 0.7,
				totalframe = 38,
				startframe = 27
			}
		},
		move = {
			{
				distance = 160,
				totalframe = 43,
				startframe = 27,
				time = 0.1
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "10350_20300_effect",
	initpos = {
		offsetY = 0.65,
		offsetX = 1,
		object = "self"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 6,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				id = 20310002
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 3000,
	offsetZ = 1,
	filename = "10350_20300_effect",
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
		totalframe = 26,
		animation = "skill",
		exe_tbl = {
			{
				id = 20323001,
				frame = 6,
				behitted = "hitdown",
				effect = {
					{
						ani = "passive",
						name = "20300_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill1_1 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 3000,
	offsetZ = 1,
	filename = "10350_20300_effect",
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
		totalframe = 26,
		animation = "skill",
		exe_tbl = {
			{
				id = 20323101,
				frame = 6,
				behitted = "hitdown",
				effect = {
					{
						ani = "passive",
						name = "20300_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill1_2 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 3000,
	offsetZ = 1,
	filename = "10350_20300_effect",
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
		totalframe = 26,
		animation = "skill",
		exe_tbl = {
			{
				id = 20323201,
				frame = 6,
				behitted = "hitdown",
				effect = {
					{
						ani = "passive",
						name = "20300_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.skill1_3 = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 3000,
	offsetZ = 1,
	filename = "10350_20300_effect",
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
		totalframe = 26,
		animation = "skill",
		exe_tbl = {
			{
				id = 20323301,
				frame = 6,
				behitted = "hitdown",
				effect = {
					{
						ani = "passive",
						name = "20300_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "run",
	maxdistance = 1000,
	movingtype = "locktarget",
	speed = 3000,
	offsetZ = 1,
	filename = "10350_20300_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 12,
		animation = "xp",
		action_on_complete = {
			{
				method = "catapult_next_target",
				param = {
					area = 600,
					maxcatapult = 2,
					condition = "random"
				}
			}
		},
		exe_tbl = {
			{
				frame = 3,
				id = 20333001,
				effect = {
					{
						ani = "attack",
						name = "20300_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20300_skill1"
				}
			}
		}
	}
}

return var_0_0
