local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack1 = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				id = 10060123,
				frame = 8,
				effect = {
					{
						ani = "skill",
						name = "21200_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				}
			},
			{
				frame = 15,
				id = 10060121
			}
		}
	},
	attack2 = {
		{
			{
				operator = ">",
				method = "random",
				param = {
					num = 2,
					range = 10
				}
			},
			{
				method = "useSkill",
				param = "attack4"
			}
		},
		{
			{
				method = "useSkill",
				param = "attack5"
			}
		}
	},
	attack4 = {
		totalframe = 45,
		animation = "attack2",
		exe_tbl = {
			{
				id = 10060171,
				frame = 22,
				effect = {
					{
						ani = "skill_attack",
						name = "35302_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				}
			}
		}
	},
	attack5 = {
		totalframe = 45,
		animation = "attack2",
		exe_tbl = {
			{
				id = 10060171,
				frame = 22,
				effect = {
					{
						ani = "skill_attack",
						name = "35302_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 707,
						distance = 300,
						time = 0.3
					}
				}
			}
		}
	},
	attack3 = {
		{
			{
				operator = ">",
				method = "random",
				param = {
					num = 2,
					range = 10
				}
			},
			{
				method = "useSkill",
				param = "attack6"
			}
		},
		{
			{
				method = "useSkill",
				param = "attack7"
			}
		}
	},
	attack6 = {
		totalframe = 60,
		animation = "attack3",
		exe_tbl = {
			{
				id = 10060181,
				frame = 34,
				effect = {
					{
						ani = "skill_attack",
						name = "35302_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				}
			}
		}
	},
	attack7 = {
		totalframe = 60,
		animation = "attack3",
		exe_tbl = {
			{
				id = 10060181,
				frame = 34,
				effect = {
					{
						ani = "skill_attack",
						name = "35302_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				},
				forceY = {
					{
						speed = 707,
						distance = 300,
						time = 0.3
					}
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
		totalframe = 60,
		animation = "skill1",
		exe_tbl = {
			{
				frame = 1,
				sound = "100601_skill1"
			},
			{
				id = 10060131,
				frame = 39,
				forceY = {
					{
						speed = 1000,
						shutdown = false,
						distance = 250,
						time = 3,
						object = "target"
					}
				},
				effect = {
					{
						ani = "attack",
						name = "36200_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				frame = 45,
				id = 10060132
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
	useskill2 = {
		totalframe = 60,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = "100601_skill2"
			},
			{
				id = 10060141,
				frame = 18,
				effect = {
					{
						ani = "skill1",
						name = "100491_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 1.2,
						shutdown = false,
						distance = 200,
						object = "target"
					}
				}
			},
			{
				id = 10060141,
				frame = 33,
				effect = {
					{
						ani = "skill1",
						name = "100491_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
			},
			{
				id = 10060141,
				frame = 48,
				effect = {
					{
						ani = "skill1",
						name = "100491_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				}
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
	useskill3 = {
		totalframe = 90,
		animation = "skill3",
		action_on_start = {
			{
				startframe = 1,
				action = {
					{
						method = "rush_forward",
						param = {
							distance = -300,
							time = 1.5
						}
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 24,
				sound = "100601_skill3"
			},
			{
				id = 10060151,
				frame = 72,
				effect = {
					{
						ani = "attack",
						name = "21200_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				forceY = {
					{
						time = 0.4,
						shutdown = false,
						distance = 250,
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
				param = "xpbegin"
			}
		}
	},
	xpbegin = {
		xpeffect = "xp_effect",
		totalframe = 120,
		nextani = true,
		animation = "xp",
		action_on_complete = {
			{
				method = "useSkill",
				param = "xp_next"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = "100601_xp"
			},
			{
				frame = 41,
				id = 10060162
			},
			{
				id = 10060161,
				frame = 42,
				effect = {
					{
						ani = "skill_attack",
						name = "35302_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				},
				forceY = {
					{
						time = 0.2,
						shutdown = false,
						distance = 50,
						object = "target"
					}
				}
			},
			{
				id = 10060161,
				frame = 59,
				effect = {
					{
						ani = "skill_attack",
						name = "35302_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				},
				forceY = {
					{
						time = 0.2,
						shutdown = false,
						distance = 50,
						object = "target"
					}
				}
			},
			{
				id = 10060161,
				frame = 75,
				effect = {
					{
						ani = "skill_attack",
						name = "35302_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				},
				forceY = {
					{
						time = 0.2,
						shutdown = false,
						distance = 50,
						object = "target"
					}
				}
			},
			{
				id = 10060161,
				frame = 92,
				behitted = "hitdown",
				effect = {
					{
						ani = "skill_attack",
						name = "35302_effect",
						offsetZ = 1,
						offsetY = 0.5,
						offsetX = 0.5,
						object = "target"
					}
				}
			}
		}
	},
	xp_next = {
		totalframe = 120,
		animation = "sit",
		action_on_start = {
			{
				startframe = 0,
				action = {
					{
						method = "add_anti_hitdown"
					}
				}
			}
		},
		exe_tbl = {
			{
				frame = 15,
				id = 10060163
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	focusoffset = -260,
	totalframe = 110,
	bgfile = "45080_bg",
	locktarget = {
		locktarget = true
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
			totalframe = 40,
			startframe = 0,
			timescale = 0.8
		}
	},
	camera = {
		zoom = {
			{
				scale = 0.85,
				totalframe = 110,
				startframe = 0,
				intime = 0.4
			}
		},
		move = {
			{
				distance = 320,
				totalframe = 94,
				startframe = 16,
				time = 0.3
			}
		}
	}
}

return var_0_0
