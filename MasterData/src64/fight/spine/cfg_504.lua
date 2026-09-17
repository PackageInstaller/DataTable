return {
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				frame = 17,
				id = 50410001,
				force = {
					{
						time = 0.1,
						shutdown = false,
						distance = 40,
						object = "target"
					}
				},
				sound = {
					"huiwu",
					0.3
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
	usexp = {
		totalframe = 65,
		animation = "xp1",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"xp",
					0.4
				}
			},
			{
				frame = 34,
				id = 50430001,
				sound = {
					"huiwu",
					0.4
				}
			},
			{
				frame = 38,
				id = 50430002,
				sound = {
					"huiwu",
					0.4
				}
			},
			{
				frame = 42,
				id = 50430003,
				sound = {
					"huiwu",
					0.4
				}
			},
			{
				frame = 45,
				id = 50430004,
				sound = {
					"huiwu",
					0.4
				}
			},
			{
				frame = 49,
				id = 50430004,
				sound = {
					"huiwu",
					0.4
				}
			},
			{
				frame = 53,
				id = 50430003,
				sound = {
					"huiwu",
					0.4
				}
			},
			{
				frame = 57,
				id = 50430002,
				sound = {
					"huiwu",
					0.4
				}
			},
			{
				frame = 60,
				id = 50430001,
				sound = {
					"huiwu",
					0.4
				}
			}
		}
	}
}
