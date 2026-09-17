local var_0_0 = {
	xpeffect = {},
	attack = {
		totalframe = 23,
		animation = "attack",
		exe_tbl = {
			{
				id = 20710001,
				frame = 12,
				effect = {
					{
						ani = "attack",
						name = "20740_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				},
				sound = {
					"20100_attack",
					0.6
				}
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
		totalframe = 48,
		animation = "skill",
		exe_tbl = {
			{
				frame = 35,
				behitted = "hitdown",
				id = 20721001,
				sound = {
					"20120_skill",
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
		totalframe = 48,
		animation = "skill",
		exe_tbl = {
			{
				frame = 35,
				behitted = "hitdown",
				id = 20721101,
				sound = {
					"20120_skill",
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
		totalframe = 48,
		animation = "skill",
		exe_tbl = {
			{
				frame = 35,
				behitted = "hitdown",
				id = 20721201,
				sound = {
					"20120_skill",
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
		totalframe = 48,
		animation = "skill",
		exe_tbl = {
			{
				frame = 35,
				behitted = "hitdown",
				id = 20721301,
				sound = {
					"20120_skill",
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
	xp1 = {
		{
			{
				method = "useSkill",
				param = "usexp1"
			}
		}
	},
	usexp = {
		totalframe = 30,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		nextani = true,
		animation = "xp1",
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20720-xp",
					0.6
				}
			}
		}
	},
	xp_attack = {
		turnbacklimit = true,
		totalframe = 11,
		animation = "xp2",
		action_on_start = {
			{
				startframe = 0,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 100
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				behitted = "hitdown",
				id = 20750001,
				frame = 5,
				shake = {
					x = 6,
					y = 6
				},
				force = {
					{
						time = 0.1,
						distance = 25,
						object = "target"
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "catapult_next_target",
				param = {
					area = 400,
					maxcatapult = 3,
					condition = "random"
				}
			},
			{
				method = "useSkill",
				param = "xp_attack"
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 0.72,
	totalframe = 76,
	bgfile = "20740_bg",
	locktarget = {
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
			texture = "role/20720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/20720_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 1,
			startframe = 35.5,
			timescale = 0.2
		},
		{
			totalframe = 1,
			startframe = 46.5,
			timescale = 0.2
		},
		{
			totalframe = 1,
			startframe = 57.5,
			timescale = 0.2
		},
		{
			totalframe = 1,
			startframe = 68.5,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 30,
				startframe = 0
			}
		},
		move = {
			{
				pos = "target",
				time = 0.1,
				distance = 50,
				totalframe = 46,
				startframe = 30
			}
		}
	}
}
var_0_0.usexp1 = {
	totalframe = 30,
	xpeffect = "xp_effect1",
	turnbacklimit = true,
	nextani = true,
	animation = "xp1",
	action_on_complete = {
		{
			method = "useSkill",
			param = "xp_attack1"
		}
	},
	exe_tbl = {
		{
			frame = 1,
			sound = {
				"20720-xp",
				0.6
			}
		}
	}
}
var_0_0.xp_attack1 = {
	turnbacklimit = true,
	totalframe = 11,
	animation = "xp2",
	action_on_start = {
		{
			startframe = 0,
			action = {
				{
					method = "rush_to_target",
					param = {
						frame = 2,
						posx = 100
					}
				}
			}
		}
	},
	exe_tbl = {
		{
			behitted = "hitdown",
			id = 20750101,
			frame = 5,
			shake = {
				x = 6,
				y = 6
			},
			force = {
				{
					time = 0.1,
					distance = 25,
					object = "target"
				}
			}
		}
	},
	action_on_complete = {
		{
			method = "catapult_next_target",
			param = {
				area = 400,
				maxcatapult = 5,
				condition = "random"
			}
		},
		{
			method = "useSkill",
			param = "xp_attack1"
		}
	}
}
var_0_0.xpeffect.xp_effect1 = {
	totalframe = 98,
	bgfile = "20740_bg",
	locktarget = {
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
			texture = "role/20720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 1,
			startframe = 35.5,
			timescale = 0.2
		},
		{
			totalframe = 1,
			startframe = 46.5,
			timescale = 0.2
		},
		{
			totalframe = 1,
			startframe = 57.5,
			timescale = 0.2
		},
		{
			totalframe = 1,
			startframe = 68.5,
			timescale = 0.2
		},
		{
			totalframe = 1,
			startframe = 79.5,
			timescale = 0.2
		},
		{
			totalframe = 1,
			startframe = 90.5,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 30,
				startframe = 0
			}
		},
		move = {
			{
				pos = "target",
				time = 0.1,
				distance = 50,
				totalframe = 46,
				startframe = 30
			}
		}
	}
}

return var_0_0
