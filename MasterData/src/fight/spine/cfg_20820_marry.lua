local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 36,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20820-attack",
					0.6
				}
			},
			{
				id = 20810101,
				frame = 11,
				effect = {
					{
						ani = "xp_attack",
						name = "10810_20820_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack2 = {
		totalframe = 36,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20820-attack",
					0.6
				}
			},
			{
				id = 20810101,
				frame = 11,
				effect = {
					{
						ani = "xp_attack",
						name = "10810_20820_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack3 = {
		totalframe = 36,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20820-attack",
					0.6
				}
			},
			{
				id = 20810101,
				frame = 11,
				effect = {
					{
						ani = "xp_attack",
						name = "10810_20820_effect",
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
				param = "skill_begin1"
			}
		}
	},
	skill_begin1 = {
		skillattackframe = 45,
		totalframe = 42,
		animation = "skill",
		action_on_start = {
			{
				startframe = 4,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 35
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				behitted = "hitdown",
				id = 20821001,
				frame = 18,
				shake = {
					x = 0,
					y = 2
				},
				sound = {
					"20800_skill",
					0.6
				}
			},
			{
				frame = 20,
				id = 20821002
			}
		}
	},
	skill1_1 = {
		{
			{
				method = "useSkill",
				param = "skill_begin1_1"
			}
		}
	},
	skill_begin1_1 = {
		totalframe = 42,
		animation = "skill",
		action_on_start = {
			{
				startframe = 4,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 30
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 20821101,
				frame = 18,
				shake = {
					x = 0,
					y = 2
				},
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
				param = "skill_begin1_2"
			}
		}
	},
	skill_begin1_2 = {
		totalframe = 42,
		animation = "skill",
		action_on_start = {
			{
				startframe = 4,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 50
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 20821201,
				frame = 18,
				shake = {
					x = 0,
					y = 2
				},
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
				param = "skill_begin1_3"
			}
		}
	},
	skill_begin1_3 = {
		totalframe = 42,
		animation = "skill",
		action_on_start = {
			{
				startframe = 4,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 50
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 20821301,
				frame = 18,
				shake = {
					x = 0,
					y = 2
				},
				sound = {
					"20800_skill",
					0.6
				}
			}
		}
	},
	usexp = {
		turnbacklimit = true,
		xpeffect = "xp_effect",
		totalframe = 126,
		animation = "xp2",
		action_on_start = {
			{
				startframe = 31,
				action = {
					{
						method = "rush_to_target",
						param = {
							frame = 2,
							posx = 15
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				id = 20850001,
				frame = 35,
				effect = {
					{
						ani = "xp_attack",
						name = "10810_20820_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 4
				},
				sound = {
					"20800_attack"
				}
			},
			{
				id = 20850001,
				frame = 46,
				effect = {
					{
						ani = "xp_attack",
						name = "10810_20820_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 4
				},
				sound = {
					"20800_attack"
				}
			},
			{
				id = 20850001,
				frame = 56,
				effect = {
					{
						ani = "xp_attack",
						name = "10810_20820_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 4,
					y = 4
				},
				sound = {
					"20800_attack"
				}
			},
			{
				id = 20850001,
				frame = 70,
				behitted = "hitdown",
				effect = {
					{
						ani = "xp_attack",
						name = "10810_20820_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					speed = 700
				},
				shake = {
					x = 4,
					y = 10
				},
				sound = {
					"20800_attack"
				}
			},
			{
				id = 20850002,
				frame = 83,
				behitted = "hitdown",
				effect = {
					{
						ani = "xp_attack",
						name = "10810_20820_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 80
				},
				forceY = {
					speed = 700
				},
				force = {
					{
						time = 0.2,
						distance = 100,
						object = "target"
					}
				},
				sound = {
					"20800_skill"
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 125,
	bgfile = "marry_bg",
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
			texture = "role/20820.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/20820_xp",
				1
			}
		}
	},
	lockframe = {
		{
			totalframe = 6,
			startframe = 70,
			timescale = 0.2
		},
		{
			totalframe = 6,
			startframe = 83,
			timescale = 0.2
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 70,
				startframe = 0
			},
			{
				scale = 1.2,
				totalframe = 28,
				startframe = 74
			}
		},
		move = {
			{
				distance = 180,
				time = 0.1,
				distanceY = 100,
				totalframe = 11,
				startframe = 67
			},
			{
				distance = 60,
				time = 0.05,
				distanceY = -100,
				totalframe = 20,
				startframe = 80
			}
		}
	}
}

return var_0_0
