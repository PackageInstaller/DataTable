local var_0_0 = {
	xpeffect = {},
	attack1 = {
		totalframe = 20,
		animation = "attack1",
		exe_tbl = {
			{
				id = 70210001,
				frame = 9,
				effect = {
					{
						ani = "attack",
						name = "70200_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"huiwu_z",
					0.4
				}
			}
		}
	},
	attack2 = {
		totalframe = 20,
		animation = "attack2",
		exe_tbl = {
			{
				id = 70210001,
				frame = 9,
				effect = {
					{
						ani = "attack",
						name = "70200_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"huiwu_z",
					0.4
				}
			}
		}
	},
	attack3 = {
		totalframe = 20,
		animation = "attack3",
		exe_tbl = {
			{
				id = 70210001,
				frame = 9,
				effect = {
					{
						ani = "attack",
						name = "70200_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"huiwu_z",
					0.4
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
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	skill3 = {
		{
			{
				method = "useSkill",
				param = "useskill3"
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "qianyao"
			}
		}
	},
	qianyao = {
		totalframe = 22,
		nextani = true,
		animation = "win",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = -50,
							time = 0.1
						}
					}
				}
			}
		},
		xpeffect = {
			conf = "xp_effect",
			startframe = 30
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
				param = "xp_begin"
			}
		}
	},
	useskill1 = {
		totalframe = 28,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 13,
				behitted = "hitdown",
				id = 70220001,
				effect = {
					{
						ani = "attack",
						name = "70200_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"huiwu_z",
					0.4
				}
			}
		}
	},
	useskill2 = {
		totalframe = 25,
		animation = "skill2",
		exe_tbl = {
			{
				id = 70221001,
				frame = 12,
				effect = {
					{
						ani = "attack",
						name = "70200_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"huiwu_z",
					0.4
				}
			}
		}
	},
	useskill3 = {
		totalframe = 20,
		animation = "skill3",
		exe_tbl = {
			{
				id = 70222001,
				frame = 12
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 47,
	bgfile = "70100_bg",
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
			texture = "role/70200.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 3,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {},
		move = {
			{
				distance = 100,
				totalframe = 36,
				startframe = 6,
				time = 0.1
			}
		}
	}
}
var_0_0.xp_begin = {
	xpeffect = "xp_effect",
	totalframe = 6,
	nextani = true,
	animation = "xp_begin",
	action_on_start = {
		{
			startframe = 10,
			action = {
				{
					method = "rush_forward",
					param = {
						distance = 90,
						time = 0.6
					}
				}
			}
		}
	},
	action_on_complete = {
		{
			method = "useSkill",
			param = "xp_attack"
		}
	}
}
var_0_0.xp_attack = {
	totalframe = 36,
	nextani = true,
	animation = "xp_attack",
	exe_tbl = {
		{
			id = 70230001,
			frame = 6,
			effect = {
				{
					ani = "attack",
					name = "70200_effect",
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
				"huiwu_z",
				0.4
			}
		},
		{
			id = 70230001,
			frame = 12,
			effect = {
				{
					ani = "attack",
					name = "70200_effect",
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
				"huiwu_z",
				0.4
			}
		},
		{
			id = 70230001,
			frame = 18,
			effect = {
				{
					ani = "attack",
					name = "70200_effect",
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
				"huiwu_z",
				0.4
			}
		},
		{
			id = 70230001,
			frame = 24,
			effect = {
				{
					ani = "attack",
					name = "70200_effect",
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
				"huiwu_z",
				0.4
			}
		},
		{
			id = 70230001,
			frame = 30,
			effect = {
				{
					ani = "attack",
					name = "70200_effect",
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
				"huiwu_z",
				0.4
			}
		}
	},
	action_on_complete = {
		{
			method = "useSkill",
			param = "xp_end"
		}
	}
}
var_0_0.xp_end = {
	totalframe = 6,
	animation = "xp_end"
}

return var_0_0
