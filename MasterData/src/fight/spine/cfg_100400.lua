return {
	attack = {
		{
			{
				operator = "<=",
				method = "random",
				param = {
					num = 12,
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
				method = "useSkill",
				param = "attack2"
			}
		}
	},
	attack1 = {
		totalframe = 25,
		animation = "attack",
		exe_tbl = {
			{
				frame = 13,
				id = 1004101,
				effect = {
					{
						ani = "attack",
						name = "100400_effect",
						offsetZ = -1,
						offsetY = 0.5,
						offsetX = -1,
						object = "target"
					}
				}
			}
		}
	},
	attack2 = {
		totalframe = 25,
		animation = "attack1",
		exe_tbl = {
			{
				frame = 13,
				id = 1004101,
				effect = {
					{
						ani = "attack",
						name = "100400_effect",
						offsetZ = -1,
						offsetY = 0.5,
						offsetX = -1,
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
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 30,
		animation = "skill",
		exe_tbl = {
			{
				id = 1004201,
				frame = 20
			}
		}
	}
}
