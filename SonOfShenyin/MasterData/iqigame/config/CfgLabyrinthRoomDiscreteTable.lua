-- chunkname: @IQIGame\\Config\\CfgLabyrinthRoomDiscreteTable.lua

local CfgLabyrinthRoomDiscreteTable = {
	[101] = {
		Id = 101,
		RoomType = 1,
		ScenePool = {
			40010001
		},
		EventPool = {
			10001
		}
	},
	[102] = {
		Id = 102,
		RoomType = 2,
		ScenePool = {
			40010002
		},
		EventPool = {
			201,
			601,
			602,
			603
		}
	},
	[103] = {
		Id = 103,
		RoomType = 3,
		ScenePool = {
			40010003
		},
		EventPool = {
			201,
			601,
			602,
			603
		}
	},
	[104] = {
		Id = 104,
		RoomType = 4,
		ScenePool = {
			40010004
		},
		EventPool = {
			201,
			601,
			602,
			603
		}
	},
	[105] = {
		Id = 105,
		RoomType = 5,
		ScenePool = {
			40010005
		},
		EventPool = {
			201,
			601,
			602,
			603
		}
	},
	[106] = {
		Id = 106,
		RoomType = 6,
		ScenePool = {
			40010006
		},
		EventPool = {
			201,
			601,
			602,
			603
		}
	},
	[107] = {
		Id = 107,
		RoomType = 7,
		ScenePool = {
			40010009
		},
		EventPool = {
			201,
			601,
			602,
			603
		}
	},
	[108] = {
		Id = 108,
		RoomType = 8,
		ScenePool = {
			40010007
		},
		EventPool = {
			201,
			601,
			602,
			603
		}
	},
	[109] = {
		Id = 109,
		RoomType = 9,
		ScenePool = {
			40010015
		},
		EventPool = {
			201,
			601,
			602,
			603
		}
	},
	[110] = {
		Id = 110,
		RoomType = 10,
		ScenePool = {
			40010010
		},
		EventPool = {
			201,
			601,
			602,
			603
		}
	},
	[111] = {
		Id = 111,
		RoomType = 11,
		ScenePool = {
			40010008
		},
		EventPool = {
			201,
			601,
			602,
			603
		}
	},
	[112] = {
		Id = 112,
		RoomType = 12,
		ScenePool = {
			40010011
		},
		EventPool = {
			201,
			205,
			601,
			602,
			603
		}
	},
	[113] = {
		Id = 113,
		RoomType = 13,
		ScenePool = {
			40010012
		},
		EventPool = {
			201,
			205,
			601,
			602,
			603
		}
	},
	[114] = {
		Id = 114,
		RoomType = 14,
		ScenePool = {
			40010013
		},
		EventPool = {
			201,
			205,
			601,
			602,
			603
		}
	},
	[115] = {
		Id = 115,
		RoomType = 15,
		ScenePool = {
			40010014
		},
		EventPool = {
			201,
			205,
			601,
			602,
			603
		}
	},
	[116] = {
		Id = 116,
		RoomType = 16,
		ScenePool = {
			40010016
		}
	},
	[117] = {
		Id = 117,
		RoomType = 17,
		ScenePool = {
			40010017
		}
	},
	[118] = {
		Id = 118,
		RoomType = 18,
		ScenePool = {
			40010016
		}
	},
	[119] = {
		Id = 119,
		RoomType = 19,
		ScenePool = {
			40010016
		}
	},
	[120] = {
		Id = 120,
		RoomType = 20,
		ScenePool = {
			40010011
		}
	},
	[121] = {
		Id = 121,
		RoomType = 21,
		ScenePool = {
			40010012
		}
	},
	[122] = {
		Id = 122,
		RoomType = 22,
		ScenePool = {
			40010013
		}
	},
	[123] = {
		Id = 123,
		RoomType = 23,
		ScenePool = {
			40010014
		}
	},
	[124] = {
		Id = 124,
		ScenePool = {
			40010011,
			40010012,
			40010013,
			40010014
		}
	}
}

setmetatable(CfgLabyrinthRoomDiscreteTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLabyrinthRoomDiscreteTable]")
	end
})

local defaultMetaTable = {
	__index = {
		RoomType = 0,
		EventPool = {},
		ScenePool = {}
	}
}

for i, data in pairs(CfgLabyrinthRoomDiscreteTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLabyrinthRoomDiscreteTable
