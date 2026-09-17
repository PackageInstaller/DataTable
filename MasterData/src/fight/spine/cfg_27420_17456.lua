local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				id = 27410010,
				frame = 18,
				sound = {
					"20200_attack",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				id = 27410011,
				frame = 18,
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
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	useskill1 = {
		totalframe = 45,
		turnbacklimit = true,
		animation = "skill",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27420_skill1",
					0.6
				}
			},
			{
				id = 27420010,
				frame = 9,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 10,
						object = "target"
					}
				}
			},
			{
				id = 27420010,
				frame = 13,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 10,
						object = "target"
					}
				}
			},
			{
				id = 27420010,
				frame = 17,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 10,
						object = "target"
					}
				}
			},
			{
				id = 27420010,
				frame = 21,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 10,
						object = "target"
					}
				}
			},
			{
				id = 27420010,
				frame = 25,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 10,
						object = "target"
					}
				}
			}
		}
	},
	useskill2 = {
		turnbacklimit = true,
		totalframe = 45,
		animation = "xp2",
		action_on_start = {
			{
				startframe = 15,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 500,
							time = 0.5
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27420_skill2",
					0.6
				}
			},
			{
				id = 27420011,
				frame = 24,
				effect = {
					{
						ani = "xp2",
						name = "17456_27420_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 28,
				id = 27420011
			},
			{
				frame = 32,
				id = 27420011
			},
			{
				frame = 36,
				id = 27420011
			},
			{
				frame = 40,
				id = 27420011
			}
		}
	},
	usexp = {
		totalframe = 84,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp1",
		action_on_start = {
			{
				startframe = 34,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 3,
							posx = -200
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"27420_xp",
					0.6
				}
			},
			{
				frame = 25,
				id = 27430012
			},
			{
				id = 27430010,
				frame = 40,
				effect = {
					{
						ani = "xp1",
						name = "17456_27420_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 50,
				id = 27430010
			},
			{
				frame = 60,
				id = 27430010
			},
			{
				frame = 70,
				id = 27430011
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 84,
	bgfile = "17456_27420_bg",
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
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/27420_xp",
				1
			}
		}
	},
	lockframe = {},
	camera = {
		zoom = {},
		move = {
			{
				pos = "self",
				totalframe = 10,
				startframe = 15,
				time = 0.1
			}
		}
	}
}

return var_0_0
