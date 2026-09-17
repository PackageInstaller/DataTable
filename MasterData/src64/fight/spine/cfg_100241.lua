local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10024161,
				frame = 10,
				effect = {
					{
						ani = "attack",
						name = "100241_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	skill1 = {
		{
			{
				method = "useSkill",
				param = "xuying1"
			}
		}
	},
	skill2 = {
		{
			{
				method = "useSkill",
				param = "xuying2"
			}
		}
	},
	skill3 = {
		{
			{
				method = "useSkill",
				param = "xuying3"
			}
		}
	},
	useskill1 = {
		totalframe = 50,
		animation = "skill1",
		exe_tbl = {
			{
				id = 10024171,
				frame = 15,
				effect = {
					{
						ani = "skill1",
						name = "100241_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"11970_21900_skill",
					1
				}
			}
		}
	},
	useskill2 = {
		totalframe = 55,
		animation = "skill2",
		exe_tbl = {
			{
				id = 10024181,
				frame = 40,
				effect = {
					{
						ani = "skill2",
						name = "100241_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20300_skill1",
					1.2
				}
			}
		}
	},
	useskill3 = {
		totalframe = 55,
		animation = "skill3",
		exe_tbl = {
			{
				frame = 30,
				id = 10024201
			}
		}
	},
	xp = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 10,
					range = 20
				}
			},
			{
				method = "useSkill",
				param = "qianyao1"
			},
			type = "sequence"
		},
		{
			{
				method = "useSkill",
				param = "qianyao2"
			},
			type = "sequence"
		},
		type = "selector"
	},
	xuying1 = {
		totalframe = 24,
		nextani = true,
		animation = "hitdown",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = -100,
							time = 0.6
						}
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	xuying2 = {
		totalframe = 24,
		nextani = true,
		animation = "hitdown",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 200,
							time = 0.6
						}
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	xuying3 = {
		totalframe = 24,
		nextani = true,
		animation = "hitdown",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = -200,
							time = 0.6
						}
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "useskill3"
			}
		}
	},
	qianyao1 = {
		totalframe = 25,
		nextani = true,
		animation = "hitdown",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = 200,
							time = 0.6
						}
					}
				}
			}
		},
		xpeffect = {
			conf = "xp_effect",
			startframe = 25
		},
		exe_tbl = {
			{
				id = 44900000,
				frame = 1,
				sound = {
					"invalid",
					1.6
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "usexp"
			}
		}
	},
	qianyao2 = {
		totalframe = 25,
		nextani = true,
		animation = "hitdown",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = -250,
							time = 0.6
						}
					}
				}
			}
		},
		xpeffect = {
			conf = "xp_effect",
			startframe = 25
		},
		exe_tbl = {
			{
				id = 44900000,
				frame = 1,
				sound = {
					"invalid",
					1.6
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "usexp"
			}
		}
	},
	usexp = {
		totalframe = 75,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 35,
				id = 10024191,
				effect = {
					{
						ani = "xp",
						name = "100241_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20300_skill1",
					1.2
				}
			},
			{
				frame = 45,
				id = 10024191,
				effect = {
					{
						ani = "xp",
						name = "100241_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20300_skill1",
					1.2
				}
			},
			{
				frame = 55,
				id = 10024191,
				effect = {
					{
						ani = "xp",
						name = "100241_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"20300_skill1",
					1.2
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 80,
	bgfile = "77102_bg",
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
	lockframe = {
		{
			totalframe = 20,
			startframe = 35,
			timescale = 0.5
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
				totalframe = 35,
				startframe = 45
			}
		}
	}
}

return var_0_0
