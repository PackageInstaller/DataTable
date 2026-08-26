-- chunkname: @modules/logic/versionactivity3_9/naxisuosi/define/NaxisuosiPipeEnum.lua

module("modules.logic.versionactivity3_9.naxisuosi.define.NaxisuosiPipeEnum", package.seeall)

local NaxisuosiPipeEnum = _M

NaxisuosiPipeEnum.pipeEntryClearCount = 2
NaxisuosiPipeEnum.pipeEntryClearDecimal = 10
NaxisuosiPipeEnum.dir = {
	down = 2,
	up = 8,
	left = 4,
	right = 6
}
NaxisuosiPipeEnum.type = {
	x_shape = 10,
	corner = 6,
	first = 1,
	zhanwei = 8,
	connect = 9,
	signsingle = 3,
	straight = 5,
	wrong = 4,
	t_shape = 7,
	last = 2
}
NaxisuosiPipeEnum.ruleConnect = {
	[NaxisuosiPipeEnum.type.first] = 2468,
	[NaxisuosiPipeEnum.type.last] = 2468,
	[NaxisuosiPipeEnum.type.signsingle] = 2468,
	[NaxisuosiPipeEnum.type.wrong] = 2468,
	[NaxisuosiPipeEnum.type.straight] = 28,
	[NaxisuosiPipeEnum.type.corner] = 26,
	[NaxisuosiPipeEnum.type.t_shape] = 468,
	[NaxisuosiPipeEnum.type.zhanwei] = 0,
	[NaxisuosiPipeEnum.type.connect] = 2468,
	[NaxisuosiPipeEnum.type.x_shape] = 2468
}
NaxisuosiPipeEnum.entry = {
	[NaxisuosiPipeEnum.type.first] = true,
	[NaxisuosiPipeEnum.type.last] = true,
	[NaxisuosiPipeEnum.type.signsingle] = true,
	[NaxisuosiPipeEnum.type.wrong] = true,
	[NaxisuosiPipeEnum.type.connect] = true
}
NaxisuosiPipeEnum.pathConn = {
	[NaxisuosiPipeEnum.type.straight] = true,
	[NaxisuosiPipeEnum.type.corner] = true,
	[NaxisuosiPipeEnum.type.t_shape] = true,
	[NaxisuosiPipeEnum.type.x_shape] = true
}
NaxisuosiPipeEnum.LineStatus = {
	Connect = 2,
	Error = 3,
	Normal = 1
}
NaxisuosiPipeEnum.MapType = {
	Blue = 1,
	Orange = 2
}
NaxisuosiPipeEnum.connectResIndex = {
	[NaxisuosiPipeEnum.MapType.Orange] = 2,
	[NaxisuosiPipeEnum.MapType.Blue] = 4
}
NaxisuosiPipeEnum.res = {
	[NaxisuosiPipeEnum.type.x_shape] = {
		"v3a9_naxisuosi_game_path_grey_2",
		"v3a9_naxisuosi_game_path_orange_2",
		"v3a9_naxisuosi_game_path_red_2",
		"v3a9_naxisuosi_game_path_blue_2"
	},
	[NaxisuosiPipeEnum.type.t_shape] = {
		"v3a9_naxisuosi_game_path_grey_3",
		"v3a9_naxisuosi_game_path_orange_3",
		"v3a9_naxisuosi_game_path_red_3",
		"v3a9_naxisuosi_game_path_blue_3"
	},
	[NaxisuosiPipeEnum.type.corner] = {
		"v3a9_naxisuosi_game_path_grey_4",
		"v3a9_naxisuosi_game_path_orange_4",
		"v3a9_naxisuosi_game_path_red_4",
		"v3a9_naxisuosi_game_path_blue_4"
	},
	[NaxisuosiPipeEnum.type.straight] = {
		"v3a9_naxisuosi_game_path_grey_5",
		"v3a9_naxisuosi_game_path_orange_5",
		"v3a9_naxisuosi_game_path_red_5",
		"v3a9_naxisuosi_game_path_blue_5"
	}
}
NaxisuosiPipeEnum.resNumIcons = {
	"v1a3_arm_puzzlesignnum1",
	"v1a3_arm_puzzlesignnum2",
	"v1a3_arm_puzzlesignnum3",
	"v1a3_arm_puzzlesignnum4"
}
NaxisuosiPipeEnum.rotate = {
	[NaxisuosiPipeEnum.type.straight] = {
		[28] = {
			0
		},
		[46] = {
			90
		}
	},
	[NaxisuosiPipeEnum.type.corner] = {
		[26] = {
			0
		},
		[68] = {
			90
		},
		[48] = {
			180
		},
		[24] = {
			270
		}
	},
	[NaxisuosiPipeEnum.type.t_shape] = {
		[468] = {
			0
		},
		[248] = {
			90
		},
		[246] = {
			180
		},
		[268] = {
			270
		}
	}
}
NaxisuosiPipeEnum.connDir = {
	[NaxisuosiPipeEnum.dir.left] = NaxisuosiPipeEnum.dir.right,
	[NaxisuosiPipeEnum.dir.right] = NaxisuosiPipeEnum.dir.left,
	[NaxisuosiPipeEnum.dir.up] = NaxisuosiPipeEnum.dir.down,
	[NaxisuosiPipeEnum.dir.down] = NaxisuosiPipeEnum.dir.up
}
NaxisuosiPipeEnum.posDir = {
	[NaxisuosiPipeEnum.dir.left] = {
		x = -1,
		y = 0
	},
	[NaxisuosiPipeEnum.dir.right] = {
		x = 1,
		y = 0
	},
	[NaxisuosiPipeEnum.dir.up] = {
		x = 0,
		y = -1
	},
	[NaxisuosiPipeEnum.dir.down] = {
		x = 0,
		y = 1
	}
}
NaxisuosiPipeEnum.PathType = {
	Order = 1,
	ConnectAll = 2
}

return NaxisuosiPipeEnum
