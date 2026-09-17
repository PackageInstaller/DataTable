local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 22,
				id = 20810001,
				sound = {
					"20800_attack",
					0.6
				},
				effect = {
					{
						ani = "skill_attack",
						name = "20800_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
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
		totalframe = 38,
		animation = "skill",
		exe_tbl = {
			{
				frame = 17,
				bullet = "skill1",
				sound = {
					"20800_skill",
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
		totalframe = 38,
		animation = "skill",
		exe_tbl = {
			{
				frame = 17,
				bullet = "skill1_1",
				sound = {
					"20800_skill",
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
		totalframe = 38,
		animation = "skill",
		exe_tbl = {
			{
				frame = 17,
				bullet = "skill1_2",
				sound = {
					"20800_skill",
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
		totalframe = 38,
		animation = "skill",
		exe_tbl = {
			{
				frame = 17,
				bullet = "skill1_3",
				sound = {
					"20800_skill",
					0.6
				}
			}
		}
	},
	usexp = {
		totalframe = 99,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		nextani = true,
		animation = "xp",
		action_on_start = {
			{
				startframe = 27,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 3,
							posx = 50
						}
					}
				}
			}
		},
		sound = {
			frame = 1,
			volume = 0.6,
			file = "20820-xp"
		},
		exe_tbl = {
			{
				frame = 30,
				id = 20832001
			},
			{
				frame = 43,
				id = 20832001
			},
			{
				frame = 60,
				id = 20832001
			},
			{
				behitted = "hitdown",
				id = 20832002,
				frame = 76,
				sound = {
					"20800_skill"
				},
				shake = {
					x = 0,
					y = 6
				},
				force = {
					{
						time = 0.03,
						shutdown = false,
						distance = 100,
						object = "target"
					}
				}
			},
			{
				frame = 77,
				force = {
					{
						time = 0.03,
						shutdown = false,
						distance = 100,
						object = "target"
					}
				}
			},
			{
				frame = 78,
				force = {
					{
						time = 0.03,
						shutdown = false,
						distance = 100,
						object = "target"
					}
				}
			},
			{
				frame = 79,
				force = {
					{
						time = 0.03,
						shutdown = false,
						distance = 100,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 98,
	bgfile = "20800_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = false,
			startframe = 1,
			ani = "BG"
		}
	},
	inserteffect = {
		{
			texture = "role/20802.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/20802_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 62,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 30,
				startframe = 62
			}
		},
		move = {
			{
				distance = 300,
				totalframe = 30,
				startframe = 62,
				time = 0.5
			}
		}
	}
}
var_0_0.extra.skill1 = {
	movingani = "skill_run",
	maxdistance = 600,
	movingtype = "lockdirection",
	speed = 900,
	offsetZ = 1,
	filename = "20800_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "cross",
		direction = 1
	},
	attack = {
		totalframe = 7,
		animation = "skill_attack",
		exe_tbl = {
			{
				id = 20820001,
				frame = 0,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 150,
						object = "target"
					}
				},
				shake = {
					x = 1,
					y = 0
				}
			}
		}
	}
}
var_0_0.extra.skill1_1 = {
	movingani = "skill_run",
	maxdistance = 600,
	movingtype = "lockdirection",
	speed = 900,
	offsetZ = 1,
	filename = "20800_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "cross",
		direction = 1
	},
	attack = {
		totalframe = 7,
		animation = "skill_attack",
		exe_tbl = {
			{
				id = 20820101,
				frame = 0,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 150,
						object = "target"
					}
				},
				shake = {
					x = 1,
					y = 0
				}
			}
		}
	}
}
var_0_0.extra.skill1_2 = {
	movingani = "skill_run",
	maxdistance = 600,
	movingtype = "lockdirection",
	speed = 900,
	offsetZ = 1,
	filename = "20800_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "cross",
		direction = 1
	},
	attack = {
		totalframe = 7,
		animation = "skill_attack",
		exe_tbl = {
			{
				id = 20820201,
				frame = 0,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 150,
						object = "target"
					}
				},
				shake = {
					x = 1,
					y = 0
				}
			}
		}
	}
}
var_0_0.extra.skill1_3 = {
	movingani = "skill_run",
	maxdistance = 600,
	movingtype = "lockdirection",
	speed = 900,
	offsetZ = 1,
	filename = "20800_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "cross",
		direction = 1
	},
	attack = {
		totalframe = 7,
		animation = "skill_attack",
		exe_tbl = {
			{
				id = 20820301,
				frame = 0,
				force = {
					{
						time = 0.05,
						shutdown = false,
						distance = 150,
						object = "target"
					}
				},
				shake = {
					x = 1,
					y = 0
				}
			}
		}
	}
}

return var_0_0
