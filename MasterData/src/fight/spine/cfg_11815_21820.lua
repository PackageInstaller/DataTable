local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1_1 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "attack1_1",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack1",
				sound = {
					"21800_attack",
					0.6
				}
			}
		}
	},
	attack2_1 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "attack3_1",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack3",
				sound = {
					"21800_attack",
					0.6
				}
			}
		}
	},
	attack3_1 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "attack3_1",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack3",
				sound = {
					"21800_attack",
					0.6
				}
			}
		}
	},
	attack1_2 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "attack1_2",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack1",
				sound = {
					"21800_attack",
					0.6
				}
			}
		}
	},
	attack2_2 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "attack3_2",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack3",
				sound = {
					"21800_attack",
					0.6
				}
			}
		}
	},
	attack3_2 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "attack3_2",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack3",
				sound = {
					"21800_attack",
					0.6
				}
			}
		}
	},
	attack1_3 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "attack1_3",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack1",
				sound = {
					"21800_attack",
					0.6
				}
			}
		}
	},
	attack2_3 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "attack3_3",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack3",
				sound = {
					"21800_attack",
					0.6
				}
			}
		}
	},
	attack3_3 = {
		totalframe = 15,
		turnbacklimit = true,
		animation = "attack3_3",
		exe_tbl = {
			{
				frame = 8,
				bullet = "attack3",
				sound = {
					"21800_attack",
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
				operator = "<=",
				method = "random",
				param = {
					num = 3,
					range = 6
				}
			},
			{
				method = "useSkill",
				param = "useskill1"
			}
		},
		{
			{
				method = "useSkill",
				param = "useskill3"
			}
		}
	},
	useskill1 = {
		skillattackframe = 30,
		totalframe = 33,
		turnbacklimit = true,
		animation = "skill1",
		exe_tbl = {
			{
				id = 21820001,
				frame = 16,
				sound = {
					"21820_skill",
					0.6
				}
			},
			{
				frame = 17,
				id = 218601003
			}
		}
	},
	useskill3 = {
		skillattackframe = 30,
		totalframe = 33,
		turnbacklimit = true,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 16,
				id = 218601002
			},
			{
				id = 21820003,
				frame = 17,
				sound = {
					"21820_skill",
					0.6
				}
			}
		}
	},
	skill1_1 = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 3,
					range = 6
				}
			},
			{
				method = "useSkill",
				param = "useskill1_1"
			}
		},
		{
			{
				method = "useSkill",
				param = "useskill3_1"
			}
		}
	},
	useskill1_1 = {
		totalframe = 33,
		turnbacklimit = true,
		animation = "skill1",
		exe_tbl = {
			{
				id = 21820101,
				frame = 16,
				sound = {
					"21820_skill",
					0.6
				}
			}
		}
	},
	useskill3_1 = {
		totalframe = 33,
		turnbacklimit = true,
		animation = "skill1",
		exe_tbl = {
			{
				id = 21820103,
				frame = 16,
				sound = {
					"21820_skill",
					0.6
				}
			}
		}
	},
	skill1_2 = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 3,
					range = 6
				}
			},
			{
				method = "useSkill",
				param = "useskill1_2"
			}
		},
		{
			{
				method = "useSkill",
				param = "useskill3_2"
			}
		}
	},
	useskill1_2 = {
		totalframe = 33,
		turnbacklimit = true,
		animation = "skill1",
		exe_tbl = {
			{
				id = 21820201,
				frame = 16,
				sound = {
					"21820_skill",
					0.6
				}
			}
		}
	},
	useskill3_2 = {
		totalframe = 33,
		turnbacklimit = true,
		animation = "skill1",
		exe_tbl = {
			{
				id = 21820203,
				frame = 16,
				sound = {
					"21820_skill",
					0.6
				}
			}
		}
	},
	skill1_3 = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 3,
					range = 6
				}
			},
			{
				method = "useSkill",
				param = "useskill1_3"
			}
		},
		{
			{
				method = "useSkill",
				param = "useskill3_3"
			}
		}
	},
	useskill1_3 = {
		totalframe = 33,
		turnbacklimit = true,
		animation = "skill1",
		exe_tbl = {
			{
				id = 21820301,
				frame = 16,
				sound = {
					"21820_skill",
					0.6
				}
			}
		}
	},
	useskill3_3 = {
		totalframe = 33,
		turnbacklimit = true,
		animation = "skill1",
		exe_tbl = {
			{
				id = 21820303,
				frame = 16,
				sound = {
					"21820_skill",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 85,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"21820-xp",
					0.6
				}
			},
			{
				frame = 35,
				id = 21850001,
				effect = {
					{
						ani = "xp4",
						name = "11815_21800_effect",
						offsetZ = -1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 55,
				effect = {
					{
						ani = "xp4",
						name = "11815_21800_effect",
						offsetZ = -1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 75,
				effect = {
					{
						ani = "xp4",
						name = "11815_21800_effect",
						offsetZ = -1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 85
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	initposy = 290,
	bgfile = "11815_21800_bg",
	totalframe = 85,
	locktarget = {
		locktargetpool = "self"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	bgaction = {},
	inserteffect = {
		{
			texture = "role/21810.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/21820_xp",
				1
			}
		}
	},
	show = {
		{
			action = "hide",
			startframe = 0,
			target = "self"
		}
	},
	camera = {
		zoom = {
			{
				startframe = 30,
				scale = 1.05,
				outtime = 0.6,
				totalframe = 45,
				intime = 0.3
			}
		},
		move = {
			{
				pos = "self",
				totalframe = 85,
				startframe = 0,
				time = 0.1
			}
		}
	}
}
var_0_0.extra.attack1 = {
	movingani = "run1",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 800,
	offsetZ = -1,
	filename = "11815_21800_effect",
	initpos = {
		offsetY = 0.7,
		offsetX = 0.25,
		object = "self"
	},
	finalpos = {
		offsetY = 0.7,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 3,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 1,
				id = 21810001
			}
		}
	}
}
var_0_0.extra.attack2 = {
	movingani = "run2",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 640,
	offsetZ = -1,
	filename = "11815_21800_effect",
	initpos = {
		offsetY = 0.7,
		offsetX = 0.25,
		object = "self"
	},
	finalpos = {
		offsetY = 0.7,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 3,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 1,
				id = 21810002
			}
		}
	}
}
var_0_0.extra.attack3 = {
	movingani = "run3",
	maxdistance = 800,
	movingtype = "locktarget",
	speed = 640,
	offsetZ = -1,
	filename = "11815_21800_effect",
	initpos = {
		offsetY = 0.7,
		offsetX = 0.25,
		object = "self"
	},
	finalpos = {
		offsetY = 0.7,
		offsetX = 0.25,
		object = "target"
	},
	attack = {
		totalframe = 3,
		animation = "attack3",
		exe_tbl = {
			{
				frame = 1,
				id = 21810003
			}
		}
	}
}

return var_0_0
