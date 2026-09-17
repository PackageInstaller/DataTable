local var_0_0 = {
	xpeffect = {},
	attack = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 3,
					range = 20
				}
			},
			{
				method = "useSkill",
				param = "attack1"
			}
		},
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 3,
					range = 3
				}
			},
			{
				method = "useSkill",
				param = "attack2"
			}
		}
	},
	attack2 = {
		totalframe = 30,
		animation = "attack2",
		exe_tbl = {
			{
				frame = 14,
				id = 22710001,
				sound = {
					"huiwu_z",
					0.6
				},
				effect = {
					{
						ani = "attack",
						name = "22700_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	attack1 = {
		totalframe = 30,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 14,
				behitted = "hitdown",
				id = 22710001,
				sound = {
					"huiwu_z",
					0.6
				},
				effect = {
					{
						ani = "attack",
						name = "22700_effect",
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
	xp1 = {
		{
			{
				method = "useSkill",
				param = "usexp1"
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
		totalframe = 40,
		animation = "skill",
		exe_tbl = {
			{
				frame = 24,
				id = 22720001,
				sound = {
					"huiwu_z",
					0.6
				},
				effect = {
					{
						ani = "skill",
						name = "22700_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	},
	usexp = {
		totalframe = 56,
		xpeffect = "xp_effect",
		turnbacklimit = true,
		animation = "xp",
		action_on_start = {
			{
				startframe = 26,
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
				frame = 1,
				sound = "xp"
			},
			{
				frame = 36,
				id = 22730001,
				sound = {
					"huiwu_z",
					0.6
				},
				shake = {
					x = 0,
					y = 8
				},
				effect = {
					{
						ani = "skill",
						name = "22700_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 55,
	bgfile = "22700_bg",
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
			texture = "role/22720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 34,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 13,
				startframe = 30
			}
		}
	}
}
var_0_0.usexp1 = {
	totalframe = 56,
	xpeffect = "xp_effect1",
	turnbacklimit = true,
	animation = "xp",
	action_on_start = {
		{
			startframe = 26,
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
			frame = 1,
			sound = "xp"
		},
		{
			frame = 36,
			id = 22750001,
			sound = {
				"huiwu_z",
				0.6
			},
			shake = {
				x = 0,
				y = 8
			},
			effect = {
				{
					ani = "skill",
					name = "22700_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			}
		}
	}
}
var_0_0.xpeffect.xp_effect1 = {
	totalframe = 55,
	bgfile = "22700_bg",
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
			texture = "role/22720.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 34,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.8,
				totalframe = 13,
				startframe = 30
			}
		}
	}
}

return var_0_0
