local var_0_0 = {
	xpeffect = {},
	attack = {
		totalframe = 34,
		animation = "attack",
		exe_tbl = {
			{
				id = 22310001,
				frame = 14
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
		turnbacklimit = true,
		totalframe = 47,
		animation = "skill",
		action_on_start = {
			{
				startframe = 17,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 80
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22320_skill",
					0.6
				}
			},
			{
				behitted = "hitdown",
				id = 22320001,
				frame = 20,
				shake = {
					x = 2,
					y = 2
				},
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 120,
						object = "target"
					}
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
		turnbacklimit = true,
		totalframe = 47,
		animation = "skill1_1",
		action_on_start = {
			{
				startframe = 17,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 80
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22320_skill",
					0.6
				}
			},
			{
				behitted = "hitdown",
				id = 22320101,
				frame = 20,
				shake = {
					x = 2,
					y = 2
				},
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 140,
						object = "target"
					}
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
		turnbacklimit = true,
		totalframe = 47,
		animation = "skill1_2",
		action_on_start = {
			{
				startframe = 17,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 80
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22320_skill",
					0.6
				}
			},
			{
				behitted = "hitdown",
				id = 22320201,
				frame = 20,
				shake = {
					x = 2,
					y = 2
				},
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 160,
						object = "target"
					}
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
		turnbacklimit = true,
		totalframe = 47,
		animation = "skill1_3",
		action_on_start = {
			{
				startframe = 17,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 80
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22320_skill",
					0.6
				}
			},
			{
				behitted = "hitdown",
				id = 22320301,
				frame = 20,
				shake = {
					x = 2,
					y = 2
				},
				force = {
					{
						time = 0.2,
						shutdown = true,
						distance = 200,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		totalframe = 78,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"22320_xp1"
				}
			},
			{
				id = 22350001,
				frame = 54,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 60,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				id = 22350001,
				frame = 56,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 60,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				id = 22350001,
				frame = 58,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 60,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				id = 22350001,
				frame = 60,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 60,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				id = 22350001,
				frame = 62,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 60,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 2
				}
			},
			{
				id = 22350001,
				frame = 64,
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 60,
						object = "target"
					}
				},
				shake = {
					x = 2,
					y = 2
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	focusoffset = 150,
	initpos = -150,
	bgfile = "2020chunjie_bg",
	totalframe = 77,
	locktarget = {
		mindistance = 250,
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "animation"
		}
	},
	inserteffect = {
		{
			texture = "role/22320.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/22320_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 5,
			startframe = 55,
			timescale = 0.15
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 22,
				startframe = 48
			}
		},
		move = {
			{
				distance = 50,
				totalframe = 27,
				startframe = 43,
				time = 0.1
			}
		}
	}
}

return var_0_0
