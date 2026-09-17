local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 12,
		animation = "attack",
		exe_tbl = {
			{
				id = 20510001,
				frame = 6,
				sound = {
					"20520-attack",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 12,
		animation = "attack",
		exe_tbl = {
			{
				id = 20510001,
				frame = 6,
				sound = {
					"20520-attack",
					0.6
				}
			}
		}
	},
	attack3 = {
		totalframe = 12,
		animation = "attack",
		exe_tbl = {
			{
				id = 20510001,
				frame = 6,
				sound = {
					"20520-attack",
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
		skillattackframe = 45,
		totalframe = 41,
		animation = "skill",
		exe_tbl = {
			{
				frame = 23,
				sound = {
					"20520-skill",
					0.6
				}
			},
			{
				frame = 24,
				bullet = "skill1"
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
		totalframe = 41,
		animation = "skill",
		exe_tbl = {
			{
				frame = 23,
				sound = {
					"20520-skill",
					0.6
				}
			},
			{
				frame = 24,
				bullet = "skill1_1"
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
		totalframe = 41,
		animation = "skill",
		exe_tbl = {
			{
				frame = 23,
				sound = {
					"20520-skill",
					0.6
				}
			},
			{
				frame = 24,
				bullet = "skill1_2"
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
		totalframe = 41,
		animation = "skill",
		exe_tbl = {
			{
				frame = 23,
				sound = {
					"20520-skill",
					0.6
				}
			},
			{
				frame = 24,
				bullet = "skill1_3"
			}
		}
	},
	usexp = {
		totalframe = 126,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20520-xp",
					0.6
				}
			},
			{
				frame = 45,
				bullet = "xp"
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 125,
	bgfile = "20520_bg",
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
			texture = "role/20520.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/20520_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 1,
			startframe = 46,
			timescale = 0.3
		},
		{
			totalframe = 1,
			startframe = 63,
			timescale = 0.3
		},
		{
			totalframe = 1,
			startframe = 72,
			timescale = 0.3
		},
		{
			totalframe = 1,
			startframe = 85,
			timescale = 0.3
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 35,
				startframe = 0
			},
			{
				scale = 0.8,
				totalframe = 70,
				startframe = 40
			}
		},
		move = {
			{
				distance = 270,
				totalframe = 70,
				startframe = 40,
				time = 0.1
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "xp_run",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 1200,
	offsetZ = 1,
	filename = "20520_effect",
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
		totalframe = 65,
		animation = "xp_run",
		exe_tbl = {
			{
				frame = 1,
				id = 20550001,
				effect = {
					{
						ani = "xp_attack",
						name = "20520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 6,
					y = 10
				}
			},
			{
				frame = 18,
				id = 20550001,
				effect = {
					{
						ani = "xp_attack",
						name = "20520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 6,
					y = 10
				}
			},
			{
				frame = 27,
				id = 20550001,
				effect = {
					{
						ani = "xp_attack",
						name = "20520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 6,
					y = 10
				}
			},
			{
				frame = 40,
				id = 20550002,
				effect = {
					{
						ani = "xp_attack",
						name = "20520_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 6,
					y = 10
				}
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "skill_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 720,
	offsetZ = 1,
	filename = "20520_effect",
	initpos = {
		offsetY = 1,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 21,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 3,
				id = 20521001
			}
		}
	}
}
var_0_0.extra.skill1_1 = {
	movingani = "skill_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 720,
	offsetZ = 1,
	filename = "20520_effect",
	initpos = {
		offsetY = 1,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 21,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 3,
				id = 20521101
			}
		}
	}
}
var_0_0.extra.skill1_2 = {
	movingani = "skill_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 720,
	offsetZ = 1,
	filename = "20520_effect",
	initpos = {
		offsetY = 1,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 21,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 3,
				id = 20521201
			}
		}
	}
}
var_0_0.extra.skill1_3 = {
	movingani = "skill_run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 720,
	offsetZ = 1,
	filename = "20520_effect",
	initpos = {
		offsetY = 1,
		offsetX = 0,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 21,
		animation = "skill_attack",
		exe_tbl = {
			{
				frame = 3,
				id = 20521301
			}
		}
	}
}

return var_0_0
