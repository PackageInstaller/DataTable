return {
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 10,
				id = 51310001,
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
		totalframe = 28,
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"xp",
					0.4
				}
			},
			{
				id = 51330001,
				frame = 23,
				effect = {
					{
						ani = "xp_gethit",
						name = "51300_effect1",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				force = {
					{
						time = 0,
						shutdown = true,
						distance = 0,
						object = "target"
					}
				},
				sound = {
					"huiwu",
					0.4
				}
			},
			{
				frame = 23,
				id = 50330002
			}
		}
	}
}
