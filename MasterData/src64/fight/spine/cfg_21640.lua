local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 15,
				bullet = "attack",
				sound = {
					"21600_attack",
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
				frame = 15,
				bullet = "attack",
				sound = {
					"21600_attack",
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
		totalframe = 30,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 11,
				bullet = "skill1",
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 180,
						object = "target"
					}
				},
				sound = {
					"21600_skill",
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
		totalframe = 30,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 11,
				bullet = "skill1_1",
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 210,
						object = "target"
					}
				},
				sound = {
					"21600_skill",
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
		totalframe = 30,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 11,
				bullet = "skill1_2",
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 240,
						object = "target"
					}
				},
				sound = {
					"21600_skill",
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
		totalframe = 30,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 11,
				bullet = "skill1_3",
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 300,
						object = "target"
					}
				},
				sound = {
					"21600_skill",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 108,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1
			},
			{
				frame = 46,
				bullet = "xp",
				sound = {
					"21620_xp1"
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 107,
	bgfile = "21640_bg",
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
	inserteffect = {
		{
			texture = "role/21610.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/21620_xp",
				1
			}
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
				totalframe = 42,
				startframe = 45,
				time = 0.1
			}
		}
	}
}
var_0_0.extra.attack = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "21640_effect",
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
		animation = "atatck",
		exe_tbl = {
			{
				id = 21610001,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "21640_effect",
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
		animation = "atatck",
		exe_tbl = {
			{
				id = 21620001,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill1_1 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "21640_effect",
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
		animation = "atatck",
		exe_tbl = {
			{
				id = 21620101,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill1_2 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "21640_effect",
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
		animation = "atatck",
		exe_tbl = {
			{
				id = 21620201,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill1_3 = {
	movingani = "run",
	maxdistance = 640,
	movingtype = "locktarget",
	speed = 860,
	offsetZ = 1,
	filename = "21640_effect",
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
		animation = "atatck",
		exe_tbl = {
			{
				id = 21620301,
				frame = 1
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "xp_run",
	maxdistance = 600,
	movingtype = "locktime",
	speed = 960,
	offsetZ = 1,
	filename = "21640_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		offsetY = 0,
		time = 0.05,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 45,
		animation = "xp_attack",
		exe_tbl = {
			{
				id = 21650001,
				frame = 1,
				shake = {
					period = 2,
					time = 0.15,
					x = 4,
					y = 40
				}
			},
			{
				id = 21650001,
				frame = 13,
				shake = {
					x = 4,
					y = 4
				}
			},
			{
				id = 21650001,
				frame = 25,
				shake = {
					x = 2,
					y = 4
				}
			},
			{
				id = 21650001,
				frame = 37,
				shake = {
					x = 2,
					y = 2
				}
			}
		}
	}
}

return var_0_0
