local var_0_0 = {
	xpeffect = {},
	attack1 = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 21010001,
				frame = 5,
				effect = {
					{
						ani = "attack",
						name = "21000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"dianju",
					0.6
				}
			}
		}
	},
	attack2 = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 21010001,
				frame = 5,
				effect = {
					{
						ani = "attack",
						name = "21000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"dianju",
					0.6
				}
			}
		}
	},
	attack3 = {
		totalframe = 10,
		animation = "attack",
		exe_tbl = {
			{
				id = 21010001,
				frame = 5,
				effect = {
					{
						ani = "attack",
						name = "21000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"dianju",
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
		totalframe = 45,
		animation = "skill",
		exe_tbl = {
			{
				id = 21020001,
				frame = 17,
				sound = {
					"dianju",
					0.6
				}
			},
			{
				frame = 30,
				behitted = "hit",
				id = 21020001,
				sound = {
					"dianju",
					0.6
				}
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "xp_begin"
			}
		}
	},
	xp1 = {
		{
			{
				method = "useSkill",
				param = "xp_begin1"
			}
		}
	},
	xp2 = {
		{
			{
				method = "useSkill",
				param = "xp_begin2"
			}
		}
	},
	xp3 = {
		{
			{
				method = "useSkill",
				param = "xp_begin3"
			}
		}
	},
	xp_begin = {
		totalframe = 45,
		animation = "xp_begin",
		xpeffect = "xp_effect",
		exe_type = "cross",
		turnbacklimit = true,
		nextani = true,
		action_on_start = {
			{
				startframe = 38,
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
		exe_tbl = {
			{
				id = 21030001,
				frame = 39,
				behitted = "hitdown",
				effect = {
					{
						ani = "attack",
						name = "21000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0.2,
						shutdown = false,
						distance = 60,
						object = "target"
					}
				},
				forceY = {
					speed = 400
				},
				sound = {
					"dianju",
					0.6
				}
			}
		},
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_attack"
			}
		}
	},
	xp_attack = {
		totalframe = 49,
		animation = "xp_attack",
		exe_tbl = {
			{
				frame = 8,
				id = 21030001,
				effect = {
					{
						ani = "attack",
						name = "21000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"dianju",
					0.6
				}
			},
			{
				frame = 16,
				id = 21030001,
				effect = {
					{
						ani = "attack",
						name = "21000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"dianju",
					0.6
				}
			},
			{
				frame = 24,
				id = 21030001,
				effect = {
					{
						ani = "attack",
						name = "21000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"dianju",
					0.6
				}
			},
			{
				frame = 32,
				id = 21030001,
				effect = {
					{
						ani = "attack",
						name = "21000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"dianju",
					0.6
				}
			},
			{
				frame = 40,
				id = 21030001,
				effect = {
					{
						ani = "attack",
						name = "21000_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				},
				sound = {
					"dianju",
					0.6
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 93,
	bgfile = "21000_bg",
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
			texture = "role/21005.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 17,
			timescale = 0.1
		},
		{
			totalframe = 3,
			startframe = 38,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 26,
				startframe = 4
			}
		}
	}
}
var_0_0.xp_begin1 = {
	totalframe = 45,
	animation = "xp_begin",
	xpeffect = "xp_effect1",
	exe_type = "cross",
	turnbacklimit = true,
	nextani = true,
	action_on_start = {
		{
			startframe = 38,
			action = {
				{
					method = "rush_to_target",
					param = {
						frame = 3,
						posx = 20
					}
				}
			}
		}
	},
	exe_tbl = {
		{
			id = 21032001,
			frame = 39,
			behitted = "hitdown",
			effect = {
				{
					ani = "attack",
					name = "21000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			force = {
				{
					time = 0.2,
					shutdown = false,
					distance = 60,
					object = "target"
				}
			},
			forceY = {
				speed = 400
			},
			sound = {
				"dianju",
				0.6
			}
		}
	},
	action_on_complete = {
		{
			method = "useSkill",
			param = "xp_attack1"
		}
	}
}
var_0_0.xp_attack1 = {
	totalframe = 49,
	animation = "xp_attack",
	exe_tbl = {
		{
			frame = 8,
			id = 21032001,
			effect = {
				{
					ani = "attack",
					name = "21000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"dianju",
				0.6
			}
		},
		{
			frame = 16,
			id = 21032001,
			effect = {
				{
					ani = "attack",
					name = "21000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"dianju",
				0.6
			}
		},
		{
			frame = 24,
			id = 21032001,
			effect = {
				{
					ani = "attack",
					name = "21000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"dianju",
				0.6
			}
		},
		{
			frame = 32,
			id = 21032001,
			effect = {
				{
					ani = "attack",
					name = "21000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"dianju",
				0.6
			}
		},
		{
			frame = 40,
			id = 21032001,
			effect = {
				{
					ani = "attack",
					name = "21000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"dianju",
				0.6
			}
		}
	}
}
var_0_0.xpeffect.xp_effect1 = {
	totalframe = 93,
	bgfile = "21000_bg",
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
			texture = "role/21002.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 17,
			timescale = 0.1
		},
		{
			totalframe = 3,
			startframe = 38,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 26,
				startframe = 4
			}
		}
	}
}
var_0_0.xp_begin2 = {
	totalframe = 45,
	animation = "xp_begin",
	xpeffect = "xp_effect2",
	exe_type = "cross",
	turnbacklimit = true,
	nextani = true,
	action_on_start = {
		{
			startframe = 38,
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
	exe_tbl = {
		{
			id = 21035001,
			frame = 39,
			behitted = "hitdown",
			effect = {
				{
					ani = "attack",
					name = "21000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			force = {
				{
					time = 0.2,
					shutdown = false,
					distance = 60,
					object = "target"
				}
			},
			forceY = {
				speed = 400
			},
			sound = {
				"dianju",
				0.6
			}
		}
	},
	action_on_complete = {
		{
			method = "useSkill",
			param = "xp_attack2"
		}
	}
}
var_0_0.xp_attack2 = {
	totalframe = 49,
	animation = "xp_attack",
	exe_tbl = {
		{
			frame = 8,
			id = 21035001,
			effect = {
				{
					ani = "attack",
					name = "21000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"dianju",
				0.6
			}
		},
		{
			frame = 16,
			id = 21035001,
			effect = {
				{
					ani = "attack",
					name = "21000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"dianju",
				0.6
			}
		},
		{
			frame = 24,
			id = 21035001,
			effect = {
				{
					ani = "attack",
					name = "21000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"dianju",
				0.6
			}
		},
		{
			frame = 32,
			id = 21035001,
			effect = {
				{
					ani = "attack",
					name = "21000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"dianju",
				0.6
			}
		},
		{
			frame = 40,
			id = 21035001,
			effect = {
				{
					ani = "attack",
					name = "21000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"dianju",
				0.6
			}
		}
	}
}
var_0_0.xpeffect.xp_effect2 = {
	totalframe = 93,
	bgfile = "21000_bg",
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
			texture = "role/21005.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 17,
			timescale = 0.1
		},
		{
			totalframe = 3,
			startframe = 38,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 26,
				startframe = 4
			}
		}
	}
}
var_0_0.xp_begin3 = {
	totalframe = 45,
	animation = "xp_begin",
	xpeffect = "xp_effect3",
	exe_type = "cross",
	turnbacklimit = true,
	nextani = true,
	action_on_start = {
		{
			startframe = 38,
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
	exe_tbl = {
		{
			id = 21040001,
			frame = 39,
			behitted = "hitdown",
			effect = {
				{
					ani = "attack",
					name = "21000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			force = {
				{
					time = 0.2,
					shutdown = false,
					distance = 60,
					object = "target"
				}
			},
			forceY = {
				speed = 400
			},
			sound = {
				"dianju",
				0.6
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
var_0_0.xp_attack3 = {
	totalframe = 49,
	animation = "xp_attack",
	exe_tbl = {
		{
			frame = 8,
			id = 21040002,
			effect = {
				{
					ani = "attack",
					name = "21000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"dianju",
				0.6
			}
		},
		{
			frame = 16,
			id = 21040002,
			effect = {
				{
					ani = "attack",
					name = "21000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"dianju",
				0.6
			}
		},
		{
			frame = 24,
			id = 21040002,
			effect = {
				{
					ani = "attack",
					name = "21000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"dianju",
				0.6
			}
		},
		{
			frame = 32,
			id = 21040002,
			effect = {
				{
					ani = "attack",
					name = "21000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"dianju",
				0.6
			}
		},
		{
			frame = 40,
			id = 21040002,
			effect = {
				{
					ani = "attack",
					name = "21000_effect",
					offsetZ = 1,
					offsetY = 0.5,
					offsetX = 0,
					object = "target"
				}
			},
			sound = {
				"dianju",
				0.6
			}
		}
	}
}
var_0_0.xpeffect.xp_effect3 = {
	totalframe = 93,
	bgfile = "21000_bg",
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
			texture = "role/21010.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200
		}
	},
	lockframe = {
		{
			totalframe = 3,
			startframe = 17,
			timescale = 0.1
		},
		{
			totalframe = 3,
			startframe = 38,
			timescale = 0.1
		}
	},
	camera = {
		zoom = {
			{
				scale = 1.2,
				totalframe = 26,
				startframe = 4
			}
		}
	}
}

return var_0_0
