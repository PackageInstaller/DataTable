return {
	attack = {
		totalframe = 15,
		animation = "attack",
		exe_tbl = {
			{
				id = 30110001,
				frame = 9,
				effect = {
					{
						ani = "attack",
						name = "30100_effect",
						offsetZ = 1,
						offsetY = 0,
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
	usexp = {
		totalframe = 40,
		animation = "skill",
		exe_tbl = {
			{
				frame = 32,
				id = 30130001,
				effect = {
					{
						ani = "attack",
						name = "30100_effect",
						offsetZ = 1,
						offsetY = 0,
						offsetX = 0,
						object = "target"
					}
				},
				shake = {
					x = 0,
					y = 8
				}
			}
		}
	}
}
