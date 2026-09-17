local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 24,
		animation = "attack1",
		exe_tbl = {
			{
				id = 22010001,
				frame = 10,
				effect = {
					{
						ani = "attack",
						name = "22040_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 25,
		animation = "attack2",
		exe_tbl = {
			{
				id = 22010001,
				frame = 9,
				effect = {
					{
						ani = "attack",
						name = "22040_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20200_attack",
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
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 14,
				bullet = "skill1",
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 28,
				bullet = "skill1",
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 38,
				bullet = "skill1",
				sound = {
					"20200_attack",
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
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 14,
				bullet = "skill1_1",
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 28,
				bullet = "skill1_1",
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 38,
				bullet = "skill1_1",
				sound = {
					"20200_attack",
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
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 14,
				bullet = "skill1_2",
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 28,
				bullet = "skill1_2",
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 38,
				bullet = "skill1_2",
				sound = {
					"20200_attack",
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
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 14,
				bullet = "skill1_3",
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 28,
				bullet = "skill1_3",
				sound = {
					"20200_attack",
					0.6
				}
			},
			{
				frame = 38,
				bullet = "skill1_3",
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 87,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1
			},
			{
				frame = 30,
				sound = {
					"22020_xp1"
				}
			},
			{
				frame = 47,
				bullet = "xp"
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 1.15,
	totalframe = 87,
	bgfile = "22040_bg",
	locktarget = {
		locktarget = true
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
			texture = "role/22020.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/22020_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 40,
			timescale = 0.3
		},
		{
			totalframe = 3,
			startframe = 77,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 30,
				startframe = 38
			},
			{
				scale = 0.8,
				totalframe = 5,
				startframe = 70
			}
		},
		move = {
			{
				pos = "target",
				time = 0.1,
				distance = 150,
				totalframe = 60,
				startframe = 38
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "skill_run",
	maxdistance = 480,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "22040_effect",
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
		animation = "skill_attack",
		exe_tbl = {
			{
				id = 22020001,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill1_1 = {
	movingani = "skill_run",
	maxdistance = 480,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "22040_effect",
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
		animation = "skill_attack",
		exe_tbl = {
			{
				id = 22020101,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill1_2 = {
	movingani = "skill_run",
	maxdistance = 480,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "22040_effect",
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
		animation = "skill_attack",
		exe_tbl = {
			{
				id = 22020201,
				frame = 1
			}
		}
	}
}
var_0_0.extra.skill1_3 = {
	movingani = "skill_run",
	maxdistance = 480,
	movingtype = "locktarget",
	speed = 1000,
	offsetZ = 1,
	filename = "22040_effect",
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
		animation = "skill_attack",
		exe_tbl = {
			{
				id = 22020301,
				frame = 1
			}
		}
	}
}
var_0_0.extra.xp = {
	movingani = "xp_attack",
	maxdistance = 480,
	movingtype = "locktarget",
	speed = 3000,
	offsetZ = 1,
	filename = "22040_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	finalpos = {
		offsetY = 0.5,
		offsetX = 0,
		object = "target"
	},
	attack = {
		totalframe = 37,
		animation = "xp_attack",
		exe_tbl = {
			{
				id = 22050001,
				frame = 2,
				shake = {
					x = 2,
					y = 0
				}
			},
			{
				id = 22050001,
				frame = 7,
				shake = {
					x = 2,
					y = 0
				}
			},
			{
				id = 22050001,
				frame = 10,
				shake = {
					x = 2,
					y = 0
				}
			},
			{
				id = 22050001,
				frame = 13,
				shake = {
					x = 2,
					y = 0
				}
			},
			{
				id = 22050001,
				frame = 18,
				shake = {
					x = 2,
					y = 0
				}
			},
			{
				behitted = "hitdown",
				id = 22050001,
				frame = 24,
				shake = {
					x = 6,
					y = 0
				}
			}
		}
	}
}

return var_0_0
